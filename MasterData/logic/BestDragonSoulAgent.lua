-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bestdragonsoul/agent/BestDragonSoulAgent.lua

module("logic.extensions.bestdragonsoul.agent.BestDragonSoulAgent", package.seeall)

local BestDragonSoulAgent = class("BestDragonSoulAgent", BaseAgent)

function BestDragonSoulAgent:sendPM_BestDragonSoulInfoReq(activityId)
	local req = BestDragonSoulExtension_pb.PM_BestDragonSoulInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BestDragonSoulAgent:handlePM_BestDragonSoulInfoRes(status, msg)
	if status == 0 then
		BestdragonsoulModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BestDragonSoulInfoRes)
	end
end

function BestDragonSoulAgent:sendPM_BestDragonSoulStartGameReq(activityId, clientKey)
	local req = BestDragonSoulExtension_pb.PM_BestDragonSoulStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function BestDragonSoulAgent:handlePM_BestDragonSoulStartGameRes(status, msg)
	if status == 0 then
		local serverKey = msg.serverKey

		BestdragonsoulController.instance:handlePM_BestDragonSoulStartGameRes(serverKey)
		GlobalDispatcher:dispatch(GlobalNotify.BestDragonSoulStartGameRes)
	end
end

function BestDragonSoulAgent:sendPM_BestDragonSoulEndGameReq(activityId, isPass, encryptedKey, prizes)
	local req = BestDragonSoulExtension_pb.PM_BestDragonSoulEndGameReq()

	req.activityId = activityId
	req.isPass = isPass
	req.encryptedKey = encryptedKey

	for i, v in ipairs(prizes) do
		local p = req.prizes:add()

		p.typeId = v.typeId
		p.num = v.num
	end

	self:sendMsg(req)
end

function BestDragonSoulAgent:handlePM_BestDragonSoulEndGameRes(status, msg)
	if status == 0 then
		BestdragonsoulModel.instance:updateProgress(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BestDragonSoulEndGameRes)
	end
end

function BestDragonSoulAgent:sendPM_BestDragonSoulGainPrizeReq(activityId, typeId, prizeId)
	local req = BestDragonSoulExtension_pb.PM_BestDragonSoulGainPrizeReq()

	req.activityId = activityId
	req.typeId = typeId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function BestDragonSoulAgent:handlePM_BestDragonSoulGainPrizeRes(status, msg)
	if status == 0 then
		BestdragonsoulModel.instance:gainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BestDragonSoulGainPrizeRes)
	end
end

function BestDragonSoulAgent:sendPM_BestDragonSoulLikeReq(activityId, id)
	local req = BestDragonSoulExtension_pb.PM_BestDragonSoulLikeReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function BestDragonSoulAgent:handlePM_BestDragonSoulLikeRes(status, msg)
	if status == 0 then
		BestdragonsoulModel.instance:updateLikeItem(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BestDragonSoulLikeRes)
	end
end

BestDragonSoulAgent.instance = BestDragonSoulAgent.New()

return BestDragonSoulAgent
