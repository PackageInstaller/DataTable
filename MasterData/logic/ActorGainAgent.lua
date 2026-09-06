-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/agent/ActorGainAgent.lua

module("logic.extensions.actorgain.agent.ActorGainAgent", package.seeall)

local ActorGainAgent = class("ActorGainAgent", BaseAgent)

function ActorGainAgent:sendPM_ActorGainGetInfoReq()
	local req = ActorGainExtension_pb.PM_ActorGainGetInfoReq()

	self:sendMsg(req)
end

function ActorGainAgent:handlePM_ActorGainGetInfoRes(status, msg)
	if status == 0 then
		LailisiModel.instance:setAllInfo(msg.activityInfo)
		GlobalDispatcher:dispatch(GlobalNotify.LailisiMain)
	end
end

function ActorGainAgent:sendPM_ActorGainChallengeReq(activityId, stageId, simpleForm)
	local req = ActorGainExtension_pb.PM_ActorGainChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if simpleForm then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function ActorGainAgent:handlePM_ActorGainChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	elseif ViewMgr.instance:isOpen(ViewName.CustomMissionView) then
		UIStateManager.instance:clear(true)
	end
end

function ActorGainAgent:sendPM_ActorGainGetTaskAwardReq(activityId, taskNum)
	local req = ActorGainExtension_pb.PM_ActorGainGetTaskAwardReq()

	req.activityId = activityId
	req.taskNum = taskNum

	self:sendMsg(req)

	self._activityId = activityId
end

function ActorGainAgent:handlePM_ActorGainGetTaskAwardRes(status, msg)
	if status == 0 then
		LailisiModel.instance:updataTaskDetailInfo(self._activityId, msg.taskDetail)
		GlobalDispatcher:dispatch(GlobalNotify.LailisiTask)
		GlobalDispatcher:dispatch(GlobalNotify.LailisiChallengeTask)
	end

	self._activityId = nil
end

function ActorGainAgent:sendPM_ActorGainGetProgressAwardReq(activityId, id)
	self._tempActId = activityId

	local req = ActorGainExtension_pb.PM_ActorGainGetProgressAwardReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function ActorGainAgent:handlePM_ActorGainGetProgressAwardRes(status, msg)
	if status == 0 then
		LailisiModel.instance:setRewardReceived(msg.rewardReceived)
		LailisiModel.instance:setRewardReceivedWithId(self._tempActId, msg.rewardReceived)
		GlobalDispatcher:dispatch(GlobalNotify.LailisiProgress)
	end
end

function ActorGainAgent:handlePM_ActorGainStageOverRes(status, msg)
	if status == 0 then
		local activityid = msg.activityId
		local taskshow = msg.taskShow

		LailisiModel.instance:updateInfo(msg)
		LailisiController.instance:setType(activityid, taskshow)
	end
end

function ActorGainAgent:sendPM_ActorGainDamageRankReq(activityId)
	local req = ActorGainExtension_pb.PM_ActorGainDamageRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ActorGainAgent:handlePM_ActorGainDamageRankRes(status, msg)
	if status == 0 then
		LailisiModel.instance:setRankInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LailisiRank)
	end
end

ActorGainAgent.instance = ActorGainAgent.New()

return ActorGainAgent
