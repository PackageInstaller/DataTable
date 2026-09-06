-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/awakenoathancestor/data/AwakenOathAncestorSubMo.lua

module("logic.extensions.awakenoathancestor.data.AwakenOathAncestorSubMo", package.seeall)

local AwakenOathAncestorSubMo = class("AwakenOathAncestorSubMo")

function AwakenOathAncestorSubMo:ctor(activityId)
	self._activityId = activityId

	local actData = AwakenOathAncestorConfig.instance:getActData(activityId)

	if actData then
		self._requiredBlood = actData.requiredBlood or 0
	end

	if actData then
		self._pointNum = actData.pointNum or 0
	end

	self._bloodNum = 0
	self._maxUnlockPointId = 0
	self._stageBloodNums = {}
	self._hasGainProgressIds = {}
	self._maxPassStageId = 0
end

function AwakenOathAncestorSubMo:dispose()
	return
end

function AwakenOathAncestorSubMo:handlePM_AwakenOathAncestorInfoRes(msg)
	self._bloodNum = msg.bloodNum
	self._maxUnlockPointId = msg.maxUnlockPointId
	self._maxPassStageId = msg.maxPassStageId

	table.clear(self._stageBloodNums)

	for stageId, v in ipairs(msg.stageBloodNum) do
		self._stageBloodNums[stageId] = v
	end

	table.clear(self._hasGainProgressIds)
	table.insertto(self._hasGainProgressIds, msg.hasGainProgressId)
end

function AwakenOathAncestorSubMo:handlePM_AwakenOathAncestorUnlockPointRes(msg)
	self._maxUnlockPointId = msg.maxUnlockPointId
end

function AwakenOathAncestorSubMo:handlePM_GainProgressPrizeRes(msg)
	table.clear(self._hasGainProgressIds)
	table.insertto(self._hasGainProgressIds, msg.progressIds)
end

function AwakenOathAncestorSubMo:handlePM_AwakenOathAncestorChallengeRes(msg)
	return
end

function AwakenOathAncestorSubMo:handlePM_AwakenOathAncestorNotifyChallengeRes(msg)
	local stageId = msg.stageId

	if msg.isWin then
		self._maxPassStageId = Mathf.Max(self._maxPassStageId, stageId)
	end

	if msg:HasField("gainBloodNum") then
		self._stageBloodNums[stageId] = self._stageBloodNums[stageId] or self._stageBloodNums[stageId] + msg.gainBloodNum
	end

	self._bloodNum = msg.maxBloodNum
end

function AwakenOathAncestorSubMo:getTotalBloodNum()
	return self._bloodNum
end

function AwakenOathAncestorSubMo:getBloodNum(pointId)
	return Mathf.Clamp(self._bloodNum - (pointId - 1) * self._requiredBlood, 0, self._requiredBlood)
end

function AwakenOathAncestorSubMo:getMaxBloodNum()
	return self._requiredBlood
end

function AwakenOathAncestorSubMo:isUnlockAllPoint()
	return self._pointNum <= self._maxUnlockPointId
end

function AwakenOathAncestorSubMo:isUnlockLastPoint(pointId)
	return self:isUnlockPoint(pointId - 1)
end

function AwakenOathAncestorSubMo:isCanUnlockPoint(pointId)
	return not self:isUnlockPoint(pointId) and self:isEnoughPoint(pointId) and self:isUnlockLastPoint(pointId)
end

function AwakenOathAncestorSubMo:isUnlockPoint(pointId)
	return pointId <= self._maxUnlockPointId
end

function AwakenOathAncestorSubMo:isEnoughPoint(pointId)
	local max = self:getMaxBloodNum()
	local cur = self:getBloodNum(pointId)

	return max <= cur
end

function AwakenOathAncestorSubMo:getMaxUnlockPointId()
	return self._maxUnlockPointId
end

function AwakenOathAncestorSubMo:isUnlockStage(stageId)
	return self:isPassStage(stageId - 1)
end

function AwakenOathAncestorSubMo:isPassStage(stageId)
	return stageId <= self._maxPassStageId
end

function AwakenOathAncestorSubMo:getBloodNumInStage(stageId)
	return self._stageBloodNums[stageId] or 0
end

function AwakenOathAncestorSubMo:isCanGetPrize(prizeId)
	return not self:isHasGainPrize(prizeId) and self:isEnoughGetPrize(prizeId)
end

function AwakenOathAncestorSubMo:isHasGainPrize(prizeId)
	for _, id in ipairs(self._hasGainProgressIds) do
		if id == prizeId then
			return true
		end
	end

	return false
end

function AwakenOathAncestorSubMo:isEnoughGetPrize(prizeId)
	local data = AwakenOathAncestorConfig.instance:getProgressPrizeData(self._activityId, prizeId)
	local need = data and data.progress
	local cur = self:getMaxUnlockPointId()

	return need <= cur
end

return AwakenOathAncestorSubMo
