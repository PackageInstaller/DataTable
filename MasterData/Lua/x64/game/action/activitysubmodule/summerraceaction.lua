local var_0_0 = {}
local cjson = require("cjson")
local var_0_2 = {
	PUSH_MAIN_SYNC = 84331,
	CS_COMPLETE_STAGE = 84332,
	SC_COMPLETE_STAGE = 84333,
	CS_MODIFY_TANK = 84334,
	SC_MODIFY_TANK = 84335
}
local var_0_3 = 2
local var_0_4 = 2
local var_0_5
local var_0_6

local function var_0_7()
	return SummerRaceLuaBridge
end

local function var_0_8(arg_2_0)
	if Debug ~= nil and Debug.LogWarning ~= nil then
		Debug.LogWarning(arg_2_0)
	end
end

local function var_0_9()
	local var_3_0 = rawget(_G, "Time")

	if var_3_0 ~= nil and var_3_0.realtimeSinceStartup ~= nil then
		return tonumber(var_3_0.realtimeSinceStartup) or 0
	end

	return os.clock()
end

manager.net:Bind(var_0_2.PUSH_MAIN_SYNC, function(arg_4_0)
	SummerRaceData:ApplyServerOutGameSnapshot(arg_4_0)
end)

local function var_0_10(arg_5_0)
	var_0_0.runtimeState_ = arg_5_0

	return arg_5_0
end

local function var_0_11(arg_6_0)
	var_0_0.settlementState_ = arg_6_0

	return arg_6_0
end

function var_0_0:StopGuidePollState()
	if self ~= nil and self.guidePollTimer ~= nil then
		self.guidePollTimer:Stop()

		self.guidePollTimer = nil
	end
end

function var_0_0.StopTimeoutResultTimers()
	if var_0_0.timeoutResultTimer_ ~= nil then
		var_0_0.timeoutResultTimer_:Stop()

		var_0_0.timeoutResultTimer_ = nil
	end

	if var_0_0.timeoutSettlementTimer_ ~= nil then
		var_0_0.timeoutSettlementTimer_:Stop()

		var_0_0.timeoutSettlementTimer_ = nil
	end

	if var_0_0.challengeFailureSettlementTimer_ ~= nil then
		var_0_0.challengeFailureSettlementTimer_:Stop()

		var_0_0.challengeFailureSettlementTimer_ = nil
	end

	if var_0_0.battleResultBannerTimer_ ~= nil then
		var_0_0.battleResultBannerTimer_:Stop()

		var_0_0.battleResultBannerTimer_ = nil
	end

	var_0_0.lastLoseBattleResultBannerShownAt_ = nil
	var_0_0.lastTimeoutResultShownAt_ = nil
	var_0_0.lastTimeoutResultType_ = nil

	var_0_5(nil)
	var_0_6(nil)
end

function var_0_0.NormalizeGuideTriggerId(arg_9_0)
	local var_9_0 = tonumber(arg_9_0)

	if var_9_0 ~= nil then
		return tostring(var_9_0)
	end

	return tostring(arg_9_0 or "")
end

function var_0_0.IsEditorGuideDisabled()
	return PlayerPrefs ~= nil and PlayerPrefs.GetInt ~= nil and PlayerPrefs.GetInt("OpenGuide", 0) == 1
end

function var_0_0.HasEnemyDefeatBeforeFxCondition(arg_11_0, arg_11_1)
	if type(arg_11_0) ~= "table" then
		return false
	end

	local var_11_0 = var_0_0.NormalizeGuideTriggerId(arg_11_1)

	for iter_11_0, iter_11_1 in pairs(arg_11_0) do
		if type(iter_11_1) == "table" and iter_11_1[1] == SummerRaceConst.GUIDE_TRIGGER.ENEMY_DEFEAT_BEFORE_FX and var_0_0.NormalizeGuideTriggerId(iter_11_1[2]) == var_11_0 then
			return true
		end
	end

	return false
end

function var_0_0.HasTournamentStageCompletedGuideCondition(arg_12_0)
	if type(arg_12_0) ~= "table" then
		return false
	end

	local var_12_0 = false
	local var_12_1 = false

	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		if type(iter_12_1) == "table" then
			if iter_12_1[1] == SummerRaceConst.GUIDE_TRIGGER.STAGE_COMPLETED then
				var_12_0 = true
			elseif iter_12_1[1] == "uiName" and iter_12_1[2] == "summerRaceTournamentView" then
				var_12_1 = true
			elseif iter_12_1[1] == "uiNameList" and type(iter_12_1[2]) == "table" then
				var_12_1 = table.indexof(iter_12_1[2], "summerRaceTournamentView") ~= false
			end
		end
	end

	return var_12_0 and var_12_1
end

local function var_0_12()
	if var_0_0.IsEditorGuideDisabled() == true then
		return false
	end

	if manager == nil or manager.guide == nil or GuideBaseCfg == nil or type(GuideBaseCfg.all) ~= "table" then
		return false
	end

	if gameContext == nil or gameContext.GetLastOpenPage == nil or gameContext:GetLastOpenPage() ~= "summerRaceTournamentView" then
		return false
	end

	if manager.guide:IsPlaying() then
		return true
	end

	for iter_13_0 = 1, #GuideBaseCfg.all do
		if GuideBaseCfg[GuideBaseCfg.all[iter_13_0]] ~= nil and var_0_0.HasTournamentStageCompletedGuideCondition(GuideBaseCfg[GuideBaseCfg.all[iter_13_0]].open_condition) then
			if manager.guide:GetGuideIsOpen(GuideBaseCfg.all[iter_13_0]) == true then
				manager.guide:Process()

				return true
			end

			if not GuideData:IsFinish(GuideBaseCfg.all[iter_13_0], true) and GuideTool.SatisfyCondition(GuideBaseCfg[GuideBaseCfg.all[iter_13_0]].open_condition) then
				manager.guide:AddGuide(GuideBaseCfg.all[iter_13_0])
				manager.guide:Process()

				return true
			end
		end
	end

	return false
end

function var_0_0.GetEnemyDefeatBeforeFxGuideChain(arg_14_0)
	local var_14_0 = {}

	if GuideBaseCfg == nil or type(GuideBaseCfg.all) ~= "table" then
		return var_14_0
	end

	for iter_14_0 = 1, #GuideBaseCfg.all do
		if GuideBaseCfg[GuideBaseCfg.all[iter_14_0]] ~= nil and var_0_0.HasEnemyDefeatBeforeFxCondition(GuideBaseCfg[GuideBaseCfg.all[iter_14_0]].open_condition, arg_14_0) then
			var_14_0[#var_14_0 + 1] = GuideBaseCfg.all[iter_14_0]
		end
	end

	return var_14_0
end

function var_0_0.ResolveEnemyDefeatBeforeFxGuideId(arg_15_0)
	if var_0_0.IsEditorGuideDisabled() == true then
		return 0
	end

	if GuideBaseCfg == nil or type(GuideBaseCfg.all) ~= "table" then
		return 0
	end

	for iter_15_0 = 1, #GuideBaseCfg.all do
		if GuideBaseCfg[GuideBaseCfg.all[iter_15_0]] ~= nil and var_0_0.HasEnemyDefeatBeforeFxCondition(GuideBaseCfg[GuideBaseCfg.all[iter_15_0]].open_condition, arg_15_0) and not GuideData:IsFinish(GuideBaseCfg.all[iter_15_0], true) and GuideTool.SatisfyCondition(GuideBaseCfg[GuideBaseCfg.all[iter_15_0]].open_condition) then
			return GuideBaseCfg.all[iter_15_0]
		end
	end

	return 0
end

function var_0_0.HasPendingEnemyDefeatBeforeFxGuide(arg_16_0, arg_16_1)
	if var_0_0.IsEditorGuideDisabled() == true then
		return false
	end

	local var_16_0 = var_0_0.GetEnemyDefeatBeforeFxGuideChain(arg_16_0)

	if #var_16_0 == 0 then
		return false
	end

	local var_16_1 = false

	for iter_16_0 = 1, #var_16_0 do
		if manager.guide:GetGuideIsOpen(var_16_0[iter_16_0]) == true then
			var_16_1 = true
		elseif not GuideData:IsFinish(var_16_0[iter_16_0]) and GuideTool.SatisfyCondition(GuideBaseCfg[var_16_0[iter_16_0]].open_condition) then
			var_16_1 = true
		end
	end

	if var_16_1 then
		return true
	end

	if arg_16_1 ~= true then
		return true
	end

	return false
end

function var_0_0.EnsureEnemyDefeatBeforeFxGuideChain(arg_17_0)
	if var_0_0.IsEditorGuideDisabled() == true then
		return
	end

	local var_17_0 = var_0_0.GetEnemyDefeatBeforeFxGuideChain(arg_17_0)

	for iter_17_0 = 1, #var_17_0 do
		if manager.guide:GetGuideIsOpen(var_17_0[iter_17_0]) ~= true then
			manager.guide:AddGuide(var_17_0[iter_17_0])
		end
	end
end

function var_0_0.NotifyEnemyDefeatGuideFinished(arg_18_0, arg_18_1)
	var_0_0.StopGuidePollState(var_0_0.enemyDefeatGuideState_)

	var_0_0.enemyDefeatGuideState_ = nil

	var_0_0.UpdateSummerRaceGuidePause()
	SummerRaceData:ClearGuideTriggerContext(SummerRaceConst.GUIDE_TRIGGER.CONTEXT_ENEMY_DEFEAT_BEFORE_FX)

	if arg_18_1 ~= nil and arg_18_1.RequestNotifyEnemyDefeatGuideFinished then
		arg_18_1.RequestNotifyEnemyDefeatGuideFinished(arg_18_0)
	end

	var_0_0.ProcessNextEnemyDefeatGuide()
end

function var_0_0.EnqueueEnemyDefeatGuidePayload(arg_19_0)
	if type(arg_19_0) ~= "table" then
		return
	end

	if type(var_0_0.enemyDefeatGuideQueue_) ~= "table" then
		var_0_0.enemyDefeatGuideQueue_ = {}
	end

	table.insert(var_0_0.enemyDefeatGuideQueue_, arg_19_0)
end

function var_0_0.ProcessNextEnemyDefeatGuide()
	if var_0_0.enemyDefeatGuideState_ ~= nil or type(var_0_0.enemyDefeatGuideQueue_) ~= "table" or #var_0_0.enemyDefeatGuideQueue_ <= 0 then
		return
	end

	local var_20_0 = var_0_7()

	if var_20_0 == nil then
		return
	end

	var_0_0.StartEnemyDefeatBeforeFxGuide(table.remove(var_0_0.enemyDefeatGuideQueue_, 1), var_20_0)
end

function var_0_0:IsEnemyDefeatGuideBattlePhase()
	if type(self) ~= "table" then
		return false
	end

	local var_21_0 = tostring(self.phase or "")

	return var_21_0 == "Battle" or var_21_0 == "SpecialDefeatPending"
end

function var_0_0:CancelEnemyDefeatGuideIfBattleLeft()
	if var_0_0.IsEnemyDefeatGuideBattlePhase(self) == true then
		return
	end

	if type(self) ~= "table" or self.phase == nil then
		return
	end

	local var_22_0 = var_0_7()

	if var_0_0.enemyDefeatGuideState_ ~= nil then
		var_0_0.ClearQueuedEnemyDefeatGuides(var_22_0)
		var_0_0.NotifyEnemyDefeatGuideFinished(var_0_0.enemyDefeatGuideState_.token, var_22_0)
	else
		var_0_0.ClearQueuedEnemyDefeatGuides(var_22_0)
	end
end

function var_0_0:ClearQueuedEnemyDefeatGuides()
	if type(var_0_0.enemyDefeatGuideQueue_) ~= "table" then
		return
	end

	for iter_23_0 = 1, #var_0_0.enemyDefeatGuideQueue_ do
		local var_23_0 = type(var_0_0.enemyDefeatGuideQueue_[iter_23_0]) == "table" and (tonumber(var_0_0.enemyDefeatGuideQueue_[iter_23_0].token) or 0) or 0

		if var_23_0 > 0 and self ~= nil and self.RequestNotifyEnemyDefeatGuideFinished then
			self.RequestNotifyEnemyDefeatGuideFinished(var_23_0)
		end
	end

	var_0_0.enemyDefeatGuideQueue_ = nil
end

function var_0_0.HasSummerRaceGuidePauseCondition(arg_24_0)
	if type(arg_24_0) ~= "table" then
		return false
	end

	for iter_24_0, iter_24_1 in pairs(arg_24_0) do
		if type(iter_24_1) == "table" then
			if iter_24_1[1] == SummerRaceConst.GUIDE_TRIGGER.WAVE_START or iter_24_1[1] == SummerRaceConst.GUIDE_TRIGGER.ENERGY_REACHED or iter_24_1[1] == SummerRaceConst.GUIDE_TRIGGER.ENEMY_DEFEAT_BEFORE_FX then
				return true
			end
		end
	end

	return false
end

function var_0_0.HasSummerRaceGuideHideUiCondition(arg_25_0)
	if type(arg_25_0) ~= "table" then
		return false
	end

	for iter_25_0, iter_25_1 in pairs(arg_25_0) do
		if type(iter_25_1) == "table" then
			if iter_25_1[1] == SummerRaceConst.GUIDE_TRIGGER.WAVE_START or iter_25_1[1] == SummerRaceConst.GUIDE_TRIGGER.ENEMY_DEFEAT_BEFORE_FX then
				return true
			end
		end
	end

	return false
end

function var_0_0.HasGuideDependency(arg_26_0, arg_26_1)
	if type(arg_26_0) ~= "table" then
		return false
	end

	local var_26_0 = tonumber(arg_26_1) or 0

	if var_26_0 <= 0 then
		return false
	end

	for iter_26_0, iter_26_1 in pairs(arg_26_0) do
		if type(iter_26_1) == "table" and iter_26_1[1] == "guide" then
			if (tonumber(iter_26_1[2]) or 0) == var_26_0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.HasNextSummerRaceHideUiGuide(arg_27_0)
	if var_0_0.IsEditorGuideDisabled() == true then
		return false
	end

	if manager == nil or manager.guide == nil or GuideBaseCfg == nil or GuideData == nil or GuideTool == nil or type(GuideBaseCfg.all) ~= "table" then
		return false
	end

	for iter_27_0 = 1, #GuideBaseCfg.all do
		if GuideBaseCfg[GuideBaseCfg.all[iter_27_0]] ~= nil and var_0_0.HasSummerRaceGuideHideUiCondition(GuideBaseCfg[GuideBaseCfg.all[iter_27_0]].open_condition) and var_0_0.HasGuideDependency(GuideBaseCfg[GuideBaseCfg.all[iter_27_0]].open_condition, arg_27_0) then
			local var_27_0 = GuideTool.SatisfyCondition(GuideBaseCfg[GuideBaseCfg.all[iter_27_0]].open_condition)

			if var_27_0 == true and manager.guide:GetGuideIsOpen(GuideBaseCfg.all[iter_27_0]) == true then
				return true
			end

			if var_27_0 == true and not GuideData:IsFinish(GuideBaseCfg.all[iter_27_0]) then
				return true
			end
		end
	end

	return false
end

function var_0_0.IsSummerRacePauseGuide(arg_28_0)
	local var_28_0

	if GuideBaseCfg then
		var_28_0 = GuideBaseCfg[arg_28_0] or nil
	end

	return var_28_0 ~= nil and var_0_0.HasSummerRaceGuidePauseCondition(var_28_0.open_condition)
end

function var_0_0.ShouldHideBattleViewForSummerRaceGuide(arg_29_0)
	local var_29_0

	if GuideBaseCfg then
		var_29_0 = GuideBaseCfg[arg_29_0] or nil
	end

	return var_29_0 ~= nil and var_0_0.HasSummerRaceGuideHideUiCondition(var_29_0.open_condition)
end

function var_0_0.GetPlayingSummerRaceGuide(arg_30_0)
	if manager == nil or manager.guide == nil or type(manager.guide._guides) ~= "table" then
		return nil
	end

	for iter_30_0, iter_30_1 in ipairs(manager.guide._guides) do
		if iter_30_1 ~= nil and iter_30_1.IsPlaying ~= nil and iter_30_1:IsPlaying() and iter_30_1.GetId ~= nil and iter_30_1:GetId() == arg_30_0 then
			return iter_30_1
		end
	end

	return nil
end

function var_0_0.HasSummerRaceGuideStepStarted(arg_31_0)
	local var_31_0 = var_0_0.GetPlayingSummerRaceGuide(arg_31_0)
	local var_31_1

	if var_31_0 ~= nil and type(var_31_0._steps) == "table" then
		var_31_1 = var_31_0._steps[1] or nil

		if var_31_1 == nil or var_31_1.GetStarTime == nil then
			return false
		end
	end

	return (tonumber(var_31_1:GetStarTime()) or 0) > 0
end

function var_0_0.ShouldRestoreBattleViewAfterGuide()
	local var_32_0 = SummerRaceData:GetRuntimeState()

	if type(var_32_0) ~= "table" then
		return true
	end

	local var_32_1 = tostring(var_32_0.phase or "")

	return var_32_1 ~= "Result" and var_32_1 ~= "SpecialDefeatPending"
end

function var_0_0.ResumeGuidePauseIfNeeded()
	if var_0_0.guidePauseState_ == nil then
		return
	end

	local var_33_0 = var_0_0.guidePauseState_

	var_0_0.guidePauseState_ = nil

	if var_33_0.battleViewHidden == true and var_0_0.HasNextSummerRaceHideUiGuide(var_33_0.guideId) == true then
		var_0_0.guidePauseState_ = var_33_0

		return
	end

	if var_33_0.battleViewHidden == true and var_0_0.ShouldRestoreBattleViewAfterGuide() == true then
		var_0_0.SetBattleViewGuideHidden(false)
	end

	if var_33_0.didPause == true and var_33_0.wasPaused ~= true then
		var_0_0.RequestSetPaused(false)
	end
end

function var_0_0.UpdateSummerRaceGuidePause()
	local var_34_0, var_34_1 = manager.guide:IsPlaying()

	if var_34_0 == true and var_0_0.IsSummerRacePauseGuide(var_34_1) then
		if var_0_0.guidePauseState_ ~= nil then
			var_0_0.guidePauseState_.guideId = var_34_1

			if var_0_0.guidePauseState_.battleViewHidden ~= true and var_0_0.ShouldHideBattleViewForSummerRaceGuide(var_34_1) == true then
				var_0_0.guidePauseState_.battleViewHidden = var_0_0.SetBattleViewGuideHidden(true)
			end

			return
		end

		if var_0_0.HasSummerRaceGuideStepStarted(var_34_1) ~= true then
			return
		end

		local var_34_2 = SummerRaceData:GetRuntimeState()
		local var_34_3 = type(var_34_2) == "table" and var_34_2.isPaused == true

		var_0_0.guidePauseState_ = {
			didPause = false,
			guideId = var_34_1,
			wasPaused = var_34_3,
			battleViewHidden = (var_0_0.ShouldHideBattleViewForSummerRaceGuide(var_34_1) == true or nil) and var_0_0.SetBattleViewGuideHidden(true)
		}
		var_0_0.guidePauseState_.didPause = var_0_0.RequestSetPaused(true) == true

		return
	end

	var_0_0.ResumeGuidePauseIfNeeded()
end

function var_0_0.StartSummerRaceGuidePauseMonitor()
	if var_0_0.guidePauseTimer_ ~= nil then
		return
	end

	var_0_0.guidePauseTimer_ = Timer.New(function()
		var_0_0.UpdateSummerRaceGuidePause()
	end, SummerRaceConst.GUIDE.PAUSE_POLL_INTERVAL, -1)

	var_0_0.guidePauseTimer_:Start()
end

function var_0_0.StopSummerRaceGuidePauseMonitor()
	if var_0_0.guidePauseTimer_ ~= nil then
		var_0_0.guidePauseTimer_:Stop()

		var_0_0.guidePauseTimer_ = nil
	end

	var_0_0.ResumeGuidePauseIfNeeded()
end

local function var_0_13()
	SummerRaceData:ReplayRuntimeState(var_0_10)

	return var_0_0.runtimeState_
end

local function var_0_14()
	SummerRaceData:ReplaySettlementState(var_0_11)

	return var_0_0.settlementState_
end

local function var_0_15(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0 and arg_40_0.stageId
	local var_40_1 = tonumber(arg_40_0 and arg_40_0.stageId) or var_40_0

	if var_40_1 ~= nil and var_40_1 ~= "" and var_40_1 ~= 0 and ActivityTankCfg[var_40_1] ~= nil then
		return var_40_1
	end

	local var_40_2 = SummerRaceConst.MODE_KEY_TO_MODE_TYPE[arg_40_1]
	local var_40_3 = tonumber(var_40_0)

	if SummerRaceConst.MODE_KEY_TO_MODE_TYPE[arg_40_1] ~= nil and var_40_3 ~= nil and var_40_3 > 0 and var_40_3 == math.floor(var_40_3) and type(ActivityTankCfg) == "table" and type(ActivityTankCfg.all) == "table" then
		local var_40_4 = {}

		for iter_40_0 = 1, #ActivityTankCfg.all do
			if ActivityTankCfg[ActivityTankCfg.all[iter_40_0]] ~= nil and tonumber(ActivityTankCfg[ActivityTankCfg.all[iter_40_0]].mode_type) == tonumber(var_40_2) then
				var_40_4[#var_40_4 + 1] = ActivityTankCfg[ActivityTankCfg.all[iter_40_0]]
			end
		end

		table.sort(var_40_4, function(arg_41_0, arg_41_1)
			local var_41_0 = tonumber(arg_41_0.sort) or 0
			local var_41_1 = tonumber(arg_41_1.sort) or 0

			if var_41_0 == var_41_1 then
				return (tonumber(arg_41_0.id) or 0) < (tonumber(arg_41_1.id) or 0)
			end

			return var_41_0 < var_41_1
		end)

		if var_40_4[var_40_3] ~= nil and var_40_4[var_40_3].id ~= nil and ActivityTankCfg[var_40_4[var_40_3].id] ~= nil then
			return var_40_4[var_40_3].id
		end
	end

	error(string.format("[SummerRace][84332] invalid settlement.stageId by mode=%s raw=%s", tostring(arg_40_1), tostring(var_40_0)), 2)
end

local function var_0_16(arg_42_0)
	local var_42_0 = 0

	if type(arg_42_0) ~= "table" then
		return var_42_0
	end

	for iter_42_0 = 1, #arg_42_0 do
		if type(arg_42_0[iter_42_0]) == "table" then
			if tostring(arg_42_0[iter_42_0].result or "") == "win" then
				var_42_0 = math.max(var_42_0, math.floor(tonumber(arg_42_0[iter_42_0].round) or 0))
			end
		end
	end

	return var_42_0
end

local function var_0_17(arg_43_0, arg_43_1)
	if arg_43_1 ~= SummerRaceConst.MODE.CHALLENGE then
		return 0
	end

	local var_43_0 = var_0_16(arg_43_0.roundRecords)

	if var_43_0 <= 0 then
		var_43_0 = var_0_16(arg_43_0.challengeRoundRecords)
	end

	if var_43_0 > 0 then
		return var_43_0
	end

	local var_43_1

	if arg_43_0.isWin == true then
		do return math.max(0, math.floor(tonumber(arg_43_0.challengeReachedWave) or 0)) end

		var_43_1 = tonumber(arg_43_0.destroyedEnemies) or 0
	end

	return math.max(0, math.floor(var_43_1))
end

local function var_0_18(arg_44_0)
	return string.sub(arg_44_0, 1, 1) == "/" and arg_44_0 or "/" .. arg_44_0
end

local function var_0_19(arg_45_0, arg_45_1)
	JumpTools.OpenPageByJump(var_0_18(arg_45_0), arg_45_1)

	return true
end

local function var_0_20(arg_46_0, arg_46_1)
	JumpTools.OpenPageByJump(arg_46_0, arg_46_1)

	return true
end

local function var_0_21(arg_47_0, arg_47_1, arg_47_2)
	OpenPageUntilLoaded(var_0_18(arg_47_0), arg_47_1, arg_47_2)

	return true
end

local function var_0_22(arg_48_0)
	if arg_48_0 == SummerRaceConst.REWARD_PAGE.RESIDENT then
		return "summerRaceResidentRewardView"
	end

	return "summerRaceLimitedRewardView"
end

local function var_0_23(arg_49_0, arg_49_1)
	JumpTools.OpenPageByJump(arg_49_1 and arg_49_1.source == "sceneReady" and arg_49_0 or var_0_18(arg_49_0), arg_49_1)

	return true
end

local function var_0_24(arg_50_0, arg_50_1)
	local var_50_0 = tonumber(arg_50_0) or 0

	if var_50_0 == 0 then
		if type(arg_50_1) == "function" then
			return arg_50_1(false)
		end

		return true
	end

	manager.story:StartStoryById(var_50_0, function()
		if type(arg_50_1) == "function" then
			arg_50_1(true)
		end
	end)

	return true
end

local var_0_25 = 10

local function var_0_26()
	local var_52_0 = var_0_7()

	if var_52_0 and var_52_0.RequestPrepareOutGameStoryCamera then
		var_52_0.RequestPrepareOutGameStoryCamera(var_0_25)
	end

	if manager and manager.ui and manager.ui.ResetMainCamera then
		manager.ui:ResetMainCamera()
	end

	local var_52_1 = manager and manager.ui and manager.ui.mainCameraCom_

	if var_52_1 ~= nil then
		var_52_1.orthographic = false
		var_52_1.orthographicSize = var_0_25
	end
end

local function var_0_27()
	if SceneManager == nil then
		var_0_8("[SummerRaceAction] UnloadBattleLevel skipped: SceneManager unavailable.")

		return false
	end

	local var_53_0 = SceneManager.GetSceneByName("SummerRaceFight")

	if var_53_0 and var_53_0.isLoaded == true then
		SceneManager.UnloadSceneAsync("SummerRaceFight")

		return true
	end

	return false
end

local function var_0_28(arg_54_0, arg_54_1)
	local var_54_0 = tonumber(arg_54_0) or arg_54_0

	if var_54_0 == nil or var_54_0 == "" or var_54_0 == 0 or SummerRaceData:IsStageCompleted(var_54_0) == true then
		if type(arg_54_1) == "function" then
			return arg_54_1()
		end

		return true
	end

	return var_0_24(SummerRaceData:GetStageStartStoryId(var_54_0), arg_54_1)
end

local function var_0_29(arg_55_0)
	return var_0_19(SummerRaceData:IsChallengeMode(arg_55_0.mode) and "summerRaceChallengeResultView" or "summerRaceBattleResultView", {
		source = "settlement"
	})
end

local function var_0_30(arg_56_0)
	if type(arg_56_0) ~= "table" then
		error("[SummerRaceAction] settlement state is missing")
	end

	local var_56_0 = var_0_15(arg_56_0, SummerRaceData:NormalizeMode(arg_56_0.mode))

	if not (arg_56_0.isWin == true and SummerRaceData:IsStageCompleted(var_56_0) ~= true) then
		return var_0_29(arg_56_0)
	end

	local var_56_1 = SummerRaceData:GetStageEndStoryId(var_56_0)

	if (tonumber(var_56_1) or 0) ~= 0 then
		var_0_26()
	end

	var_0_27()

	return var_0_24(var_56_1, function()
		var_0_29(arg_56_0)
	end)
end

local function var_0_31(arg_58_0)
	if type(arg_58_0) ~= "table" or arg_58_0.playFirstPlotOnEnter ~= true or arg_58_0.skipFirstPlotGate == true then
		return false
	end

	local var_58_0 = SummerRaceData:GetFirstPlotStageIdIfIncomplete()

	if var_58_0 == nil then
		return false
	end

	return var_0_0.PlayPlotStage(var_58_0, function()
		local var_59_0 = {
			skipFirstPlotGate = true
		}

		if arg_58_0.playBodyDisplayOnEnter == true then
			var_59_0.playBodyDisplayOnEnter = true
		end

		var_0_0.OpenMainView(var_59_0)
	end)
end

local function var_0_32(arg_60_0, arg_60_1)
	local var_60_0 = {}

	if type(arg_60_1) == "table" then
		for iter_60_0, iter_60_1 in pairs(arg_60_1) do
			var_60_0[iter_60_0] = iter_60_1
		end
	end

	var_60_0.panelType = arg_60_0

	if arg_60_0 == "stageDetail" then
		return var_0_20("summerRaceModifyView", var_60_0)
	end

	return var_0_19("summerRaceModifyView", var_60_0)
end

local function var_0_33(arg_61_0, arg_61_1)
	if GetIsInMainScene == nil or GetIsInMainScene() ~= true then
		LuaExchangeHelper.GoToMain()
	end

	return var_0_21(arg_61_0, arg_61_1)
end

local function var_0_34()
	local var_62_0 = var_0_0.settlementState_ or var_0_14()
	local var_62_1 = SummerRaceData:GetRuntimeState()

	if var_62_0 then
		if SummerRaceData:IsChallengeMode(var_62_0.mode or var_62_1 and var_62_1.mode) then
			return "summerRaceModifyView", {
				panelType = "challenge"
			}
		end
	end

	return "summerRaceTournamentView", nil
end

local function var_0_35()
	local var_63_0 = SummerRaceData:ConsumePendingUnlockPopModel()

	if var_63_0 == nil then
		local var_63_1 = SummerRaceData:ConsumePendingStageUnlockBannerModel()

		if var_63_1 == nil then
			return false
		end

		return var_0_0.OpenUnlockBannerView(var_63_1)
	end

	return var_0_0.OpenUnlockPop(var_63_0.sourceType)
end

local function var_0_36()
	if var_0_35() then
		return true, "unlock"
	end

	if var_0_12() then
		return true, "guide"
	end

	SummerRaceData:NotifyPendingStageItemUnlockAnim()

	return false, nil
end

local function var_0_37()
	if LuaExchangeHelper ~= nil and LuaExchangeHelper.GetSceneIsHanding ~= nil then
		return LuaExchangeHelper.GetSceneIsHanding() == true
	end

	return false
end

local function var_0_38()
	if gameContext == nil or gameContext.GetOpenPageHandler == nil then
		return nil
	end

	return gameContext:GetOpenPageHandler("summerRaceBattleView")
end

function var_0_5(arg_67_0)
	local var_67_0 = var_0_38()

	if var_67_0 ~= nil and var_67_0.SetTimeoutResultVisible ~= nil then
		var_67_0:SetTimeoutResultVisible(arg_67_0)

		return true
	end

	return false
end

function var_0_6(arg_68_0)
	local var_68_0 = var_0_38()

	if var_68_0 ~= nil and var_68_0.SetBattleResultVisible ~= nil then
		var_68_0:SetBattleResultVisible(arg_68_0)

		return true
	end

	return false
end

local function var_0_39(arg_69_0)
	local var_69_0 = var_0_38()

	if var_69_0 ~= nil and var_69_0.SetSpecialDefeatUiHidden ~= nil then
		var_69_0:SetSpecialDefeatUiHidden(arg_69_0 == true)
	end
end

function var_0_0.SetBattleViewGuideHidden(arg_70_0)
	local var_70_0 = var_0_38()

	if var_70_0 == nil or var_70_0.SetSpecialDefeatUiHidden == nil then
		return false
	end

	var_70_0:SetSpecialDefeatUiHidden(arg_70_0 == true)

	return true
end

local function var_0_40()
	if manager ~= nil and manager.ui ~= nil and manager.ui.SetMainCamera ~= nil then
		if manager.ui.mainCamera ~= nil and manager.ui.mainCamera.transform ~= nil then
			manager.ui.mainCamera.transform.parent = nil
		end

		manager.ui:SetMainCamera("summerRaceBattle")
	end
end

local function var_0_41(arg_72_0, arg_72_1)
	local var_72_0 = var_0_7()

	if var_72_0 == nil or var_72_0.ExitScene == nil then
		var_0_8("[SummerRaceAction] CloseSettlementAndBattleStack skipped: SummerRaceLuaBridge.ExitScene unavailable.")

		return false
	end

	if var_0_37() then
		var_0_8("[SummerRaceAction] CloseSettlementAndBattleStack skipped: SceneDirector is handling.")

		return false
	end

	if type(arg_72_1) == "function" then
		arg_72_1()
	end

	return var_72_0.ExitScene(LuaHelper.VoidAction(function()
		if type(arg_72_0) == "function" then
			arg_72_0()
		end
	end)) == true
end

local function var_0_42(arg_74_0)
	if manager and manager.redPoint and manager.redPoint.setTip then
		arg_74_0 = arg_74_0 or var_0_0.runtimeState_ or var_0_13()

		local var_74_0 = false

		if arg_74_0 ~= nil then
			if arg_74_0.hasInteractableSkill == true then
				var_74_0 = true
			elseif arg_74_0.skillReady == true then
				var_74_0 = true
			elseif type(arg_74_0.skills) == "table" then
				for iter_74_0 = 1, #arg_74_0.skills do
					if arg_74_0.skills[iter_74_0] ~= nil and (arg_74_0.skills[iter_74_0].canUse == true or arg_74_0.skills[iter_74_0].canOverload == true) then
						var_74_0 = true

						break
					end
				end
			end
		end

		manager.redPoint:setTip("SUMMERRACE_BATTLE_ENTRY", var_74_0 and 1 or 0)
	end
end

local function var_0_43(arg_75_0)
	local var_75_0 = SummerRaceData:GetCurrentBuildCostSummary()

	if var_75_0.isOverflow == true then
		ShowTips(arg_75_0)

		return false, var_75_0
	end

	return true, var_75_0
end

local function var_0_44(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	local var_76_0 = tonumber(arg_76_0) or arg_76_0

	if var_76_0 == nil or var_76_0 == "" or var_76_0 == 0 then
		error("[SummerRaceAction] complete stage requires valid stageId")
	end

	local var_76_1 = {
		activity_id = SummerRaceConst.ACTIVITY_ID.MAIN,
		stage_id = var_76_0
	}

	if arg_76_1 ~= nil then
		var_76_1.round = math.max(0, math.floor(tonumber(arg_76_1) or 0))
	end

	if arg_76_2 ~= nil then
		var_76_1.score = math.max(0, math.floor(tonumber(arg_76_2) or 0))
	end

	if arg_76_3 ~= nil then
		var_76_1.kill_num = math.max(0, math.floor(tonumber(arg_76_3) or 0))
	end

	return var_76_1
end

local function var_0_45(arg_77_0)
	local var_77_0 = {}

	if type(arg_77_0) == "table" then
		for iter_77_0 = 1, #(arg_77_0.weaponIds or {}) do
			var_77_0[#var_77_0 + 1] = tostring(arg_77_0.weaponIds[iter_77_0])
		end

		for iter_77_1 = 1, #(arg_77_0.equipIds or {}) do
			var_77_0[#var_77_0 + 1] = tostring(arg_77_0.equipIds[iter_77_1])
		end
	end

	return "[" .. table.concat(var_77_0, ",") .. "]"
end

local function var_0_46(arg_78_0)
	if type(arg_78_0) ~= "table" or SDKTools == nil or SDKTools.SendMessageToSDK == nil then
		return false
	end

	local var_78_0 = SummerRaceData:NormalizeMode(arg_78_0.mode)
	local var_78_1 = var_0_15(arg_78_0, var_78_0)
	local var_78_2 = SummerRaceData:BuildCurrentBuildSnapshot()
	local var_78_3

	if type(var_78_2) == "table" then
		var_78_3 = var_78_2.buildData or nil
	end

	local var_78_4 = 0

	if var_78_0 == SummerRaceConst.MODE.CHALLENGE then
		var_78_4 = math.max(0, math.floor(tonumber(arg_78_0.challengeReachedWave) or tonumber(arg_78_0.destroyedEnemies) or 0))
	end

	local var_78_5 = "activity_combat_over"
	local var_78_6 = {
		activity_id = SummerRaceConst.ACTIVITY_ID.MAIN,
		stage_id = var_78_1
	}

	var_78_6.score = math.max(0, math.floor(tonumber(arg_78_0.score) or 0))
	var_78_6.result = arg_78_0.isWin == true and 1 or 2
	var_78_6.use_seconds = math.max(0, math.floor(tonumber(arg_78_0.battleElapsed) or 0))
	var_78_6.sequence_id = var_78_4

	if var_78_3 then
		var_78_6.hero_id = tonumber(var_78_3.bodyId) or var_78_3.bodyId or 0
	end

	var_78_6.extra_data = var_0_45(var_78_3)

	SDKTools.SendMessageToSDK(var_78_5, var_78_6)

	return true
end

function var_0_0.RequestCompleteStage(arg_79_0, arg_79_1, arg_79_2, arg_79_3, arg_79_4, arg_79_5)
	local var_79_0 = var_0_44(arg_79_0, arg_79_1, arg_79_2, arg_79_5)

	var_79_0.result = arg_79_4 == true and 0 or 1

	local var_79_1 = SummerRaceData:IsStageCompleted(var_79_0.stage_id)

	manager.net:SendWithLoadingNew(var_0_2.CS_COMPLETE_STAGE, var_79_0, var_0_2.SC_COMPLETE_STAGE, function(arg_80_0, arg_80_1)
		if isSuccess(arg_80_0.result) then
			if arg_79_4 == true then
				SummerRaceData:TryPrepareStageFirstClearUnlock(arg_80_1.stage_id, true, var_79_1)
				SummerRaceData:MarkStageCompletedFromServer(arg_80_1.stage_id, true)
			end

			if arg_80_1.round ~= nil or arg_80_1.score ~= nil then
				SummerRaceData:UpdateChallengeRecord(arg_80_1.round, arg_80_1.score, true)
			end

			SummerRaceData:NotifyOutGameUpdated("completeStage")

			if type(arg_79_3) == "function" then
				arg_79_3(true, arg_80_0, arg_80_1)
			end
		else
			ShowTips(arg_80_0.result)

			if type(arg_79_3) == "function" then
				arg_79_3(false, arg_80_0, arg_80_1)
			end
		end
	end)
end

function var_0_0.SubmitCurrentBuild(arg_81_0)
	manager.net:SendWithLoadingNew(var_0_2.CS_MODIFY_TANK, SummerRaceData:BuildServerModifyPayload(), var_0_2.SC_MODIFY_TANK, function(arg_82_0, arg_82_1)
		if isSuccess(arg_82_0.result) then
			SummerRaceData:NotifyOutGameUpdated("submitModify")

			if type(arg_81_0) == "function" then
				arg_81_0(true, arg_82_0, arg_82_1)
			end
		else
			ShowTips(arg_82_0.result)

			if type(arg_81_0) == "function" then
				arg_81_0(false, arg_82_0, arg_82_1)
			end
		end
	end)
end

local function var_0_47(arg_83_0, arg_83_1)
	if type(arg_83_0) ~= "table" then
		error("[SummerRace][84332] settlement must be a table", 2)
	end

	local var_83_0 = SummerRaceData:NormalizeMode(arg_83_0.mode)

	var_0_0.RequestCompleteStage(var_0_15(arg_83_0, var_83_0), var_0_17(arg_83_0, var_83_0), math.max(0, math.floor(tonumber(arg_83_0.score) or 0)), arg_83_1, arg_83_0.isWin == true, (math.max(0, math.floor(tonumber(arg_83_0.destroyedEnemies) or 0))))
end

function var_0_0.RecordRuntimeSnapshot(arg_84_0)
	local var_84_0 = var_0_10(SummerRaceData:PushRuntimeState(arg_84_0))

	var_0_42(var_84_0)
	var_0_0.CancelEnemyDefeatGuideIfBattleLeft(var_84_0)
	var_0_0.StartSummerRaceGuidePauseMonitor()
	var_0_0.UpdateSummerRaceGuidePause()
end

function var_0_0.RecordDamageText(arg_85_0)
	SummerRaceData:PushDamageTextEvent(arg_85_0)
end

function var_0_0.RecordPlayerLabelPose(arg_86_0)
	SummerRaceData:PushPlayerLabelPose(arg_86_0)
end

function var_0_0.RequestUsePrimarySkill()
	local var_87_0 = var_0_7()

	if var_87_0 and var_87_0.RequestUsePrimarySkill then
		return var_87_0.RequestUsePrimarySkill()
	end

	return false
end

function var_0_0.RequestUseEquipSkill()
	local var_88_0 = var_0_7()

	if var_88_0 and var_88_0.RequestUseEquipSkill then
		return var_88_0.RequestUseEquipSkill()
	end

	return false
end

function var_0_0.RequestUseWeaponSlot(arg_89_0)
	local var_89_0 = var_0_7()

	if var_89_0 and var_89_0.RequestUseWeaponSlot then
		return var_89_0.RequestUseWeaponSlot(arg_89_0)
	end

	return false
end

function var_0_0.RequestUseEquipSlot(arg_90_0)
	local var_90_0 = var_0_7()

	if var_90_0 and var_90_0.RequestUseEquipSlot then
		return var_90_0.RequestUseEquipSlot(arg_90_0)
	end

	return false
end

function var_0_0.RequestOverloadWeaponSlot(arg_91_0)
	local var_91_0 = var_0_7()

	if var_91_0 and var_91_0.RequestOverloadWeaponSlot then
		return var_91_0.RequestOverloadWeaponSlot(arg_91_0)
	end

	return false
end

function var_0_0.RequestToggleAds()
	local var_92_0 = var_0_7()

	if var_92_0 and var_92_0.RequestToggleAds then
		var_92_0.RequestToggleAds()

		return true
	end

	return false
end

function var_0_0.RequestSetManualAccelerationNormalized(arg_93_0)
	local var_93_0 = var_0_7()

	if var_93_0 and var_93_0.RequestSetManualAccelerationNormalized then
		return var_93_0.RequestSetManualAccelerationNormalized(arg_93_0)
	end

	return false
end

function var_0_0.RequestSetPaused(arg_94_0)
	local var_94_0 = var_0_7()

	if var_94_0 and var_94_0.RequestSetPaused then
		return var_94_0.RequestSetPaused(arg_94_0)
	end

	return false
end

function var_0_0.RequestGiveUpBattle()
	local var_95_0 = var_0_7()

	if var_95_0 and var_95_0.RequestGiveUpBattle then
		return var_95_0.RequestGiveUpBattle()
	end

	return false
end

function var_0_0.RecordStageResolved(arg_96_0, arg_96_1)
	SummerRaceData:PushResolvedStage(arg_96_0, arg_96_1)
end

function var_0_0.RecordSettlement(arg_97_0)
	var_0_46((var_0_11(SummerRaceData:PushSettlementState(arg_97_0))))
	var_0_42()
end

function var_0_0.ReportSettlement(arg_98_0)
	local var_98_0 = var_0_0.settlementState_ or var_0_14()

	if var_98_0 == nil then
		error("[SummerRace][84332] settlement state is missing", 2)
	end

	var_0_47(var_98_0, function(arg_99_0, arg_99_1, arg_99_2)
		if not arg_99_0 then
			error(string.format("[SummerRace][84332] server rejected settlement, result=%s", tostring(arg_99_1 and arg_99_1.result)), 2)
		end

		if type(arg_98_0) == "function" then
			arg_98_0(arg_99_1, arg_99_2)
		end
	end)
end

function var_0_0.PrepareBattleLaunch(arg_100_0)
	local var_100_0 = var_0_7()

	if var_100_0 == nil or var_100_0.RequestPrepareBattleConfig == nil then
		var_0_8("[SummerRaceAction] PrepareBattleLaunch skipped: " .. "SummerRaceLuaBridge.RequestPrepareBattleConfig unavailable.")

		return false
	end

	return var_100_0.RequestPrepareBattleConfig((var_0_0.EncodeBattleLaunchPayload(arg_100_0))) == true
end

function var_0_0.EncodeBattleLaunchPayload(arg_101_0)
	if arg_101_0 == nil then
		return ""
	end

	if type(arg_101_0) ~= "table" then
		error("[SummerRaceAction] battle launch payload must be a table")
	end

	local var_101_0, var_101_1 = pcall(cjson.encode, arg_101_0)

	if not var_101_0 or type(var_101_1) ~= "string" then
		error("[SummerRaceAction] battle launch payload encode failed: " .. tostring(var_101_1))
	end

	return var_101_1
end

function var_0_0.LaunchBattle(arg_102_0)
	local var_102_0 = var_0_7()

	if var_102_0 == nil or var_102_0.Launcher == nil then
		var_0_8("[SummerRaceAction] LaunchBattle skipped: SummerRaceLuaBridge.Launcher unavailable.")

		return false
	end

	if var_0_37() then
		var_0_8("[SummerRaceAction] LaunchBattle skipped: SceneDirector is handling.")

		return false
	end

	local var_102_1 = var_0_0.EncodeBattleLaunchPayload(arg_102_0)

	var_0_0.RefreshRedPoint()
	var_0_0.StopSummerRaceGuidePauseMonitor()
	var_0_0.StopTimeoutResultTimers()

	if var_102_0.Launcher(var_102_1) ~= true then
		return false
	end

	var_0_0.settlementState_ = nil

	SummerRaceData:ClearSettlementState(true)

	return true
end

function var_0_0.EnterStageBattle(arg_103_0, arg_103_1)
	if not var_0_43("ACTIVITY_TANK_COST_LIMMIT") then
		return false
	end

	local var_103_0 = SummerRaceData:BuildStageBattleLaunchPayload(arg_103_0, arg_103_1 or "stageDetail")

	return var_0_28(var_103_0 and var_103_0.stageId, function()
		return var_0_0.LaunchBattle(var_103_0)
	end)
end

function var_0_0.EnterChallengeBattle(arg_105_0, arg_105_1)
	if not var_0_43("ACTIVITY_TANK_COST_LIMMIT") then
		return false
	end

	local var_105_0 = SummerRaceData:BuildChallengeBattleLaunchPayload(arg_105_0 or "challenge", arg_105_1)

	return var_0_28(var_105_0 and var_105_0.stageId, function()
		return var_0_0.LaunchBattle(var_105_0)
	end)
end

function var_0_0.RetrySettlementBattle(arg_107_0)
	local var_107_0 = var_0_7()

	if var_107_0 == nil then
		error("[SummerRaceAction] retry settlement failed: SummerRaceLuaBridge unavailable")
	end

	if var_107_0.RequestPrepareBattleConfig == nil then
		error("[SummerRaceAction] retry settlement failed: RequestPrepareBattleConfig unavailable")
	end

	if var_107_0.RequestApplyPreparedLaunchForStandaloneValidation == nil then
		error("[SummerRaceAction] retry settlement failed: RequestApplyPreparedLaunchForStandaloneValidation unavailable")
	end

	if var_0_37() then
		var_0_8("[SummerRaceAction] RetrySettlementBattle skipped: SceneDirector is handling.")

		return false
	end

	if var_107_0.RequestPrepareBattleConfig((var_0_0.EncodeBattleLaunchPayload((SummerRaceData:BuildSettlementRetryLaunchPayload(arg_107_0 or "settlementRetry"))))) ~= true then
		error("[SummerRaceAction] retry settlement failed: RequestPrepareBattleConfig rejected")
	end

	if var_107_0.RequestApplyPreparedLaunchForStandaloneValidation() ~= true then
		error("[SummerRaceAction] retry settlement failed: runtime restart rejected")
	end

	var_0_0.settlementState_ = nil

	SummerRaceData:ClearSettlementState(true)
	var_0_40()
	var_0_0.RefreshRedPoint()

	return true
end

function var_0_0.RetrySettlementBattleFromResult(arg_108_0)
	if var_0_0.RetrySettlementBattle(arg_108_0 or "settlementRetry") ~= true then
		return false
	end

	return var_0_0.OpenBattleView({
		source = "settlementRetry"
	})
end

function var_0_0.OpenSettlementResult()
	var_0_0.StopSummerRaceGuidePauseMonitor()

	local var_109_0 = var_0_0.settlementState_ or var_0_14()

	if type(var_109_0) == "table" and var_109_0.isWin ~= true and (var_109_0.resultReason == "timeout" or var_0_0.lastTimeoutResultType_ == "lose") then
		local var_109_1 = "lose"
		local var_109_2 = var_0_3

		if var_0_0.lastTimeoutResultShownAt_ ~= nil then
			var_109_2 = math.max(0, var_0_3 - (var_0_9() - var_0_0.lastTimeoutResultShownAt_))
		end

		if var_0_0.timeoutResultTimer_ ~= nil then
			var_0_0.timeoutResultTimer_:Stop()

			var_0_0.timeoutResultTimer_ = nil
		end

		var_0_5(var_109_1)

		if var_109_2 <= 0 then
			var_0_5(nil)

			return var_0_30(var_109_0)
		end

		if var_0_0.timeoutSettlementTimer_ == nil then
			var_0_0.timeoutSettlementTimer_ = Timer.New(function()
				if var_0_0.timeoutSettlementTimer_ ~= nil then
					var_0_0.timeoutSettlementTimer_:Stop()

					var_0_0.timeoutSettlementTimer_ = nil
				end

				var_0_5(nil)
				var_0_30(var_109_0)
			end, var_109_2, 1)

			var_0_0.timeoutSettlementTimer_:Start()
		end

		return true
	end

	if type(var_109_0) == "table" and SummerRaceData:IsChallengeMode(var_109_0.mode) and var_109_0.isWin ~= true and var_109_0.resultReason ~= "giveup" then
		local var_109_3 = var_0_4

		if var_0_0.lastLoseBattleResultBannerShownAt_ ~= nil then
			var_109_3 = math.max(0, var_0_4 - (var_0_9() - var_0_0.lastLoseBattleResultBannerShownAt_))
		end

		if var_109_3 <= 0 then
			return var_0_30(var_109_0)
		end

		if var_0_0.challengeFailureSettlementTimer_ == nil then
			var_0_0.challengeFailureSettlementTimer_ = Timer.New(function()
				if var_0_0.challengeFailureSettlementTimer_ ~= nil then
					var_0_0.challengeFailureSettlementTimer_:Stop()

					var_0_0.challengeFailureSettlementTimer_ = nil
				end

				var_0_30(var_109_0)
			end, var_109_3, 1)

			var_0_0.challengeFailureSettlementTimer_:Start()
		end

		return true
	end

	return var_0_30(var_109_0)
end

function var_0_0.OpenBattleView(arg_112_0)
	return var_0_23("summerRaceBattleView", arg_112_0)
end

function var_0_0.OpenInfoPop(arg_113_0)
	return var_0_20("summerRaceBattleInfoPopView", arg_113_0 or {
		source = "runtime"
	})
end

function var_0_0.OpenMainView(arg_114_0)
	if GetIsInMainScene == nil or GetIsInMainScene() ~= true then
		LuaExchangeHelper.GoToMain()
	end

	local var_114_0 = var_0_21("summerRaceMainView", arg_114_0)

	var_0_31(arg_114_0)

	return var_114_0
end

function var_0_0.LeaveSettlementToMain(arg_115_0)
	local var_115_0

	if arg_115_0 ~= nil then
		var_115_0 = {
			preferredStageTab = arg_115_0
		}
	end

	return var_0_41(function()
		var_0_0.OpenMainView(var_115_0)
	end, function()
		DestroyLua()
	end)
end

function var_0_0.LeaveBattleToMain()
	DestroyLua()
	var_0_0.StopTimeoutResultTimers()

	return var_0_41(function()
		local var_119_0, var_119_1 = var_0_34()

		var_0_33(var_119_0, var_119_1)
	end)
end

function var_0_0.OpenTournamentView(arg_120_0, arg_120_1)
	SummerRaceData:MarkChampionshipEntryClicked(true)

	if arg_120_0 ~= nil then
		SummerRaceData:SetTournamentTab(arg_120_0, true)
	end

	local var_120_0 = arg_120_1 or {}

	if arg_120_0 ~= nil then
		var_120_0.tabType = arg_120_0
	end

	return var_0_19("summerRaceTournamentView", next(var_120_0) ~= nil and var_120_0 or nil)
end

function var_0_0.OpenStageDetailView(arg_121_0)
	if arg_121_0 ~= nil then
		SummerRaceData:SetCurrentStageId(arg_121_0, true)
	end

	return var_0_32("stageDetail", {
		stageId = arg_121_0
	})
end

function var_0_0.OpenChallengeView()
	local var_122_0 = SummerRaceData:GetChallengeUnlockState()

	if var_122_0.isUnlocked ~= true then
		if var_122_0.tipText ~= "" then
			ShowTips(var_122_0.tipText)
		end

		return false
	end

	return var_0_32("challenge")
end

function var_0_0.OpenModifyView(arg_123_0)
	SummerRaceData:ResetModifyOperateState(true)
	SummerRaceData:SetModifyFilter(arg_123_0 or SummerRaceConst.FILTER.ALL, true)

	return var_0_32("modify", arg_123_0 ~= nil and {
		filterType = arg_123_0
	} or nil)
end

function var_0_0.OpenIllustratedView(arg_124_0)
	local var_124_0

	if arg_124_0 ~= nil then
		SummerRaceData:SetIllustratedFilter(arg_124_0, true)

		var_124_0 = arg_124_0 ~= nil and {
			filterType = arg_124_0
		} or nil
	end

	return var_0_19("summerRaceIllustratedView", var_124_0)
end

function var_0_0.OpenRewardView(arg_125_0, arg_125_1)
	local var_125_0, var_125_1 = SummerRaceData:ResolveRewardEntryPage(arg_125_0, arg_125_1)

	SummerRaceData:SetRewardPage(var_125_0, var_125_1, true)

	return var_0_19(var_0_22(var_125_0), {
		pageType = var_125_0,
		subType = var_125_1
	})
end

function var_0_0.OpenRankView()
	return var_0_19("summerRaceRankView")
end

function var_0_0.OpenEnemyDetailPop(arg_127_0)
	return var_0_19("summerRaceEnemyDetailPopView", {
		enemyId = arg_127_0
	})
end

function var_0_0.OpenTankDetailPop(arg_128_0)
	return var_0_19("summerRaceTankDetailPopView", {
		buildData = arg_128_0
	})
end

function var_0_0.OpenEquipInfoPop(arg_129_0)
	return var_0_19("summerRaceEquipInfoPopView", {
		equipId = arg_129_0
	})
end

function var_0_0.OpenUnlockPop(arg_130_0)
	return var_0_20("summerRaceUnlockPopView", arg_130_0 ~= nil and {
		sourceType = arg_130_0
	} or nil)
end

function var_0_0:OpenUnlockBannerView()
	local var_131_0

	if type(self) == "table" then
		do return var_0_20("summerRaceUnlockBannerView", {
			sourceType = self.sourceType,
			unlockBannerModel = self
		}) end

		var_131_0 = self ~= nil and {
			sourceType = self
		} or nil
	end

	return var_0_20("summerRaceUnlockBannerView", var_131_0)
end

function var_0_0.OpenCutScenesPop(arg_132_0)
	return var_0_20("summerRaceCutScenesPopView", arg_132_0)
end

function var_0_0.TryOpenPendingUnlockPop()
	return var_0_35()
end

function var_0_0.TryContinuePendingUnlockFlow()
	return var_0_36()
end

function var_0_0.SelectTournamentTab(arg_135_0)
	SummerRaceData:SetTournamentTab(arg_135_0)
end

function var_0_0.PlayPlotStage(arg_136_0, arg_136_1)
	local var_136_0 = tonumber(arg_136_0) or arg_136_0

	if var_136_0 == nil or var_136_0 == "" or var_136_0 == 0 then
		error("[SummerRaceAction] plot stage requires valid stageId")
	end

	return var_0_24(SummerRaceData:GetStageStartStoryId(var_136_0), function()
		if SummerRaceData:IsStageCompleted(var_136_0) == true then
			return true
		end

		var_0_0.RequestCompleteStage(var_136_0, nil, nil, function(arg_138_0)
			if type(arg_136_1) == "function" then
				arg_136_1(arg_138_0 == true)
			end

			if arg_138_0 then
				var_0_0.TryOpenPendingUnlockPop()
			end
		end, true)

		return true
	end)
end

function var_0_0.SelectStage(arg_139_0)
	SummerRaceData:MarkChampionshipEntryClicked()

	local var_139_0 = SummerRaceData:FindStageInfoById(arg_139_0)

	if var_139_0 ~= nil then
		if SummerRaceConst.STAGE_MODE_TO_TAB[tonumber(var_139_0.modeType) or 0] ~= nil then
			SummerRaceData:SetTournamentTab(SummerRaceConst.STAGE_MODE_TO_TAB[tonumber(var_139_0.modeType) or 0], true)
		end
	end

	SummerRaceData:SetCurrentStageId(arg_139_0, true)

	if SummerRaceData:IsPlotStage(arg_139_0) == true then
		return var_0_0.PlayPlotStage(arg_139_0)
	end

	return var_0_0.OpenStageDetailView(arg_139_0)
end

function var_0_0.SelectModifyFilter(arg_140_0)
	SummerRaceData:ClearSelectedModifySlot(true)
	SummerRaceData:SetModifyFilter(arg_140_0)
end

function var_0_0.SelectModifySlot(arg_141_0, arg_141_1)
	SummerRaceData:SetSelectedModifySlot(arg_141_0, arg_141_1)
end

function var_0_0.ClearModifySlotSelection()
	SummerRaceData:ClearSelectedModifySlot()
end

function var_0_0.SelectIllustratedFilter(arg_143_0)
	SummerRaceData:SetIllustratedFilter(arg_143_0)
end

function var_0_0.SelectRewardPage(arg_144_0, arg_144_1)
	SummerRaceData:SetRewardPage(arg_144_0, arg_144_1)
end

function var_0_0.SelectBody(arg_145_0)
	local var_145_0, var_145_1, var_145_2 = SummerRaceData:CanSelectBody(arg_145_0)

	if not var_145_0 then
		if var_145_2 == "locked" then
			ShowTips("ACTIVITY_TANK_BODY_LOCK")
		elseif var_145_2 == "overflow" then
			ShowTips("ACTIVITY_TANK_COST_LIMMIT")
		else
			ShowTips("ACTIVITY_TANK_BODY_LOCK")
		end

		return false
	end

	SummerRaceData:SetSelectedBody(arg_145_0)

	return true
end

function var_0_0.SelectOption(arg_146_0)
	local var_146_0 = SummerRaceData:GetSelectedModifySlot()
	local var_146_1 = SummerRaceData:GetOptionDefById(arg_146_0)

	if var_146_0 == nil then
		return false
	end

	if var_146_1 == nil then
		return false
	end

	if var_146_1.isUnlocked ~= true then
		ShowTips("ACTIVITY_TANK_WEAPON_LOCK")

		return false
	end

	if var_146_1.typeText ~= var_146_0.slotType then
		return false
	end

	local var_146_2 = SummerRaceData:GetModifyPageModel().slotList or {}
	local var_146_3

	for iter_146_0 = 1, #var_146_2 do
		if var_146_2[iter_146_0].slotType == var_146_0.slotType and tonumber(var_146_2[iter_146_0].slotIndex) == tonumber(var_146_0.slotIndex) then
			var_146_3 = var_146_2[iter_146_0]

			break
		end
	end

	if var_146_3 ~= nil and var_146_3.itemId == var_146_1.itemId then
		SummerRaceData:ClearSlot(var_146_0.slotType, var_146_0.slotIndex)

		return true
	end

	if var_146_3 == nil then
		return false
	end

	local var_146_4, var_146_5 = SummerRaceData:GetProjectedAssignCostSummary(var_146_1.itemId, var_146_0.slotType, var_146_0.slotIndex)

	if var_146_4 == nil then
		return false
	end

	if var_146_4.isOverflow == true then
		ShowTips("ACTIVITY_TANK_COST_LIMMIT")

		return false
	end

	SummerRaceData:AssignOptionToSlot(var_146_1.itemId, var_146_0.slotIndex)

	return true
end

function var_0_0.PreviewOption(arg_147_0, arg_147_1)
	local var_147_0 = SummerRaceData:GetOptionDefById(arg_147_0)

	if var_147_0 == nil then
		return false
	end

	if arg_147_1 == true then
		SummerRaceData:ClearSelectedModifySlot(true)
	end

	SummerRaceData:SetSelectedOption(var_147_0.itemId)

	return true
end

function var_0_0.AssignOptionToSlot(arg_148_0, arg_148_1)
	SummerRaceData:AssignOptionToSlot(arg_148_0, arg_148_1)
end

function var_0_0.RemoveSlot(arg_149_0, arg_149_1)
	SummerRaceData:ClearSlot(arg_149_0, arg_149_1)
end

function var_0_0.AssignDraggedOptionToSlot(arg_150_0, arg_150_1, arg_150_2)
	local var_150_0 = SummerRaceData:GetOptionDefById(arg_150_0)
	local var_150_1 = tonumber(arg_150_2) or 0

	if var_150_0 == nil then
		return false
	end

	if var_150_0.isUnlocked ~= true then
		ShowTips("ACTIVITY_TANK_WEAPON_LOCK")

		return false
	end

	if arg_150_1 ~= var_150_0.typeText then
		return false
	end

	local var_150_2, var_150_3 = SummerRaceData:GetProjectedAssignCostSummary(var_150_0.itemId, arg_150_1, var_150_1)

	if var_150_2 == nil then
		return false
	end

	if var_150_2.isOverflow == true then
		ShowTips("ACTIVITY_TANK_COST_LIMMIT")

		return false
	end

	SummerRaceData:SetSelectedModifySlot(arg_150_1, var_150_1, true, false)
	SummerRaceData:AssignOptionToSlot(var_150_0.itemId, var_150_1, true)
	SummerRaceData:NotifyOutGameUpdated("slotAssignDrag")

	return true
end

function var_0_0.MoveEquippedSlotBackToList(arg_151_0, arg_151_1, arg_151_2)
	local var_151_0 = SummerRaceData:GetOptionDefById(arg_151_2)

	if var_151_0 == nil then
		return false
	end

	SummerRaceData:ClearSlot(arg_151_0, arg_151_1, true)
	SummerRaceData:ClearSelectedModifySlot(true)
	SummerRaceData:SetSelectedOption(var_151_0.itemId, true)
	SummerRaceData:NotifyOutGameUpdated("slotDragBack")

	return true
end

function var_0_0.MoveEquippedSlotToSlot(arg_152_0, arg_152_1, arg_152_2, arg_152_3, arg_152_4)
	local var_152_0 = tonumber(arg_152_1) or 0
	local var_152_1 = tonumber(arg_152_3) or 0

	if arg_152_0 == arg_152_2 and var_152_0 == var_152_1 then
		return false
	end

	SummerRaceData:SetSelectedModifySlot(arg_152_2, var_152_1, true, false)
	SummerRaceData:AssignOptionToSlot(SummerRaceData:GetOptionDefById(arg_152_4).itemId, var_152_1, true)
	SummerRaceData:ClearSlot(arg_152_0, var_152_0, true)
	SummerRaceData:NotifyOutGameUpdated("slotMoveDrag")

	return true
end

function var_0_0.SelectIllustratedItem(arg_153_0)
	SummerRaceData:SetSelectedIllustratedItem(arg_153_0)
end

function var_0_0.ReceiveReward(arg_154_0)
	SummerRaceData:MarkRewardReceived(arg_154_0)
end

function var_0_0.ReceiveAllReward()
	local var_155_0 = SummerRaceData:GetRewardPageModel().rewardList or {}

	for iter_155_0 = 1, #var_155_0 do
		if var_155_0[iter_155_0].state == "canReceive" then
			SummerRaceData:MarkRewardReceived(var_155_0[iter_155_0].rewardId, true)
		end
	end

	SummerRaceData:NotifyOutGameUpdated("rewardReceiveAll")
end

function var_0_0.ConfirmModify(arg_156_0)
	if not var_0_43("ACTIVITY_TANK_COST_LIMMIT") then
		if type(arg_156_0) == "function" then
			arg_156_0(false)
		end

		return false
	end

	var_0_0.SubmitCurrentBuild(function(arg_157_0)
		if not arg_157_0 then
			if type(arg_156_0) == "function" then
				arg_156_0(false)
			end

			return
		end

		SummerRaceData:NotifyOutGameUpdated("modifyConfirm")

		if type(arg_156_0) == "function" then
			arg_156_0(true)
		end
	end)

	return true
end

function var_0_0.RefreshRedPoint()
	var_0_42()
	SummerRaceData:RefreshFrameworkRedPoints()
end

function var_0_0:OnSpecialDefeatTriggered()
	if type(self) ~= "table" then
		return
	end

	local var_159_0 = tonumber(self.token) or 0

	if var_159_0 <= 0 then
		return
	end

	local var_159_1 = var_0_7()

	if var_159_1 == nil then
		return
	end

	local var_159_2 = var_0_0
	local var_159_3 = {
		guideAccepted = false,
		guideWaitElapsed = 0,
		guideStarted = false,
		guideFinished = false,
		token = var_159_0
	}

	var_159_3.guideId = math.max(0, tonumber(self.guideId) or 0)
	var_159_3.enemyId = self.enemyId
	var_159_2.specialDefeatState_ = var_159_3

	SummerRaceData:SetGuideTriggerContext(SummerRaceConst.GUIDE_TRIGGER.CONTEXT_ENEMY_DEFEAT_BEFORE_FX, {
		token = var_159_0,
		stageId = self.stageId,
		wave = self.wave,
		enemyId = self.enemyId
	})
	manager.transition:OnlyShowEffect(true, function()
		var_0_39(true)

		if var_159_1.RequestNotifySpecialDefeatBlackoutFinished then
			var_159_1.RequestNotifySpecialDefeatBlackoutFinished(var_159_0)
		end

		manager.transition:OnlyShowEffect(false, function()
			var_0_0.StartSpecialDefeatGuideAfterBlackout(var_159_0, var_159_1)
		end)
	end)
end

function var_0_0.StartSpecialDefeatGuideAfterBlackout(arg_162_0, arg_162_1)
	if var_0_0.specialDefeatState_ == nil or var_0_0.specialDefeatState_.token ~= arg_162_0 or arg_162_1 == nil then
		return
	end

	var_0_0.specialDefeatState_.guideWaitElapsed = 0

	local var_162_0 = var_0_0.specialDefeatState_.guideId

	if var_0_0.specialDefeatState_.guideId <= 0 or var_0_0.IsEditorGuideDisabled() == true then
		SummerRaceData:ClearGuideTriggerContext(SummerRaceConst.GUIDE_TRIGGER.CONTEXT_ENEMY_DEFEAT_BEFORE_FX)

		if arg_162_1.RequestNotifySpecialDefeatGuideFinished then
			arg_162_1.RequestNotifySpecialDefeatGuideFinished(arg_162_0)
		end

		return
	end

	var_0_0.EnsureEnemyDefeatBeforeFxGuideChain(var_0_0.specialDefeatState_.enemyId)

	if manager.guide.Process then
		manager.guide:Process()
	end

	var_0_0.specialDefeatState_.guidePollTimer = Timer.New(function()
		local var_163_0 = var_0_0.specialDefeatState_

		if var_0_0.specialDefeatState_ == nil or var_163_0.token ~= arg_162_0 then
			return
		end

		var_163_0.guideWaitElapsed = var_163_0.guideWaitElapsed + 0.05

		if var_163_0.guideAccepted ~= true then
			var_163_0.guideAccepted = manager.guide:GetGuideIsOpen(var_162_0) == true

			if var_163_0.guideAccepted ~= true then
				if var_163_0.guideWaitElapsed < 5 then
					return
				end

				var_163_0.guideFinished = true
			end
		end

		local var_163_1, var_163_2 = manager.guide:IsPlaying()
		local var_163_3 = false

		if var_163_1 == true then
			local var_163_4 = var_0_0.GetEnemyDefeatBeforeFxGuideChain(var_163_0.enemyId)

			for iter_163_0 = 1, #var_163_4 do
				if var_0_0.NormalizeGuideTriggerId(var_163_2) == var_0_0.NormalizeGuideTriggerId(var_163_4[iter_163_0]) then
					var_163_3 = true

					break
				end
			end
		end

		if var_163_0.guideAccepted == true then
			if var_163_3 then
				var_163_0.guideStarted = true

				return
			end

			if var_0_0.HasPendingEnemyDefeatBeforeFxGuide(var_163_0.enemyId, var_163_0.guideStarted) then
				if var_163_0.guideWaitElapsed < 30 then
					if manager.guide.Process then
						manager.guide:Process()
					end

					return
				end
			elseif var_163_0.guideStarted == true then
				var_163_0.guideFinished = true
			else
				if var_163_0.guideWaitElapsed < 10 then
					return
				end

				var_163_0.guideFinished = true
			end
		end

		if var_163_0.guideFinished ~= true then
			if var_163_0.guideWaitElapsed < 10 then
				return
			end

			var_163_0.guideFinished = true
		end

		if var_163_0.guidePollTimer ~= nil then
			var_163_0.guidePollTimer:Stop()

			var_163_0.guidePollTimer = nil
		end

		SummerRaceData:ClearGuideTriggerContext(SummerRaceConst.GUIDE_TRIGGER.CONTEXT_ENEMY_DEFEAT_BEFORE_FX)

		if arg_162_1.RequestNotifySpecialDefeatGuideFinished then
			arg_162_1.RequestNotifySpecialDefeatGuideFinished(arg_162_0)
		end
	end, 0.05, -1)

	var_0_0.specialDefeatState_.guidePollTimer:Start()
end

function var_0_0:OnSpecialDefeatFinished()
	var_0_0.StopGuidePollState(var_0_0.specialDefeatState_)

	var_0_0.specialDefeatState_ = nil

	var_0_0.UpdateSummerRaceGuidePause()
	SummerRaceData:ClearGuideTriggerContext(SummerRaceConst.GUIDE_TRIGGER.CONTEXT_ENEMY_DEFEAT_BEFORE_FX)

	if type(self) == "table" then
		if (tostring(self.resumedPhase or "") or "") ~= "Result" then
			var_0_39(false)
		end
	end
end

function var_0_0:OnEnemyDefeatBeforeFxTriggered()
	if type(self) ~= "table" then
		return
	end

	if (tonumber(self.token) or 0) <= 0 then
		return
	end

	local var_165_0 = var_0_7()

	if var_165_0 == nil then
		return
	end

	if var_0_0.enemyDefeatGuideState_ ~= nil or type(var_0_0.enemyDefeatGuideQueue_) == "table" and #var_0_0.enemyDefeatGuideQueue_ > 0 then
		var_0_0.EnqueueEnemyDefeatGuidePayload(self)
		var_0_0.ProcessNextEnemyDefeatGuide()

		return
	end

	var_0_0.StartEnemyDefeatBeforeFxGuide(self, var_165_0)
end

function var_0_0:OnTimeoutResult()
	if type(self) ~= "table" then
		return
	end

	local var_166_0 = tostring(self.result or "")

	if var_166_0 ~= "win" and var_166_0 ~= "lose" then
		return
	end

	if var_0_5(var_166_0) then
		var_0_0.lastTimeoutResultShownAt_ = var_0_9()
		var_0_0.lastTimeoutResultType_ = var_166_0
	else
		var_0_0.lastTimeoutResultShownAt_ = nil
		var_0_0.lastTimeoutResultType_ = var_166_0
	end

	local var_166_1

	if var_0_0.timeoutResultTimer_ ~= nil then
		var_0_0.timeoutResultTimer_:Stop()

		var_0_0.timeoutResultTimer_ = nil
		var_166_1 = tonumber(self.delaySeconds) or var_0_3
	end

	var_0_0.timeoutResultTimer_ = Timer.New(function()
		if var_0_0.timeoutResultTimer_ ~= nil then
			var_0_0.timeoutResultTimer_:Stop()

			var_0_0.timeoutResultTimer_ = nil
		end

		var_0_5(nil)
	end, math.max(0, var_166_1), 1)

	var_0_0.timeoutResultTimer_:Start()
end

function var_0_0:OnBattleResultBanner()
	if type(self) ~= "table" then
		return
	end

	local var_168_0 = tostring(self.result or "")

	if var_168_0 ~= "win" and var_168_0 ~= "lose" then
		return
	end

	var_0_0.lastLoseBattleResultBannerShownAt_ = var_168_0 == "lose" and var_0_9() or nil

	var_0_6(var_168_0)

	local var_168_1

	if var_0_0.battleResultBannerTimer_ ~= nil then
		var_0_0.battleResultBannerTimer_:Stop()

		var_0_0.battleResultBannerTimer_ = nil
		var_168_1 = tonumber(self.delaySeconds) or var_0_4
	end

	var_0_0.battleResultBannerTimer_ = Timer.New(function()
		if var_0_0.battleResultBannerTimer_ ~= nil then
			var_0_0.battleResultBannerTimer_:Stop()

			var_0_0.battleResultBannerTimer_ = nil
		end

		var_0_6(nil)
	end, math.max(0, var_168_1), 1)

	var_0_0.battleResultBannerTimer_:Start()
end

function var_0_0:StartEnemyDefeatBeforeFxGuide(arg_170_1)
	if type(self) ~= "table" or arg_170_1 == nil then
		return
	end

	local var_170_0 = tonumber(self.token) or 0

	if var_170_0 <= 0 then
		return
	end

	var_0_0.enemyDefeatGuideState_ = {
		guideAccepted = false,
		guideWaitElapsed = 0,
		guideStarted = false,
		guideFinished = false,
		guideId = 0,
		token = var_170_0
	}

	SummerRaceData:SetGuideTriggerContext(SummerRaceConst.GUIDE_TRIGGER.CONTEXT_ENEMY_DEFEAT_BEFORE_FX, {
		token = var_170_0,
		stageId = self.stageId,
		wave = self.wave,
		enemyId = self.enemyId
	})

	local var_170_2 = var_0_0.ResolveEnemyDefeatBeforeFxGuideId(self.enemyId)

	var_0_0.enemyDefeatGuideState_.guideId = var_170_2

	if var_170_2 <= 0 then
		var_0_0.NotifyEnemyDefeatGuideFinished(var_170_0, arg_170_1)

		return
	end

	var_0_0.EnsureEnemyDefeatBeforeFxGuideChain(self.enemyId)

	if manager.guide.Process then
		manager.guide:Process()
	end

	var_0_0.enemyDefeatGuideState_.guidePollTimer = Timer.New(function()
		local var_171_0 = var_0_0.enemyDefeatGuideState_

		if var_0_0.enemyDefeatGuideState_ == nil or var_171_0.token ~= var_170_0 then
			return
		end

		var_171_0.guideWaitElapsed = var_171_0.guideWaitElapsed + 0.05

		if var_171_0.guideAccepted ~= true then
			var_171_0.guideAccepted = manager.guide:GetGuideIsOpen(var_170_2) == true

			if var_171_0.guideAccepted ~= true then
				if var_171_0.guideWaitElapsed < 5 then
					return
				end

				var_171_0.guideFinished = true
			end
		end

		local var_171_1, var_171_2 = manager.guide:IsPlaying()

		if var_171_0.guideAccepted == true then
			if var_171_1 == true and var_0_0.NormalizeGuideTriggerId(var_171_2) == var_0_0.NormalizeGuideTriggerId(var_170_2) then
				var_171_0.guideStarted = true

				return
			end

			if var_171_0.guideStarted == true then
				var_171_0.guideFinished = true
			elseif var_171_0.guideWaitElapsed < 10 then
				return
			else
				var_171_0.guideFinished = true
			end
		end

		if var_171_0.guideFinished ~= true then
			if var_171_0.guideWaitElapsed < 10 then
				return
			end

			var_171_0.guideFinished = true
		end

		var_0_0.NotifyEnemyDefeatGuideFinished(var_170_0, arg_170_1)
	end, 0.05, -1)

	var_0_0.enemyDefeatGuideState_.guidePollTimer:Start()
end

return var_0_0
