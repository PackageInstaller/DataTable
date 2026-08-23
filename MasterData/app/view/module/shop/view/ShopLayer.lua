local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE
local var_0_2 = g.core.model.User.shopData
local var_0_3 = g.core.common.Goods
local ShopLayer = class("ShopLayer", require("app.fairyGUI.shop.UI_ShopLayer"), function(arg_1_0)
	local var_1_0 = not (arg_1_0 and arg_1_0.isAsPopUp)

	return fgui.GComponent:create({
		resName = "ShopLayer",
		pkgPath = "ui/shop/shop",
		pkgName = "shop",
		isFullScreen = var_1_0
	}, arg_1_0)
end)

function ShopLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1 and arg_2_1.isAsPopUp then
		self:getView():setSize(display.width, display.height)
	end

	arg_2_1.tabType = arg_2_1.tabType or arg_2_1.route1
	arg_2_1.shopType = arg_2_1.shopType or arg_2_1.route2
	arg_2_1.subId = arg_2_1.subId

	if not arg_2_1.subId and tonumber(arg_2_1.route3) and tonumber(arg_2_1.route3) > 0 then
		arg_2_1.subId = tonumber(arg_2_1.route3)
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
	self._selectedIndex = 0
	self._comps = {}
	self._currentComp = nil
	self._tabNum = 0
	self._childSize = self.m_childComp:getSize()
	self._childX = self.m_childComp:getX()
	self._childY = self.m_childComp:getY()

	self:_init()
end

function ShopLayer:_init()
	self:addBg("bg/shop/bg_wanfasd.jpg", true)
	self.m_topBarComp:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.SHOP)
	self.m_tabList:setIniter()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRenderer))
	self:addListen(self.m_tabList)
end

function ShopLayer:_onTabListItemRenderer(arg_6_1, arg_6_2)
	if arg_6_1 > #self._tabCfgs then
		return
	end

	if self._tabCfgs[arg_6_1 + 1] then
		arg_6_2:updateCell(self._tabCfgs[arg_6_1 + 1])
	end
end

function ShopLayer:onLoad()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_STORE)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SHOP_NEED_REFRESH, handler(self, self._updateTabListView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._updateTabListView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_GETSHOPINFO, handler(self, self._updateTabListView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_CAR_UNFOLLOW, handler(self, self._onS2CShopCarUnFollow), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_CAR_FOLLOW, handler(self, self._onS2CShopCarFollow), self)

	if var_0_2:isNeedUpdateInfo() then
		g.core.network.GameNetProxy:send_C2S_Shop_GetShopInfo({})
	end

	self:_updateTabListView()
end

function ShopLayer:_updateTabListView()
	self._tabCfgs = {}

	local var_8_0 = var_0_2:getShopInfoGroup()

	if var_8_0[var_0_1.PLAY_TAB_TYPE] then
		self:_initShopInfo(var_8_0[var_0_1.PLAY_TAB_TYPE])
	end

	if var_8_0[var_0_1.FLUSH_TAB_TYPE] then
		self:_initShopFlushInfo(var_8_0[var_0_1.FLUSH_TAB_TYPE])
	end

	self:_sortTabList()

	self._tabNum = #self._tabCfgs

	if self._tabNum > 0 then
		self.m_tabList:setNumItems(self._tabNum)
		self.m_tabList:setSelectedIndex(self._selectedIndex)

		if self._selectedIndex < self._tabNum then
			local var_8_1 = self.m_tabList:getChildAt((self.m_tabList:itemIndexToChildIndex(self._selectedIndex)))

			if var_8_1 then
				var_8_1:onSelected(self._selectedSubIndex)
			end
		end
	end

	self.m_tabList:scrollToView(self._selectedIndex)
end

function ShopLayer:_initShopFlushInfo(arg_9_1)
	local var_9_0 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		var_9_0 = iter_9_1[1]

		if not (iter_9_1[1].function_id ~= 0 and not g.core.common.ModuleUnlock:isModuleUnlock(var_9_0.function_id, nil, true) or false) then
			table.insert(var_9_2, {
				info = var_9_0
			})
		end
	end

	local var_9_3 = {
		tabType = var_9_0.tab_type,
		name = var_9_0.tab_name,
		isUnlock = #var_9_2 > 0
	}

	var_9_3.subTabSelectIndex = 0

	if #var_9_2 > 0 then
		var_9_3.info = var_9_2[1].info or {}
	end

	var_9_3.subInfo = next(var_9_2) and var_9_2 or nil

	table.insert(self._tabCfgs, var_9_3)
end

function ShopLayer:_initShopInfo(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		local var_10_1 = iter_10_1[1]
		local var_10_2 = true
		local var_10_3 = false
		local var_10_4 = {}
		local var_10_5 = 0

		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			var_10_2 = iter_10_3.function_id ~= 0 and not g.core.common.ModuleUnlock:isModuleUnlock(iter_10_3.function_id, nil, iter_10_3.function_id ~= 2400) or false

			if not var_10_2 and g.core.model.User.shopData:checkShopOpen(iter_10_3.shop_type, iter_10_3.shop_first, iter_10_3.function_id) then
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

		local var_10_8 = {}

		if var_10_4 then
			for iter_10_4, iter_10_5 in pairs(var_10_4) do
				table.insert(var_10_8, iter_10_5)
			end
		end

		if var_10_3 then
			table.insert(self._tabCfgs, {
				tabType = var_10_1.tab_type,
				name = var_10_1.type_name,
				isUnlock = var_10_2,
				subTabSelectIndex = var_10_5,
				info = var_10_1,
				subInfo = next(var_10_8) and var_10_8 or nil
			})
		end
	end
end

function ShopLayer:_sortTabList()
	local var_11_0 = g.core.const.ConstMgr.ShopConst

	table.sort(self._tabCfgs, function(arg_12_0, arg_12_1)
		if arg_12_0.info.shop_type == var_11_0.SHOP_TYPE.SHOP_CAR or arg_12_1.info.shop_type == var_11_0.SHOP_TYPE.SHOP_CAR then
			return arg_12_0.info.shop_type == var_11_0.SHOP_TYPE.SHOP_CAR
		end

		if arg_12_0.info.season_function and arg_12_1.info.season_function then
			if arg_12_0.info.season_function > 0 and arg_12_1.info.season_function > 0 then
				local var_12_0 = var_0_2:isSeasonOpen(arg_12_0.info.season_function)

				if var_12_0 ~= var_0_2:isSeasonOpen(arg_12_1.info.season_function) then
					return var_12_0
				end
			elseif arg_12_0.info.season_function > 0 and arg_12_1.info.season_function == 0 then
				return (var_0_2:isSeasonOpen(arg_12_0.info.season_function))
			elseif arg_12_0.info.season_function == 0 and arg_12_1.info.season_function > 0 then
				return not var_0_2:isSeasonOpen(arg_12_1.info.season_function)
			end
		end

		return (arg_12_1.info.sort or 0) < (arg_12_0.info.sort or 0)
	end)

	self._selectedIndex = 0
	self._selectedSubIndex = 0

	local function var_11_1(arg_13_0, arg_13_1)
		return arg_13_0.info.shop_first == arg_13_1
	end

	local function var_11_2(arg_14_0, arg_14_1)
		return arg_14_0.info.id == arg_14_1
	end

	for iter_11_0, iter_11_1 in pairs(self._tabCfgs) do
		if iter_11_1.info.tab_type == self._params.tabType and (iter_11_1.info.shop_type == self._params.shopType or self._params.tabType == var_0_1.FLUSH_TAB_TYPE) then
			self._selectedIndex = iter_11_0 - 1

			if iter_11_1.subInfo then
				for iter_11_2, iter_11_3 in pairs(iter_11_1.subInfo) do
					if self._params.subId and var_11_2(iter_11_3, self._params.subId) then
						self._selectedSubIndex = iter_11_2 - 1

						break
					elseif self._params.shopValue and var_11_1(iter_11_3, self._params.shopValue) then
						self._selectedSubIndex = iter_11_2 - 1

						break
					end
				end
			end

			break
		end
	end
end

function ShopLayer:_updateRightCompView(arg_15_1)
	if self._currentComp then
		self._currentComp:setVisible(false)
	end

	if self._comps[arg_15_1.info.tab_type] then
		self._currentComp = self._comps[arg_15_1.info.tab_type]
	else
		self._currentComp = fgui.UIPackage:createObject("shop", self:_getCompNameByShopInfoId(arg_15_1.info.tab_type))

		self._currentComp:setSize(self._childSize.width, self._childSize.height)
		self._currentComp:setPosition(self._childX, self._childY)
		self.m_child:addChild(self._currentComp)

		self._comps[arg_15_1.info.tab_type] = self._currentComp
	end

	self._currentComp:updateComp(arg_15_1)
	self._currentComp:setVisible(true)
end

function ShopLayer:_getCompNameByShopInfoId(arg_16_1)
	if arg_16_1 == var_0_1.PLAY_TAB_TYPE then
		return "ShopPlayComp"
	elseif arg_16_1 == var_0_1.FLUSH_TAB_TYPE then
		return "ShopFlushComp"
	else
		return "ShopPlayComp"
	end
end

function ShopLayer:receiveCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == var_0_0.ShopConst.SHOP_EVENT_TAB_CHANGE then
		self._params.tabType = arg_17_2.info.tab_type
		self._params.shopType = arg_17_2.info.shop_type
		self._params.shopValue = arg_17_2.info.shop_first

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SHOP_TAB_CHANGE)
		self:_updateTopBarRes(arg_17_2.info)
		self:_updateRightCompView(arg_17_2)
	end
end

function ShopLayer:_updateTopBarRes(arg_18_1)
	if not arg_18_1.help_id or arg_18_1.help_id == 0 then
		self.m_topBarComp:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.SHOP)
	else
		self.m_topBarComp:setHelpId(arg_18_1.help_id)
	end

	local var_18_0 = {}

	if arg_18_1.type1 ~= 0 or arg_18_1.value1 ~= 0 then
		for iter_18_0 = 3, 1, -1 do
			if arg_18_1["type" .. iter_18_0] ~= 0 then
				table.insert(var_18_0, {
					type = arg_18_1["type" .. iter_18_0],
					value = arg_18_1["value" .. iter_18_0]
				})
			end
		end
	else
		var_18_0 = {
			{
				type = var_0_3.TYPE_RESOURCE,
				value = var_0_3.RESOURCE.TYPE_STAMINA
			},
			{
				type = var_0_3.TYPE_RESOURCE,
				value = var_0_3.RESOURCE.TYPE_COIN
			},
			{
				value = 0,
				type = var_0_3.TYPE_GOLD
			}
		}
	end

	self.m_topBarComp:updateTopRes(var_18_0)
end

function ShopLayer:_onCrossDay()
	self:_updateTabListView()
end

function ShopLayer:_onS2CShopCarFollow()
	g.core.module.ModuleManager:tip(g.core.lang:get(433101))
end

function ShopLayer:_onS2CShopCarUnFollow()
	g.core.module.ModuleManager:tip(g.core.lang:get(433102))
end

return ShopLayer
