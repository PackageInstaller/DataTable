local var_0_0 = g.core.model.User.activityMonthCardData
local RechargeMonthCardProgPop = class("RechargeMonthCardProgPop", require("app.fairyGUI.recharge.UI_RechargeMonthCardProgPop"), function()
	return fgui.GComponent:create({
		resName = "RechargeMonthCardProgPop",
		pkgPath = "ui/recharge/recharge",
		pkgName = "recharge"
	})
end)

function RechargeMonthCardProgPop:ctor()
	self:showAtCenter()

	self._awardList = {}

	self:_updateMainView()
end

function RechargeMonthCardProgPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_MONTHCARDTURNAWARD, handler(self, self._onGetMonthCardTurnAward), self)
end

function RechargeMonthCardProgPop:_updateMainView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))

	self._awardList = var_0_0:getMonthCardTurnRewardConfig()

	self.m_awardList:setNumItems(#self._awardList)
	self.m_scoreTxt:setText((var_0_0:getCurMonthCardAwardScore()))
end

function RechargeMonthCardProgPop:_onRenderAwardList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._awardList[arg_5_1 + 1], arg_5_1 + 1)
end

function RechargeMonthCardProgPop:_onGetMonthCardTurnAward(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
		self:_updateMainView()
	end
end

return RechargeMonthCardProgPop
