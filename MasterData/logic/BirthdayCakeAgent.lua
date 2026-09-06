-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaycake/agent/BirthdayCakeAgent.lua

module("logic.extensions.birthdaycake.agent.BirthdayCakeAgent", package.seeall)

local BirthdayCakeAgent = class("BirthdayCakeAgent", BaseAgent)

function BirthdayCakeAgent:sendPM_BirthdayCakeInfoReq(activityId)
	local req = BirthdayCakeExtension_pb.PM_BirthdayCakeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayCakeAgent:handlePM_BirthdayCakeInfoRes(status, msg)
	if status == 0 then
		BirthdayCakeModel.instance:setMainInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BirthdayCakeInfo)
	end
end

function BirthdayCakeAgent:sendPM_BirthdayCakeTaskInfoReq(activityId)
	local req = BirthdayCakeExtension_pb.PM_BirthdayCakeTaskInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayCakeAgent:handlePM_BirthdayCakeTaskInfoRes(status, msg)
	if status == 0 then
		BirthdayCakeModel.instance:setTaskList(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BirthdayCakeTaskInfo)
	end
end

function BirthdayCakeAgent:sendPM_BirthdayCakeTaskGetRewardReq(activityId, taskId)
	local req = BirthdayCakeExtension_pb.PM_BirthdayCakeTaskGetRewardReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function BirthdayCakeAgent:handlePM_BirthdayCakeTaskGetRewardRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BirthdayCakeTaskReq)
	end
end

function BirthdayCakeAgent:sendPM_BirthdayCakeMakeReq(activityId, cakeId)
	local req = BirthdayCakeExtension_pb.PM_BirthdayCakeMakeReq()

	req.activityId = activityId
	req.cakeId = cakeId

	self:sendMsg(req)
end

function BirthdayCakeAgent:handlePM_BirthdayCakeMakeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BirthdayCakeThings)

		local activityId = BirthdayCakeModel.instance:getActivityId()

		BirthdayCakeAgent.instance:sendPM_BirthdayCakeInfoReq(activityId)
	end
end

function BirthdayCakeAgent:sendPM_BirthdayCakeWorldProgressValueReq(activityId)
	local req = BirthdayCakeExtension_pb.PM_BirthdayCakeWorldProgressValueReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayCakeAgent:handlePM_BirthdayCakeWorldProgressValueRes(status, msg)
	if status == 0 then
		BirthdayCakeModel.instance:setWorldProgressValue(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BirthdayCakeWorldProgress)
	end
end

function BirthdayCakeAgent:sendPM_BirthdayCakeWorldProgressRewardReq(activityId, progressId)
	local req = BirthdayCakeExtension_pb.PM_BirthdayCakeWorldProgressRewardReq()

	req.activityId = activityId
	req.progressId = progressId

	self:sendMsg(req)
end

function BirthdayCakeAgent:handlePM_BirthdayCakeWorldProgressRewardRes(status, msg)
	if status == 0 then
		local worldprogressreward = msg.worldProgressReward

		BirthdayCakeModel.instance:setWorldProgressReward(worldprogressreward)
		GlobalDispatcher:dispatch(GlobalNotify.BirthdayCakeWorldProgress)
	end
end

function BirthdayCakeAgent:sendPM_BirthdayCakeCarveUpReq(activityId)
	local req = BirthdayCakeExtension_pb.PM_BirthdayCakeCarveUpReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayCakeAgent:handlePM_BirthdayCakeCarveUpRes(status, msg)
	if status == 0 then
		BirthdayCakeModel.instance:setCarveUpNum()

		local activityId = BirthdayCakeModel.instance:getActivityId()

		BirthdayCakeAgent.instance:sendPM_BirthdayCakeInfoReq(activityId)
	end
end

function BirthdayCakeAgent:sendPM_BirthdayCakeBuyReq(activityId)
	local req = BirthdayCakeExtension_pb.PM_BirthdayCakeBuyReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayCakeAgent:handlePM_BirthdayCakeBuyRes(status, msg)
	if status == 0 then
		BirthdayCakeModel.instance:setBuyNum(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BirthdayCakeBuyTime)
	end
end

function BirthdayCakeAgent:sendPM_BirthdayCakeCarveUpRecordReq(activityId)
	local req = BirthdayCakeExtension_pb.PM_BirthdayCakeCarveUpRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayCakeAgent:handlePM_BirthdayCakeCarveUpRecordRes(status, msg)
	if status == 0 then
		BirthdayCakeModel.instance:setPlayerRecords(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BirthdayCakeRecord)
	end
end

BirthdayCakeAgent.instance = BirthdayCakeAgent.New()

return BirthdayCakeAgent
