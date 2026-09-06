-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bindmobile/agent/BindMobileAgent.lua

module("logic.extensions.bindmobile.agent.BindMobileAgent", package.seeall)

local BindMobileAgent = class("BindMobileAgent", BaseAgent)

function BindMobileAgent:sendPM_BindMobileGetInfoReq()
	local req = BindMobileExtension_pb.PM_BindMobileGetInfoReq()

	self:sendMsg(req)
end

function BindMobileAgent:handlePM_BindMobileGetInfoRes(status, msg)
	if status == 0 then
		BindMobileModel.instance:onGetInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BIND_MOBILE_INFO_UPDATE)
	end
end

function BindMobileAgent:sendPM_BindMobileGetCaptchaReq(mobile)
	local req = BindMobileExtension_pb.PM_BindMobileGetCaptchaReq()

	req.mobile = mobile

	self:sendMsg(req)
end

function BindMobileAgent:handlePM_BindMobileGetCaptchaRes(status, msg)
	if status == 0 then
		BindMobileModel.instance:onGetBindCode(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BIND_MOBILE_INFO_UPDATE)
	end
end

function BindMobileAgent:sendPM_BindMobileBindReq(mobile, captcha)
	local req = BindMobileExtension_pb.PM_BindMobileBindReq()

	req.mobile = mobile
	req.captcha = captcha

	self:sendMsg(req)
end

function BindMobileAgent:handlePM_BindMobileBindRes(status, msg)
	if status == 0 then
		BindMobileModel.instance:onBindCode(msg)

		local pb = GameUtil.pbToTable(msg) or {}

		if pb.result and pb.result.code ~= 0 then
			GlobalDispatcher:dispatch(GlobalNotify.BIND_MOBILE_INFO_UPDATE)
		else
			BindMobileAgent.instance:sendPM_BindMobileGetInfoReq()
		end
	end
end

function BindMobileAgent:sendPM_BindMobileGainPrizeReq()
	local req = BindMobileExtension_pb.PM_BindMobileGainPrizeReq()

	self:sendMsg(req)
end

function BindMobileAgent:handlePM_BindMobileGainPrizeRes(status, msg)
	if status == 0 then
		BindMobileAgent.instance:sendPM_BindMobileGetInfoReq()
	end
end

BindMobileAgent.instance = BindMobileAgent.New()

return BindMobileAgent
