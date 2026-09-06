-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/agent/AchievementAgent.lua

module("logic.extensions.achievement.agent.AchievementAgent", package.seeall)

local AchievementAgent = class("AchievementAgent", BaseAgent)

function AchievementAgent:sendPM_LoadAllAchievementReq()
	local req = AchievementExtension_pb.PM_LoadAllAchievementReq()

	self:sendMsg(req)
end

function AchievementAgent:handlePM_LoadAllAchievementRes(status, msg)
	if status == 0 then
		AchievementModel.instance:onLoadAllAchievementRes(msg)
		AchievementController.instance:localNotify("LoadAllAchievement")
	end
end

function AchievementAgent:sendPM_GainAchievementPrizeReq(achievementId)
	self._achievementId = achievementId

	local req = AchievementExtension_pb.PM_GainAchievementPrizeReq()

	req.achievementId = achievementId

	self:sendMsg(req)
end

function AchievementAgent:handlePM_GainAchievementPrizeRes(status, msg)
	if status == 0 then
		AchievementModel.instance:onGainAchievementPrize(self._achievementId)
		AchievementController.instance:localNotify("GainAchievementPrize")
	end
end

function AchievementAgent:sendPM_GainAchievementLevelPrizeReq(prizeId)
	self._prizeId = prizeId

	local req = AchievementExtension_pb.PM_GainAchievementLevelPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function AchievementAgent:handlePM_GainAchievementLevelPrizeRes(status, msg)
	if status == 0 then
		AchievementModel.instance:onGainLevelPrize(self._prizeId)
		AchievementController.instance:localNotify("GainAchievementLevelPrize")
	end
end

function AchievementAgent:handlePM_notifyGetAchievementRes(status, msg)
	if status == 0 then
		local achievementidlist = msg.achievementIdList

		AchievementModel.instance:handleGetAchievementRes(achievementidlist)
		GlobalDispatcher:dispatch(GlobalNotify.GetNewAchievement)
	end
end

function AchievementAgent:sendPM_OneKeyGainAchievementPrizeReq(handler, handlerObj, errHandler)
	if self._isReqing then
		return
	end

	self._isReqing = true

	local req = AchievementExtension_pb.PM_OneKeyGainAchievementPrizeReq()

	self:sendMsg(req)
end

function AchievementAgent:handlePM_OneKeyGainAchievementPrizeRes(status, msg)
	self._isReqing = false

	if status == 0 then
		AchievementModel.instance:onOneKeyGain()
		GlobalDispatcher:dispatch(GlobalNotify.AchievementOneKeySuccess)
		RedPointModel.instance:updateAllRedPoint()
	end
end

function AchievementAgent:sendPM_AchievementGetRankReq()
	local req = AchievementExtension_pb.PM_AchievementGetRankReq()

	self:sendMsg(req)
end

function AchievementAgent:handlePM_AchievementGetRankRes(status, msg)
	if status == 0 then
		AchievementController.instance:handleAchievementGetRankRes(msg)
	end
end

AchievementAgent.instance = AchievementAgent.New()

return AchievementAgent
