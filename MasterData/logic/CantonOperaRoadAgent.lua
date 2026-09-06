-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/agent/CantonOperaRoadAgent.lua

module("logic.extensions.cantonoperaroad.agent.CantonOperaRoadAgent", package.seeall)

local CantonOperaRoadAgent = class("CantonOperaRoadAgent", BaseAgent)

function CantonOperaRoadAgent:sendPM_CantonOperaRoadGetInfoReq(activityId)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadGetInfoRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadGetInfoRes(msg)
	end
end

function CantonOperaRoadAgent:sendPM_CantonOperaRoadAnswerInfoReq(activityId)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadAnswerInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadAnswerInfoRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadAnswerInfoRes(msg)
	end
end

function CantonOperaRoadAgent:sendPM_CantonOperaRoadAnswerReq(activityId)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadAnswerReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadAnswerRes(status, msg)
	CantonOperaRoadController.instance:handlePM_CantonOperaRoadAnswerRes(status, msg)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadAnswerSceneExitRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadAnswerSceneExitRes(msg)
	end
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadAnswerPrizeNotifyRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadAnswerPrizeNotifyRes(msg)
	end
end

function CantonOperaRoadAgent:sendPM_CantonOperaRoadJigsawInfoReq(activityId)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadJigsawInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadJigsawInfoRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadJigsawInfoRes(msg)
	end
end

function CantonOperaRoadAgent:sendPM_CantonOperaRoadJigsawClgReq(activityId, jigsawId, stageId, simpleForm)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadJigsawClgReq()

	req.activityId = activityId
	req.jigsawId = jigsawId
	req.stageId = stageId

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadJigsawClgRes(status, msg)
	CantonOperaRoadController.instance:handlePM_CantonOperaRoadJigsawClgRes(status, msg)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadJigsawBattleEndRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadJigsawBattleEndRes(msg)
	end
end

function CantonOperaRoadAgent:sendPM_CantonOperaRoadLightUpReq(activityId, jigsawId, pieceId)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadLightUpReq()

	req.activityId = activityId
	req.jigsawId = jigsawId
	req.pieceId = pieceId

	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadLightUpRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadLightUpRes(msg)
	end
end

function CantonOperaRoadAgent:sendPM_CantonOperaRoadBossInfoReq(activityId)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadBossInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadBossInfoRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadBossInfoRes(msg)
	end
end

function CantonOperaRoadAgent:sendPM_CantonOperaRoadBossClgReq(activityId, simpleForm)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadBossClgReq()

	req.activityId = activityId

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadBossClgRes(status, msg)
	CantonOperaRoadController.instance:handlePM_CantonOperaRoadBossClgRes(status, msg)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadBossBattleEndRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadBossBattleEndRes(msg)
	end
end

function CantonOperaRoadAgent:sendPM_CantonOperaRoadBossFormReq(activityId, challengeTimes)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadBossFormReq()

	req.activityId = activityId
	req.challengeTimes = challengeTimes

	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadBossFormRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadBossFormRes(msg)
	end
end

function CantonOperaRoadAgent:sendPM_CantonOperaRoadBossRankReq(activityId)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadBossRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadBossRankRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadBossRankRes(msg)
	end
end

function CantonOperaRoadAgent:sendPM_CantonOperaRoadPvGetPrizeReq(activityId)
	local req = CantonOperaRoadExtension_pb.PM_CantonOperaRoadPvGetPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CantonOperaRoadAgent:handlePM_CantonOperaRoadPvGetPrizeRes(status, msg)
	if status == 0 then
		CantonOperaRoadController.instance:handlePM_CantonOperaRoadPvGetPrizeRes(msg)
	end
end

CantonOperaRoadAgent.instance = CantonOperaRoadAgent.New()

return CantonOperaRoadAgent
