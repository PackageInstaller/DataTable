-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorherolottery/agent/ArmorHeroLotteryAgent.lua

module("logic.extensions.armorherolottery.agent.ArmorHeroLotteryAgent", package.seeall)

local ArmorHeroLotteryAgent = class("ArmorHeroLotteryAgent", BaseAgent)

function ArmorHeroLotteryAgent:sendPM_ArmorHeroLotteryInfoReq(activityId)
	local req = ArmorHeroLotteryExtension_pb.PM_ArmorHeroLotteryInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ArmorHeroLotteryAgent:handlePM_ArmorHeroLotteryInfoRes(status, msg)
	if status == 0 then
		ArmorherolotteryModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ArmorHeroLotteryInfoRes)
	end
end

function ArmorHeroLotteryAgent:sendPM_ArmorHeroLotteryDrawReq(activityId, num)
	local req = ArmorHeroLotteryExtension_pb.PM_ArmorHeroLotteryDrawReq()

	req.activityId = activityId
	req.num = num

	self:sendMsg(req)
end

function ArmorHeroLotteryAgent:handlePM_ArmorHeroLotteryDrawRes(status, msg)
	if status == 0 then
		ArmorherolotteryModel.instance:onLotteryDrawRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ArmorHeroLotteryDrawRes, status, msg)
end

function ArmorHeroLotteryAgent:sendPM_ArmorHeroLotteryGainPrizeReq(activityId, prizeId)
	local req = ArmorHeroLotteryExtension_pb.PM_ArmorHeroLotteryGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ArmorHeroLotteryAgent:handlePM_ArmorHeroLotteryGainPrizeRes(status, msg)
	if status == 0 then
		ArmorherolotteryModel.instance:onGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ArmorHeroLotteryGainPrizeRes)
	end
end

function ArmorHeroLotteryAgent:sendPM_ArmorHeroLotteryOneKeyGainPrizeReq(activityId)
	local req = ArmorHeroLotteryExtension_pb.PM_ArmorHeroLotteryOneKeyGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ArmorHeroLotteryAgent:handlePM_ArmorHeroLotteryOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		self:sendPM_ArmorHeroLotteryInfoReq(activityId)
		GlobalDispatcher:dispatch(GlobalNotify.ArmorHeroLotteryOneKeyGainPrizeRes)
	end
end

ArmorHeroLotteryAgent.instance = ArmorHeroLotteryAgent.New()

return ArmorHeroLotteryAgent
