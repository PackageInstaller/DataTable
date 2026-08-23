local ShopSummerPlayComp = class("ShopSummerPlayComp", require("app.fairyGUI.shop.UI_ShopSummerPlayComp"))
local var_0_1 = g.core.model.User.shopData
local var_0_2 = g.core.const.ConstMgr
local var_0_4 = g.core.model.User.themeData

function ShopSummerPlayComp:ctor()
	self._info = nil
	self._shopInfoList = nil
	self._showList = nil
	self._isUnlock = true

	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemListRender))
	self.m_tabList:setIniter()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangeTab))
	self.m_tabList:setVisible(false)
end

function ShopSummerPlayComp:_onItemListRender(arg_2_1, arg_2_2)
	if self._showList and self._showList[arg_2_1 + 1] then
		arg_2_2:updateCell(self._showList[arg_2_1 + 1], arg_2_1, self._info, self._isUnlock)
	end
end

function ShopSummerPlayComp:_onTabListRenderer(arg_3_1, arg_3_2)
	if self._subInfo then
		local var_3_0 = self._subInfo[arg_3_1 + 1] or nil

		if var_3_0 then
			arg_3_2:setTitle(var_3_0.name_2)
			arg_3_2:getChild("indexTxt"):setText(arg_3_1 + 1)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = arg_3_2,
				customData = {
					themeValue = var_3_0.shop_first
				}
			})
		end
	end
end

function ShopSummerPlayComp:_onChangeTab()
	local var_4_0 = self._subInfo[self.m_tabList:getSelectedIndex() + 1]

	if self._info.id ~= var_4_0.id then
		self._info = var_4_0

		self:_updateCurShowItemListData()
	end
end

function ShopSummerPlayComp:updateComp(arg_5_1)
	if arg_5_1 then
		g.core.common.ActivitySort:setSortTp(g.core.common.ActivitySort.SHOP_SHOW)

		self._info = arg_5_1.info
		self._subInfo = arg_5_1.subInfo

		if arg_5_1.subInfo then
			self.m_isShowSubController:setSelectedIndex(1)
			self.m_tabList:setNumItems(#arg_5_1.subInfo)
			self.m_tabList:setSelectedIndex(0)

			if #arg_5_1.subInfo > 1 then
				self.m_tabList:setVisible(true)
			end

			self:_updateItemListData()
			self:checkLastTimeShow()
		else
			self.m_isShowSubController:setSelectedIndex(0)
			self.m_shopName:setText(self._info.type_name)
			self:_updateItemListData()
			self:checkLastTimeShow()
		end

		self.m_enterTransition:play()
	end
end

function ShopSummerPlayComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, handler(self, self._onShop), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, handler(self, self._onRcvItemUse), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._updateCurShowItemListData), self)

	if self._info then
		self:checkLastTimeShow()
	end
end

function ShopSummerPlayComp:checkLastTimeShow()
	self.m_lastTimeTxt:setVisible(false)

	if self._info.shop_type == var_0_2.ShopConst.SHOP_TYPE.UNITE_TOKEN_NORMAL and self._info.function_id == g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_UNITE_TOKEN_LIMIT then
		self._endTime = g.core.model.User.recruitData:getUniteTokenRecruitLimitCloseTime()

		self:refreshShopTime()

		self._timeSchedule = self._timeSchedule or g.core.common.Scheduler:newSchedule(handler(self, self.refreshShopTime), 1)
	elseif self._info.shop_type == var_0_2.ShopConst.SHOP_TYPE.UNITE_TOKEN_OPENSERVER then
		self._endTime = g.core.model.User.recruitData:getOpenServerUniteTokenRecruitCloseTime()

		self:refreshShopTime()

		self._timeSchedule = self._timeSchedule or g.core.common.Scheduler:newSchedule(handler(self, self.refreshShopTime), 1)
	elseif self._info.tab_type == var_0_2.ShopConst.SHOP_INFO_TAB_TYPE.THEME_TAB_TYPE then
		self.m_lastTimeTxt:setVisible(true)

		self._endTime = var_0_4:getThemeMergeEntranceActivityData(self._info.shop_first):getExpireTime()
		self._timeSchedule = self._timeSchedule or g.core.common.Scheduler:newSchedule(handler(self, self.refreshShopTime), 1)

		self:refreshShopTime()
	end

	if not self.m_lastTimeTxt:isVisible() then
		self.m_descTxt:setText(self._info.tip)
	else
		self.m_descTxt:setText("")
	end
end

function ShopSummerPlayComp:_onStopTimeSchedule()
	if self._timeSchedule then
		g.core.common.Scheduler:cancelSchedule(self._timeSchedule)
	end

	self._timeSchedule = nil
end

function ShopSummerPlayComp:refreshShopTime()
	local var_9_0, var_9_1, var_9_2, var_9_3 = g.core.common.ServerTime:getLeftTimeParts(self._endTime)
	local var_9_4 = var_9_0 > 0 and string.format(g.core.lang:get(108052), var_9_0, var_9_1, var_9_2, var_9_3) or var_9_1 > 0 and string.format(g.core.lang:get(108051), var_9_1, var_9_2, var_9_3) or var_9_2 > 0 and string.format(g.core.lang:get(108050), var_9_2, var_9_3) or string.format(g.core.lang:get(108049), var_9_3)

	self.m_lastTimeTxt:setText(g.core.lang:get(107059, {
		timeTip = var_9_4
	}))

	if var_9_0 + var_9_1 + var_9_2 + var_9_3 <= 0 then
		self:_onStopTimeSchedule()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SHOP_NEED_REFRESH, false)
	end
end

function ShopSummerPlayComp:_updateItemListData(arg_10_1)
	if self._info then
		local var_10_0 = {}

		var_10_0 = arg_10_1 and var_0_1:getThemeInfo(self._info.shop_type, arg_10_1, true) or var_0_1:getThemeInfo(self._info.shop_type, self._info.shop_first, true)

		if self._subInfo then
			self._shopInfoList = {}

			for iter_10_0, iter_10_1 in pairs(var_10_0) do
				self._shopInfoList[iter_10_1.shop_second] = self._shopInfoList[iter_10_1.shop_second] or {}

				table.insert(self._shopInfoList[iter_10_1.shop_second], iter_10_1)
			end
		else
			self._shopInfoList = var_10_0 or {}
		end

		self:_updateCurShowItemListData()
	end
end

function ShopSummerPlayComp:_updateCurShowItemListData()
	if self._info then
		if self._info.open_type == 0 then
			self.m_showTipController:setSelectedIndex(0)

			self._isUnlock = true
		else
			self.m_showTipController:setSelectedIndex(1)
			self.m_tipTxt:setText(var_0_1:getShopUnlockText(self._info.open_type, self._info.open_value))

			self._isUnlock = not var_0_1:checkBuyBan({
				buy_ban_type = self._info.open_type,
				buy_ban_value = self._info.open_value
			})
		end

		if not self.m_lastTimeTxt:isVisible() then
			self.m_descTxt:setText(self._info.tip)
		else
			self.m_descTxt:setText("")
		end
	end

	self._showList = self._subInfo and (self._shopInfoList[self._info.shop_second] or {}) or self._shopInfoList

	if self._hasUpdate then
		self:_updateItemList()
	else
		self:newScheduleOnce(handler(self, self._updateItemList), 0.2)

		self._hasUpdate = true
	end
end

function ShopSummerPlayComp:_updateItemList()
	if self._isIgnoreListTransition then
		self.m_itemList:setNumItems(#self._showList)
	else
		self.m_itemList:setNumItems(0)
		self.m_itemList:setNumItems(#self._showList)
		self.m_itemList:transitionShowCells("listCardAUiLeftIn", 0.03, 1)
	end
end

function ShopSummerPlayComp:_onShop(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if self:isVisible() then
		local var_13_0 = g.core.config.shop_score_info.get(arg_13_4.info.id)

		self._isIgnoreListTransition = true

		self:_updateItemListData(var_13_0.shop_first)

		self._isIgnoreListTransition = false

		if var_13_0.type == g.core.common.Goods.TYPE_ITEM and g.core.config.item_info.get(var_13_0.value).if_open == 1 then
			g.core.network.GameNetProxy:send_C2S_Item_Use({
				id = var_13_0.value,
				num = var_13_0.size * arg_13_4.info.num
			})

			return
		end

		g.core.module.ModuleManager:awardSummary((arg_13_4.awards == nil or nil) and {
			{
				type = var_13_0.type,
				value = var_13_0.value,
				size = var_13_0.size * arg_13_4.info.num
			}
		})
	end
end

function ShopSummerPlayComp:_onRcvItemUse(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if self:isVisible() then
		g.core.module.ModuleManager:awardSummary(arg_14_4.awards)
	end
end

function ShopSummerPlayComp:_onCrossDay()
	if self._info.shop_first == 1 and self:isVisible() then
		self:_updateItemListData()
	end
end

function ShopSummerPlayComp:onUnload()
	self:_onStopTimeSchedule()
end

return ShopSummerPlayComp
