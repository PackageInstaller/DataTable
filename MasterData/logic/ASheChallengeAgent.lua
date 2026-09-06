-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/agent/ASheChallengeAgent.lua

module("logic.extensions.ashechallenge.agent.ASheChallengeAgent", package.seeall)

local ASheChallengeAgent = class("ASheChallengeAgent", BaseAgent)

function ASheChallengeAgent:sendPM_ASheChallengeInfoReq(activityId)
	local req = ASheChallengeExtension_pb.PM_ASheChallengeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ASheChallengeAgent:handlePM_ASheChallengeInfoRes(status, msg)
	if status == 0 then
		ASheModel.instance:onChallengeInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ASheChallengeInfoRes)
	end
end

function ASheChallengeAgent:sendPM_ASheChallengeBattleReq(activityId, difficultyId)
	local req = ASheChallengeExtension_pb.PM_ASheChallengeBattleReq()

	req.activityId = activityId
	req.difficultyId = difficultyId

	self:sendMsg(req)
end

function ASheChallengeAgent:handlePM_ASheChallengeBattleRes(status, msg)
	if status == 0 then
		ASheModel.instance:onChallengeBattleRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ASheChallengeBattleRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function ASheChallengeAgent:handlePM_NotifyASheChallengeBattleFinishRes(status, msg)
	if status == 0 then
		ASheModel.instance:onChallengeBattleFinishRes(msg)
		ASheController.instance:saveChangeSetIdForBattleSettlementView(msg.changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.ASheChallengeBattleFinishRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function ASheChallengeAgent:sendPM_ASheChallengeSelectBuffReq(activityId, selectedBuffs)
	local req = ASheChallengeExtension_pb.PM_ASheChallengeSelectBuffReq()

	req.activityId = activityId

	if selectedBuffs ~= nil then
		for i, v in ipairs(selectedBuffs) do
			req.selectedBuffs:append(v)
		end
	end

	self:sendMsg(req)
end

function ASheChallengeAgent:handlePM_ASheChallengeSelectBuffRes(status, msg)
	if status == 0 then
		ASheModel.instance:onChallengeSelectBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ASheChallengeSelectBuffRes)
	end
end

function ASheChallengeAgent:sendPM_ASheChallengeRefreshReq(activityId, difficultyId)
	local req = ASheChallengeExtension_pb.PM_ASheChallengeRefreshReq()

	req.activityId = activityId
	req.difficultyId = difficultyId
	self._tmpActivityId = activityId

	self:sendMsg(req)
end

function ASheChallengeAgent:handlePM_ASheChallengeRefreshRes(status, msg)
	if status == 0 then
		ASheModel.instance:onChallengeRefreshRes(msg, self._tmpActivityId)
		GlobalDispatcher:dispatch(GlobalNotify.ASheChallengeRefreshRes)
	end
end

ASheChallengeAgent.instance = ASheChallengeAgent.New()

return ASheChallengeAgent
