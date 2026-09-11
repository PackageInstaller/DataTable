local var_0_0 = singletonClass("TetrisGameRunTimeManager")
local var_0_1
local var_0_2
local var_0_3
local var_0_4

local function var_0_6(arg_1_0)
	var_0_1 = {}
	var_0_1.stageID = arg_1_0.stageID
	var_0_1.usedTime = 0
	var_0_1.totalTime = ActivityTetrisGameStageCfg[arg_1_0.stageID].time
	var_0_1.detlaTime = 0
	var_0_1.usedLogicRound = 0
	var_0_1.usedRound = 0
	var_0_1.finish_condition = ActivityTetrisGameStageCfg[arg_1_0.stageID].finish_condition
	var_0_1.finishType = ActivityTetrisGameStageCfg[arg_1_0.stageID].finish_type
	var_0_1.useChipCount = 0
	var_0_1.disposeNum = 0
	var_0_1.curBigRoundDisposeNum = 0
	var_0_1.totalScore = 0
	var_0_1.pauseGameFlag = false
	var_0_1.isGameEnd = false
	var_0_1.chargeNum = 0
	var_0_1.chargeNumMax = 0
	var_0_1.specialChipList = nil
	var_0_1.resultFlag = false
	var_0_1.specifyChipRound = 0
	var_0_1.scoreMaxFlag = false
	var_0_1.comboCount = 0
	var_0_1.comboTime = 0
	var_0_1.lockNowCDRound = 0
	var_0_1.lockRound = 0
	var_0_1.isUseLock = false
	var_0_1.useLockTimes = 0
	var_0_1.selectLockIndex = -1
	var_0_1.bubbleNoRemoveRound = 0
	var_0_1.isUseBubble = false
	var_0_1.isOpenCreateGoalChip = false
	var_0_1.goalRemainChargeValue = -1
	var_0_1.skillUseTimes = {}
	var_0_1.rateList = GameSetting.tetris_game_grade_rate.value

	return var_0_1
end

local function var_0_7(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		var_0_1.skillUseTimes[iter_2_1] = 0
	end
end

local function var_0_8(arg_3_0)
	var_0_1.skillUseTimes[arg_3_0] = not var_0_1.skillUseTimes[arg_3_0] and 1 or var_0_1.skillUseTimes[arg_3_0] + 1
end

local function var_0_9()
	var_0_2 = {}
	var_0_2.curRoundDisposeNum = 0
	var_0_2.placeCellNum = 0
	var_0_2.isDisposeTile = false
	var_0_2.chargeAddNum = 0
	var_0_2.addScore = 0
	var_0_2.disposeCellCount = 0
end

local function var_0_10()
	for iter_5_0 = #var_0_3[TetrisGameConst.skillType.combom].params1, 1, -1 do
		if var_0_1.comboCount >= var_0_3[TetrisGameConst.skillType.combom].params1[iter_5_0][1] - 1 then
			var_0_4.comboScoreRate = 1 + var_0_3[TetrisGameConst.skillType.combom].params1[iter_5_0][2]

			break
		end
	end
end

local function var_0_11()
	for iter_6_0 = #var_0_3[TetrisGameConst.skillType.charge].params1, 1, -1 do
		if var_0_1.chargeNum >= var_0_3[TetrisGameConst.skillType.charge].params1[iter_6_0][1] - 1 then
			var_0_4.accumulateScoreRate = 1 + var_0_3[TetrisGameConst.skillType.charge].params1[iter_6_0][2]

			break
		end
	end
end

local function var_0_12(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(ActivityTetrisGameSkillCfg.all) do
		if not arg_7_0[iter_7_1] and ActivityTetrisGameSkillCfg[iter_7_1].type == TetrisGameConst.skillUseType.default then
			arg_7_0[iter_7_1] = {
				active = true,
				params1 = ActivityTetrisGameSkillCfg[iter_7_1].params_1,
				params2 = ActivityTetrisGameSkillCfg[iter_7_1].params_2
			}
		end
	end

	if ActivityTetrisGameStageCfg[var_0_1.stageID].type == TetrisGameConst.stageType.endLess and not arg_7_0[TetrisGameConst.skillType.createGoalChip] then
		arg_7_0[TetrisGameConst.skillType.createGoalChip] = {
			active = true,
			params1 = ActivityTetrisGameSkillCfg[TetrisGameConst.skillType.createGoalChip].params_1,
			params2 = ActivityTetrisGameSkillCfg[TetrisGameConst.skillType.createGoalChip].params_2
		}
	end

	return arg_7_0
end

local function var_0_13(arg_8_0)
	local var_8_0

	if var_0_4 then
		var_8_0 = var_0_4.needSpecifyChip or false
	end

	var_0_4 = {}
	var_0_4 = {
		canLock = false,
		lockCDRound = 0,
		lockExistRound = 0,
		isTakeLock = false,
		accumulateScoreRate = 1,
		needSpecifyChip = false,
		chargeFlag = false,
		goalChargeNeedValue = 0,
		bubbleCDRoundValue = 0,
		comboScoreRate = 1,
		lockMaxTimes = 0,
		chargeTimer = false,
		scoreRateMax = 1,
		canRotate = false,
		isUseCreateGoalChip = false,
		quickScoreRate = 1,
		forceChangeChip = false
	}

	local var_8_1 = TetrisGameExchange.New()

	var_8_1.canRotate = false
	var_8_1.canCombom = false
	var_8_1.canCharge = false
	var_8_1.canCharge = false
	var_8_1.colorRemove = false
	var_8_1.skillSpecialChipID = -1
	var_8_1.bubbleColorIndex = -1
	var_0_3 = var_0_12(var_0_3)

	for iter_8_0, iter_8_1 in pairs(var_0_3) do
		if iter_8_0 == TetrisGameConst.skillType.rotate then
			var_8_1.canRotate = true
			var_0_4.canRotate = true
		elseif iter_8_0 == TetrisGameConst.skillType.placeRefreshChip then
			var_0_4.forceChangeChip = true
		elseif iter_8_0 == TetrisGameConst.skillType.constRefreshChip then
			if var_8_0 == true then
				TetrisGameBridge.RefreshAllWaitChip(true)
			end

			if var_0_1.usedRound > var_0_1.specifyChipRound and var_0_1.usedRound % var_0_3[iter_8_0].params1[1] == 0 then
				var_0_4.needSpecifyChip = true
				var_0_1.specialChipList = var_0_3[iter_8_0].params2
				var_0_1.specifyChipRound = var_0_1.usedRound
			else
				var_0_4.needSpecifyChip = false
				var_0_1.specialChipList = nil
			end
		elseif iter_8_0 == TetrisGameConst.skillType.scoreMax then
			var_0_4.quickScoreRate = var_0_4.quickScoreRate + var_0_3[iter_8_0].params1[2]

			if var_0_1.scoreMaxFlag == false and var_0_1.usedRound == 0 and var_0_1.usedLogicRound == 0 then
				var_0_1.usedTime = var_0_1.usedTime + var_0_3[iter_8_0].params1[1]
				var_0_1.scoreMaxFlag = true
			end
		elseif iter_8_0 == TetrisGameConst.skillType.charge then
			var_0_4.chargeFlag = true
			var_0_1.chargeNumMax = ActivityTetrisGameSkillCfg[iter_8_0].Params_3[1]
			var_0_4.scoreRateMax = var_0_4.scoreRateMax + var_0_3[iter_8_0].params1[math.min(var_0_1.chargeNumMax + 1, #var_0_3[iter_8_0].params1)][2]

			if var_0_2 then
				var_0_2.chargeAddNum = 1
			end

			var_8_1.canCharge = true

			var_0_11()
		elseif iter_8_0 == TetrisGameConst.skillType.combom then
			var_8_1.canCombom = true
			var_0_4.chargeFlag = true
			var_0_4.chargeTimer = true
			var_0_1.chargeNumMax = ActivityTetrisGameSkillCfg[iter_8_0].Params_3[1]
			var_0_4.scoreRateMax = var_0_4.scoreRateMax + var_0_3[iter_8_0].params1[math.min(var_0_1.chargeNumMax + 1, #var_0_3[iter_8_0].params1)][2]

			var_0_10()
		elseif iter_8_0 == TetrisGameConst.skillType.lock then
			var_0_4.isTakeLock = true
			var_0_4.canLock = true
			var_0_4.lockExistRound = var_0_3[iter_8_0].params1[1]
			var_0_4.lockMaxTimes = var_0_3[iter_8_0].params1[2]
			var_0_4.lockCDRound = var_0_3[iter_8_0].params1[3]

			if var_0_1.isUseLock then
				var_0_4.canLock = false
			elseif var_0_1.lockNowCDRound < var_0_4.lockCDRound and var_0_1.useLockTimes < var_0_4.lockMaxTimes then
				var_0_4.canLock = false
			end
		elseif iter_8_0 == TetrisGameConst.skillType.bubble then
			var_0_4.bubbleCDRoundValue = var_0_3[iter_8_0].params1[1]

			if var_0_1.isUseLock == false and var_0_1.bubbleNoRemoveRound ~= 0 and var_0_1.bubbleNoRemoveRound % var_0_4.bubbleCDRoundValue == 0 then
				var_8_1.skillSpecialChipID = var_0_3[iter_8_0].params2[1]
				var_8_1.bubbleChipPosIndex = var_0_3[iter_8_0].params2[2]
				var_8_1.bubbleColorIndex = var_0_3[iter_8_0].params2[3]
				var_0_1.isUseBubble = true
			end
		elseif iter_8_0 == TetrisGameConst.skillType.colorRemove then
			var_8_1.colorRemove = true
		elseif iter_8_0 == TetrisGameConst.skillType.createGoalChip then
			var_0_4.isUseCreateGoalChip = true
			var_0_4.goalChargeNeedValue = var_0_3[iter_8_0].params2[1]

			if var_0_1.usedRound == 0 and var_0_1.usedLogicRound == 0 then
				var_0_1.goalRemainChargeValue = var_0_3[iter_8_0].params2[1]
			end

			if var_0_1.isOpenCreateGoalChip then
				var_0_4.needSpecifyChip = true
				var_0_1.specialChipList = var_0_3[iter_8_0].params1
				var_0_1.goalRemainChargeValue = var_0_3[iter_8_0].params2[1]
			else
				var_0_4.needSpecifyChip = false
				var_0_1.specialChipList = nil
			end
		end
	end

	TetrisGameBridge.SetSkillInfo(var_8_1)
end

local function var_0_14()
	var_0_3 = {}

	for iter_9_0, iter_9_1 in ipairs(ActivityTetrisGameStageCfg[var_0_1.stageID].type == TetrisGameConst.stageType.endLess and TetrisGameData:GetSkillList() or ActivityTetrisGameStageCfg[var_0_1.stageID].skill_list) do
		var_0_3[iter_9_1] = {
			active = true,
			params1 = ActivityTetrisGameSkillCfg[iter_9_1].params_1,
			params2 = ActivityTetrisGameSkillCfg[iter_9_1].params_2
		}
	end

	var_0_13()

	return var_0_3, var_0_4
end

local function var_0_15()
	return var_0_4.quickScoreRate * (1 + (var_0_4.comboScoreRate - 1) + (var_0_4.accumulateScoreRate - 1)), var_0_4.scoreRateMax
end

local function var_0_16(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0 = math.min(arg_11_0, 6)

	return (arg_11_1 * (arg_11_1 * arg_11_2[3] + arg_11_2[4]) * 2 + arg_11_0 * (arg_11_0 * arg_11_2[1] + arg_11_2[2]) * 10) * var_0_15()
end

local function var_0_17()
	local var_12_1 = var_0_2.placeCellNum + ((var_0_2.curRoundDisposeNum > 0 or nil) and var_0_16(var_0_2.curRoundDisposeNum, var_0_2.disposeCellCount, var_0_1.rateList))

	var_0_2.addScore = var_0_2.placeCellNum + ((var_0_2.curRoundDisposeNum > 0 or nil) and var_0_16(var_0_2.curRoundDisposeNum, var_0_2.disposeCellCount, var_0_1.rateList))
	var_0_1.totalScore = var_0_1.totalScore + var_12_1
end

local function var_0_18()
	for iter_13_0, iter_13_1 in pairs(var_0_3) do
		if iter_13_0 == TetrisGameConst.skillType.combom and var_0_2.isDisposeTile then
			var_0_1.comboCount = var_0_1.comboCount + 1

			var_0_10()
			manager.notify:CallUpdateFunc(TETRIS_GAME_COMBO_TIME_UPDATE)
		end
	end
end

local function var_0_19()
	if var_0_4.chargeFlag and not var_0_4.chargeTimer then
		if not var_0_1.isOpenCreateGoalChip then
			var_0_1.chargeNum = math.min(var_0_1.chargeNum + var_0_2.chargeAddNum, var_0_1.chargeNumMax)
		end

		var_0_11()
	end

	if var_0_2.curRoundDisposeNum > 0 then
		var_0_1.chargeNum = 0

		if var_0_4.chargeFlag and not var_0_4.chargeTimer then
			var_0_11()
		end
	end

	var_0_18()
end

local function var_0_20()
	if TetrisGameBridge.CheckNeedRefreshAllWaitChip() or var_0_4.forceChangeChip then
		if var_0_1.selectLockIndex > 0 then
			var_0_1.isUseLock = true
		end

		if var_0_1.isUseLock then
			if var_0_1.lockRound == 0 then
				var_0_8(TetrisGameConst.skillType.lock)

				var_0_1.lockNowCDRound = 0
				var_0_1.useLockTimes = var_0_1.useLockTimes + 1
			elseif var_0_1.lockRound == var_0_4.lockExistRound then
				var_0_1.lockRound = 0
				var_0_1.selectLockIndex = -1

				TetrisGameBridge.SetLockChip(-1)

				var_0_1.isUseLock = false

				return
			end

			var_0_1.lockRound = var_0_1.lockRound + 1
		else
			var_0_1.lockNowCDRound = var_0_1.lockNowCDRound + 1
		end
	end
end

local function var_0_21(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0 > 0 then
		var_0_2.isDisposeTile = true
	end

	var_0_1.disposeNum = var_0_1.disposeNum + arg_16_0
	var_0_2.placeCellNum = arg_16_1
	var_0_2.curRoundDisposeNum = arg_16_0
	var_0_2.disposeCellCount = arg_16_2
	var_0_1.curBigRoundDisposeNum = var_0_1.curBigRoundDisposeNum + arg_16_0
	var_0_1.usedLogicRound = var_0_1.usedLogicRound + 1
	var_0_1.useChipCount = var_0_1.useChipCount + 1

	if TetrisGameBridge.CheckNeedRefreshAllWaitChip() or var_0_4.forceChangeChip then
		var_0_1.usedRound = var_0_1.usedRound + 1
		var_0_1.isUseBubble = false

		if var_0_1.curBigRoundDisposeNum == 0 and var_0_1.isUseLock == false then
			var_0_1.bubbleNoRemoveRound = var_0_1.bubbleNoRemoveRound + 1
		end

		var_0_1.curBigRoundDisposeNum = 0
	end

	if arg_16_0 > 0 then
		var_0_1.bubbleNoRemoveRound = 0
	end

	if var_0_4.isUseCreateGoalChip then
		if arg_16_1 > 0 and var_0_1.isOpenCreateGoalChip == false then
			var_0_1.goalRemainChargeValue = math.max(var_0_1.goalRemainChargeValue - 1, 0)
		end

		if arg_16_0 > 0 and var_0_1.isOpenCreateGoalChip == true then
			var_0_1.isOpenCreateGoalChip = false
		end
	end

	var_0_20()
end

local function var_0_22()
	var_0_2 = nil
end

local function var_0_23()
	if var_0_4.needSpecifyChip and var_0_1.specialChipList and not var_0_1.isUseLock then
		if var_0_1.isOpenCreateGoalChip then
			if var_0_4.forceChangeChip then
				TetrisGameBridge.RefreshSpecificChip(var_0_1.specialChipList)
			elseif TetrisGameBridge.CheckNeedRefreshAllWaitChip() then
				TetrisGameBridge.RefreshSpecificChip(var_0_1.specialChipList)
			end
		else
			TetrisGameBridge.RefreshSpecificChip(var_0_1.specialChipList)
		end
	else
		TetrisGameBridge.RefreshAllWaitChip(var_0_4.forceChangeChip)
	end
end

local function var_0_24()
	var_0_1.isOpenCreateGoalChip = true
	var_0_1.goalRemainChargeValue = var_0_3[TetrisGameConst.skillType.createGoalChip].params2[1]
	var_0_1.chargeNum = var_0_1.chargeNumMax + var_0_3[TetrisGameConst.skillType.createGoalChip].params2[2]

	var_0_11()
end

function var_0_0.Init(arg_20_0, arg_20_1, arg_20_2)
	var_0_1 = var_0_6(arg_20_1)

	TetrisGameBridge.StartGame(var_0_1.stageID, arg_20_2, 3)

	arg_20_0.stageCfg = ActivityTetrisGameStageCfg[var_0_1.stageID]
	var_0_3, var_0_4 = var_0_14()

	var_0_0:PauseGame(true)
	manager.notify:Invoke(TETRIS_GAME_START_GAME)
end

function var_0_0.StartGame(arg_21_0)
	if var_0_1.stageID then
		var_0_0:PauseGame(false)
		var_0_0:StartGameTimeTimer()
		var_0_0:StartLogicRound()
	end
end

function var_0_0:CheckIsRoundOrChipEndGame()
	if var_0_1.finishType == TetrisGameConst.finishType.round and self.stageCfg.finish_condition > 0 and var_0_1.usedRound >= self.stageCfg.finish_condition then
		return true
	end

	if var_0_1.finishType == TetrisGameConst.finishType.chipCount and self.stageCfg.finish_condition > 0 and var_0_1.useChipCount >= self.stageCfg.finish_condition then
		return true
	end

	return false
end

function var_0_0:StartLogicRound()
	if self:CheckIsRoundOrChipEndGame() then
		var_0_0:EndGame()

		return
	end

	var_0_9()
	var_0_14()
	var_0_23()

	if not TetrisGameBridge.CheckCanPlaceWaitChip() then
		var_0_0:EndGame()
		ShowTips("ACTIVITY_TETRIS_GAME_CHIP_END")
	end
end

function var_0_0.EndLogicRound(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0.isNowRoundEnd_ = true

	var_0_21(arg_24_1, arg_24_2, arg_24_3)
	var_0_17()
	var_0_19()
	manager.notify:Invoke(TETRIS_GAME_ROUND_END, var_0_1)
	var_0_22()
	var_0_0:StartLogicRound()
end

function var_0_0.PauseGame(arg_25_0, arg_25_1)
	var_0_1.pauseGameFlag = arg_25_1

	TetrisGameBridge.PauseGame(arg_25_1)
end

function var_0_0:Updata()
	if self.startTime == nil then
		self.startTime = Time.realtimeSinceStartup
	end

	if not var_0_1.pauseGameFlag then
		var_0_1.detlaTime = var_0_1.detlaTime + (Time.realtimeSinceStartup - self.startTime)

		if var_0_1.detlaTime >= 1 then
			var_0_1.usedTime = var_0_1.usedTime + var_0_1.detlaTime
			var_0_1.detlaTime = 0

			manager.notify:Invoke(TETRIS_GAME_TIMER_UPDATE, var_0_1.usedTime)

			if ActivityTetrisGameStageCfg[var_0_1.stageID].time > 0 and ActivityTetrisGameStageCfg[var_0_1.stageID].time - var_0_1.usedTime <= 0 then
				var_0_0:EndGame()
			end
		end
	end

	self.startTime = Time.realtimeSinceStartup
end

function var_0_0:EndGame(arg_27_1, arg_27_2, arg_27_3)
	var_0_0:PauseGame(true)
	var_0_0:StopTimer()

	local var_27_0 = TetrisGameData:GetCurActivityID()
	local var_27_1

	if self:CheckIsRoundOrChipEndGame() then
		var_27_1 = 1
		var_0_1.resultFlag = true
	else
		var_27_1 = 0
		var_0_1.resultFlag = false
	end

	local var_27_2 = {
		stageID = var_0_1.stageID,
		score = var_0_1.totalScore,
		useTime = var_0_1.usedTime,
		result = var_27_1,
		battle_times = var_0_1.usedRound
	}

	var_0_1.isGameEnd = true

	local var_27_3 = false
	local var_27_4 = TetrisGameData:GetStageInfoByStageID(var_0_1.stageID)

	if var_27_4 and var_27_4.isClear == false and var_27_1 == 1 then
		var_27_3 = true
	end

	if not arg_27_1 then
		TetrisGameAction:AskClearStage(var_27_0, var_27_2, function()
			manager.notify:CallUpdateFunc(TETRIS_GAME_GAME_END, arg_27_3, var_27_3)
		end, arg_27_2 and not arg_27_1)
	end
end

function var_0_0.ExitGame(arg_29_0)
	var_0_0:StopTimer()
	var_0_0:Dispose()
end

function var_0_0.Dispose(arg_30_0)
	var_0_1 = nil
	var_0_4 = nil

	TetrisGameBridge.ExitGame()
	var_0_0:StopTimer()
end

function var_0_0:StartGameTimeTimer()
	self:StopTimer()

	self.startTime = Time.realtimeSinceStartup
	self.timer = FrameTimer.New(function()
		var_0_0:Updata()
	end, 1, -1)

	self.timer:Start()
end

function var_0_0:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function var_0_0.RotateChip(arg_34_0, arg_34_1)
	if arg_34_1 then
		TetrisGameBridge.RotateChip(arg_34_1)
	end
end

function var_0_0.SetMachineInfoState(arg_35_0, arg_35_1)
	TetrisGameBridge.SetMachineInfoState(arg_35_1)
end

function var_0_0.UpdateComboScoreRateCompute(arg_36_0)
	var_0_10()
end

function var_0_0.UseCreateGoalChip(arg_37_0)
	var_0_24()
	var_0_8(TetrisGameConst.skillType.createGoalChip)
end

function var_0_0.RecordSkillUse(arg_38_0, arg_38_1)
	var_0_8(arg_38_1)
end

function var_0_0.InitRecordSkillUse(arg_39_0, arg_39_1)
	var_0_7(arg_39_1)
end

function var_0_0.GetBlackBoard(arg_40_0)
	return var_0_1
end

function var_0_0.GetSkillEffectBlackBoard(arg_41_0)
	return var_0_4
end

function var_0_0.GetSkillBlackBoard(arg_42_0)
	return var_0_3
end

function var_0_0.GetCurRoundBoard(arg_43_0)
	return var_0_2
end

function var_0_0.GetCurScoreRate(arg_44_0)
	return var_0_15()
end

function var_0_0.CalculateDisposeScore(arg_45_0, arg_45_1)
	return var_0_16(arg_45_1)
end

function var_0_0.GetSkillCD(arg_46_0, arg_46_1)
	if arg_46_1 ~= TetrisGameConst.skillType.bubble and arg_46_1 ~= TetrisGameConst.skillType.lock and arg_46_1 ~= TetrisGameConst.skillType.createGoalChip then
		return nil
	end

	if arg_46_1 == TetrisGameConst.skillType.lock then
		return math.max(var_0_4.lockCDRound - var_0_1.lockNowCDRound, 0)
	end

	if arg_46_1 == TetrisGameConst.skillType.bubble then
		return var_0_4.bubbleCDRoundValue - var_0_1.bubbleNoRemoveRound % var_0_4.bubbleCDRoundValue
	end

	if arg_46_1 == TetrisGameConst.skillType.createGoalChip then
		return var_0_1.goalRemainChargeValue
	end
end

function var_0_0.GetBublleIsUse(arg_47_0)
	return var_0_1 and var_0_1.isUseBubble
end

function var_0_0.GetLockIsCanUse(arg_48_0)
	return var_0_1 and var_0_1.lockNowCDRound >= var_0_4.lockCDRound
end

function var_0_0.GetIsLockCube(arg_49_0)
	return var_0_1 and var_0_1.isUseLock
end

function var_0_0.IsSkillEnough(arg_50_0)
	return var_0_1 and var_0_1.goalRemainChargeValue == 0
end

function var_0_0:GetIsEndNowRound()
	self.isNowRoundEnd_ = false

	return self.isNowRoundEnd_
end

function var_0_0.SetTetrisPos(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = TetrisGameGuideInfo.New()

	var_52_0.isGuide = true
	var_52_0.putInX = arg_52_1
	var_52_0.putInY = arg_52_2

	TetrisGameBridge.SetGuideInfo(var_52_0)
end

return var_0_0
