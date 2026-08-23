local var_0_0 = g.core.model.User.activityMonthCardData
local RechargeMonthCardStepComp = class("RechargeMonthCardStepComp", require("app.fairyGUI.recharge.UI_RechargeMonthCardStepComp"))

function RechargeMonthCardStepComp:ctor()
	self._curAwardId = 0
	self._curAwardData = {}

	self:addClickListener(handler(self, self._onClickSelf))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function RechargeMonthCardStepComp:updateStepProgress()
	self._curAwardId = var_0_0:getCurProgMonthCardAwardId()
	self._curAwardData = var_0_0:getMonthCardTurnAwardData(self._curAwardId)

	local var_2_0 = var_0_0:getCurMonthCardAwardScore()
	local var_2_1 = g.core.config.month_card_reward_info.get(self._curAwardId).score
	local var_2_2 = g.core.config.month_card_reward_info.fetch(self._curAwardId - 1)
	local var_2_3

	if var_2_2 then
		var_2_3 = var_2_2.score or 0
	end

	self.m_progressValueTxt:setText(var_2_0 .. "/" .. var_2_1)
	self.m_progressComp:setPercent({
		cur = var_2_0 - var_2_3,
		max = var_2_1 - var_2_3
	})
	self.m_awardStateController:setSelectedIndex(var_0_0:isCanGetMonthTurnAwards() and 1 or 0)
	self.m_awardList:setNumItems(#self._curAwardData)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function RechargeMonthCardStepComp:_onAwardListRenderer(arg_3_1, arg_3_2)
	if var_0_0:isCanGetMonthCardAwardId(self._curAwardId) then
		local var_3_0 = arg_3_2:getSize()

		arg_3_2:removeAllEffect()
		arg_3_2:addEffectSpine({
			isLoop = true,
			name = "eff_ui_common_iconget",
			anim = "play_0",
			x = var_3_0.width / 2,
			y = var_3_0.height / 2
		})
	else
		arg_3_2:removeAllEffect()
	end

	arg_3_2:updateIcon(self._curAwardData[arg_3_1 + 1])
end

function RechargeMonthCardStepComp:_onClickSelf()
	if var_0_0:isCanGetMonthCardAwardId(self._curAwardId) then
		g.core.network.GameNetProxy:send_C2S_Recharge_MonthCardTurnAward({
			id = var_0_0:getMonthCardTurnId(),
			reward_id = self._curAwardId
		})
	else
		g.core.module.ModuleManager:pushPopup((require("app.view.module.recharge.view.RechargeMonthCardProgPop").new()))
	end
end

return RechargeMonthCardStepComp
