-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/agent/BreachFormMasterAgent.lua

module("logic.extensions.breachformmaster.agent.BreachFormMasterAgent", package.seeall)

local BreachFormMasterAgent = class("BreachFormMasterAgent", BaseAgent)

function BreachFormMasterAgent:sendPM_BreachFormMasterGetInfoReq(activityId)
	local req = BreachFormMasterExtension_pb.PM_BreachFormMasterGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BreachFormMasterAgent:handlePM_BreachFormMasterGetInfoRes(status, msg)
	if status == 0 then
		BreachFormMasterController.instance:handlePM_BreachFormMasterGetInfoRes(msg)
	end
end

function BreachFormMasterAgent:sendPM_BreachFormMasterStageInfoReq(activityId, stageId)
	local req = BreachFormMasterExtension_pb.PM_BreachFormMasterStageInfoReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function BreachFormMasterAgent:handlePM_BreachFormMasterStageInfoRes(status, msg)
	if status == 0 then
		BreachFormMasterController.instance:handlePM_BreachFormMasterStageInfoRes(msg)
	end
end

function BreachFormMasterAgent:sendPM_BreachFormMasterFightReq(activityId, stageId, useBuff, form)
	local req = BreachFormMasterExtension_pb.PM_BreachFormMasterFightReq()

	req.activityId = activityId
	req.stageId = stageId
	req.useBuff = useBuff

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function BreachFormMasterAgent:handlePM_BreachFormMasterFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function BreachFormMasterAgent:handlePM_BreachFormMasterFightNotifyRes(status, msg)
	if status == 0 then
		BreachFormMasterController.instance:handlePM_BreachFormMasterFightNotifyRes(msg)
	end
end

function BreachFormMasterAgent:sendPM_BreachFormMasterSetDefenseFormReq(activityId, form)
	local req = BreachFormMasterExtension_pb.PM_BreachFormMasterSetDefenseFormReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function BreachFormMasterAgent:handlePM_BreachFormMasterSetDefenseFormRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function BreachFormMasterAgent:sendPM_BreachFormMasterRankViewReq(activityId, rankType, stepId)
	local req = BreachFormMasterExtension_pb.PM_BreachFormMasterRankViewReq()

	req.activityId = activityId
	req.rankType = rankType
	req.stepId = stepId

	self:sendMsg(req)
end

function BreachFormMasterAgent:handlePM_BreachFormMasterRankViewRes(status, msg)
	if status == 0 then
		BreachFormMasterController.instance:handlePM_BreachFormMasterRankViewRes(msg)
	end
end

function BreachFormMasterAgent:sendPM_BreachFormMasterBattleReportReq(activityId)
	local req = BreachFormMasterExtension_pb.PM_BreachFormMasterBattleReportReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BreachFormMasterAgent:handlePM_BreachFormMasterBattleReportRes(status, msg)
	if status == 0 then
		BreachFormMasterController.instance:handlePM_BreachFormMasterBattleReportRes(msg)
	end
end

function BreachFormMasterAgent:sendPM_BreachFormMasterBattleVideoReq(battleId)
	local req = BreachFormMasterExtension_pb.PM_BreachFormMasterBattleVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function BreachFormMasterAgent:handlePM_BreachFormMasterBattleVideoRes(status, msg)
	if status == 0 then
		BreachFormMasterController.instance:handlePM_BreachFormMasterBattleVideoRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_BreachFormMasterBattleVideoErrorRes, status)
	end
end

BreachFormMasterAgent.instance = BreachFormMasterAgent.New()

return BreachFormMasterAgent
