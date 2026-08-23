local var_0_0 = g.core.config.friend_task_info
local var_0_1 = g.core.config.friend_invitation_info
local var_0_2 = g.core.common.ServerTime
local ActivityInviteFriendData = class("ActivityInviteFriendData")

function ActivityInviteFriendData:ctor()
	self:initData()
end

function ActivityInviteFriendData:initData()
	self._userState = false
	self._myInviteCode = 0
	self._inviteStatus = 0
	self._inviteNum = 0
	self._taskInfo = nil
	self._newUserRecReward = {}
	self._inviteRewardInfo = {}
	self._activityInfo = {}
	self._inviteCodeReward = {}
	self._taskReward = {}
	self._rewardStatus = {}
	self._friendInvitation = {}
	self._totalRechargeNum = 0
	self._cumulativeAwardIds = {}
	self._openServerDayTime = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ACTIVITY_INVITE_FRIEND).parameter
end

function ActivityInviteFriendData:updateRecommendInfo(arg_3_1)
	self._userState = arg_3_1.user_state or 1
	self._myInviteCode = arg_3_1.invite_code or ""
	self._invitedStatus = arg_3_1.invited_state or 0
	self._inviteNum = arg_3_1.invite_num or 0
	self._taskInfo = arg_3_1.task_info or {}
	self._invitedRecReward = arg_3_1.award_ids or {}
	self._inviteRewardInfo = arg_3_1.invite_info or {}
	self._activityInfo = arg_3_1.act_info or {}
	self._inviteCodeReward = arg_3_1.invite_awards or {}
	self._taskReward = arg_3_1.task_awards or {}
	self._totalRechargeNum = arg_3_1.recharge_num or 0
	self._cumulativeAwardIds = arg_3_1.recharge_award_ids or {}

	table.sort(self._inviteRewardInfo, function(arg_4_0, arg_4_1)
		return arg_4_0.target < arg_4_1.target
	end)
	self:updateAllRewardStatus()
end

function ActivityInviteFriendData:updateActivityInfo(arg_5_1)
	self._activityInfo = arg_5_1.act_info
end

function ActivityInviteFriendData:getIsNewUser()
	return self._userState == 2
end

function ActivityInviteFriendData:getMyInviteCode()
	return self._myInviteCode
end

function ActivityInviteFriendData:getNewUserTask()
	return self._taskInfo
end

function ActivityInviteFriendData:getInviteNum()
	return self._inviteNum
end

function ActivityInviteFriendData:getActivityInfo()
	return self._activityInfo
end

function ActivityInviteFriendData:getInvitedState()
	return self._invitedStatus
end

function ActivityInviteFriendData:getInviteRewardInfo()
	return self._inviteRewardInfo
end

function ActivityInviteFriendData:getInvitedRecReward()
	return self._invitedRecReward
end

function ActivityInviteFriendData:setInvitedRecReward(arg_14_1)
	arg_14_1 = arg_14_1 or {}

	for iter_14_0 = 1, #arg_14_1 do
		local var_14_0 = false

		for iter_14_1 = 1, #self._invitedRecReward do
			if self._invitedRecReward[iter_14_1] == arg_14_1[iter_14_0] then
				var_14_0 = true
			end
		end

		if not var_14_0 then
			table.insert(self._invitedRecReward, arg_14_1[iter_14_0])
		end
	end
end

function ActivityInviteFriendData:getInviteCodeReward()
	return self._inviteCodeReward
end

function ActivityInviteFriendData:getTaskReward()
	return self._taskReward
end

function ActivityInviteFriendData:isReceivedByType(arg_17_1, arg_17_2)
	local var_17_0 = false

	if arg_17_1 == 1 or arg_17_1 == 2 then
		for iter_17_0 = 1, #self._invitedRecReward do
			if arg_17_1 == self._invitedRecReward[iter_17_0] then
				var_17_0 = true
			end
		end
	elseif arg_17_1 == 3 then
		for iter_17_1 = 1, #self._inviteRewardInfo do
			if arg_17_2 == self._inviteRewardInfo[iter_17_1].id then
				return self._inviteRewardInfo[iter_17_1].is_award
			end
		end
	end

	return var_17_0
end

function ActivityInviteFriendData:isCanReceiveByType(arg_18_1, arg_18_2)
	local var_18_0 = false
	local var_18_1 = self._rewardStatus[arg_18_1] or {}

	if arg_18_1 == 1 or arg_18_1 == 2 and self:getIsNewUser() then
		return var_18_1.is_task_award
	elseif arg_18_1 == 3 then
		if arg_18_2 then
			for iter_18_0 = 1, #var_18_1 do
				local var_18_2 = var_18_1.award_ids or {}

				for iter_18_1 = 1, #var_18_2 do
					if var_18_2[iter_18_1] == arg_18_2 then
						return true
					end
				end
			end
		else
			var_18_0 = next((not var_18_1.award_ids or nil) and {})
		end
	end

	return var_18_0
end

function ActivityInviteFriendData:hasInviteReward()
	for iter_19_0 = 1, #self._inviteRewardInfo do
		if self._inviteNum >= self._inviteRewardInfo[iter_19_0].target and not self._inviteRewardInfo[iter_19_0].is_award then
			return true
		end
	end

	return false
end

function ActivityInviteFriendData:updateInviteReward(arg_20_1)
	if arg_20_1.id then
		for iter_20_0 = 1, #self._inviteRewardInfo do
			if self._inviteRewardInfo[iter_20_0].id == arg_20_1.id then
				self._inviteRewardInfo[iter_20_0].is_award = true
			end
		end
	end
end

function ActivityInviteFriendData:updateRechargeReward(arg_21_1)
	table.insert(self._cumulativeAwardIds, arg_21_1.id)
end

function ActivityInviteFriendData:getTaskInfoByTaskId(arg_22_1)
	for iter_22_0 = 1, var_0_0.getLength() do
		local var_22_0 = var_0_0.get(iter_22_0)

		if var_22_0.task_id == arg_22_1 then
			return var_22_0
		end
	end
end

function ActivityInviteFriendData:canReceiveTaskReward()
	if self:isCompleteAllTask() and not self:isReceivedByType(2) and self:isReceivedByType(1) then
		return true
	end

	return false
end

function ActivityInviteFriendData:isCompleteAllTask()
	local var_24_0 = true

	for iter_24_0 = 1, #self._taskInfo do
		if not self._taskInfo[iter_24_0].is_finish then
			var_24_0 = false

			break
		end
	end

	return var_24_0
end

function ActivityInviteFriendData:updateRewardStatus(arg_25_1)
	if arg_25_1.award_type then
		self._rewardStatus[arg_25_1.award_type] = arg_25_1
	end

	if arg_25_1.recharge_num then
		self._totalRechargeNum = arg_25_1.recharge_num
	end
end

function ActivityInviteFriendData:updateAllRewardStatus()
	if #self._myInviteCode > 1 then
		self:updateRewardStatus({
			award_type = 1,
			is_task_award = not self:isReceivedByType(1)
		})
	end

	if self:isCompleteAllTask() then
		self:updateRewardStatus({
			award_type = 2,
			is_task_award = not self:isReceivedByType(2)
		})
	end
end

function ActivityInviteFriendData:onS2CActionStatusFlush(arg_27_1)
	return
end

function ActivityInviteFriendData:onS2CFlushRedPoint(arg_28_1)
	self._activityInfo = arg_28_1

	g.core.network.GameNetProxy:send_C2S_FriendRecommend_GetInfo({})
end

function ActivityInviteFriendData:isHaveAwardGet()
	if not self:isShowInviteEntrance() then
		return false
	end

	return self:isCanReceiveByType(2) or self:isCanReceiveByType(3) or self:hasInviteReward()
end

function ActivityInviteFriendData:getOpenServerDayTime()
	return self._openServerDayTime
end

function ActivityInviteFriendData:isShowInviteEntrance()
	if var_0_2:getOpenDays() <= self._openServerDayTime then
		return true
	end

	local var_31_0 = var_0_2:getTime() or 0
	local var_31_1 = self:getActivityInfo()

	if (var_31_1.begin_time or 0) <= var_31_0 and var_31_0 <= (var_31_1.end_time or 0) and g.core.model.User:getCreateTime() <= var_31_1.join_time then
		return true
	end

	return false
end

function ActivityInviteFriendData:isHaveNew()
	return self:isShowInviteEntrance()
end

function ActivityInviteFriendData:initFriendInvitationInfo()
	self._friendInvitation = {}

	for iter_33_0, iter_33_1 in var_0_1.ipairs() do
		table.insert(self._friendInvitation, iter_33_1)
	end
end

function ActivityInviteFriendData:getInvitationData()
	if #self._friendInvitation == 0 then
		self:initFriendInvitationInfo()
	end

	return self._friendInvitation
end

function ActivityInviteFriendData:getCumulativeMoney()
	return self._totalRechargeNum
end

function ActivityInviteFriendData:isGetReBateAwardById(arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(self._cumulativeAwardIds) do
		if iter_36_1 == arg_36_1 then
			return true
		end
	end

	return false
end

return ActivityInviteFriendData
