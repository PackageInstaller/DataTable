-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/agent/BuddyLuckyBagAgent.lua

module("logic.extensions.buddyluckybag.agent.BuddyLuckyBagAgent", package.seeall)

local BuddyLuckyBagAgent = class("BuddyLuckyBagAgent", BaseAgent)

function BuddyLuckyBagAgent:sendPM_BuddyLuckyBagGetInfoReq(activityId)
	local req = BuddyLuckyBagExtension_pb.PM_BuddyLuckyBagGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BuddyLuckyBagAgent:handlePM_BuddyLuckyBagGetInfoRes(status, msg)
	if status == 0 then
		BuddyLuckyBagController.instance:handlePM_BuddyLuckyBagGetInfoRes(msg)
	end
end

function BuddyLuckyBagAgent:sendPM_BuddyLuckyBagHelpOpenBagReq(activityId, buddyCode)
	local req = BuddyLuckyBagExtension_pb.PM_BuddyLuckyBagHelpOpenBagReq()

	req.activityId = activityId
	req.buddyCode = buddyCode

	self:sendMsg(req)
end

function BuddyLuckyBagAgent:handlePM_BuddyLuckyBagHelpOpenBagRes(status, msg)
	if status == 0 then
		BuddyLuckyBagController.instance:handlePM_BuddyLuckyBagHelpOpenBagRes(msg)
	end
end

function BuddyLuckyBagAgent:sendPM_BuddyLuckyBagGainCollectPrizeBagReq(activityId, prizeId)
	local req = BuddyLuckyBagExtension_pb.PM_BuddyLuckyBagGainCollectPrizeBagReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function BuddyLuckyBagAgent:handlePM_BuddyLuckyBagGainCollectPrizeBagRes(status, msg)
	if status == 0 then
		BuddyLuckyBagController.instance:handlePM_BuddyLuckyBagGainCollectPrizeBagRes(msg)
	end
end

function BuddyLuckyBagAgent:sendPM_BuddyLuckyBagBuddyBagsReq(activityId, buddyIds)
	local req = BuddyLuckyBagExtension_pb.PM_BuddyLuckyBagBuddyBagsReq()

	req.activityId = activityId

	if buddyIds then
		for _, v in ipairs(buddyIds) do
			req.buddyIds:append(v)
		end
	end

	self:sendMsg(req)
end

function BuddyLuckyBagAgent:handlePM_BuddyLuckyBagBuddyBagsRes(status, msg)
	if status == 0 then
		BuddyLuckyBagController.instance:handlePM_BuddyLuckyBagBuddyBagsRes(msg)
	end
end

function BuddyLuckyBagAgent:sendPM_BuddyLuckyBagGainLuckReq(activityId, buddyId, bagId, prizeId)
	local req = BuddyLuckyBagExtension_pb.PM_BuddyLuckyBagGainLuckReq()

	req.activityId = activityId
	req.buddyId = buddyId
	req.bagId = bagId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function BuddyLuckyBagAgent:handlePM_BuddyLuckyBagGainLuckRes(status, msg)
	if status == 0 then
		BuddyLuckyBagController.instance:handlePM_BuddyLuckyBagGainLuckRes(msg)
	end
end

function BuddyLuckyBagAgent:sendPM_BuddyLuckyBagGainBagPrizeReq(activityId, bagId)
	local req = BuddyLuckyBagExtension_pb.PM_BuddyLuckyBagGainBagPrizeReq()

	req.activityId = activityId
	req.bagId = bagId

	self:sendMsg(req)
end

function BuddyLuckyBagAgent:handlePM_BuddyLuckyBagGainBagPrizeRes(status, msg)
	if status == 0 then
		BuddyLuckyBagController.instance:handlePM_BuddyLuckyBagGainBagPrizeRes(msg)
	end
end

function BuddyLuckyBagAgent:handlePM_BuddyLuckyBagNotifyChangeRes(status, msg)
	if status == 0 then
		BuddyLuckyBagController.instance:handlePM_BuddyLuckyBagNotifyChangeRes(msg)
	end
end

BuddyLuckyBagAgent.instance = BuddyLuckyBagAgent.New()

return BuddyLuckyBagAgent
