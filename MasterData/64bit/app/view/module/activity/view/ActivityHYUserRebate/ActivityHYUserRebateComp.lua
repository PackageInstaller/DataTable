local BaseConfirmPop = require("app.view.base.pop.BaseConfirmPop")
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.activityOtherReturnPayData
local ActivityHYUserRebateComp = class("ActivityHYUserRebateComp", require("app.fairyGUI.activity.UI_ActivityHYUserRebateComp"))

function ActivityHYUserRebateComp:ctor()
	self.m_rewardBtn:addClickListener(handler(self, self._onClickGetBtn))
	self.m_rechargeBtn:addClickListener(handler(self, self._onClickRechargeBtn))
end

function ActivityHYUserRebateComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OTHER_RETURN_PAY_GETAWARD, handler(self, self._onGetAward), self)
	self:updateComp()
end

function ActivityHYUserRebateComp:_onGetAward(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_3_4.awards)
	end

	self:updateComp()
end

function ActivityHYUserRebateComp:updateComp()
	if self.m_enterTransition then
		self.m_enterTransition:play()
	end

	local var_4_0, var_4_1 = var_0_2:getRechargeAmount()

	self.m_costTxt:setText(g.core.lang:get(410401, {
		num = var_4_0
	}))
	self.m_backTxt:setText("x" .. var_4_1)
	self.m_backIcon:setURL(var_0_1:convert({
		type = var_0_1.TYPE_RESOURCE,
		value = var_0_1.RESOURCE.TYPE_VOUCHER_COIN_RESOURCE
	}).icon)
	self.m_stateController:setSelectedIndex(var_0_2:isCanAward() and 0 or 1)
end

function ActivityHYUserRebateComp:_onClickRechargeBtn()
	g.view.entrance.ModuleGotoProxy:gotoModule(65)
end

function ActivityHYUserRebateComp:_onClickGetBtn()
	g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(410403),
		onConfirm = function()
			g.core.network.GameNetProxy:send_C2S_OtherReturnPay_GetAward({})
		end
	}))
end

return ActivityHYUserRebateComp
