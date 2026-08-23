local GmFundConst = require("app.view.module.newFund.const.GmFundConst")
local var_0_1 = g.core.model.User.gmFundData
local FundNewItemComp = class("FundNewItemComp", require("app.fairyGUI.newFund.UI_FundNewItemComp"))

function FundNewItemComp:ctor()
	self:addClickListener(handler(self, self._onClick))
end

function FundNewItemComp:updateFundNewItemComp(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._fundType = arg_2_4
	self._isFree = arg_2_3
	self._cfg = arg_2_2
	self._reward = arg_2_1

	self.m_iconComp:updateIcon(arg_2_1)
	self.m_numTxt:setText(arg_2_1.size)

	local var_2_0 = var_0_1:getFundAwardState(arg_2_2.fund_id, arg_2_2.level, arg_2_3)

	self.m_stateController:setSelectedIndex(var_2_0)
	self.m_normalEffHolder:removeAllEffect()

	if var_2_0 == 1 then
		self.m_normalEffHolder:addEffectSpine({
			anim = "play",
			name = "eff_ui_newFund_award",
			isLoop = true
		})
	end
end

function FundNewItemComp:_onClick()
	local var_3_0 = var_0_1:getFundAwardState(self._cfg.fund_id, self._cfg.level, self._isFree)

	if var_3_0 == GmFundConst.FUND_AWARD_STATE.CAN_GET then
		g.core.network.GameNetProxy:send_C2S_FundActivity_LevelAward({
			activity_id = var_0_1:getSvrIdByType(self._fundType),
			lv = self._cfg.level,
			type = self._isFree and 1 or 2
		})
	elseif var_3_0 == GmFundConst.FUND_AWARD_STATE.LOCKED then
		g.core.module.ModuleManager:tip(g.core.lang:get(422509))
	elseif self._reward then
		g.core.common.GlobalFunc.pushInfoPop(self._reward)
	end
end

return FundNewItemComp
