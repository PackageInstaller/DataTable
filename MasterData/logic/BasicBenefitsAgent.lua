-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/agent/BasicBenefitsAgent.lua

module("logic.extensions.basicbenefits.agent.BasicBenefitsAgent", package.seeall)

local BasicBenefitsAgent = class("BasicBenefitsAgent", BaseAgent)

BasicBenefitsAgent.PM_BasicBenefitsGainPrizeRes = "BasicBenefitsAgent_PM_BasicBenefitsGainPrizeRes"

function BasicBenefitsAgent:ctor()
	return
end

function BasicBenefitsAgent:setExtId(extId)
	BasicBenefitsAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function BasicBenefitsAgent:sendPM_BasicBenefitsGetInfoReq()
	local req = BasicBenefitsExtension_pb.PM_BasicBenefitsGetInfoReq()

	self:sendMsg(req)
end

function BasicBenefitsAgent:handlePM_BasicBenefitsGetInfoRes(status, msg)
	if status == 0 then
		SupplymergeController.instance:handleBasicBenefitsGetInfoRes(msg)
	end
end

function BasicBenefitsAgent:sendPM_BasicBenefitsGainStrengthPrizeReq()
	local req = BasicBenefitsExtension_pb.PM_BasicBenefitsGainStrengthPrizeReq()

	self:sendMsg(req)
end

function BasicBenefitsAgent:handlePM_BasicBenefitsGainStrengthPrizeRes(status, msg)
	if status == 0 then
		SupplymergeController.instance:handleBasicBenefitsGainStrengthPrizeRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.BasicBenefitsGainStrengthPrizeRes_assistant, status, msg)
end

function BasicBenefitsAgent:sendPM_BasicBenefitsGainPrizeReq()
	local req = BasicBenefitsExtension_pb.PM_BasicBenefitsGainPrizeReq()

	self:sendMsg(req)
end

function BasicBenefitsAgent:handlePM_BasicBenefitsGainPrizeRes(status, msg)
	SupplymergeController.instance:handleBasicBenefitsGainPrizeResult(status, msg)
	self:dispatch(BasicBenefitsAgent.PM_BasicBenefitsGainPrizeRes, status, msg)
end

function BasicBenefitsAgent:sendPM_BasicBenefitsCompensateReq(index)
	local req = BasicBenefitsExtension_pb.PM_BasicBenefitsCompensateReq()

	req.index = index

	self:sendMsg(req)
end

function BasicBenefitsAgent:handlePM_BasicBenefitsCompensateRes(status, msg)
	if status == 0 then
		SupplymergeController.instance:handleBasicBenefitsCompensateRes(msg)
	end
end

BasicBenefitsAgent.instance = BasicBenefitsAgent.New()

return BasicBenefitsAgent
