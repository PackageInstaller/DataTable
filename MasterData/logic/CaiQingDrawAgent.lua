-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/agent/CaiQingDrawAgent.lua

module("logic.extensions.caiqingdraw.agent.CaiQingDrawAgent", package.seeall)

local CaiQingDrawAgent = class("CaiQingDrawAgent", BaseAgent)

function CaiQingDrawAgent:sendPM_CaiQingDrawGetInfoReq(activityId)
	local req = CaiQingDrawExtension_pb.PM_CaiQingDrawGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CaiQingDrawAgent:handlePM_CaiQingDrawGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CaiQingDrawGetInfoRes, msg)
	end
end

function CaiQingDrawAgent:sendPM_CaiQingDrawPrizeReq(activityId, ten)
	local req = CaiQingDrawExtension_pb.PM_CaiQingDrawPrizeReq()

	req.activityId = activityId
	req.ten = ten

	self:sendMsg(req)
end

function CaiQingDrawAgent:handlePM_CaiQingDrawPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CaiQingDrawPrizeRes)
	end
end

CaiQingDrawAgent.instance = CaiQingDrawAgent.New()

return CaiQingDrawAgent
