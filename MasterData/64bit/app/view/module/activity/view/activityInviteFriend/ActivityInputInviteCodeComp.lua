local var_0_0 = g.core.model.User.activityInviteFriendData
local ActivityInputInviteCodeComp = class("ActivityInputInviteCodeComp", require("app.fairyGUI.activity.UI_ActivityInputInviteCodeComp"))

function ActivityInputInviteCodeComp:ctor()
	self._receiveAwardStatus = nil
	self._inviteStatus = nil

	self:_initView()
end

function ActivityInputInviteCodeComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_USEINVITECODE, handler(self, self._onRcvUseInviteCode), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_INVITED_AWARD, handler(self, self._onRcvInvitedReward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_AWARDSTATUSFLUSH, handler(self, self._onRewardFlush), self)
end

function ActivityInputInviteCodeComp:playCutAnimation()
	self.m_cutTransition:play()
end

function ActivityInputInviteCodeComp:playEnterAnimation()
	self.m_enterTransition:play()
end

function ActivityInputInviteCodeComp:updateView()
	self:_updateUseInviteCode()
	self:_updateTask()
	self:_updateCompleteTaskReward()
end

function ActivityInputInviteCodeComp:_updateUseInviteCode()
	self._inviteCodeReward = var_0_0:getInviteCodeReward()

	self.m_inviteRewardList:setNumItems(#self._inviteCodeReward)

	if var_0_0:isReceivedByType(1) then
		self.m_inviteStatusController:setSelectedIndex(1)
	else
		self.m_inviteStatusController:setSelectedIndex(0)
	end
end

function ActivityInputInviteCodeComp:_updateTask()
	self._taskData = var_0_0:getNewUserTask()

	self.m_taskList:setNumItems(#self._taskData)
end

function ActivityInputInviteCodeComp:_updateCompleteTaskReward()
	self._taskReward = var_0_0:getTaskReward()
	self._recRewardData = var_0_0:getInvitedRecReward()

	self.m_taskRewardList:setNumItems(#self._taskReward)
end

function ActivityInputInviteCodeComp:_initView()
	self.m_inputComp.m_lable:setColor(cc.c3b(204, 204, 204))
	self.m_confirmInviteBtn:addClickListener(handler(self, self._onConfirmInviteBtn))
	self.m_inviteRewardList:setVirtual()
	self.m_inviteRewardList:setItemRenderer(handler(self, self._onInviteRewardRenderer))
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRenderer))
	self.m_taskRewardList:setVirtual()
	self.m_taskRewardList:setItemRenderer(handler(self, self._onTaskRewardItemRenderer))
	self.m_touchNode:addClickListener(handler(self, self._onClickReceiveReward))
end

function ActivityInputInviteCodeComp:_onConfirmInviteBtn()
	local var_10_0 = self.m_inputComp:getInputStr()

	if var_10_0 and self:_checkInputString(var_10_0) then
		g.core.network.GameNetProxy:send_C2S_FriendRecommend_UseInviteCode({
			invite_code = var_10_0
		})
	end
end

function ActivityInputInviteCodeComp:_checkInputString(arg_11_1)
	if g.core.utils.Black:isMatchText(arg_11_1) or string.find(arg_11_1, "*") then
		self.m_inputComp:setText("")
		g.core.module.ModuleManager:tip(g.core.lang:get(407802))

		return false
	end

	if #arg_11_1 > 10 or #arg_11_1 < 8 then
		g.core.module.ModuleManager:tip(g.core.lang:get(407802))

		return false
	end

	if arg_11_1 == var_0_0:getMyInviteCode() then
		g.core.module.ModuleManager:tip(g.core.lang:get(407803))

		return false
	end

	if string.find(arg_11_1, "^%s+$") or arg_11_1 == "" or string.find(arg_11_1, "　") then
		g.core.module.ModuleManager:tip(g.core.lang:get(407802))

		return false
	end

	return true
end

function ActivityInputInviteCodeComp:_onInviteRewardRenderer(arg_12_1, arg_12_2)
	local var_12_0 = var_0_0:isReceivedByType(1)

	arg_12_2:updateIcon(self._inviteCodeReward[arg_12_1 + 1])
	arg_12_2:updateStatus(var_12_0 and 3 or 1)
end

function ActivityInputInviteCodeComp:_onTaskItemRenderer(arg_13_1, arg_13_2)
	arg_13_2:updateView(self._taskData[arg_13_1 + 1])
end

function ActivityInputInviteCodeComp:_onTaskRewardItemRenderer(arg_14_1, arg_14_2)
	local var_14_0 = 1

	arg_14_2:updateIcon(self._taskReward[arg_14_1 + 1])

	if var_0_0:canReceiveTaskReward() then
		var_14_0 = 2

		self.m_touchNode:setVisible(true)
	elseif var_0_0:isReceivedByType(2) then
		var_14_0 = 3

		self.m_touchNode:setVisible(false)
	else
		var_14_0 = 1

		self.m_touchNode:setVisible(false)
	end

	arg_14_2:updateStatus(var_14_0)
end

function ActivityInputInviteCodeComp:_onClickReceiveReward()
	if not var_0_0:isReceivedByType(1) then
		g.core.module.ModuleManager:tip(407804)

		return
	end

	if var_0_0:canReceiveTaskReward() then
		g.core.network.GameNetProxy:send_C2S_FriendRecommend_Invited_Award({})
	end
end

function ActivityInputInviteCodeComp:_onRcvInvitedReward(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self.m_taskRewardList:setNumItems(#self._taskReward)
	g.core.module.ModuleManager:awardSummary(arg_16_4.awards)
end

function ActivityInputInviteCodeComp:_onRcvUseInviteCode(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	g.core.module.ModuleManager:awardSummary(arg_17_4.awards)
	self:_updateUseInviteCode()
end

function ActivityInputInviteCodeComp:_onRewardFlush()
	local var_18_0 = var_0_0:isCanReceiveByType(2)
end

return ActivityInputInviteCodeComp
