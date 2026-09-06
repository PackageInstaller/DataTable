-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/athenabless/model/AthenaBlessModel.lua

module("logic.extensions.athenabless.model.AthenaBlessModel", package.seeall)

local AthenaBlessModel = class("AthenaBlessModel", BaseModel)

function AthenaBlessModel:ctor()
	return
end

function AthenaBlessModel:onInit()
	self:onReset()
end

function AthenaBlessModel:onReset()
	self._activityId = 0
	self._totalScore = 0
	self._weeklyScore = 0
	self._prizeGainStateList = {}
	self._dailyScoreList = {}
	self._isRecieveInfo = false
end

function AthenaBlessModel:onGetInfo(msg)
	self._isRecieveInfo = true
	self._activityId = msg.activityId
	self._totalScore = msg.totalScore
	self._weeklyScore = msg.weeklyScore
	self._prizeGainStateList = GameUtil.pbToTable(msg.prizeGainStates) or {}
	self._dailyScoreList = GameUtil.pbToTable(msg.dailyScoreList) or {}
end

function AthenaBlessModel:updatePrizeState(prizeId, isGet)
	if not prizeId then
		return
	end

	self._prizeGainStateList[prizeId] = isGet
end

function AthenaBlessModel:getActivityId()
	return self._activityId
end

function AthenaBlessModel:isInActivityTime()
	if self._activityId == 0 then
		return false
	end

	if not self._isRecieveInfo then
		return false
	end

	return ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.AthenaBless, self._activityId)
end

function AthenaBlessModel:getScore(taskId)
	if self._dailyScoreList[taskId] then
		return self._dailyScoreList[taskId].score
	else
		return 0
	end
end

function AthenaBlessModel:getCurScore()
	return self._totalScore
end

function AthenaBlessModel:getWeeklyScore()
	return self._weeklyScore
end

function AthenaBlessModel:getTriggerTimes(taskId)
	if self._dailyScoreList[taskId] then
		return self._dailyScoreList[taskId].triggerTimes or 0
	else
		return 0
	end
end

function AthenaBlessModel:isGetedReward(prizeId)
	if self._prizeGainStateList[prizeId] ~= nil then
		return self._prizeGainStateList[prizeId]
	end

	return false
end

AthenaBlessModel.instance = AthenaBlessModel.New()

return AthenaBlessModel
