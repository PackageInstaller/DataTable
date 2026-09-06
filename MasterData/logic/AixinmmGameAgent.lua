-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmmgame/agent/AixinmmGameAgent.lua

module("logic.extensions.aixinmmgame.agent.AixinmmGameAgent", package.seeall)

local AixinmmGameAgent = class("AixinmmGameAgent", BaseAgent)

function AixinmmGameAgent:sendPM_AXMMGameGetInfoReq(activityId)
	local req = AXMMGameExtension_pb.PM_AXMMGameGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AixinmmGameAgent:handlePM_AXMMGameGetInfoRes(status, msg)
	if status == 0 then
		AixinmmGameController.instance:handleGetInfo(msg)
	end
end

function AixinmmGameAgent:sendPM_AXMMGameGetGamePrizeReq(activityId, prizeId)
	local req = AXMMGameExtension_pb.PM_AXMMGameGetGamePrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function AixinmmGameAgent:handlePM_AXMMGameGetGamePrizeRes(status, msg)
	if status == 0 then
		AixinmmGameController.instance:handleGetGamePrize(msg)
	end
end

function AixinmmGameAgent:sendPM_AXMMGameStartGameReq(activityId, clientKey)
	local req = AXMMGameExtension_pb.PM_AXMMGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function AixinmmGameAgent:handlePM_AXMMGameStartGameRes(status, msg)
	if status == 0 then
		AixinmmGameController.instance:handleStartGame(msg)
	end
end

function AixinmmGameAgent:sendPM_AXMMGameEndGameReq(activityId, shovelNums, encryptedKey)
	local req = AXMMGameExtension_pb.PM_AXMMGameEndGameReq()

	req.activityId = activityId
	req.shovelNums = shovelNums
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function AixinmmGameAgent:handlePM_AXMMGameEndGameRes(status, msg)
	if status == 0 then
		AixinmmGameController.instance:handleSettleGame(msg)
	end
end

AixinmmGameAgent.instance = AixinmmGameAgent.New()

return AixinmmGameAgent
