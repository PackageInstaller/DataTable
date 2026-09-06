-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/agent/CampaignInviteAgent.lua

module("logic.extensions.playerreturn.agent.CampaignInviteAgent", package.seeall)

local CampaignInviteAgent = class("CampaignInviteAgent", BaseAgent)

function CampaignInviteAgent:sendPM_CIGetActInfoReq(activityId)
	local req = CampaignInviteExtension_pb.PM_CIGetActInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CampaignInviteAgent:handlePM_CIGetActInfoRes(status, msg)
	if status == 0 then
		PlayerReturnController.instance:csSendCIGetActInfo(msg)
	end
end

function CampaignInviteAgent:sendPM_CIGetInviteListReq(activityId)
	local req = CampaignInviteExtension_pb.PM_CIGetInviteListReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CampaignInviteAgent:handlePM_CIGetInviteListRes(status, msg)
	if status == 0 then
		PlayerReturnController.instance:csSendCIGetInviteList(msg.inviteList)
	end
end

function CampaignInviteAgent:sendPM_CIUseCodeReq(activityId, code)
	local req = CampaignInviteExtension_pb.PM_CIUseCodeReq()

	req.activityId = activityId
	req.code = code

	self:sendMsg(req)
end

function CampaignInviteAgent:handlePM_CIUseCodeRes(status, msg)
	if status == 0 then
		PlayerReturnController.instance:csSendCIUseCode(msg)
	end
end

function CampaignInviteAgent:sendPM_CIGainPrizeReq(activityId)
	local req = CampaignInviteExtension_pb.PM_CIGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CampaignInviteAgent:handlePM_CIGainPrizeRes(status, msg)
	if status == 0 then
		PlayerReturnController.instance:csSendCIGainPrize(msg)
	end
end

function CampaignInviteAgent:sendPM_CIGainTypePrizeReq(activityId, prizeId)
	local req = CampaignInviteExtension_pb.PM_CIGainTypePrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function CampaignInviteAgent:handlePM_CIGainTypePrizeRes(status, msg)
	if status == 0 then
		PlayerReturnController.instance:handlePM_CIGainTypePrizeRes(msg)
	end
end

function CampaignInviteAgent:handlePM_CINotifyNewInviteRes(status, msg)
	if status == 0 then
		PlayerReturnController.instance:csSendCINotifyNewInvite(msg)
	end
end

CampaignInviteAgent.instance = CampaignInviteAgent.New()

return CampaignInviteAgent
