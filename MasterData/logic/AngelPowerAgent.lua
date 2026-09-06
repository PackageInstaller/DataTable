-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/agent/AngelPowerAgent.lua

module("logic.extensions.angelpower.agent.AngelPowerAgent", package.seeall)

local AngelPowerAgent = class("AngelPowerAgent", BaseAgent)

function AngelPowerAgent:sendPM_AngelPowerGetInfoReq(activityId)
	local req = AngelPowerExtension_pb.PM_AngelPowerGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AngelPowerAgent:handlePM_AngelPowerGetInfoRes(status, msg)
	if status == 0 then
		AngelPowerClgController.instance:handlePM_AngelPowerGetInfoRes(msg)
	end
end

function AngelPowerAgent:sendPM_AngelPowerChallengeReq(activityId, stageId, form)
	local req = AngelPowerExtension_pb.PM_AngelPowerChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function AngelPowerAgent:handlePM_AngelPowerChallengeRes(status, msg)
	if status == 0 then
		AngelPowerClgController.instance:handlePM_AngelPowerChallengeRes(msg)
	end
end

function AngelPowerAgent:handlePM_Notify_AngelPowerChallengeEndRes(status, msg)
	if status == 0 then
		AngelPowerClgController.instance:handlePM_Notify_AngelPowerChallengeEndRes(msg)
	end
end

AngelPowerAgent.instance = AngelPowerAgent.New()

return AngelPowerAgent
