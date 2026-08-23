local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.shopData
local var_0_2 = g.core.model.User.giftData
local var_0_3 = g.core.const.ConstMgr.ShopConst
local var_0_4 = g.core.model.User.hotSaleGMGiftData
local var_0_5 = g.core.const.ConstMgr.FUNCTION_TYPE
local RechargeLayer = class("RechargeLayer", require("app.fairyGUI.recharge.UI_RechargeLayer"), function()
	return fgui.GComponent:create({
		pkgName = "recharge",
		isFullScreen = true,
		pkgPath = "ui/recharge/recharge",
		resName = "RechargeLayer"
	}, ...)
end)

function RechargeLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	arg_2_1.tabType = arg_2_1.tabType or arg_2_1.route1
	arg_2_1.shopType = arg_2_1.shopType or arg_2_1.route2

	if arg_2_1.route3 and arg_2_1.route3 > 0 then
		arg_2_1.shopValue = arg_2_1.route3
	end

	if arg_2_1.shopType and not arg_2_1.tabType then
		arg_2_1.shopValue = arg_2_1.shopValue or 1

		local var_2_0 = g.core.config.shop_info.match(function(arg_3_0)
			return arg_3_0.shop_type == arg_2_1.shopType and (arg_3_0.shop_first == arg_2_1.shopValue or arg_3_0.shop_first == 0)
		end)

		if not next(var_2_0) then
			var_2_0 = g.core.config.shop_info.match(function(arg_4_0)
				return arg_4_0.shop_type == arg_2_1.shopType
			end)
			arg_2_1.shopValue = var_2_0.shop_first
		end

		if var_2_0 and #var_2_0 > 0 then
			if var_2_0[1] then
				arg_2_1.tabType = var_2_0[1].tab_type
				arg_2_1.shopValue = var_2_0[1].shop_first
			end
		end
	end

	self._params = arg_2_1

	if self._params.shopType == g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RECHARGE_SKIN then
		self._selectedContentSkinId = self._params.selectedContentSkinId
	end

	self._selectedIndex = 0
	self._comps = {}
	self._currentComp = nil
	self._tabNum = 0
	self._bgComp = nil
	self._timeSchedule = nil
	self._childSize = self.m_childComp:getSize()
	self._childX = self.m_childComp:getX()
	self._childY = self.m_childComp:getY()

	self:_init()
end

function RechargeLayer:_init()
	self._bgComp = self:addBg("bg/shop/bg_shopbg0.jpg", true)

	self.m_topBarComp:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.RECHARGE)
	self.m_tabList:setIniter()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRenderer))
	self:addListen(self.m_tabList)
	self:addListen(self.m_child)
end

function RechargeLayer:_onTabListItemRenderer(arg_6_1, arg_6_2)
	if arg_6_1 > #self._tabCfgs then
		return
	end

	if self._tabCfgs[arg_6_1 + 1] then
		arg_6_2:updateCell(self._tabCfgs[arg_6_1 + 1])
	end
end

function RechargeLayer:onLoad()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_STORE)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.HOT_SELLING)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_AWARD, handler(self, self._onRechargeAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self:_updateTabListView()
end

function RechargeLayer:_updateTabListView()
	self._tabCfgs = {}
	self._selectedIndex = nil
	self._selectedSubIndex = nil

	local var_8_0 = var_0_1:getShopInfoGroup()

	if var_8_0[var_0_3.SHOP_INFO_TAB_TYPE.RECHARGE_TAB_TYPE] then
		self:_initShopInfo(var_8_0[var_0_3.SHOP_INFO_TAB_TYPE.RECHARGE_TAB_TYPE])
	end

	if var_8_0[var_0_3.SHOP_INFO_TAB_TYPE.GIFT_TAB_TYPE] then
		self:_initShopInfo(var_8_0[var_0_3.SHOP_INFO_TAB_TYPE.GIFT_TAB_TYPE])
	end

	if var_8_0[var_0_3.SHOP_INFO_TAB_TYPE.SKIN_TAB_TYPE] then
		self:_initShopInfo(var_8_0[var_0_3.SHOP_INFO_TAB_TYPE.SKIN_TAB_TYPE])
	end

	if var_8_0[var_0_3.SHOP_INFO_TAB_TYPE.HOT_TAB_TYPE] then
		self:_initShopInfo((self:_convertHotSaleTabData(var_8_0[var_0_3.SHOP_INFO_TAB_TYPE.HOT_TAB_TYPE])))
	end

	if var_8_0[var_0_3.SHOP_INFO_TAB_TYPE.COMMON_TAB_TYPE] then
		self:_initShopInfo(var_8_0[var_0_3.SHOP_INFO_TAB_TYPE.COMMON_TAB_TYPE])
	end

	self:_sortTabList()
	self:goToSelectedShop()
end

function RechargeLayer:goToSelectedShop()
	self._tabNum = #self._tabCfgs
	self._selectedIndex = self._selectedIndex or 0

	if self._tabNum > 0 then
		self.m_tabList:setNumItems(self._tabNum)
		self.m_tabList:setSelectedIndex(self._selectedIndex)

		if self._selectedIndex < self._tabNum then
			local var_9_0 = self.m_tabList:getChildAt((self.m_tabList:itemIndexToChildIndex(self._selectedIndex)))

			if var_9_0 then
				var_9_0:onSelected(self._selectedSubIndex)
			end
		end
	end

	self.m_tabList:scrollToView(self._selectedIndex)
end

function RechargeLayer:_initShopInfo(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		local var_10_1 = iter_10_1[1]
		local var_10_2 = true
		local var_10_3 = false
		local var_10_4 = {}
		local var_10_5 = 0

		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			var_10_2 = iter_10_3.function_id ~= 0 and not g.core.common.ModuleUnlock:isModuleUnlock(iter_10_3.function_id, nil, true) or false

			if not var_10_2 and g.core.model.User.shopData:checkShopOpen(iter_10_3.shop_type, iter_10_3.shop_first) then
				var_10_3 = true

				if iter_10_3.shop_second ~= 0 then
					var_10_4[iter_10_3.shop_first] = var_10_4[iter_10_3.shop_first] or {
						info = iter_10_3,
						subInfo = {}
					}

					table.insert(var_10_4[iter_10_3.shop_first].subInfo, iter_10_3)
				elseif iter_10_3.shop_first ~= 0 then
					var_10_4[iter_10_3.shop_first] = {
						info = iter_10_3
					}
				end
			end
		end

		local var_10_7 = {}

		if var_10_4 then
			for iter_10_4, iter_10_5 in pairs(var_10_4) do
				table.insert(var_10_7, iter_10_5)
			end
		end

		if var_10_3 then
			table.insert(self._tabCfgs, {
				tabType = var_10_1.tab_type,
				name = var_10_1.type_name,
				isUnlock = var_10_2,
				subTabSelectIndex = var_10_5,
				info = var_10_1,
				subInfo = next(var_10_7) and var_10_7 or nil
			})
		end
	end
end

function RechargeLayer:_sortTabList()
	table.sort(self._tabCfgs, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1.info

		if arg_12_0.info.sort ~= arg_12_1.info.sort then
			return arg_12_0.info.sort > var_12_0.sort
		else
			return arg_12_0.info.id > var_12_0.id
		end
	end)

	self._selectedIndex = 0
	self._selectedSubIndex = 0

	for iter_11_0, iter_11_1 in pairs(self._tabCfgs) do
		if iter_11_1.info.tab_type == self._params.tabType and iter_11_1.info.shop_type == self._params.shopType then
			self._selectedIndex = iter_11_0 - 1

			if iter_11_1.subInfo then
				for iter_11_2, iter_11_3 in pairs(iter_11_1.subInfo) do
					if iter_11_3.info.shop_first == self._params.shopValue then
						self._selectedSubIndex = iter_11_2 - 1

						break
					end
				end
			end

			break
		end
	end
end

function RechargeLayer:_updateRightCompView(arg_13_1)
	local var_13_0 = arg_13_1.info.tab_type
	local var_13_1 = arg_13_1.info.shop_type
	local var_13_2 = arg_13_1.info.shop_first
	local var_13_3 = arg_13_1.info.shop_first == 0 and var_13_1 or tonumber(var_13_1 .. var_13_2)

	if self._currentComp then
		self._currentComp:setVisible(false)
	end

	if self._comps[var_13_3] then
		self._currentComp = self._comps[var_13_3]
	else
		local var_13_4, var_13_5 = self:_getCompNameByShopInfoId(var_13_0, var_13_1, var_13_2)

		self._currentComp = fgui.UIPackage:createObject("recharge", var_13_4)

		if self.initNetEvent then
			self:initNetEvent()
		end

		if var_13_5 then
			self._currentComp:setSize(self._childSize.width, self._childSize.height)
			self._currentComp:setPosition(self._childX, self._childY)
		else
			self._currentComp:setSize(display.width, display.height)
		end

		self.m_child:addChild(self._currentComp)

		self._comps[var_13_3] = self._currentComp
	end

	self._currentComp:setVisible(true)
	self._currentComp:updateComp(arg_13_1)

	if var_13_0 == var_0_3.SHOP_INFO_TAB_TYPE.SKIN_TAB_TYPE and var_13_1 == var_0_3.SHOP_TYPE.RECHARGE_SKIN then
		if self._selectedContentSkinId and self._currentComp.checkSelectedSkinIndex then
			self._currentComp:checkSelectedSkinIndex(self._selectedContentSkinId)
		end
	elseif self._currentComp.m_enterTransition then
		self._currentComp.m_enterTransition:play()
	end

	if var_13_2 == var_0_3.SHOP_GIFT_VALUE.FURNITURE_GIFT then
		g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.FURNITURE_GIFT)
	end
end

function RechargeLayer:_getCompNameByShopInfoId(arg_14_1, arg_14_2, arg_14_3)
	if arg_14_1 == var_0_3.SHOP_INFO_TAB_TYPE.RECHARGE_TAB_TYPE then
		if arg_14_2 == var_0_3.SHOP_TYPE.RECHARGE then
			return "RechargeComp", true
		elseif arg_14_2 == var_0_3.SHOP_TYPE.MONTH_CARD then
			return "RechargeMonthCardComp", false
		end
	elseif arg_14_1 == var_0_3.SHOP_INFO_TAB_TYPE.GIFT_TAB_TYPE then
		return "RechargeGiftComp", true
	elseif arg_14_1 == var_0_3.SHOP_INFO_TAB_TYPE.SKIN_TAB_TYPE then
		return "RechargeSkinComp", true
	elseif arg_14_1 == var_0_3.SHOP_INFO_TAB_TYPE.HOT_TAB_TYPE then
		if arg_14_2 == var_0_3.SHOP_TYPE.HOT_SALE then
			if arg_14_3 == var_0_3.RECHARGE_HOT_VALUE.HOT_MONTH_CARD then
				return "RechargeMonthCardComp", false
			elseif arg_14_3 == var_0_3.RECHARGE_HOT_VALUE.HOT_SKIN then
				return "RechargeHotSkinComp", false
			elseif arg_14_3 == var_0_3.RECHARGE_HOT_VALUE.HOT_KNIGHT then
				return "RechargeHotKnightComp", false
			elseif arg_14_3 == var_0_3.RECHARGE_HOT_VALUE.HOT_GIFT or arg_14_3 == var_0_3.RECHARGE_HOT_VALUE.HOT_THEME then
				return "RechargeGiftComp", true
			elseif arg_14_3 == var_0_3.RECHARGE_HOT_VALUE.HOT_GM_PUSHGIFT then
				return "RechargeGMPushGiftComp", true
			end
		end
	elseif arg_14_1 == var_0_3.SHOP_INFO_TAB_TYPE.COMMON_TAB_TYPE then
		return "RechargeStoreComp", true
	end

	return "RechargeStoreComp", true
end

function RechargeLayer:receiveCompEvent(arg_15_1, arg_15_2)
	if arg_15_1 == var_0_3.SHOP_EVENT_TAB_CHANGE then
		self._params.tabType = arg_15_2.info.tab_type
		self._params.shopType = arg_15_2.info.shop_type
		self._params.shopValue = arg_15_2.info.shop_first

		self:_updateTopBarRes(arg_15_2.info)
		self:_updateRightCompView(arg_15_2)

		if var_0_2:saveNewGiftIds() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_LEVEL_GIFT_SHOW_NEW)
		end
	elseif arg_15_1 == var_0_3.SHOP_EVENT_GO_TO then
		self._params = arg_15_2

		self:_updateTabListView()
	end
end

function RechargeLayer:_updateTopBarRes(arg_16_1)
	if not arg_16_1.help_id or arg_16_1.help_id == 0 then
		self.m_topBarComp:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.SHOP)
	else
		self.m_topBarComp:setHelpId(arg_16_1.help_id)
	end

	local var_16_0 = {}

	if arg_16_1.type1 ~= 0 or arg_16_1.value1 ~= 0 then
		for iter_16_0 = 4, 1, -1 do
			if arg_16_1["type" .. iter_16_0] ~= 0 then
				table.insert(var_16_0, {
					type = arg_16_1["type" .. iter_16_0],
					value = arg_16_1["value" .. iter_16_0]
				})
			end
		end
	else
		var_16_0 = {
			{
				type = var_0_0.TYPE_RESOURCE,
				value = var_0_0.RESOURCE.TYPE_STAMINA
			},
			{
				type = var_0_0.TYPE_RESOURCE,
				value = var_0_0.RESOURCE.TYPE_COIN
			},
			{
				value = 1,
				type = var_0_0.TYPE_GOLD
			},
			{
				value = 0,
				type = var_0_0.TYPE_GOLD
			}
		}
	end

	if g.core.model.User.resourceData:getResourceById(var_0_0.RESOURCE.TYPE_VOUCHER_COIN_RESOURCE) > 0 then
		var_16_0[3] = {
			type = var_0_0.TYPE_RESOURCE,
			value = var_0_0.RESOURCE.TYPE_VOUCHER_COIN_RESOURCE
		}
	end

	self.m_topBarComp:updateTopRes(var_16_0)
	self:_updateBg(arg_16_1)
end

function RechargeLayer:onUnload()
	var_0_2:saveNewGiftIds()
end

function RechargeLayer:_updateBg(arg_18_1)
	if arg_18_1 and self._bgComp then
		if arg_18_1.tab_type == var_0_3.SHOP_INFO_TAB_TYPE.SKIN_TAB_TYPE then
			self._bgComp:setURL("bg/shop/bg_pifuxinxi.jpg")
		else
			self._bgComp:setURL("bg/shop/bg_shopbg0.jpg")
		end
	end
end

function RechargeLayer:_onRechargeAward(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = {}

	if arg_19_4.awards and next(arg_19_4.awards) then
		for iter_19_0, iter_19_1 in ipairs(arg_19_4.awards) do
			if iter_19_1.size ~= 0 then
				table.insert(var_19_0, iter_19_1)
			end
		end

		g.core.module.ModuleManager:awardSummary(var_19_0)
	end
end

function RechargeLayer:gotoShopByType(arg_20_1)
	if arg_20_1.shopType == self._params.shopType then
		g.core.module.ModuleManager:tip(g.core.lang:get(1143))

		return
	end

	self._params = arg_20_1

	self:_updateTabListView()
end

function RechargeLayer:_convertHotSaleTabData(arg_21_1)
	if var_0_4:isShowHotSaleGMGiftTab() then
		local var_21_0 = clone(arg_21_1)
		local var_21_1 = {
			id = g.core.config.shop_info.getLength() + 1,
			tab_type = var_0_3.SHOP_INFO_TAB_TYPE.HOT_TAB_TYPE,
			shop_type = var_0_3.SHOP_TYPE.HOT_SALE,
			name_1 = g.core.lang:get(1300),
			shop_first = var_0_3.RECHARGE_HOT_VALUE.HOT_GM_PUSHGIFT,
			function_id = var_0_5.PUSH_GIFT
		}

		var_21_1.sort = 99
		var_21_1.help_id = 112
		var_21_1.type1 = 1
		var_21_1.value1 = 4
		var_21_1.type2 = 1
		var_21_1.value2 = 3
		var_21_1.type3 = 999
		var_21_1.value3 = 1
		var_21_1.type4 = 999
		var_21_1.value4 = 0

		table.insert(var_21_0[var_0_3.SHOP_TYPE.HOT_SALE], var_21_1)

		if self._params.tabType == var_0_3.SHOP_INFO_TAB_TYPE.HOT_TAB_TYPE then
			self._params.shopType = var_0_3.SHOP_TYPE.HOT_SALE
			self._params.shopValue = var_0_3.RECHARGE_HOT_VALUE.HOT_GM_PUSHGIFT
		end

		self:_onStartTimeSchedule()

		return var_21_0
	else
		return arg_21_1
	end
end

function RechargeLayer:_onStartTimeSchedule()
	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateTime), 1)
end

function RechargeLayer:_onStopTimeSchedule()
	if self._timeSchedule then
		self:cancelSchedule(self._timeSchedule)

		self._timeSchedule = nil

		self:_updateTabListView()
	end
end

function RechargeLayer:_updateTime()
	if not var_0_4:isShowHotSaleGMGiftTab() then
		self:_onStopTimeSchedule()
	end
end

function RechargeLayer:onUnload()
	self:_onStopTimeSchedule()
end

function RechargeLayer:_onCrossDayUpdate()
	if self._tabNum > 0 then
		self.m_tabList:setNumItems(self._tabNum)
	end
end

return RechargeLayer
