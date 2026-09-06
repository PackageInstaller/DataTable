-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/agent/AnniversaryPublicityAgent.lua

module("logic.extensions.anniversarypublicity.agent.AnniversaryPublicityAgent", package.seeall)

local AnniversaryPublicityAgent = class("AnniversaryPublicityAgent", BaseAgent)

function AnniversaryPublicityAgent:ctor()
	return
end

function AnniversaryPublicityAgent:setExtId(extId)
	AnniversaryPublicityAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function AnniversaryPublicityAgent:sendPM_AnniversaryPublicityGetInfoReq(activityId)
	local req = AnniversaryPublicityExtension_pb.PM_AnniversaryPublicityGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnniversaryPublicityAgent:handlePM_AnniversaryPublicityGetInfoRes(status, msg)
	if status == 0 then
		OfflineController.instance:setPrizeInfo(msg)
	end
end

function AnniversaryPublicityAgent:sendPM_AnniversaryPublicityGainPrizeReq(activityId, prizeId)
	local req = AnniversaryPublicityExtension_pb.PM_AnniversaryPublicityGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function AnniversaryPublicityAgent:handlePM_AnniversaryPublicityGainPrizeRes(status, msg)
	if status == 0 then
		OfflineController.instance:setGetPrize()
	end
end

AnniversaryPublicityAgent.instance = AnniversaryPublicityAgent.New()

return AnniversaryPublicityAgent
