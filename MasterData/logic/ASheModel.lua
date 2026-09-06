-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/model/ASheModel.lua

module("logic.extensions.ashechallenge.model.ASheModel", package.seeall)

local ASheModel = class("ASheModel", BaseModel)

ASheModel.LevelEnum = {
	Medium = 2,
	Simple = 1,
	Hard = 3
}

function ASheModel:ctor()
	return
end

function ASheModel:onInit()
	self:onReset()
end

function ASheModel:onReset()
	self._activityId = 0
	self._msgMap = {}
	self._isWin = false
	self._changeSetId = 0
	self._customFmtMo = nil
end

function ASheModel:getCustomFmtMo(activityId, difficultyId, creepsMasterId, enterView, mainView)
	if self._customFmtMo == nil then
		self._customFmtMo = ASheChallengeCustomFmtMo.New()
	end

	self._customFmtMo:initParams(activityId, difficultyId, creepsMasterId, enterView, mainView)

	return self._customFmtMo
end

function ASheModel:onChallengeInfoRes(msg)
	local activityId = msg.activityId

	self._msgMap[activityId] = GameUtil.pbToTable(msg)
end

function ASheModel:onChallengeBattleRes(msg)
	return
end

function ASheModel:onChallengeBattleFinishRes(msg)
	self._isWin = msg.isWin

	local activityId = msg.activityId
	local msgTb = self._msgMap[activityId]

	if msgTb then
		msgTb.lastFinishDifficulty = msg.difficultyId

		if msg:HasField("newInfo") then
			local newInfo = msg.newInfo

			for i, v in ipairs(msgTb.info) do
				if v.difficultyId == newInfo.difficultyId then
					v.stageId = newInfo.stageId
				end
			end
		end

		if msg.isWin then
			msgTb.usedTimes = msgTb.usedTimes + 1
		end
	end
end

function ASheModel:onChallengeSelectBuffRes(msg)
	local activityId = msg.activityId
	local msgTb = self._msgMap[activityId]

	if msgTb then
		msgTb.selectedBuffs = GameUtil.pbToTable(msg.selectedBuffs) or {}
	end
end

function ASheModel:onChallengeRefreshRes(msg, activityId)
	local msgTb = self._msgMap[activityId]

	if msgTb then
		local newInfo = GameUtil.pbToTable(msg.info) or {}

		for i, v in ipairs(msgTb.info) do
			if v.difficultyId == newInfo.difficultyId then
				v.stageId = newInfo.stageId
				msgTb.info[i] = v
			end
		end
	end
end

function ASheModel:getActivityType()
	return GameEnum.ActivityType.Ashe_Challenge
end

function ASheModel:getActivityId()
	return self:getAsheActivityId()
end

function ASheModel:getAsheActivityId()
	return 246001
end

function ASheModel:getLuxifaActivityId()
	return 246002
end

function ASheModel:getDivineelizabethActivityId()
	return 246004
end

function ASheModel:getStageId(activityId, difficultyId)
	local stageId = 0
	local msgTb = self._msgMap[activityId]

	if msgTb then
		for i, v in ipairs(msgTb.info) do
			if v.difficultyId == difficultyId then
				stageId = v.stageId

				break
			end
		end
	end

	return stageId
end

function ASheModel:getSelectedBuffs(activityId)
	local msgTb = self._msgMap[activityId]

	if msgTb then
		return msgTb.selectedBuffs
	end

	return {}
end

function ASheModel:getUsedTimes(activityId)
	local msgTb = self._msgMap[activityId]

	if msgTb then
		return msgTb.usedTimes
	end

	return 0
end

function ASheModel:getCanSelectBuffs(activityId)
	local msgTb = self._msgMap[activityId]

	if msgTb then
		return msgTb.canSelectBuffs
	end

	return {}
end

function ASheModel:isSelectedBuffs(activityId)
	local msgTb = self._msgMap[activityId]

	if msgTb then
		return #msgTb.selectedBuffs >= 2
	end

	return false
end

function ASheModel:getLastFinishDifficultyId(activityId)
	local msgTb = self._msgMap[activityId]

	if msgTb then
		return msgTb.lastFinishDifficulty
	end

	return 0
end

ASheModel.instance = ASheModel.New()

return ASheModel
