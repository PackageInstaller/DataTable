-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/agent/AngelInvestorAgent.lua

module("logic.extensions.angelinvestor.agent.AngelInvestorAgent", package.seeall)

local AngelInvestorAgent = class("AngelInvestorAgent", BaseAgent)

function AngelInvestorAgent:sendPM_AngelInvestorGetInfoReq(activityId)
	local req = AngelInvestorExtension_pb.PM_AngelInvestorGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AngelInvestorAgent:handlePM_AngelInvestorGetInfoRes(status, msg)
	if status == 0 then
		AngelInvestorController.instance:handlePM_AngelInvestorGetInfoRes(msg)
	end
end

function AngelInvestorAgent:sendPM_AngelInvestorSignContractReq(activityId)
	local req = AngelInvestorExtension_pb.PM_AngelInvestorSignContractReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AngelInvestorAgent:handlePM_AngelInvestorSignContractRes(status, msg)
	if status == 0 then
		AngelInvestorController.instance:handlePM_AngelInvestorSignContractRes(msg)
	end
end

function AngelInvestorAgent:sendPM_AngelInvestorUpgradeAngelReq(activityId)
	local req = AngelInvestorExtension_pb.PM_AngelInvestorUpgradeAngelReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AngelInvestorAgent:handlePM_AngelInvestorUpgradeAngelRes(status, msg)
	if status == 0 then
		AngelInvestorController.instance:handlePM_AngelInvestorUpgradeAngelRes(msg)
	end
end

function AngelInvestorAgent:sendPM_AngelInvestorStartHangReq(activityId)
	local req = AngelInvestorExtension_pb.PM_AngelInvestorStartHangReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AngelInvestorAgent:handlePM_AngelInvestorStartHangRes(status, msg)
	if status == 0 then
		AngelInvestorController.instance:handlePM_AngelInvestorStartHangRes(msg)
	end
end

function AngelInvestorAgent:sendPM_AngelInvestorGainHangRewardReq(activityId, prizeIds)
	local req = AngelInvestorExtension_pb.PM_AngelInvestorGainHangRewardReq()

	req.activityId = activityId

	for i, id in ipairs(prizeIds) do
		req.prizeIds:append(id)
	end

	self:sendMsg(req)
end

function AngelInvestorAgent:handlePM_AngelInvestorGainHangRewardRes(status, msg)
	if status == 0 then
		AngelInvestorController.instance:handlePM_AngelInvestorGainHangRewardRes(msg)
	end
end

function AngelInvestorAgent:sendPM_AngelInvestorChallengeReq(activityId, stageId, form)
	local req = AngelInvestorExtension_pb.PM_AngelInvestorChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function AngelInvestorAgent:handlePM_AngelInvestorChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function AngelInvestorAgent:handlePM_Notify_AngelInvestorChallengeResultRes(status, msg)
	if status == 0 then
		AngelInvestorController.instance:handlePM_Notify_AngelInvestorChallengeResultRes(msg)
	end
end

AngelInvestorAgent.instance = AngelInvestorAgent.New()

return AngelInvestorAgent
