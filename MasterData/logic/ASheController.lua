-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/controller/ASheController.lua

module("logic.extensions.ashechallenge.controller.ASheController", package.seeall)

local ASheController = class("ASheController", BaseController)

function ASheController:ctor()
	return
end

function ASheController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onChangeDate, self)
end

function ASheController:_onChangeDate()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(ASheModel.instance:getActivityType())

	if cfg then
		local isOpen = TimeGateController.instance:isOpenByActivityId(cfg.activityId)

		if isOpen then
			ASheChallengeAgent.instance:sendPM_ASheChallengeInfoReq(cfg.activityId)
		end
	end
end

function ASheController:getDailyBuffDesc(activityId)
	local activityType = ASheModel.instance:getActivityType()
	local activityId = activityId

	if not ActivityDefineController.instance:isInActivityTimeById(activityType, activityId) then
		return ""
	end

	local startTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local curTimestamp = ServerTime.now()

	if curTimestamp < startTimestamp then
		return ""
	else
		local cfgActivity = ASheConfig.instance:getActivityCfg(activityId)

		if not cfgActivity then
			return ""
		end

		local cfgs = ASheConfig.instance:getDailyBuffList(cfgActivity.dailyBuffPlanId)

		if not cfgs or #cfgs == 0 then
			return ""
		end

		local maxDay = #cfgs
		local day = GameUtil.getDaysByTimestamp(startTimestamp, curTimestamp)

		printInfo("test 当前第几天", day, Mathf.Clamp(day, 1, maxDay))

		day = Mathf.Clamp(day, 1, maxDay)

		local cfgDailyBuff = ASheConfig.instance:getDailyBuff(cfgActivity.dailyBuffPlanId, day)

		return (cfgDailyBuff or nil) and (cfgDailyBuff.buffDesc or "")
	end
end

function ASheController:getLeftChallengeTimes(activityId)
	local cfg = ASheConfig.instance:getActivityCfg(activityId)

	if cfg then
		local maxNum = cfg.dailyChallengeTimes
		local usedNum = ASheModel.instance:getUsedTimes(activityId)

		return Mathf.Max(maxNum - usedNum, 0)
	else
		return 0
	end
end

function ASheController:getBuffLists(activityId, selectBuffPlanId)
	local globalBuffList = {}
	local localBuffList = {}
	local canSelectBuffs = ASheModel.instance:getCanSelectBuffs(activityId)

	for i, buffId in ipairs(canSelectBuffs) do
		local cfg = ASheConfig.instance:getSelectBuff(selectBuffPlanId, buffId)

		if cfg then
			if cfg.buffType == 1 then
				table.insert(globalBuffList, buffId)
			else
				table.insert(localBuffList, buffId)
			end
		end
	end

	return globalBuffList, localBuffList
end

function ASheController:openMissionView(activityId, difficultyId, creepsMasterId, enterView, mainView)
	local fmtMo = ASheModel.instance:getCustomFmtMo(activityId, difficultyId, creepsMasterId, enterView, mainView)

	CustomFmtController.instance:showMissionView(fmtMo)
end

function ASheController:getCreepsMasterId(activityId, difficultyPlanId, tabId)
	local cfgDifficulty = ASheConfig.instance:getDifficultyCfg(difficultyPlanId, tabId)

	if not cfgDifficulty then
		return 0
	end

	local stageId = ASheModel.instance:getStageId(activityId, tabId)
	local cfgStage = ASheConfig.instance:getStage(cfgDifficulty.challengePlanId, stageId)

	if not cfgStage then
		return 0
	end

	return cfgStage.creepsMasterId
end

function ASheController:getShowRaceId(activityId, difficultyPlanId, tabId)
	local cfgDifficulty = ASheConfig.instance:getDifficultyCfg(difficultyPlanId, tabId)

	if not cfgDifficulty then
		return 0
	end

	local stageId = ASheModel.instance:getStageId(activityId, tabId)
	local cfgStage = ASheConfig.instance:getStage(cfgDifficulty.challengePlanId, stageId)

	if not cfgStage then
		return 0
	end

	return cfgStage.raceId
end

function ASheController:saveChangeSetIdForBattleSettlementView(changeSetId)
	if changeSetId > 0 then
		MaterialController.instance:saveChangeSetToTemp(changeSetId)
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	end
end

ASheController.instance = ASheController.New()

return ASheController
