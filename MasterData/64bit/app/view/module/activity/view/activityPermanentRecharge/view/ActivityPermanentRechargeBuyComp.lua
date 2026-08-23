local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.model.User.activityPermanentRechargeData
local ActivityPermanentRechargeConst = require("app.view.module.activity.view.activityPermanentRecharge.const.ActivityPermanentRechargeConst")
local ActivityPermanentRechargeBuyComp = class("ActivityPermanentRechargeBuyComp", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeBuyComp"))

function ActivityPermanentRechargeBuyComp:ctor()
	self._curSelectedIndex = 1
	self._activityId = 0
	self._lastUnlockId = 1
	self._firstId, self._lastId = var_0_3:getFrontAndRearId()

	self.m_leftBtn:getChild("redPointComp"):setId(704)
	self.m_rightBtn:getChild("redPointComp"):setId(705)

	self._awardData = {}
	self._giftData = {}

	self:_initListen()
end

function ActivityPermanentRechargeBuyComp:_initListen()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_giftList:setVirtual()
	self.m_giftList:doFairyBatching(false)
	self.m_giftList:setItemRenderer(handler(self, self._onRenderGiftList))
	self.m_receiveBtn:addClickListener(handler(self, self._onClickReceiveBtn))
	self.m_buyBtn:addClickListener(handler(self, self._onClickBuyBtn))
	self.m_rechargeBtn:addClickListener(handler(self, self._onClickRechargeBtn))
	self.m_returnBtn:addClickListener(handler(self, self._onClickReturnBtn))
	self.m_leftClick:addClickListener(handler(self, self._onClickLeftBtn))
	self.m_rightClick:addClickListener(handler(self, self._onClickRightBtn))
end

function ActivityPermanentRechargeBuyComp:updateView(arg_3_1)
	self._curSelectedIndex = arg_3_1 or self._curSelectedIndex
	self._activityId = var_0_3:getActivityId()
	self._awardData = var_0_3:getAwardDataById(arg_3_1)
	self._giftData = var_0_3:getGiftDataById(arg_3_1)

	local var_3_0 = var_0_3:getLastNeedRechargeNum()

	self._lastUnlockId = var_0_3:getLastUnlockId()

	self.m_allReceiveController:setSelectedIndex(var_0_3:isAllAwardReceive() and 1 or 0)
	self.m_leftBtn:setVisible(arg_3_1 > self._firstId)
	self.m_leftClick:setVisible(arg_3_1 > self._firstId)
	self.m_preLevel:setVisible(arg_3_1 > self._firstId)
	self.m_rightBtn:setVisible(arg_3_1 < self._lastId)
	self.m_rightClick:setVisible(arg_3_1 < self._lastId)
	self.m_nextLevel:setVisible(arg_3_1 < self._lastId)

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.JAPAN then
		var_3_0 = var_3_0 * 24
	elseif config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA and config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.KR then
		var_3_0 = var_3_0 / 100
	end

	self.m_numTxt:setText(g.core.lang:get(408323, {
		num = var_3_0
	}))
	self.m_hideGroup:setVisible(not BATTLE_CONFIG_TYPE.isOs)

	local var_3_1 = self._awardData.info.bonus_value

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.JAPAN then
		var_3_1 = self._awardData.info.bonus_value * 24
	elseif config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA and config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.KR then
		var_3_1 = self._awardData.info.bonus_value / 100
	end

	self.m_valueTxt:setText(g.core.lang:get(408322, {
		price = var_3_1
	}))
	self.m_buyBtn:getChild("originTxt"):setText(g.core.lang:get(408324, {
		price = self._giftData.info.discount / 100 * self._giftData.info.diamond_price
	}))
	self.m_buyBtn:getChild("discountTxt"):setText(g.core.lang:get(408324, {
		price = self._giftData.info.diamond_price
	}))
	self.m_awardList:setNumItems(#self._awardData.awards)
	self.m_giftList:setNumItems(#self._giftData.giftList)
	self:_updateBtnStatus()
	self:_updateProgress()
	self:dispatchCompEvent("CurIndex", {
		index = self._curSelectedIndex
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_receiveBtn,
		customData = {
			index = self._curSelectedIndex
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_leftBtn,
		customData = {
			index = self._curSelectedIndex
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_rightBtn,
		customData = {
			index = self._curSelectedIndex
		}
	})
end

function ActivityPermanentRechargeBuyComp:_updateBtnStatus()
	local var_4_0, var_4_1 = var_0_3:getAmountOwnAndNeedSize()

	self.m_returnBtn:setVisible(self._curSelectedIndex ~= self._lastUnlockId)

	if self._awardData.isReceive and not self._awardData.newAwardState then
		self.m_receiveBtn:setCtrlState("isReceived", {
			index = ActivityPermanentRechargeConst.RECEIVE_STATUS.RECEIVED
		})
		self.m_buyBtn:setCtrlState("hasBuy", {
			index = self._giftData.hasBuy and 1 or 0
		})
	elseif (self._curSelectedIndex < self._lastUnlockId or var_4_1 <= var_4_0) and (not self._awardData.isReceive or self._awardData.newAwardState) then
		self.m_receiveBtn:setCtrlState("isReceived", {
			index = ActivityPermanentRechargeConst.RECEIVE_STATUS.ABLE
		})
		self.m_buyBtn:setCtrlState("hasBuy", {
			index = self._giftData.hasBuy and 1 or 0
		})
	else
		self.m_receiveBtn:setCtrlState("isReceived", {
			index = ActivityPermanentRechargeConst.RECEIVE_STATUS.UNABLE
		})
		self.m_buyBtn:setCtrlState("hasBuy", {
			index = 2
		})
	end
end

function ActivityPermanentRechargeBuyComp:_updateProgress()
	local var_5_0 = self._curSelectedIndex

	if self._curSelectedIndex > self._lastUnlockId then
		var_5_0 = self._lastUnlockId
	end

	local var_5_1, var_5_2 = var_0_3:getAmountOwnAndNeedSize()
	local var_5_3 = var_0_3:getNeedLightSizeById(var_5_0)
	local var_5_4 = var_5_3 - (var_5_2 - var_5_1)

	if self._awardData.isReceive or var_5_0 < self._lastUnlockId then
		var_5_4 = var_5_3
	end

	if g.core.platform.PlatformProxy:matchRegionByRegionKeyList({
		"EN"
	}) then
		var_5_3 = var_5_3 / 100
		var_5_4 = var_5_4 / 100
	end

	self.m_progTxt:setText(var_5_4 .. "/" .. var_5_3, false, true)
	self.m_progressBar:setValue(var_5_4)
	self.m_progressBar:setMax(var_5_3)
end

function ActivityPermanentRechargeBuyComp:_onClickReceiveBtn()
	local var_6_0 = self.m_receiveBtn:getController("isReceived"):getSelectedIndex()

	if var_6_0 == ActivityPermanentRechargeConst.RECEIVE_STATUS.RECEIVED then
		var_0_2:tip(g.core.lang:get(408321))

		return
	elseif var_6_0 == ActivityPermanentRechargeConst.RECEIVE_STATUS.UNABLE then
		var_0_2:tip(g.core.lang:get(408308))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Recharge_GetRechargeRebateAward({
		id = self._curSelectedIndex
	})
end

function ActivityPermanentRechargeBuyComp:_onClickBuyBtn()
	local var_7_0 = self.m_buyBtn:getController("hasBuy"):getSelectedIndex()

	if var_7_0 == 0 then
		local var_7_1 = g.core.model.User:getGold()

		if var_7_1 < self._giftData.info.gift_price then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				value = 1,
				type = 999,
				curSize = var_7_1,
				needSize = self._giftData.info.gift_price
			})

			return
		end

		g.core.network.GameNetProxy:send_C2S_Recharge_BuyRechargeRebateGift({
			id = self._curSelectedIndex
		})
	elseif var_7_0 == 1 then
		var_0_2:tip(g.core.lang:get(408317))

		return
	else
		var_0_2:tip(g.core.lang:get(408325))

		return
	end
end

function ActivityPermanentRechargeBuyComp:_onClickRechargeBtn()
	var_0_3:tempSavePreId(self._curSelectedIndex)
	g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RECHARGE
	})
end

function ActivityPermanentRechargeBuyComp:_onClickReturnBtn()
	if self._curSelectedIndex == self._lastUnlockId then
		return
	else
		self:updateView(self._lastUnlockId)
	end
end

function ActivityPermanentRechargeBuyComp:_onClickLeftBtn()
	self:updateView(self._curSelectedIndex - 1)
	self.m_leftTransition:play()
end

function ActivityPermanentRechargeBuyComp:_onClickRightBtn()
	self:updateView(self._curSelectedIndex + 1)
	self.m_rightTransition:play()
end

function ActivityPermanentRechargeBuyComp:_onRenderAwardList(arg_12_1, arg_12_2)
	arg_12_2:updateIcon(self._awardData.awards[arg_12_1 + 1], self._awardData.isReceive, self._awardData.newAwardState)
end

function ActivityPermanentRechargeBuyComp:_onRenderGiftList(arg_13_1, arg_13_2)
	arg_13_2:updateIcon(self._giftData.giftList[arg_13_1 + 1], self._giftData.hasBuy)
end

function ActivityPermanentRechargeBuyComp:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_RECHARGE_GETRECHARGEREBATEAWARD, handler(self, self._onRcvRechargeRebateAwards), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_RECHARGE_BUYRECHARGEREBATEGIFT, handler(self, self._onBuyGift), self)
	self.m_leftBtn:getTransition("loop"):play(-1, 0)
	self.m_rightBtn:getTransition("loop"):play(-1, 0)
end

function ActivityPermanentRechargeBuyComp:_onBuyGift(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if arg_15_4.awards then
		var_0_2:awardSummary(arg_15_4.awards or {})

		self._giftData.hasBuy = true

		self.m_giftList:setNumItems(#self._giftData.giftList)
		self:_updateBtnStatus()
	end
end

function ActivityPermanentRechargeBuyComp:_onRcvRechargeRebateAwards(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if arg_16_4 and arg_16_4.awards then
		var_0_2:awardSummary(arg_16_4.awards or {}, nil, nil, g.core.lang:get(300001))
		self:updateView(self._curSelectedIndex)
	end
end

return ActivityPermanentRechargeBuyComp
