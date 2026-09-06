-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operatingGift/agent/CampaignThemeAgent.lua

module("logic.extensions.campaigntheme.agent.CampaignThemeAgent", package.seeall)

local CampaignThemeAgent = class("CampaignThemeAgent", BaseAgent)

CampaignThemeAgent.PM_GetMyCurCampaignThemeInfoRes = "CampaignThemeAgent_PM_GetMyCurCampaignThemeInfoRes"
CampaignThemeAgent.PM_GainCampaignThemeGiftRes = "CampaignThemeAgent_PM_GainCampaignThemeGiftRes"
CampaignThemeAgent.PM_NotifyCampaignThemeBuyGiftRes = "CampaignThemeAgent_PM_NotifyCampaignThemeBuyGiftRes"

function CampaignThemeAgent:ctor()
	return
end

function CampaignThemeAgent:setExtId(extId)
	CampaignThemeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function CampaignThemeAgent:sendPM_GetMyCurCampaignThemeInfoReq(handler, handlerObj, errHandler)
	local req = CampaignThemeExtension_pb.PM_GetMyCurCampaignThemeInfoReq()

	self:sendMsg(req)
	self:addEventOnce(CampaignThemeAgent.PM_GetMyCurCampaignThemeInfoRes, handler, handlerObj, errHandler)
end

function CampaignThemeAgent:handlePM_GetMyCurCampaignThemeInfoRes(status, msg)
	self:dispatch(CampaignThemeAgent.PM_GetMyCurCampaignThemeInfoRes, status, msg)
end

function CampaignThemeAgent:sendPM_GainCampaignThemeGiftReq(actId, giftId, handler, handlerObj, errHandler)
	local req = CampaignThemeExtension_pb.PM_GainCampaignThemeGiftReq()

	req.actId = actId
	req.giftId = giftId

	self:sendMsg(req)
	self:addEventOnce(CampaignThemeAgent.PM_GainCampaignThemeGiftRes, handler, handlerObj, errHandler)
end

function CampaignThemeAgent:handlePM_GainCampaignThemeGiftRes(status, msg)
	self:dispatch(CampaignThemeAgent.PM_GainCampaignThemeGiftRes, status, msg)
end

function CampaignThemeAgent:handlePM_NotifyCampaignThemeBuyGiftRes(status, msg)
	self:dispatch(CampaignThemeAgent.PM_NotifyCampaignThemeBuyGiftRes, status, msg)
end

CampaignThemeAgent.instance = CampaignThemeAgent.New()

return CampaignThemeAgent
