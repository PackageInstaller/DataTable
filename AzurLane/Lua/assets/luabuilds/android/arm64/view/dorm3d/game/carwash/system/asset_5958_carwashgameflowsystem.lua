class = var_0_10000

local var_0_0 = "CarWashGameFlowSystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_1.START_GAME = "CarWashGameFlowSystem.START_GAME"
var_0_1.REQUEST_RESTART_GAME = "CarWashGameFlowSystem.REQUEST_RESTART_GAME"
var_0_1.MODIFY_GAME_STATUS = "CarWashGameFlowSystem.MODIFY_GAME_STATUS"
var_0_1.UPDATE_GAME_STATE = "CarWashGameFlowSystem.UPDATE_GAME_STATE"
var_0_1.UPDATE_IS_SHOOTING = "CarWashGameFlowSystem.UPDATE_IS_SHOOTING"
var_0_1.UPDATE_CURRENT_GUN_TYPE = "CarWashGameFlowSystem.UPDATE_CURRENT_GUN_TYPE"
var_0_1.UPDATE_HEART_BEAT_VALUE = "CarWashGameFlowSystem.UPDATE_HEART_BEAT_VALUE"
var_0_1.UPDATE_LADY_POS = "CarWashGameFlowSystem.UPDATE_LADY_POS"
var_0_1.UPDATE_STAINS_COUNT_MAX = "CarWashGameFlowSystem.UPDATE_STAINS_COUNT_MAX"
var_0_1.UPDATE_STAINS_COUNT = "CarWashGameFlowSystem.UPDATE_STAINS_COUNT"
var_0_1.UPDATE_COUNTDOWN = "CarWashGameFlowSystem.UPDATE_COUNTDOWN"
var_0_1.SWITCH_SHOOTING = "CarWashGameFlowSystem.SWITCH_SHOOTING"
var_0_1.SWITCH_GUN_TYPE = "CarWashGameFlowSystem.SWITCH_GUN_TYPE"
var_0_1.SWITCH_LADY_POS = "CarWashGameFlowSystem.SWITCH_LADY_POS"
var_0_1.SWITCH_STATE = "CarWashGameFlowSystem.SWITCH_STATE"
var_0_1.SET_STAINS_COUNT_MAX = "CarWashGameFlowSystem.SET_STAINS_COUNT_MAX"
var_0_1.SET_STAINS_COUNT = "CarWashGameFlowSystem.SET_STAINS_COUNT"
var_0_1.DECREASE_STAINS_COUNT = "CarWashGameFlowSystem.DECREASE_STAINS_COUNT"
var_0_1.MODIFY_HEART_BEAT_VALUE = "CarWashGameFlowSystem.MODIFY_HEART_BEAT_VALUE"
var_0_1.PLAY_PHASE2_REACTION = "CarWashGameFlowSystem.PLAY_PHASE2_REACTION"
var_0_1.TRIGGER_HIDDEN_REACTION = "CarWashGameFlowSystem.TRIGGER_HIDDEN_REACTION"
var_0_1.UPDATE_PHASE2_REACTION_PROGRESS = "CarWashGameFlowSystem.UPDATE_PHASE2_REACTION_PROGRESS"

function var_0_1.OnInit(arg_1_0)
	arg_1_0.contextData = arg_1_0:GetContextData()
	arg_1_0.phase2ClickedTips = {}
	arg_1_0.isPhaseTransitioning = false
	arg_1_0.remainingTime = 0
	arg_1_0.lastCountdownSeconds = nil
	arg_1_0.isEnding = false
	arg_1_0.isTimelineSequencePlaying = false
	arg_1_0.isTransitionPlaying = false

	arg_1_0:InitGameStatus()

	return
end

function var_0_1.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_1.START_GAME, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.StartGame(var_3_0, arg_3_1)

		return
	end)
	arg_2_0:Bind(var_0_1.REQUEST_RESTART_GAME, function(arg_4_0)
		local var_4_0 = arg_2_0

		var_1.RestartGame(var_4_0)

		return
	end)
	arg_2_0:Bind(var_0_1.MODIFY_GAME_STATUS, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_2_0

		var_3.UpdateGameStatus(var_5_0, arg_5_1, arg_5_2)

		return
	end)
	arg_2_0:Bind(var_0_1.SWITCH_SHOOTING, function(arg_6_0)
		local var_6_0 = arg_2_0

		var_1.SetShooting(var_6_0, not arg_2_0.contextData.gameStatus.isShooting)

		return
	end)
	arg_2_0:Bind(var_0_1.SWITCH_GUN_TYPE, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_2_0

		var_2.SetCurrentGunType(var_7_0, arg_7_1)

		return
	end)
	arg_2_0:Bind(var_0_1.SWITCH_LADY_POS, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_2_0
		local var_8_1 = var_2.SetLadyPos

		pg = var_2_10005

		var_8_1(var_8_0, var_2_10005.dorm3d_carwash_pos[arg_8_1])

		return
	end)
	arg_2_0:Bind(var_0_1.SWITCH_STATE, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_2_0

		var_2.SetGameState(var_9_0, arg_9_1)

		return
	end)
	arg_2_0:Bind(var_0_1.SET_STAINS_COUNT_MAX, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_2_0

		var_2.SetStainsCountMax(var_10_0, arg_10_1)

		return
	end)
	arg_2_0:Bind(var_0_1.SET_STAINS_COUNT, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_2_0

		var_2.SetStainsCount(var_11_0, arg_11_1)

		return
	end)
	arg_2_0:Bind(var_0_1.DECREASE_STAINS_COUNT, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_2_0

		var_2.DecreaseStainsCount(var_12_0, arg_12_1)

		return
	end)
	arg_2_0:Bind(var_0_1.MODIFY_HEART_BEAT_VALUE, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_2_0

		var_2.ModifyHeartBeatValue(var_13_0, arg_13_1)

		return
	end)
	arg_2_0:Bind(var_0_1.PLAY_PHASE2_REACTION, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_2_0

		var_2.PlayPhase2Reaction(var_14_0, arg_14_1)

		return
	end)
	arg_2_0:Bind(var_0_1.TRIGGER_HIDDEN_REACTION, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_2_0

		var_2.TriggerHiddenReaction(var_15_0, arg_15_1)

		return
	end)

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.Bind

	CarWashTimelineSystem = var_4

	var_2_1(var_2_0, var_4.TIMELINE_SEQUENCE_BEGIN, function(arg_16_0, arg_16_1)
		arg_2_0.isTimelineSequencePlaying = true

		return
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.Bind

	CarWashTimelineSystem = var_4

	var_2_3(var_2_2, var_4.TIMELINE_SEQUENCE_END, function(arg_17_0, arg_17_1)
		arg_2_0.isTimelineSequencePlaying = false

		return
	end)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.Bind

	CarWashTimelineSystem = var_4

	var_2_5(var_2_4, var_4.TRANSITION_BEGIN, function(arg_18_0, arg_18_1)
		arg_2_0.isTransitionPlaying = true

		return
	end)

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.Bind

	CarWashTimelineSystem = var_4

	var_2_7(var_2_6, var_4.TRANSITION_END, function(arg_19_0, arg_19_1)
		arg_2_0.isTransitionPlaying = false

		return
	end)

	return
end

function var_0_1.OnDispose(arg_20_0)
	arg_20_0.contextData = nil
	arg_20_0.phase1LadyPosCache = nil
	arg_20_0.phase2ClickedTips = nil
	arg_20_0.isPhaseTransitioning = nil
	arg_20_0.remainingTime = nil
	arg_20_0.lastCountdownSeconds = nil
	arg_20_0.isEnding = nil
	arg_20_0.isTimelineSequencePlaying = nil
	arg_20_0.isTransitionPlaying = nil

	return
end

function var_0_1.InitGameStatus(arg_21_0)
	local var_21_0 = arg_21_0.contextData

	pg = var_1_10002
	var_21_0.gameConfig = var_1_10002.dorm3d_carwash[arg_21_0.contextData.groupId]

	local var_21_1 = arg_21_0.contextData
	local var_21_2 = {
		stainsCount = 0,
		stainsCountMax = 0,
		isShooting = false,
		heartBeatValue = 0
	}

	CarWashConst = var_3
	var_21_2.currentState = var_3.GAME_STATE.NONE
	var_21_1.gameStatus = var_21_2

	return
end

function var_0_1.StartGame(arg_22_0, arg_22_1)
	arg_22_0:ResetRuntimeState()

	seriesAsync = var_2

	var_2({
		function(arg_23_0)
			local var_23_0 = arg_22_0
			local var_23_1 = var_1.SetCurrentGunType

			CarWashConst = var_2_10004

			var_23_1(var_23_0, var_2_10004.GUN_TYPE.WASHER)

			local var_23_2 = arg_22_0
			local var_23_3 = var_1.SetLadyPos

			pg = var_4

			var_23_3(var_23_2, var_4.dorm3d_carwash_pos[arg_22_0.contextData.gameConfig.pos[1]])

			local var_23_4 = arg_22_0
			local var_23_5 = var_1.Emit

			CarWashDecalSystem = var_4

			var_23_5(var_23_4, var_4.GENERATE_DECALS)
			arg_23_0()

			return
		end,
		function(arg_24_0)
			PlayerPrefs = var_2_10001

			if var_2_10001.GetInt("CarWashGuideShown", 0) == 0 then
				PlayerPrefs = var_1

				var_1.SetInt("CarWashGuideShown", 1)

				local var_24_0 = arg_22_0
				local var_24_1 = var_1.Emit

				CarWashMainPage = var_4

				var_24_1(var_24_0, var_4.SHOW_HELP_BOX, arg_24_0)
			else
				arg_24_0()
			end

			return
		end,
		function(arg_25_0)
			local var_25_0 = arg_22_0
			local var_25_1 = var_1.SetGameState

			CarWashConst = var_2_10004

			var_25_1(var_25_0, var_2_10004.GAME_STATE.PHASE_1)
			arg_25_0()

			return
		end
	}, function()
		existCall = var_2_10000

		var_2_10000(arg_22_1)

		return
	end)

	return
end

function var_0_1.ResetRuntimeState(arg_27_0)
	arg_27_0.phase1LadyPosCache = nil
	arg_27_0.phase2ClickedTips = {}
	arg_27_0.isPhaseTransitioning = false
	arg_27_0.isEnding = false
	arg_27_0.isTimelineSequencePlaying = false
	arg_27_0.isTransitionPlaying = false
	CarWashConst = var_1
	arg_27_0.remainingTime = var_1.GAME_DURATION
	arg_27_0.lastCountdownSeconds = nil

	arg_27_0:EmitCountdown()

	return
end

function var_0_1.OnUpdate(arg_28_0, arg_28_1)
	arg_28_0:UpdateCountdown(arg_28_1)

	return
end

function var_0_1.IsCountdownRunning(arg_29_0)
	if arg_29_0.isEnding then
		return false
	end

	if arg_29_0.isPhaseTransitioning then
		return false
	end

	if arg_29_0.isTimelineSequencePlaying then
		return false
	end

	if arg_29_0.isTransitionPlaying then
		return false
	end

	local var_29_0 = arg_29_0.contextData.gameStatus.currentState

	CarWashConst = var_1_10002

	return var_29_0 == var_1_10002.GAME_STATE.PHASE_1
end

function var_0_1.UpdateCountdown(arg_30_0, arg_30_1)
	if not arg_30_0:IsCountdownRunning() then
		return
	end

	math = var_2
	arg_30_0.remainingTime = var_2.max(arg_30_0.remainingTime - arg_30_1, 0)

	arg_30_0:EmitCountdown()

	if arg_30_0.remainingTime <= 0 then
		arg_30_0:FinishGame()
	end

	return
end

function var_0_1.EmitCountdown(arg_31_0)
	math = var_1_10001

	local var_31_0 = var_1_10001.max

	math = var_1_10003

	local var_31_1 = var_1_10003.ceil
	local var_31_2

	if not arg_31_0.remainingTime then
		var_31_2 = 0
	end

	local var_31_3 = var_31_0(var_31_1(var_31_2), 0)

	if arg_31_0.lastCountdownSeconds == var_31_3 then
		return
	end

	arg_31_0.lastCountdownSeconds = var_31_3

	arg_31_0:Emit(var_0_1.UPDATE_COUNTDOWN, {
		remainingSeconds = var_31_3
	})

	return
end

function var_0_1.GetGameStatusEventName(arg_32_0, arg_32_1)
	switch = var_1_10002

	return var_1_10002(arg_32_1, {
		currentState = function()
			return var_0_1.UPDATE_GAME_STATE
		end,
		isShooting = function()
			return var_0_1.UPDATE_IS_SHOOTING
		end,
		currentGunType = function()
			return var_0_1.UPDATE_CURRENT_GUN_TYPE
		end,
		heartBeatValue = function()
			return var_0_1.UPDATE_HEART_BEAT_VALUE
		end,
		ladyPos = function()
			return var_0_1.UPDATE_LADY_POS
		end,
		stainsCountMax = function()
			return var_0_1.UPDATE_STAINS_COUNT_MAX
		end,
		stainsCount = function()
			return var_0_1.UPDATE_STAINS_COUNT
		end
	})
end

function var_0_1.UpdateGameStatus(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0:GetGameStatusEventName(arg_40_1)

	assert = var_1_10004

	local var_40_1 = var_40_0
	local var_40_2 = "CarWash gameStatus key not found: "

	tostring = var_1_10008

	var_1_10004(var_40_1, var_40_2 .. var_1_10008(arg_40_1))

	local var_40_3 = arg_40_0.contextData.gameStatus[arg_40_1]

	arg_40_0.contextData.gameStatus[arg_40_1] = arg_40_2

	arg_40_0:Emit(var_40_0, {
		key = arg_40_1,
		oldValue = var_40_3,
		newValue = arg_40_2
	})

	return
end

function var_0_1.SetGameState(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.contextData.gameStatus.currentState

	CarWashConst = var_1_10003

	local var_41_2

	if arg_41_1 == var_1_10003.GAME_STATE.PHASE_2 then
		CarWashConst = var_41_2

		if var_41_0 ~= var_41_2.GAME_STATE.PHASE_2 then
			arg_41_0.phase1LadyPosCache = arg_41_0.contextData.gameStatus.ladyPos

			arg_41_0:ResetPhase2Progress()

			local var_41_1 = arg_41_0

			var_41_2 = arg_41_0.SetLadyPos
			pg = var_1_10006

			var_41_2(var_41_1, var_1_10006.dorm3d_carwash_pos[arg_41_0.contextData.gameConfig.pos_phase2])

			goto label_41_0
		end
	end

	CarWashConst = var_41_2

	if arg_41_1 == var_41_2.GAME_STATE.PHASE_1 and arg_41_0.phase1LadyPosCache then
		arg_41_0:SetLadyPos(arg_41_0.phase1LadyPosCache)

		arg_41_0.phase1LadyPosCache = nil

		arg_41_0:ResetPhase2Progress()
	else
		CarWashConst = var_3

		if arg_41_1 == var_3.GAME_STATE.END then
			arg_41_0:SetShooting(false)
		end
	end

	::label_41_0::

	arg_41_0:UpdateGameStatus("currentState", arg_41_1)

	return
end

function var_0_1.SetShooting(arg_42_0, arg_42_1)
	arg_42_0:UpdateGameStatus("isShooting", arg_42_1)

	return
end

function var_0_1.SetCurrentGunType(arg_43_0, arg_43_1)
	arg_43_0:UpdateGameStatus("currentGunType", arg_43_1)

	return
end

function var_0_1.ModifyHeartBeatValue(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0.contextData.gameStatus.heartBeatValue

	math = var_1_10003

	local var_44_1 = var_1_10003.max

	math = var_1_10005

	local var_44_2 = var_44_1(var_1_10005.min(var_44_0 + arg_44_1, 100), 0)

	arg_44_0:SetHeartBeatValue(var_44_2)

	return
end

function var_0_1.SetHeartBeatValue(arg_45_0, arg_45_1)
	arg_45_0:UpdateGameStatus("heartBeatValue", arg_45_1)
	arg_45_0:TryEnterPhase2ByHeartBeat(arg_45_1)

	return
end

function var_0_1.TryEnterPhase2ByHeartBeat(arg_46_0, arg_46_1)
	pg = var_1_10002

	if not var_1_10002.dorm3d_carwash_pos[arg_46_0.contextData.gameConfig.pos_phase2] then
		return
	end

	if arg_46_1 < var_2.mood_value then
		return
	end

	local var_46_0 = arg_46_0.contextData.gameStatus.currentState

	CarWashConst = var_1_10004

	if var_46_0 == var_1_10004.GAME_STATE.PHASE_2 then
		return
	end

	if arg_46_0.isPhaseTransitioning then
		return
	end

	arg_46_0:EnterPhase2WithTransition()

	return
end

function var_0_1.EnterPhase2WithTransition(arg_47_0)
	arg_47_0.isPhaseTransitioning = true

	local var_47_0 = arg_47_0
	local var_47_1 = arg_47_0.Emit

	CarWashTimelineSystem = var_1_10004

	local var_47_2 = var_1_10004.PLAY_TRANSITION
	local var_47_3 = {
		waitHold = true
	}

	CarWashTimelineSystem = var_1_10006
	var_47_3.type = var_1_10006.TRANSITION.WHITE

	function var_47_3.onHold(arg_48_0, arg_48_1)
		local var_48_0 = arg_47_0
		local var_48_1 = var_2.SetGameState

		CarWashConst = var_2_10005

		var_48_1(var_48_0, var_2_10005.GAME_STATE.PHASE_2)
		arg_48_0()

		return
	end

	function var_47_3.onFinish(arg_49_0)
		arg_47_0.isPhaseTransitioning = false

		return
	end

	var_47_1(var_47_0, var_47_2, var_47_3)

	return
end

function var_0_1.SetLadyPos(arg_50_0, arg_50_1)
	arg_50_0:UpdateGameStatus("ladyPos", arg_50_1)

	return
end

function var_0_1.SetStainsCountMax(arg_51_0, arg_51_1)
	arg_51_0:UpdateGameStatus("stainsCountMax", arg_51_1)

	return
end

function var_0_1.SetStainsCount(arg_52_0, arg_52_1)
	arg_52_0:UpdateGameStatus("stainsCount", arg_52_1)

	warning = var_2

	var_2("Remain stains count:", arg_52_1)

	return
end

function var_0_1.DecreaseStainsCount(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0.contextData.gameStatus.stainsCount
	local var_53_1 = arg_53_0
	local var_53_2 = arg_53_0.SetStainsCount

	math = var_1_10006

	var_53_2(var_53_1, var_1_10006.max(var_53_0 - arg_53_1, 0))

	return
end

function var_0_1.ResetPhase2Progress(arg_54_0)
	arg_54_0.phase2ClickedTips = {}

	return
end

function var_0_1.PlayPhase2Reaction(arg_55_0, arg_55_1)
	assert = var_1_10002

	var_1_10002(arg_55_1, "CarWash phase2 reaction request is nil")

	assert = var_1_10002

	var_1_10002(arg_55_1.animId, "CarWash phase2 reaction animId is nil")

	local var_55_0 = arg_55_0.contextData.gameStatus.currentState

	CarWashConst = var_1_10003

	if var_55_0 ~= var_1_10003.GAME_STATE.PHASE_2 then
		return
	end

	if arg_55_0.phase2ClickedTips[arg_55_1.animId] then
		return
	end

	local var_55_1 = arg_55_0
	local var_55_2 = arg_55_0.Emit

	CarWashLadySystem = var_5

	var_55_2(var_55_1, var_5.PLAY_PHASE2_REACTION, {
		animId = arg_55_1.animId,
		callback = function(arg_56_0)
			if not arg_56_0 then
				return
			end

			arg_55_0.phase2ClickedTips[arg_55_1.animId] = true

			local var_56_0 = arg_55_0

			var_1.Emit(var_56_0, var_0_1.UPDATE_PHASE2_REACTION_PROGRESS, {
				animId = arg_55_1.animId,
				clickedTips = arg_55_0.phase2ClickedTips
			})

			local var_56_1 = arg_55_0

			var_1.CheckAllPhase2TipsClicked(var_56_1)

			return
		end
	})

	return
end

function var_0_1.CheckAllPhase2TipsClicked(arg_57_0)
	pg = var_1_10001

	local var_57_0 = var_1_10001.dorm3d_carwash_pos[arg_57_0.contextData.gameConfig.pos_phase2]

	assert = var_2

	local var_57_1 = var_57_0
	local var_57_2 = "CarWash phase2 pos config not found: "

	tostring = var_1_10006

	var_2(var_57_1, var_57_2 .. var_1_10006(arg_57_0.contextData.gameConfig.pos_phase2))

	ipairs = var_2

	for iter_57_0, iter_57_1 in var_2(var_57_0.fury_anim) do
		if not arg_57_0.phase2ClickedTips[iter_57_1] then
			return
		end
	end

	arg_57_0:ReturnToPhase1WithTransition()

	return
end

function var_0_1.ReturnToPhase1WithTransition(arg_58_0)
	if arg_58_0.isPhaseTransitioning then
		return
	end

	arg_58_0.isPhaseTransitioning = true

	local var_58_0 = arg_58_0
	local var_58_1 = arg_58_0.Emit

	CarWashTimelineSystem = var_1_10004

	local var_58_2 = var_1_10004.PLAY_TRANSITION
	local var_58_3 = {
		waitHold = true
	}

	CarWashTimelineSystem = var_1_10006
	var_58_3.type = var_1_10006.TRANSITION.WHITE

	function var_58_3.onHold(arg_59_0, arg_59_1)
		local var_59_0 = arg_58_0

		var_2.SetHeartBeatValue(var_59_0, 0)

		local var_59_1 = arg_58_0
		local var_59_2 = var_2.SetGameState

		CarWashConst = var_5

		var_59_2(var_59_1, var_5.GAME_STATE.PHASE_1)
		arg_59_0()

		return
	end

	function var_58_3.onFinish(arg_60_0)
		arg_58_0.isPhaseTransitioning = false

		return
	end

	var_58_1(var_58_0, var_58_2, var_58_3)

	return
end

function var_0_1.FinishGame(arg_61_0)
	if arg_61_0.isEnding then
		return
	end

	local var_61_0 = arg_61_0.contextData.gameStatus.currentState

	CarWashConst = var_1_10002

	if var_61_0 == var_1_10002.GAME_STATE.END then
		return
	end

	arg_61_0.isEnding = true
	arg_61_0.remainingTime = 0

	arg_61_0:EmitCountdown()

	local var_61_1 = arg_61_0
	local var_61_2 = arg_61_0.SetGameState

	CarWashConst = var_1_10004

	var_61_2(var_61_1, var_1_10004.GAME_STATE.END)
	arg_61_0:PlayEndArtTimeline()

	return
end

function var_0_1.PlayEndArtTimeline(arg_62_0)
	local var_62_0 = arg_62_0
	local var_62_1 = arg_62_0.Emit

	CarWashTimelineSystem = var_1_10004

	var_62_1(var_62_0, var_1_10004.PLAY_ART_TIMELINE, arg_62_0.contextData.gameConfig.end_timeline)

	return
end

function var_0_1.RestartGame(arg_63_0)
	local var_63_0 = arg_63_0.contextData.gameStatus.currentState

	CarWashConst = var_1_10002

	if var_63_0 ~= var_1_10002.GAME_STATE.END then
		return
	end

	local var_63_1 = arg_63_0
	local var_63_2 = arg_63_0.Emit

	CarWashTimelineSystem = var_1_10004

	var_63_2(var_63_1, var_1_10004.EXIT_ART_TIMELINE, {
		onHold = function(arg_64_0, arg_64_1)
			local var_64_0 = arg_63_0

			var_2.InitGameStatus(var_64_0)

			local var_64_1 = arg_63_0

			var_2.StartGame(var_64_1, arg_64_0)

			return
		end,
		onFinish = function(arg_65_0)
			return
		end
	})

	return
end

function var_0_1.TriggerHiddenReaction(arg_66_0, arg_66_1)
	if not arg_66_1 then
		return
	end

	arg_66_0:ModifyHeartBeatValue(arg_66_1.mood_value_plus)

	local var_66_0 = arg_66_0
	local var_66_1 = arg_66_0.Emit

	CarWashTimelineSystem = var_5

	var_66_1(var_66_0, var_5.PLAY_ART_TIMELINE, arg_66_1.hidden_reaction)

	return
end

return var_0_1
