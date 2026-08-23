local var_0_0 = g.core.model.User.activityMonthCardData
local RechargeMonthCardComp = class("RechargeMonthCardComp", require("app.fairyGUI.recharge.UI_RechargeMonthCardComp"))

RechargeMonthCardComp.CELL_CNT = 2

function RechargeMonthCardComp:ctor()
	self:addBg("bg/recharge/bg_monthlycard.jpg")
end

function RechargeMonthCardComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._onGetRecharge), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onOpRecharge), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_USEMONTHCARD, handler(self, self._useMonthCard), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_MONTHCARDTURNAWARD, handler(self, self._onS2CGetTurnAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
end

function RechargeMonthCardComp:updateComp()
	self:_updateMainCells()
end

function RechargeMonthCardComp:_updateMainCells()
	local var_4_0 = var_0_0:getMonthCards()

	for iter_4_0 = 1, RechargeMonthCardComp.CELL_CNT do
		self["m_cardComp" .. iter_4_0]:updateBaseCell(var_4_0[iter_4_0])
	end

	self.m_stepComp:updateStepProgress()
end

function RechargeMonthCardComp:_onCrossDayUpdate()
	self:_updateMainCells()
end

function RechargeMonthCardComp:_useMonthCard(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.awards and self:isVisible() then
		g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
	end

	g.core.network.GameNetProxy:send_C2S_Recharge_GetRecharge({})
end

function RechargeMonthCardComp:_onGetRecharge()
	self:_updateMainCells()
end

function RechargeMonthCardComp:_onS2CGetTurnAward(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	g.core.module.ModuleManager:awardSummary(arg_8_4.awards)
	self.m_stepComp:updateStepProgress()
end

function RechargeMonthCardComp:_onOpRecharge(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4 and arg_9_4.month_card and self:isVisible() then
		self:_updateMainCells()
	end
end

return RechargeMonthCardComp
