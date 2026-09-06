-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualbox/agent/AssembleOrderAgent.lua

module("logic.extensions.annualbox.agent.AssembleOrderAgent", package.seeall)

local AssembleOrderAgent = class("AssembleOrderAgent", BaseAgent)

function AssembleOrderAgent:sendPM_AssembleOrderInfoReq()
	local req = AssembleOrderExtension_pb.PM_AssembleOrderInfoReq()

	self:sendMsg(req)
end

function AssembleOrderAgent:handlePM_AssembleOrderInfoRes(status, msg)
	if status == 0 then
		AnnualBoxController.instance:scPushAssembleOrderInfo(msg)
	end
end

function AssembleOrderAgent:sendPM_AssembleOrderGainInvitePrizeReq(prizeId)
	local req = AssembleOrderExtension_pb.PM_AssembleOrderGainInvitePrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function AssembleOrderAgent:handlePM_AssembleOrderGainInvitePrizeRes(status, msg)
	if status == 0 then
		AnnualBoxController.instance:scPushAssembleOrderGainInvitePrize()
	end
end

function AssembleOrderAgent:sendPM_AssembleOrderGainRegressionPrizeReq()
	local req = AssembleOrderExtension_pb.PM_AssembleOrderGainRegressionPrizeReq()

	self:sendMsg(req)
end

function AssembleOrderAgent:handlePM_AssembleOrderGainRegressionPrizeRes(status, msg)
	if status == 0 then
		AnnualBoxController.instance:setRegressionPrizeStateGeted()
		GlobalDispatcher:dispatch(GlobalNotify.AssembleOrderGainRegressionPrizeRes)
	end
end

AssembleOrderAgent.instance = AssembleOrderAgent.New()

return AssembleOrderAgent
