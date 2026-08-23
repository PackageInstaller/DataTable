local var_0_0 = g.core.model.User.activityInviteFriendData
local ActivityInviteStepComp = class("ActivityInviteStepComp", require("app.fairyGUI.activity.UI_ActivityInviteStepComp"))

function ActivityInviteStepComp:ctor()
	self._rewardData = {}

	self:_initView()
end

function ActivityInviteStepComp:_initView()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardRenderer))
	self.m_touchNode:addClickListener(handler(self, self._onTouchReward))
end

function ActivityInviteStepComp:updateView(arg_3_1)
	self._rewardData = arg_3_1

	self.m_inviteConditionText:setText(g.core.lang:get(407801, {
		num = self._rewardData.target
	}))

	local var_3_0 = self._rewardData.awards

	self:newScheduleOnce(function()
		self.m_rewardList:setNumItems(#var_3_0)
	end, 0.3)
end

function ActivityInviteStepComp:_onRewardRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._rewardData.awards[arg_5_1 + 1])

	local var_5_0 = 1

	if self._rewardData.is_award then
		var_5_0 = 3

		self.m_touchNode:setVisible(false)
	elseif var_0_0:getInviteNum() >= self._rewardData.target then
		var_5_0 = 2

		self.m_touchNode:setVisible(true)
	else
		var_5_0 = 1

		self.m_touchNode:setVisible(false)
	end

	arg_5_2:updateStatus(var_5_0)
end

function ActivityInviteStepComp:_onTouchReward()
	local var_6_0 = self._rewardData.id

	if not self._rewardData.is_award and var_0_0:getInviteNum() >= self._rewardData.target and var_6_0 then
		g.core.network.GameNetProxy:send_C2S_FriendRecommend_Invite_Award({
			id = var_6_0
		})
	end
end

function ActivityInviteStepComp:updateStatus(arg_7_1)
	if arg_7_1 then
		self.m_receiveController:setSelectedIndex(1)
	else
		self.m_receiveController:setSelectedIndex(0)
	end
end

return ActivityInviteStepComp
