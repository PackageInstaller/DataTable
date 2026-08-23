local var_0_0 = g.core.model.User.activityInviteFriendData
local ActivityCumulativeMoneyComp = class("ActivityCumulativeMoneyComp", require("app.fairyGUI.activity.UI_ActivityCumulativeMoneyComp"))

function ActivityCumulativeMoneyComp:ctor()
	self._rewardData = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardRenderer))
	self.m_touchNode:addClickListener(handler(self, self._onTouchReward))
end

function ActivityCumulativeMoneyComp:updateCumulativeCell(arg_2_1)
	self._info = arg_2_1
	self._cumulativate = var_0_0:getCumulativeMoney()
	self._isAward = var_0_0:isGetReBateAwardById(self._info.id)

	self.m_descText:setText(g.core.lang:get(407807, {
		value = arg_2_1.money
	}))

	self._awards = self:getAwardData(arg_2_1)

	self.m_rewardList:setNumItems(#self._awards)
	self.m_receiveController:setSelectedIndex(self._isAward and 1 or 0)
end

function ActivityCumulativeMoneyComp:getAwardData(arg_3_1)
	local var_3_0 = {}

	table.insert(var_3_0, {
		type = arg_3_1.reward_type,
		value = arg_3_1.reward_value,
		size = arg_3_1.reward_size
	})

	return var_3_0
end

function ActivityCumulativeMoneyComp:_onRewardRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._awards[arg_4_1 + 1])

	local var_4_0 = 1

	if self._isAward then
		var_4_0 = 3

		self.m_touchNode:setVisible(false)
	elseif self._cumulativate >= self._info.money then
		var_4_0 = 2

		self.m_touchNode:setVisible(true)
	else
		var_4_0 = 1

		self.m_touchNode:setVisible(false)
	end

	arg_4_2:updateStatus(var_4_0)
end

function ActivityCumulativeMoneyComp:_onTouchReward()
	if not self._isAward and self._cumulativate >= self._info.money then
		g.core.network.GameNetProxy:send_C2S_FriendRecommend_Recharge_GetAward({
			id = self._info.id
		})
	end
end

return ActivityCumulativeMoneyComp
