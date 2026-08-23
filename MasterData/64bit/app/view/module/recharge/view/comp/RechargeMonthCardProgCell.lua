local var_0_0 = g.core.model.User.activityMonthCardData
local RechargeMonthCardProgCell = class("RechargeMonthCardProgCell", require("app.fairyGUI.recharge.UI_RechargeMonthCardProgCell"))

function RechargeMonthCardProgCell:ctor()
	self._rewardData = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onListRenderer))
	self.m_getBtn:addClickListener(handler(self, self.onRewardClick))
end

function RechargeMonthCardProgCell:updateCell(arg_2_1, arg_2_2)
	self._id = arg_2_1.id
	self._maxScore = arg_2_1.score

	self.m_rewardTitle:setText(g.core.lang:get(406008, {
		num = g.core.utils.Number.toChineseNumber(arg_2_2)
	}))
	self.m_starTxt:setText(self._maxScore)

	self._curScore = var_0_0:getCurMonthCardAwardScore()

	self.m_starNum:setText("[color=#e52e2e]" .. self._curScore .. "[/color]" .. "/" .. self._maxScore)

	self._rewardData = var_0_0:getMonthCardTurnAwardData(self._id)

	self.m_rewardList:setNumItems(#self._rewardData)
	self.m_rewardStateController:setSelectedIndex((self:_getAwardsState()))
end

function RechargeMonthCardProgCell:_getAwardsState()
	return self._curScore >= self._maxScore and (var_0_0:isGetMonthCardTurnAward(self._id) and 3 or 2) or 1
end

function RechargeMonthCardProgCell:_onListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._rewardData[arg_4_1 + 1])
end

function RechargeMonthCardProgCell:onRewardClick()
	g.core.network.GameNetProxy:send_C2S_Recharge_MonthCardTurnAward({
		id = var_0_0:getMonthCardTurnId(),
		reward_id = self._id
	})
end

return RechargeMonthCardProgCell
