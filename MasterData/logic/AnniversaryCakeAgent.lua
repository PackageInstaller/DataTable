-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/agent/AnniversaryCakeAgent.lua

module("logic.extensions.anniversarycake.agent.AnniversaryCakeAgent", package.seeall)

local AnniversaryCakeAgent = class("AnniversaryCakeAgent", BaseAgent)

function AnniversaryCakeAgent:sendPM_ACGetMakeCakeInfoReq(activityId)
	local req = AnniversaryCakeExtension_pb.PM_ACGetMakeCakeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACGetMakeCakeInfoRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onGetMakeCakeInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACGetMakeCakeInfoRes)
	end
end

function AnniversaryCakeAgent:sendPM_ACGainMakeCakePersonalPrizeReq(activityId, personalPrizeId)
	local req = AnniversaryCakeExtension_pb.PM_ACGainMakeCakePersonalPrizeReq()

	req.activityId = activityId
	req.personalPrizeId = personalPrizeId

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACGainMakeCakePersonalPrizeRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onGainMakeCakePersonalPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACGainMakeCakePersonalPrizeRes)
	end
end

function AnniversaryCakeAgent:sendPM_ACGainMakeCakeWorldPrizeReq(activityId, worldPrizeId)
	local req = AnniversaryCakeExtension_pb.PM_ACGainMakeCakeWorldPrizeReq()

	req.activityId = activityId
	req.worldPrizeId = worldPrizeId

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACGainMakeCakeWorldPrizeRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onGainMakeCakeWorldPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACGainMakeCakeWorldPrizeRes)
	end
end

function AnniversaryCakeAgent:sendPM_ACStartMakeCakeReq(activityId, stage)
	local req = AnniversaryCakeExtension_pb.PM_ACStartMakeCakeReq()

	req.activityId = activityId
	req.stage = stage

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACStartMakeCakeRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onStartMakeCakeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACStartMakeCakeRes)
	end
end

function AnniversaryCakeAgent:sendPM_ACEndMakeCakeReq(activityId)
	local req = AnniversaryCakeExtension_pb.PM_ACEndMakeCakeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACEndMakeCakeRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onEndMakeCakeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACEndMakeCakeRes)
	end
end

function AnniversaryCakeAgent:sendPM_ACGetRankInfoReq(activityId, fromStage, toStage)
	local req = AnniversaryCakeExtension_pb.PM_ACGetRankInfoReq()

	req.activityId = activityId
	req.fromStage = fromStage
	req.toStage = toStage

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACGetRankInfoRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:GetRankInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACGetRankInfoRes)
	end
end

function AnniversaryCakeAgent:sendPM_ACMakeCakeAddPipeReq(activityId)
	local req = AnniversaryCakeExtension_pb.PM_ACMakeCakeAddPipeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACMakeCakeAddPipeRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onMakeCakeAddPipeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACMakeCakeAddPipeRes)
	end
end

function AnniversaryCakeAgent:sendPM_ACGetEatCakeInfoReq(activityId)
	local req = AnniversaryCakeExtension_pb.PM_ACGetEatCakeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACGetEatCakeInfoRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onGetEatCakeInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACGetEatCakeInfoRes)
	end
end

function AnniversaryCakeAgent:sendPM_ACGainEatCakePrizeReq(activityId, eatCakePrizeId)
	local req = AnniversaryCakeExtension_pb.PM_ACGainEatCakePrizeReq()

	req.activityId = activityId
	req.eatCakePrizeId = eatCakePrizeId

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACGainEatCakePrizeRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onGainEatCakePrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACGainEatCakePrizeRes)
	end
end

function AnniversaryCakeAgent:sendPM_ACGainEatCakeWorldPrizeReq(activityId, worldPrizeId)
	local req = AnniversaryCakeExtension_pb.PM_ACGainEatCakeWorldPrizeReq()

	req.activityId = activityId
	req.worldPrizeId = worldPrizeId

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACGainEatCakeWorldPrizeRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onGainEatCakeWorldPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACGainEatCakeWorldPrizeRes)
	end
end

function AnniversaryCakeAgent:sendPM_ACStartEatCakeReq(activityId, clientKey)
	local req = AnniversaryCakeExtension_pb.PM_ACStartEatCakeReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACStartEatCakeRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onStartEatCakeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACStartEatCakeRes, msg.serverKey)
	end
end

function AnniversaryCakeAgent:sendPM_ACEndEatCakeReq(activityId, eatCakeCount, encryptedKey)
	local req = AnniversaryCakeExtension_pb.PM_ACEndEatCakeReq()

	req.activityId = activityId
	req.eatCakeCount = eatCakeCount
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function AnniversaryCakeAgent:handlePM_ACEndEatCakeRes(status, msg)
	if status == 0 then
		MakeCakeModel.instance:onEndEatCakeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ACEndEatCakeRes)
	end
end

AnniversaryCakeAgent.instance = AnniversaryCakeAgent.New()

return AnniversaryCakeAgent
