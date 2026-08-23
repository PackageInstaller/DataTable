local ShopPlayComp = class("ShopPlayComp", require("app.fairyGUI.shop.UI_ShopPlayComp"))
local var_0_1 = g.core.model.User.shopData
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = g.core.model.User.activityDataManager
local var_0_5 = g.core.common.ServerTime
local DrawKnight = require("app.view.common.DrawKnight")

function ShopPlayComp:ctor()
	self._info = nil
	self._shopInfoList = nil
	self._showList = nil
	self._isUnlock = true
	self._seasonHandler = nil
	self._seasonEndTime = 0
	self._isOneKeyBuying = false

	self.m_itemList:setVirtual()
	self.m_itemList:doFairyBatching(false)
	self.m_itemList:setItemRenderer(handler(self, self._onItemListRender))
	self.m_tabList:setIniter()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangeTab))

	local var_1_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_1_1 = self.m_descTxt:getPosition()
	local var_1_2 = self.m_lastTimeTxt:getPosition()

	self.m_descTxt:setPosition(var_1_1.x - var_1_0.x, var_1_1.y)
	self.m_lastTimeTxt:setPosition(var_1_2.x - var_1_0.x, var_1_2.y)

	if self.m_clickArea then
		self.m_clickArea:addClickListener(handler(self, self._onClickOneKeyBuy))
	end

	if self.m_oneKeyBuyBtn then
		self.m_oneKeyBuyBtn:setVisible(false)
	end

	if self.m_clickArea then
		self.m_clickArea:setVisible(false)
	end
end

function ShopPlayComp:_onItemListRender(arg_2_1, arg_2_2)
	if self._showList and self._showList[arg_2_1 + 1] then
		arg_2_2:updateCell(self._showList[arg_2_1 + 1], arg_2_1, self._info, self._isUnlock, self._bgStyle, self._activityId)
	end
end

function ShopPlayComp:_onTabListRenderer(arg_3_1, arg_3_2)
	if self._subInfo then
		local var_3_0 = self._subInfo[arg_3_1 + 1] or nil

		if var_3_0 then
			arg_3_2:setTitle(var_3_0.name_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = arg_3_2,
				customData = {
					shopType = var_3_0.shop_type,
					themeValue = var_3_0.shop_first
				}
			})
		end
	end
end

function ShopPlayComp:_onChangeTab()
	local var_4_0 = self._subInfo[self.m_tabList:getSelectedIndex() + 1]

	if self._info.id ~= var_4_0.id then
		self._info = var_4_0

		self:_updateCurShowItemListData()
	end
end

function ShopPlayComp:updateComp(arg_5_1)
	if arg_5_1 then
		if self._seasonHandler then
			self:cancelSchedule(self._seasonHandler)

			self._seasonHandler = nil
		end

		g.core.common.ActivitySort:setSortTp(g.core.common.ActivitySort.SHOP_SHOW)

		self._info = arg_5_1.info
		self._subInfo = arg_5_1.subInfo
		self._bgStyle = arg_5_1.bgStyle or 0
		self._activityId = arg_5_1.activity_id

		if arg_5_1.subInfo then
			self.m_isShowSubController:setSelectedIndex(1)
			self.m_tabList:setNumItems(#arg_5_1.subInfo)
			self.m_tabList:setSelectedIndex(0)
			self:_updateItemListData()
			self:checkLastTimeShow()
		else
			self.m_isShowSubController:setSelectedIndex(0)
			self.m_shopName:setText(self._info.type_name)
			self:_updateItemListData()
			self:checkLastTimeShow()
		end

		if arg_5_1.hideAll then
			self.m_isShowSubController:setSelectedIndex(2)
		end

		if self._info then
			self.m_isSeasonController:setSelectedIndex(self._info.season_function > 0 and 1 or 0)

			if self._info.season_function > 0 then
				local var_5_0 = self._info.season_function
				local var_5_1 = var_0_1:isSeasonOpen(self._info.season_function)

				self.m_seasonStatusController:setSelectedIndex(var_5_1 and 1 or 0)

				if var_5_1 then
					self._seasonEndTime = var_0_1:getSeasonEndTime(var_5_0)

					self:_checkSeasonTime()

					self._seasonHandler = self._seasonHandler or self:newSchedule(handler(self, self._checkSeasonTime), 1)
				end
			end
		end

		self:_addAssistant()
		self:updateCostNumText()

		if self.m_isBountyController:getSelectedIndex() == 1 then
			self.m_isSeasonController:setSelectedIndex(0)
		end

		self.m_enterTransition:play()
	end
end

function ShopPlayComp:updateCostNumText()
	if self._info.shop_type == var_0_3.ShopConst.SHOP_TYPE.BOUNTY then
		local var_6_0 = g.core.const.ConstMgr.BountyConst.SHOP_FIRST_TARGET[self._info.shop_first] or 0

		self.m_tipsTxt:setText(var_6_0 > 0 and g.core.lang:get(107131, {
			cur = var_0_1:getShopNeedNumBuyBanType(var_0_3.ShopConst.TASK_TYPE.BOUNTY, g.core.common.Goods.RESOURCE.TYPE_BOUNTY),
			target = var_6_0
		}) or "")
		self.m_tipsTxt2:setText(g.core.lang:get(107132))
	end
end

function ShopPlayComp:_addAssistant()
	local var_7_0 = self._info.shop_type == var_0_3.ShopConst.SHOP_TYPE.BOUNTY

	if self._info.shop_type == var_0_3.ShopConst.SHOP_TYPE.BOUNTY then
		local var_7_1 = {}

		if self._info.spine > 0 then
			var_7_1.resId = self._info.spine or 700060
		end

		var_7_1.isShowBg = false
		var_7_1.isAlphaNode = true

		if not self._resId or self._resId ~= var_7_1.resId then
			self.m_knightComp:removeChildren()

			local var_7_2 = DrawKnight.new(var_7_1)

			self.m_knightComp:addChild(var_7_2)
			var_7_2:setAlphaRect(var_0_3.SpineConst.MASK_TYPE.HORIZON, cc.rect(-150, -10, 390, 100), 300)
		end

		self._resId = var_7_1.resId
	end

	self.m_isBountyController:setSelectedIndex(var_7_0 and 1 or 0)
	self:checkLastTimeShow()

	self._listWidth = self._listWidth or self.m_itemList:getWidth()

	self.m_itemList:setWidth(var_7_0 and 700 or self._listWidth)
end

function ShopPlayComp:_checkSeasonTime()
	local var_8_0 = self._seasonEndTime - var_0_5:getTime()

	if var_8_0 > 86400 then
		self.m_seasonLastTime:setText((var_0_5:getLeftDHMFormat(self._seasonEndTime)))
	elseif var_8_0 > 0 then
		self.m_seasonLastTime:setText((var_0_5:getLeftHMSFormat(self._seasonEndTime)))
	else
		self.m_seasonLastTime:setText("")
	end
end

function ShopPlayComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, handler(self, self._onShop), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, handler(self, self._onRcvItemUse), self)
	g.core.event.EventManager:addEventListener("EVENT_SHOP_ONE_KEY_BUY_FINISH", handler(self, self._onOneKeyBuyFinish), self)

	if self._info then
		self:checkLastTimeShow()
	end
end

function ShopPlayComp:checkLastTimeShow()
	self.m_lastTimeTxt:setVisible(false)

	if self._info.shop_type == var_0_3.ShopConst.SHOP_TYPE.UNITE_TOKEN_NORMAL and self._info.function_id == g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_UNITE_TOKEN_LIMIT then
		self.m_lastTimeTxt:setVisible(true)

		self._endTime = g.core.model.User.recruitData:getUniteTokenRecruitLimitCloseTime()

		self:refreshShopTime()

		self._timeSchedule = self._timeSchedule or g.core.common.Scheduler:newSchedule(handler(self, self.refreshShopTime), 1)
	elseif self._info.shop_type == var_0_3.ShopConst.SHOP_TYPE.UNITE_TOKEN_OPENSERVER then
		self.m_lastTimeTxt:setVisible(true)

		self._endTime = g.core.model.User.recruitData:getOpenServerUniteTokenRecruitCloseTime()

		self:refreshShopTime()

		self._timeSchedule = self._timeSchedule or g.core.common.Scheduler:newSchedule(handler(self, self.refreshShopTime), 1)
	elseif self._info.tab_type == var_0_3.ShopConst.SHOP_INFO_TAB_TYPE.THEME_TAB_TYPE then
		self.m_lastTimeTxt:setVisible(true)

		local var_10_0 = var_0_4:getShowActivityDataByCfg(self._info.shop_type, self._info.shop_first)

		if var_10_0 and var_10_0:isAwardPeriod() then
			self._endTime = var_10_0:getExpireTime()
		end

		self._timeSchedule = self._timeSchedule or g.core.common.Scheduler:newSchedule(handler(self, self.refreshShopTime), 1)

		self:refreshShopTime()
	elseif self._info.tab_type == var_0_3.ShopConst.SHOP_INFO_TAB_TYPE.CULTIVATE_TYPE then
		-- block empty
	end

	if not self.m_lastTimeTxt:isVisible() then
		self.m_descTxt:setText(self._info.tip)
	else
		self.m_descTxt:setText("")
	end

	if self.m_isBountyController:getSelectedIndex() == 1 then
		self:_onStopTimeSchedule()

		self._endTime = g.core.model.User.bountyData:getActivityTimeInfo().expireTime

		if g.core.common.ServerTime:getTime() < self._endTime then
			self._timeSchedule = g.core.common.Scheduler:newSchedule(handler(self, self.updateBountyTime), 1)
		end

		self:updateBountyTime()
	end
end

function ShopPlayComp:_onStopTimeSchedule()
	if self._timeSchedule then
		g.core.common.Scheduler:cancelSchedule(self._timeSchedule)
	end

	self._timeSchedule = nil
end

function ShopPlayComp:refreshShopTime()
	self._endTime = self._endTime or -1

	local var_12_0, var_12_1, var_12_2, var_12_3 = g.core.common.ServerTime:getLeftTimeParts(self._endTime)
	local var_12_4 = var_12_0 > 0 and string.format(g.core.lang:get(108052), var_12_0, var_12_1, var_12_2, var_12_3) or var_12_1 > 0 and string.format(g.core.lang:get(108051), var_12_1, var_12_2, var_12_3) or var_12_2 > 0 and string.format(g.core.lang:get(108050), var_12_2, var_12_3) or string.format(g.core.lang:get(108049), var_12_3)

	self.m_lastTimeTxt:setText(g.core.lang:get(107059, {
		timeTip = var_12_4
	}))

	if var_12_0 + var_12_1 + var_12_2 + var_12_3 <= 0 then
		self:_onStopTimeSchedule()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SHOP_NEED_REFRESH, false)
	end
end

function ShopPlayComp:_updateItemListData(arg_13_1)
	if self._info then
		local var_13_0 = {}

		if self._info.shop_type == g.core.const.ConstMgr.ShopConst.SHOP_TYPE.THEME or self._info.shop_type == g.core.const.ConstMgr.ShopConst.SHOP_TYPE.CULTIVATE then
			var_13_0 = arg_13_1 and var_0_1:getThemeInfo(self._info.shop_type, arg_13_1, true) or var_0_1:getThemeInfo(self._info.shop_type, self._info.shop_first, true)
		elseif self._info.shop_type == g.core.const.ConstMgr.ShopConst.SHOP_TYPE.SHOP_CAR then
			var_13_0 = var_0_1:getShopCarInfo()

			if self.m_oneKeyBuyBtn then
				self.m_oneKeyBuyBtn:setVisible(true)
			end

			if self.m_clickArea then
				self.m_clickArea:setVisible(true)
			end

			local var_13_1 = false

			for iter_13_0, iter_13_1 in ipairs(var_13_0) do
				if not var_0_1:checkBuyBan(iter_13_1) then
					local var_13_2 = var_0_1:getBuyLimitLeft(iter_13_1)

					if var_13_2 and var_13_2 > 0 then
						local var_13_3 = var_0_1:getBuyItemNum(iter_13_1, 1)

						if var_13_3 and var_13_3 > 0 then
							var_13_1 = true

							break
						end
					end
				end
			end

			if self.m_oneKeyBtnStateController then
				self.m_oneKeyBtnStateController:setSelectedIndex(var_13_1 and 1 or 0)
			end
		else
			var_13_0 = arg_13_1 and var_0_1:getInfo(self._info.shop_type, arg_13_1, true) or var_0_1:getInfo(self._info.shop_type, self._info.shop_first, true)

			if self.m_oneKeyBuyBtn then
				self.m_oneKeyBuyBtn:setVisible(false)
			end

			if self.m_clickArea then
				self.m_clickArea:setVisible(false)
			end
		end

		if self._subInfo then
			self._shopInfoList = {}

			for iter_13_2, iter_13_3 in pairs(var_13_0) do
				self._shopInfoList[iter_13_3.shop_second] = self._shopInfoList[iter_13_3.shop_second] or {}

				if self._info.shop_type == var_0_3.ShopConst.SHOP_TYPE.UNITE_TOKEN_NORMAL then
					if g.core.model.User.recruitData:isUniteTokenActOpen(iter_13_3.activity_id) then
						table.insert(self._shopInfoList[iter_13_3.shop_second], iter_13_3)
					end
				else
					table.insert(self._shopInfoList[iter_13_3.shop_second], iter_13_3)
				end
			end
		else
			self._shopInfoList = var_13_0 or {}

			if self._info.shop_type == var_0_3.ShopConst.SHOP_TYPE.UNITE_TOKEN_NORMAL then
				for iter_13_4 = #self._shopInfoList, 1, -1 do
					if not g.core.model.User.recruitData:isUniteTokenActOpen(self._shopInfoList[iter_13_4].activity_id) then
						table.remove(self._shopInfoList, iter_13_4)
					end
				end
			end
		end

		self:_updateCurShowItemListData()
	end
end

function ShopPlayComp:_updateCurShowItemListData()
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

function ShopPlayComp:_updateItemList()
	if self._isIgnoreListTransition then
		self.m_itemList:setNumItems(#self._showList)
	else
		self.m_itemList:setNumItems(0)
		self.m_itemList:setNumItems(#self._showList)
		self.m_itemList:transitionShowCells("listCardAUiLeftIn", 0.03, 1)
	end

	if #self._showList == 0 then
		if self.m_isEmptyController then
			self.m_isEmptyController:setSelectedIndex(1)
		end
	elseif self.m_isEmptyController then
		self.m_isEmptyController:setSelectedIndex(0)
	end
end

function ShopPlayComp:_onShop(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if self._isOneKeyBuying then
		return
	end

	if self:isVisible() then
		local var_16_0 = g.core.config.shop_score_info.get(arg_16_4.info.id)

		if arg_16_4.shop_id == self._info.id or var_0_1:isShopItemFollow(var_16_0.id) then
			self._isIgnoreListTransition = true

			self:_updateItemListData(var_16_0.shop_first)

			self._isIgnoreListTransition = false
		end

		if var_16_0.type == g.core.common.Goods.TYPE_ITEM and g.core.config.item_info.get(var_16_0.value).if_open == 1 then
			g.core.network.GameNetProxy:send_C2S_Item_Use({
				id = var_16_0.value,
				num = var_16_0.size * arg_16_4.info.num
			})

			return
		end

		g.core.module.ModuleManager:awardSummary((arg_16_4.awards == nil or nil) and {
			{
				type = var_16_0.type,
				value = var_16_0.value,
				size = var_16_0.size * arg_16_4.info.num
			}
		})
		self:updateCostNumText()
	end
end

function ShopPlayComp:_onClickOneKeyBuy()
	local var_17_0

	if self.m_oneKeyBtnStateController and self.m_oneKeyBtnStateController:getSelectedIndex() == 0 then
		do return end

		var_17_0 = require("app.view.base.pop.BaseConfirmPop").new
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(107209),
		desc = g.core.lang:get(107210),
		onConfirm = handler(self, self._showOneKeyBuyPop)
	}), {
		touchDisappear = true
	})
end

function ShopPlayComp:_showOneKeyBuyPop()
	self._isOneKeyBuying = true

	local var_18_0 = require("app.view.module.shop.view.shopOneKeyBuy.ShopOneKeyBuyPop").new
	local var_18_1 = {}

	var_18_1.shopCarList = var_0_1:getShopCarInfo() or {}

	g.core.module.ModuleManager:pushPopup(require("app.view.module.shop.view.shopOneKeyBuy.ShopOneKeyBuyPop").new(var_18_1), {
		touchDisappear = false
	})
end

function ShopPlayComp:_onOneKeyBuyFinish()
	self._isOneKeyBuying = false

	self:_updateItemListData()
	self:updateCostNumText()
end

function ShopPlayComp:_onRcvItemUse(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if self:isVisible() then
		g.core.module.ModuleManager:awardSummary(arg_20_4.awards)
	end
end

function ShopPlayComp:_onCrossDay()
	if self._info.shop_first == 1 and self:isVisible() then
		self:_updateItemListData()
	end
end

function ShopPlayComp:onUnload()
	self:_onStopTimeSchedule()
end

function ShopPlayComp:updateBountyTime()
	self._endTime = self._endTime or -1

	local var_23_0, var_23_1, var_23_2, var_23_3 = g.core.common.ServerTime:getLeftTimeParts(self._endTime)

	self.m_timeTips:setText(var_23_0 > 0 and g.core.lang:get(422568, {
		day = var_23_0,
		hour = var_23_1,
		min = var_23_2,
		sec = var_23_3
	}) or var_23_1 > 0 and g.core.lang:get(422569, {
		hour = var_23_1,
		min = var_23_2,
		sec = var_23_3
	}) or g.core.lang:get(422570, {
		hour = var_23_1,
		min = var_23_2,
		sec = var_23_3
	}))

	if var_23_0 + var_23_1 + var_23_2 + var_23_3 <= 0 then
		self:_onStopTimeSchedule()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SHOP_NEED_REFRESH, false)
	end
end

return ShopPlayComp
