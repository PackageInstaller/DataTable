-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarypreheat/agent/AnniversaryPreheatAgent.lua

module("logic.extensions.anniversarypreheat.agent.AnniversaryPreheatAgent", package.seeall)

local AnniversaryPreheatAgent = class("AnniversaryPreheatAgent", BaseAgent)

function AnniversaryPreheatAgent:sendPM_AnniversaryPreheatInfoReq()
	local req = AnniversaryPreheatExtension_pb.PM_AnniversaryPreheatInfoReq()

	self:sendMsg(req)
end

function AnniversaryPreheatAgent:handlePM_AnniversaryPreheatInfoRes(status, msg)
	if status == 0 then
		AnniversaryPreheatController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.AnniversaryPreheatError, status)
	end
end

function AnniversaryPreheatAgent:sendPM_AnniversaryPreheatDanMuReq()
	local req = AnniversaryPreheatExtension_pb.PM_AnniversaryPreheatDanMuReq()

	self:sendMsg(req)
end

function AnniversaryPreheatAgent:handlePM_AnniversaryPreheatDanMuRes(status, msg)
	if status == 0 then
		AnniversaryPreheatController.instance:handleGetDanMuInfos(msg)
	end
end

function AnniversaryPreheatAgent:sendPM_AnniversaryPreheatSendDanmuReq(danmuId)
	local req = AnniversaryPreheatExtension_pb.PM_AnniversaryPreheatSendDanmuReq()

	req.danmuId = danmuId

	self:sendMsg(req)
end

function AnniversaryPreheatAgent:handlePM_AnniversaryPreheatSendDanmuRes(status, msg)
	if status == 0 then
		AnniversaryPreheatController.instance:handleSendDanMu(msg)
	end
end

function AnniversaryPreheatAgent:sendPM_AnniversaryPreheatSuccessShareReq()
	local req = AnniversaryPreheatExtension_pb.PM_AnniversaryPreheatSuccessShareReq()

	self:sendMsg(req)
end

function AnniversaryPreheatAgent:handlePM_AnniversaryPreheatSuccessShareRes(status, msg)
	if status == 0 then
		AnniversaryPreheatController.instance:handldSucShare(msg)
	end
end

function AnniversaryPreheatAgent:sendPM_AnniversaryPreheatGainSharePrizeReq()
	local req = AnniversaryPreheatExtension_pb.PM_AnniversaryPreheatGainSharePrizeReq()

	self:sendMsg(req)
end

function AnniversaryPreheatAgent:handlePM_AnniversaryPreheatGainSharePrizeRes(status, msg)
	if status == 0 then
		AnniversaryPreheatController.instance:handleGainSharePrize(msg)
	end
end

function AnniversaryPreheatAgent:sendPM_AnniversaryPreheatGainProgressPrizeReq(id)
	local req = AnniversaryPreheatExtension_pb.PM_AnniversaryPreheatGainProgressPrizeReq()

	req.id = id

	self:sendMsg(req)
end

function AnniversaryPreheatAgent:handlePM_AnniversaryPreheatGainProgressPrizeRes(status, msg)
	if status == 0 then
		AnniversaryPreheatController.instance:handleGainProgressPrize(msg)
	end
end

function AnniversaryPreheatAgent:sendPM_AnniversaryPreheatDanmuSwitchReq(closeDanmu)
	local req = AnniversaryPreheatExtension_pb.PM_AnniversaryPreheatDanmuSwitchReq()

	req.closeDanmu = closeDanmu

	self:sendMsg(req)
end

function AnniversaryPreheatAgent:handlePM_AnniversaryPreheatDanmuSwitchRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.AnniversaryPreheatGetInfo)
	end
end

AnniversaryPreheatAgent.instance = AnniversaryPreheatAgent.New()

return AnniversaryPreheatAgent
