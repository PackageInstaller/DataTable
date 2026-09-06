-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/agent/AnniversaryKoiAgent.lua

module("logic.extensions.anniversarykoi.agent.AnniversaryKoiAgent", package.seeall)

local AnniversaryKoiAgent = class("AnniversaryKoiAgent", BaseAgent)

function AnniversaryKoiAgent:sendPM_AnniversaryKoiGetInfoReq(activityId)
	local req = AnniversaryKoiExtension_pb.PM_AnniversaryKoiGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnniversaryKoiAgent:handlePM_AnniversaryKoiGetInfoRes(status, msg)
	if status == 0 then
		AnniversaryKoiController.instance:handlePM_AnniversaryKoiGetInfoRes(status, msg)
	end
end

function AnniversaryKoiAgent:sendPM_AnniversaryKoiGetRecordsReq(activityId)
	local req = AnniversaryKoiExtension_pb.PM_AnniversaryKoiGetRecordsReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnniversaryKoiAgent:handlePM_AnniversaryKoiGetRecordsRes(status, msg)
	if status == 0 then
		AnniversaryKoiController.instance:handlePM_AnniversaryKoiGetRecordsRes(status, msg)
	end
end

function AnniversaryKoiAgent:sendPM_AnniversaryKoiRankViewReq(activityId, poolId, prizeType)
	local req = AnniversaryKoiExtension_pb.PM_AnniversaryKoiRankViewReq()

	req.activityId = activityId
	req.poolId = poolId
	req.prizeType = prizeType

	self:sendMsg(req)
end

function AnniversaryKoiAgent:handlePM_AnniversaryKoiRankViewRes(status, msg)
	if status == 0 then
		AnniversaryKoiController.instance:handlePM_AnniversaryKoiRankViewRes(status, msg)
	end
end

function AnniversaryKoiAgent:sendPM_AnniversaryKoiLotteryReq(activityId, poolId)
	local req = AnniversaryKoiExtension_pb.PM_AnniversaryKoiLotteryReq()

	req.activityId = activityId
	req.poolId = poolId

	self:sendMsg(req)
end

function AnniversaryKoiAgent:handlePM_AnniversaryKoiLotteryRes(status, msg)
	if status == 0 then
		AnniversaryKoiController.instance:handlePM_AnniversaryKoiLotteryRes(status, msg)
	end
end

function AnniversaryKoiAgent:handlePM_AnniversaryKoiNotifyLuckNumberRes(status, msg)
	if status == 0 then
		AnniversaryKoiController.instance:handlePM_AnniversaryKoiNotifyLuckNumberRes(status, msg)
	end
end

AnniversaryKoiAgent.instance = AnniversaryKoiAgent.New()

return AnniversaryKoiAgent
