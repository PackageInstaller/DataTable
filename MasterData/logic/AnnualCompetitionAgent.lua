-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/agent/AnnualCompetitionAgent.lua

module("logic.extensions.annualcompetition.agent.AnnualCompetitionAgent", package.seeall)

local AnnualCompetitionAgent = class("AnnualCompetitionAgent", BaseAgent)

function AnnualCompetitionAgent:ctor()
	return
end

function AnnualCompetitionAgent:setExtId(extId)
	AnnualCompetitionAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionGetInfoReq(activityId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionGetInfoRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onGetInfoAndOpenView(msg)
	else
		AnnimatchController.instance:onMatchError(status)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionGainTicketReq(activityId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionGainTicketReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionGainTicketRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:updateTicketInfo(msg)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionParticipateReq(activityId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionParticipateReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionParticipateRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onJoinMatch(msg)
	else
		AnnimatchController.instance:onMatchError(status)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionSetSysPetReq(activityId, creepsId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionSetSysPetReq()

	req.activityId = activityId
	req.creepsId = creepsId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionSetSysPetRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onGetSysPet(msg)
	else
		AnnimatchController.instance:onMatchError(status)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionBuySysPetReq(activityId, creepsId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionBuySysPetReq()

	req.activityId = activityId
	req.creepsId = creepsId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionBuySysPetRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:handlePM_AnnualCompetitionBuySysPetRes(msg)
	else
		AnnimatchController.instance:onMatchError(status)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionRefreshSysPetShopReq(activityId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionRefreshSysPetShopReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionRefreshSysPetShopRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:handlePM_AnnualCompetitionRefreshSysPetShopRes(msg)
	else
		AnnimatchController.instance:onMatchError(status)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionSetFormReq(activityId, simpleForm_pb)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionSetFormReq()

	req.activityId = activityId

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionSetFormRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onSetForm(msg)
	else
		AnnimatchController.instance:onMatchError(status)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionMatchFightReq(activityId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionMatchFightReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionMatchFightRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onGoFinding(msg)
	else
		AnnimatchController.instance:onMatchError(status)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionCancelMatchReq(activityId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionCancelMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionCancelMatchRes(status, msg)
	if status == 0 then
		-- block empty
	else
		AnnimatchController.instance:onMatchError(status)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionSetBuffReq(activityId, buffConfigId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionSetBuffReq()

	req.activityId = activityId
	req.buffConfigId = buffConfigId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionSetBuffRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onSetBuff(msg)
	else
		AnnimatchController.instance:onMatchError(status)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionGetTaskInfoReq(activityId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionGetTaskInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionGetTaskInfoRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onGetTaskInfo(msg)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionGainTaskPrizeReq(activityId, taskId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionGainTaskPrizeRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onGetTaskPrize(msg)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionViewRankReq(activityId, startRank, endRank)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionViewRankReq()

	req.activityId = activityId
	req.startRank = startRank
	req.endRank = endRank

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionViewRankRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onGetRankInfo(msg)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionGiveUpReq(activityId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionGiveUpReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionGiveUpRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onGiveup(msg)
	else
		AnnimatchController.instance:onMatchError(status)
	end
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionMatchFightResultRes(status, msg)
	AnnimatchController.instance:onNotifyFightResult(msg)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionMatchFailRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchMatchFailed)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionMatchOvertimeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchMatchFailed)
end

function AnnualCompetitionAgent:sendPM_AnnualComptitionReplaceCreepsReq(activityId, oldCreepsId, newCreepsId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualComptitionReplaceCreepsReq()

	req.activityId = activityId

	if oldCreepsId ~= nil then
		req.oldCreepsId = oldCreepsId
	end

	if newCreepsId ~= nil then
		req.newCreepsId = newCreepsId
	end

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualComptitionReplaceCreepsRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:onReplaceCreeps(msg)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionBanPetInfoReq(activityId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionBanPetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionBanPetInfoRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:handlePM_AnnualCompetitionBanPetInfoRes(msg)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionBanPetReq(activityId, raceIds)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionBanPetReq()

	req.activityId = activityId

	for i, id in ipairs(raceIds) do
		req.raceIds:append(id)
	end

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionBanPetRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:handlePM_AnnualCompetitionBanPetRes(msg)
	end
end

function AnnualCompetitionAgent:sendPM_AnnualCompetitionFinishBuyPetReq(activityId)
	local req = AnnualCompetitionExtension_pb.PM_AnnualCompetitionFinishBuyPetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualCompetitionAgent:handlePM_AnnualCompetitionFinishBuyPetRes(status, msg)
	if status == 0 then
		AnnimatchController.instance:handlePM_AnnualCompetitionFinishBuyPetRes(msg)
	end
end

AnnualCompetitionAgent.instance = AnnualCompetitionAgent.New()

return AnnualCompetitionAgent
