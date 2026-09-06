-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brotherhood/model/BrotherHoodModel.lua

module("logic.extensions.brotherhood.model.BrotherHoodModel", package.seeall)

local BrotherHoodModel = class("BrotherHoodModel", BaseModel)

function BrotherHoodModel:onInit()
	self:onReset()
end

function BrotherHoodModel:onReset()
	self._activityId = 0
	self._finishPlotPlanIds = {}
	self._rewardProcessIds = {}
	self._dicUnlockIds = {}
	self._splicePlotChangeSetId = nil
end

function BrotherHoodModel:onBrotherHoodPanelInfoRes(msg)
	self._finishPlotPlanIds = GameUtil.pbToTable(msg.finishPlotPlanIds) or {}
	self._rewardProcessIds = GameUtil.pbToTable(msg.rewardProcessIds) or {}
end

function BrotherHoodModel:onBrotherHoodSinglePlotPlanRes(msg)
	self._dicUnlockIds[msg.plotPlanId] = GameUtil.pbToTable(msg.unlockIds) or {}
end

function BrotherHoodModel:onBrotherHoodSplicePlotRes(msg)
	self._dicUnlockIds[msg.plotPlanId] = self._dicUnlockIds[msg.plotPlanId] or {}

	if not TableUtil.isHad(self._dicUnlockIds[msg.plotPlanId], msg.fragmentsId) then
		table.insert(self._dicUnlockIds[msg.plotPlanId], msg.fragmentsId)
	end

	if msg.finish == 1 and not TableUtil.isHad(self._finishPlotPlanIds, msg.plotPlanId) then
		table.insert(self._finishPlotPlanIds, msg.plotPlanId)
	end

	self._splicePlotChangeSetId = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
end

function BrotherHoodModel:onBrotherHoodRewardProcessRes(msg)
	if not TableUtil.isHad(self._rewardProcessIds, msg.rewardProcessId) then
		table.insert(self._rewardProcessIds, msg.rewardProcessId)
	end
end

function BrotherHoodModel:initActivity()
	local cfgActivity = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.BrotherHood)

	if cfgActivity then
		self._activityId = cfgActivity.activityId or 0
	end
end

function BrotherHoodModel:getActivityId()
	if self._activityId > 0 then
		return self._activityId
	else
		self:initActivity()

		return self._activityId
	end
end

function BrotherHoodModel:getRewardProgress()
	return #self._finishPlotPlanIds
end

function BrotherHoodModel:isFinishPlotPlan(plotPlanId)
	return TableUtil.isHad(self._finishPlotPlanIds, plotPlanId)
end

function BrotherHoodModel:isPlayerRewardCanGet(progressId, matchNum)
	local isScoreEnough = matchNum <= self:getRewardProgress()

	if isScoreEnough then
		local isGeted = self:isPlayerRewardGeted(progressId)

		return not isGeted
	else
		return false
	end
end

function BrotherHoodModel:isPlayerRewardGeted(progressId)
	return TableUtil.isHad(self._rewardProcessIds, progressId)
end

function BrotherHoodModel:isUnlock(plotPlanId, fragmentsId)
	if self._dicUnlockIds[plotPlanId] then
		return TableUtil.isHad(self._dicUnlockIds[plotPlanId], fragmentsId)
	else
		return false
	end
end

function BrotherHoodModel:getSplicePlotChangeSetId()
	self._splicePlotChangeSetId = nil

	return self._splicePlotChangeSetId
end

BrotherHoodModel.instance = BrotherHoodModel.New()

return BrotherHoodModel
