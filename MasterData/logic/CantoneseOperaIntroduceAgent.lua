-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantoneseopera/agent/CantoneseOperaIntroduceAgent.lua

module("logic.extensions.cantoneseoperaintroduce.agent.CantoneseOperaIntroduceAgent", package.seeall)

local CantoneseOperaIntroduceAgent = class("CantoneseOperaIntroduceAgent", BaseAgent)

function CantoneseOperaIntroduceAgent:ctor()
	return
end

function CantoneseOperaIntroduceAgent:setExtId(extId)
	CantoneseOperaIntroduceAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function CantoneseOperaIntroduceAgent:sendPM_CantoneseOperaIntroduceGetInfoReq(activityId)
	local req = CantoneseOperaIntroduceExtension_pb.PM_CantoneseOperaIntroduceGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CantoneseOperaIntroduceAgent:handlePM_CantoneseOperaIntroduceGetInfoRes(status, msg)
	if status == 0 then
		CantoneseOperaController.instance:onGetInfo(msg)
	end
end

function CantoneseOperaIntroduceAgent:sendPM_CantoneseOperaIntroduceGainPrizeReq(activityId, prizeNodeId)
	local req = CantoneseOperaIntroduceExtension_pb.PM_CantoneseOperaIntroduceGainPrizeReq()

	req.activityId = activityId
	req.prizeNodeId = prizeNodeId

	self:sendMsg(req)
end

function CantoneseOperaIntroduceAgent:handlePM_CantoneseOperaIntroduceGainPrizeRes(status, msg)
	if status == 0 then
		CantoneseOperaController.instance:onGetPrize(msg)
	end
end

function CantoneseOperaIntroduceAgent:sendPM_CantoneseOperaIntroduceGoReq(activityId)
	local req = CantoneseOperaIntroduceExtension_pb.PM_CantoneseOperaIntroduceGoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CantoneseOperaIntroduceAgent:handlePM_CantoneseOperaIntroduceGoRes(status, msg)
	if status == 0 then
		CantoneseOperaController.instance:onMoveNext(msg)
	end
end

CantoneseOperaIntroduceAgent.instance = CantoneseOperaIntroduceAgent.New()

return CantoneseOperaIntroduceAgent
