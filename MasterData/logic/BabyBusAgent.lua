-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/agent/BabyBusAgent.lua

module("logic.extensions.babybus.agent.BabyBusAgent", package.seeall)

local BabyBusAgent = class("BabyBusAgent", BaseAgent)

BabyBusAgent.BabyBusGetInfo = "BabyBusAgent.BabyBusGetInfo"
BabyBusAgent.BabyBusWalk = "BabyBusAgent.BabyBusWalk"
BabyBusAgent.BabyBusGainPrize = "BabyBusAgent.BabyBusGainPrize"

function BabyBusAgent:sendPM_BabyBusGetInfoReq(activityId)
	local req = BabyBusExtension_pb.PM_BabyBusGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BabyBusAgent:handlePM_BabyBusGetInfoRes(status, msg)
	if status == 0 then
		BabybusModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(BabyBusAgent.BabyBusGetInfo)
	end
end

function BabyBusAgent:sendPM_BabyBusWalkReq(activityId)
	local req = BabyBusExtension_pb.PM_BabyBusWalkReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BabyBusAgent:handlePM_BabyBusWalkRes(status, msg)
	if status == 0 then
		BabybusModel.instance:setWaledToday()
		GlobalDispatcher:dispatch(BabyBusAgent.BabyBusWalk)
	end
end

function BabyBusAgent:sendPM_BabyBusGainPrizeReq(activityId, prizeId)
	local req = BabyBusExtension_pb.PM_BabyBusGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function BabyBusAgent:handlePM_BabyBusGainPrizeRes(status, msg)
	if status == 0 then
		BabybusController.instance:babyBusGainPrize(msg.code)
		GlobalDispatcher:dispatch(BabyBusAgent.BabyBusGainPrize)
	end
end

BabyBusAgent.instance = BabyBusAgent.New()

return BabyBusAgent
