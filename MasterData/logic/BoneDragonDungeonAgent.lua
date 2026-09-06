-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragondungeon/agent/BoneDragonDungeonAgent.lua

module("logic.extensions.bonedragondungeon.agent.BoneDragonDungeonAgent", package.seeall)

local BoneDragonDungeonAgent = class("BoneDragonDungeonAgent", BaseAgent)

function BoneDragonDungeonAgent:sendPM_BoneDragonDungeonGetInfoReq(activityId)
	local req = BoneDragonDungeonExtension_pb.PM_BoneDragonDungeonGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BoneDragonDungeonAgent:handlePM_BoneDragonDungeonGetInfoRes(status, msg)
	if status == 0 then
		BoneDragonDungeonController.instance:handlePM_BoneDragonDungeonGetInfoRes(msg)
	end
end

function BoneDragonDungeonAgent:sendPM_BoneDragonDungeonGainProgressPrizeReq(activityId)
	local req = BoneDragonDungeonExtension_pb.PM_BoneDragonDungeonGainProgressPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BoneDragonDungeonAgent:handlePM_BoneDragonDungeonGainProgressPrizeRes(status, msg)
	if status == 0 then
		BoneDragonDungeonController.instance:handlePM_BoneDragonDungeonGainProgressPrizeRes(msg)
	end
end

function BoneDragonDungeonAgent:sendPM_BoneDragonDungeonStartExploreReq(activityId, stageId)
	local req = BoneDragonDungeonExtension_pb.PM_BoneDragonDungeonStartExploreReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function BoneDragonDungeonAgent:handlePM_BoneDragonDungeonStartExploreRes(status, msg)
	if status == 0 then
		BoneDragonDungeonController.instance:handlePM_BoneDragonDungeonStartExploreRes(msg)
	end
end

function BoneDragonDungeonAgent:sendPM_BoneDragonDungeonExitOrResetReq(activityId, stageId, exit)
	local req = BoneDragonDungeonExtension_pb.PM_BoneDragonDungeonExitOrResetReq()

	req.activityId = activityId
	req.stageId = stageId
	req.exit = exit

	self:sendMsg(req)
end

function BoneDragonDungeonAgent:handlePM_BoneDragonDungeonExitOrResetRes(status, msg)
	if status == 0 then
		BoneDragonDungeonController.instance:handlePM_BoneDragonDungeonExitOrResetRes(msg)
	end
end

function BoneDragonDungeonAgent:sendPM_BoneDragonDungeonMoveReq(activityId, stageId, direction)
	local req = BoneDragonDungeonExtension_pb.PM_BoneDragonDungeonMoveReq()

	req.activityId = activityId
	req.stageId = stageId
	req.direction = direction

	self:sendMsg(req)
end

function BoneDragonDungeonAgent:handlePM_BoneDragonDungeonMoveRes(status, msg)
	if status == 0 then
		BoneDragonDungeonController.instance:handlePM_BoneDragonDungeonMoveRes(msg)
	end
end

function BoneDragonDungeonAgent:sendPM_BoneDragonDungeonBuyPetReq(activityId, petPosId)
	local req = BoneDragonDungeonExtension_pb.PM_BoneDragonDungeonBuyPetReq()

	req.activityId = activityId
	req.petPosId = petPosId

	self:sendMsg(req)
end

function BoneDragonDungeonAgent:handlePM_BoneDragonDungeonBuyPetRes(status, msg)
	if status == 0 then
		BoneDragonDungeonController.instance:handlePM_BoneDragonDungeonBuyPetRes(msg)
	end
end

function BoneDragonDungeonAgent:sendPM_BoneDragonDungeonHandleEventReq(activityId, stageId, eventId, roleId, battleForm)
	local req = BoneDragonDungeonExtension_pb.PM_BoneDragonDungeonHandleEventReq()

	req.activityId = activityId
	req.stageId = stageId
	req.eventId = eventId
	req.roleId = roleId

	if battleForm ~= nil then
		req.battleForm:ParseFromString(battleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function BoneDragonDungeonAgent:handlePM_BoneDragonDungeonHandleEventRes(status, msg)
	if status == 0 then
		BoneDragonDungeonController.instance:handlePM_BoneDragonDungeonHandleEventRes(msg)
	end
end

function BoneDragonDungeonAgent:handlePM_Notify_BoneDragonDungeonChallengeResult(status, msg)
	if status == 0 then
		BoneDragonDungeonController.instance:handlePM_Notify_BoneDragonDungeonChallengeResult(msg)
	end
end

BoneDragonDungeonAgent.instance = BoneDragonDungeonAgent.New()

return BoneDragonDungeonAgent
