-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/beforecampadjustmentguide/WorkWaitBeforeCampAdjustmentGuide.lua

module("logic.battle.battleflow.defaultwork.beforecampadjustmentguide.WorkWaitBeforeCampAdjustmentGuide", package.seeall)

local WorkWaitBeforeCampAdjustmentGuide = class("WorkWaitBeforeCampAdjustmentGuide", WorkBase)

function WorkWaitBeforeCampAdjustmentGuide:onEnter(context)
	if not self:_isStillInCampAdjustmentGuide() then
		self:onDone(WorkResult.Succeed)

		return
	end

	if BattleLog.enableLog then
		BattleLog.log("Begin wait for before camp adjustment guide finish.")
	end

	self:_setEvent(true)
end

function WorkWaitBeforeCampAdjustmentGuide:onExit(isInterrupt)
	self:_setEvent(false)
end

function WorkWaitBeforeCampAdjustmentGuide:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GUIDE_FINISH_STEP, self._onGuideFinished, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GUIDE_FINISH_STEP, self._onGuideFinished, self)
	end
end

function WorkWaitBeforeCampAdjustmentGuide:_isStillInCampAdjustmentGuide()
	if not BattleCampAdjustmentModel.instance:isBeforeCampAdjustmentGuideTriggerred() then
		return false
	end

	return WorkTriggerBeforeCampAdjustmentGuide:isInBeforeCampAdjustmentGuide()
end

function WorkWaitBeforeCampAdjustmentGuide:_onGuideFinished(evt, guideId)
	if BattleLog.enableLog then
		BattleLog.log("Finish wait for before camp adjustment guide.")
	end

	self:onDone(WorkResult.Succeed)
end

return WorkWaitBeforeCampAdjustmentGuide
