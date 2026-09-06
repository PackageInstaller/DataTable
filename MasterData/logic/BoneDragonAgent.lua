-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/agent/BoneDragonAgent.lua

module("logic.extensions.bonedragon.agent.BoneDragonAgent", package.seeall)

local BoneDragonAgent = class("BoneDragonAgent", BaseAgent)

function BoneDragonAgent:sendPM_BoneDragonClgInfoReq(activityId)
	local req = BoneDragonClgExtension_pb.PM_BoneDragonClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BoneDragonAgent:handlePM_BoneDragonClgInfoRes(status, msg)
	if status == 0 then
		BoneDragonController.instance:handlePM_BoneDragonClgInfoRes(msg)
	end
end

function BoneDragonAgent:sendPM_BoneDragonClgSelectPetReq(activityId, petIds)
	local req = BoneDragonClgExtension_pb.PM_BoneDragonClgSelectPetReq()

	req.activityId = activityId

	for i, id in ipairs(petIds) do
		req.petIds:append(id)
	end

	self:sendMsg(req)
end

function BoneDragonAgent:handlePM_BoneDragonClgSelectPetRes(status, msg)
	if status == 0 then
		BoneDragonController.instance:handlePM_BoneDragonClgSelectPetRes(msg)
	end
end

function BoneDragonAgent:sendPM_BoneDragonClgSelectFormationReq(activityId, stageId, formationId)
	local req = BoneDragonClgExtension_pb.PM_BoneDragonClgSelectFormationReq()

	req.activityId = activityId
	req.stageId = stageId
	req.formationId = formationId

	self:sendMsg(req)
end

function BoneDragonAgent:handlePM_BoneDragonClgSelectFormationRes(status, msg)
	if status == 0 then
		BoneDragonController.instance:handlePM_BoneDragonClgSelectFormationRes(msg)
	end
end

function BoneDragonAgent:sendPM_BoneDragonClgRefreshFormationReq(activityId, stageId)
	local req = BoneDragonClgExtension_pb.PM_BoneDragonClgRefreshFormationReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function BoneDragonAgent:handlePM_BoneDragonClgRefreshFormationRes(status, msg)
	if status == 0 then
		BoneDragonController.instance:handlePM_BoneDragonClgRefreshFormationRes(msg)
	end
end

function BoneDragonAgent:sendPM_BoneDragonClgChallengeReq(activityId, stageId, form)
	local req = BoneDragonClgExtension_pb.PM_BoneDragonClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function BoneDragonAgent:handlePM_BoneDragonClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function BoneDragonAgent:sendPM_BoneDragonClgConfirmReq(activityId, save)
	local req = BoneDragonClgExtension_pb.PM_BoneDragonClgConfirmReq()

	req.activityId = activityId
	req.save = save

	self:sendMsg(req)
end

function BoneDragonAgent:handlePM_BoneDragonClgConfirmRes(status, msg)
	if status == 0 then
		BoneDragonController.instance:handlePM_BoneDragonClgConfirmRes(msg)
	end
end

function BoneDragonAgent:sendPM_BoneDragonClgResetReq(activityId)
	local req = BoneDragonClgExtension_pb.PM_BoneDragonClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BoneDragonAgent:handlePM_BoneDragonClgResetRes(status, msg)
	if status == 0 then
		BoneDragonController.instance:handlePM_BoneDragonClgResetRes(msg)
	end
end

function BoneDragonAgent:handlePM_NotifyBoneDragonClgChallengeFinishRes(status, msg)
	if status == 0 then
		BoneDragonController.instance:handlePM_NotifyBoneDragonClgChallengeFinishRes(msg)
	end
end

BoneDragonAgent.instance = BoneDragonAgent.New()

return BoneDragonAgent
