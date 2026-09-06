-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/agent/AshlessLongYanAgent.lua

module("logic.extensions.ashlesslongyan.agent.AshlessLongYanAgent", package.seeall)

local AshlessLongYanAgent = class("AshlessLongYanAgent", BaseAgent)

function AshlessLongYanAgent:sendPM_AshlessLongYanGetInfoReq(activityId)
	local req = AshlessLongYanExtension_pb.PM_AshlessLongYanGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AshlessLongYanAgent:handlePM_AshlessLongYanGetInfoRes(status, msg)
	if status == 0 then
		AshlessLongYanController.instance:handlePM_AshlessLongYanGetInfoRes(msg)
	end
end

function AshlessLongYanAgent:sendPM_AshlessLongYanChallengeReq(activityId, phaseId, stageId, form)
	local req = AshlessLongYanExtension_pb.PM_AshlessLongYanChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function AshlessLongYanAgent:handlePM_AshlessLongYanChallengeRes(status, msg)
	if status == 0 then
		AshlessLongYanController.instance:handlePM_AshlessLongYanChallengeRes(msg)
	end
end

function AshlessLongYanAgent:sendPM_AshlessLongYanConfirmScoreReq(activityId, phaseId, stageId, confirm)
	local req = AshlessLongYanExtension_pb.PM_AshlessLongYanConfirmScoreReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId
	req.confirm = confirm

	self:sendMsg(req)
end

function AshlessLongYanAgent:handlePM_AshlessLongYanConfirmScoreRes(status, msg)
	if status == 0 then
		AshlessLongYanController.instance:handlePM_AshlessLongYanConfirmScoreRes(msg)
	end
end

function AshlessLongYanAgent:sendPM_AshlessLongYanUseWoodReq(activityId, phaseId, stageId, useCount)
	local req = AshlessLongYanExtension_pb.PM_AshlessLongYanUseWoodReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId
	req.useCount = useCount

	self:sendMsg(req)
end

function AshlessLongYanAgent:handlePM_AshlessLongYanUseWoodRes(status, msg)
	if status == 0 then
		AshlessLongYanController.instance:handlePM_AshlessLongYanUseWoodRes(msg)
	end
end

function AshlessLongYanAgent:sendPM_AshlessLongYanStashOrTakeReq(activityId, phaseId, stageId, stashOrTake)
	local req = AshlessLongYanExtension_pb.PM_AshlessLongYanStashOrTakeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId
	req.stashOrTake = stashOrTake

	self:sendMsg(req)
end

function AshlessLongYanAgent:handlePM_AshlessLongYanStashOrTakeRes(status, msg)
	if status == 0 then
		AshlessLongYanController.instance:handlePM_AshlessLongYanStashOrTakeRes(msg)
	end
end

function AshlessLongYanAgent:sendPM_AshlessLongYanResetPhaseReq(activityId, phaseId)
	local req = AshlessLongYanExtension_pb.PM_AshlessLongYanResetPhaseReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function AshlessLongYanAgent:handlePM_AshlessLongYanResetPhaseRes(status, msg)
	if status == 0 then
		AshlessLongYanController.instance:handlePM_AshlessLongYanResetPhaseRes(msg)
	end
end

function AshlessLongYanAgent:handlePM_Notify_AshlessLongYanChallengeEndRes(status, msg)
	if status == 0 then
		AshlessLongYanController.instance:handlePM_Notify_AshlessLongYanChallengeEndRes(msg)
	end
end

AshlessLongYanAgent.instance = AshlessLongYanAgent.New()

return AshlessLongYanAgent
