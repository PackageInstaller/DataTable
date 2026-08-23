local var_0_0 = g.core.common.Drops
local var_0_1 = g.core.model.User.rechargeData
local var_0_2 = g.core.model.User.phoenixGiftData
local var_0_3 = g.core.model.User.firstRechargeData
local PhoenixGiftPop = class("PhoenixGiftPop", require("app.fairyGUI.phoenixGift.UI_PhoenixGiftPop"), function()
	return fgui.GComponent:create({
		resName = "PhoenixGiftPop",
		pkgName = "phoenixGift",
		pkgPath = "ui/phoenixGift/phoenixGift"
	}, ...)
end)

function PhoenixGiftPop:ctor()
	self._giftList = {}
	self._rechargeInfo = nil

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
	self.m_closeBtn:addClickListener(handler(self, self._onClose))
	self.m_buyBtn:addClickListener(handler(self, self._onClickBuy))
	self:showAtCenter()
	g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.PHOENIX_GIFT_ENTERED)
end

function PhoenixGiftPop:_updateView()
	local var_3_0 = var_0_2:getCurrentGift()

	self._giftList = var_0_0:getGoodsArray(var_3_0.value)
	self._rechargeInfo = var_0_1:getRechargeInfoByTypeAndPrice(var_3_0.recharge_type, var_3_0.recharge_money)

	self.m_buyBtn:setPrice(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney, (config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA or nil) and g.core.model.User.rechargeData:safeCalPriceString(self._rechargeInfo.id, var_0_2:getDiscount() / 100, "*"))
	self.m_rewardList:setNumItems(#self._giftList)
	self.m_discount:setTitle(var_0_2:getDiscount() .. "%")
	var_0_2:saveGiftStatus(var_0_2:getCurGiftId())

	self._FRechargeActId = var_0_3:getFirstRechargeActId()

	self.m_typeController:setSelectedIndex(self._FRechargeActId)
	self.m_detailBtn:updateBtnName()

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		self.m_isSexyController:setSelectedIndex(0)
	else
		self.m_isSexyController:setSelectedIndex(1)
	end
end

function PhoenixGiftPop:_onRenderRewardList(arg_4_1, arg_4_2)
	arg_4_2:getChild("iconComp"):updateIcon(self._giftList[arg_4_1 + 1])
end

function PhoenixGiftPop:_onClickBuy()
	g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, var_0_2:getCurGiftId(), 0)
end

function PhoenixGiftPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function PhoenixGiftPop:_onReceiveGift(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.gift then
		var_0_2:refreshCurGiftId(arg_7_4.gift.update)
		g.core.module.ModuleManager:awardSummary(arg_7_4.gift.awards or {}, nil, nil, nil, handler(self, self._onClose))
	end
end

function PhoenixGiftPop:_refreshNewGift()
	if not var_0_2:isShowEntrance() then
		self:_onClose()
	else
		self:_updateView()
		self:_playEnterEffect()
	end
end

function PhoenixGiftPop:_playEnterEffect()
	self.m_enterEffUp:removeAllEffect()
	self.m_enterEffUp:addEffectSpine({
		isLoop = false,
		anim = "up",
		name = "eff_ui_phoenixGift_enter"
	})
	self.m_enterEffDown:removeAllEffect()
	self.m_enterEffDown:addEffectSpine({
		isLoop = false,
		anim = "down",
		name = "eff_ui_phoenixGift_enter"
	})
	self.m_enterTransition:play()
end

function PhoenixGiftPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onReceiveGift), self)
	self:_updateView()
	self:_playEnterEffect()
end

function PhoenixGiftPop:onUnload()
	if var_0_2:isShowEntrance() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.PHOENIX_REFRESH_NEW_GIFT)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.LAST_PHOENIX_GIFT)
	end
end

return PhoenixGiftPop
