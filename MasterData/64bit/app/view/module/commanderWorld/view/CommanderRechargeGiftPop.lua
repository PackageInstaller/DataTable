local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.giftData
local var_0_2 = g.core.model.User.commanderWorldData
local var_0_3 = g.core.const.ConstMgr.CommanderWorldConst
local CommanderRechargeGiftPop = class("CommanderRechargeGiftPop", require("app.fairyGUI.commanderWorld.UI_CommanderRechargeGiftPop"), function()
	return fgui.GComponent:create({
		resName = "CommanderRechargeGiftPop",
		pkgName = "commanderWorld",
		pkgPath = "ui/commanderWorld/commanderWorld"
	}, ...)
end)

function CommanderRechargeGiftPop:ctor()
	self:showAtCenter()

	self._rechargeRewardInfo = {}

	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onRenderItem))
end

function CommanderRechargeGiftPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, self._onRcvRecharge, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_AWARD, self._onRcvReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_INFO, self.onRcvCommanderWorldInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT, self._onCrossDayUpdate, self)
	self:_updateCommanderGiftList()
end

function CommanderRechargeGiftPop:_onCrossDayUpdate()
	self:_updateCommanderGiftList()
end

function CommanderRechargeGiftPop:_updateCommanderGiftList()
	self._rechargeRewardInfo = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.COMMANDER_GIFT) or {}

	self.m_giftList:setNumItems(#self._rechargeRewardInfo)
	self.m_giftList:transitionShowCells("enter_left", 0.03)
end

function CommanderRechargeGiftPop:_onRenderItem(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._rechargeRewardInfo[arg_6_1 + 1])
end

function CommanderRechargeGiftPop:_onRcvRecharge(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3.gift and arg_7_3.gift.awards then
		g.core.module.ModuleManager:awardSummary(arg_7_3.gift.awards, true)
	end

	self:_updateCommanderGiftList()
end

function CommanderRechargeGiftPop:_onRcvReward(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_8_3.awards, true)
		self:_updateCommanderGiftList()
	end
end

function CommanderRechargeGiftPop:onRcvCommanderWorldInfo()
	if var_0_2:getActivityStageAndRemainTime() == var_0_3.STAGE.REWARDDAY then
		g.core.module.ModuleManager:tip(g.core.lang:get(410322))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	self:_updateCommanderGiftList()
end

return CommanderRechargeGiftPop
