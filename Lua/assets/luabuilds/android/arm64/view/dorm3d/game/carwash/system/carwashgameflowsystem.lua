local var_0_0 = class("CarWashGameFlowSystem", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_0.START_GAME = "CarWashGameFlowSystem.START_GAME"
var_0_0.REQUEST_RESTART_GAME = "CarWashGameFlowSystem.REQUEST_RESTART_GAME"
var_0_0.MODIFY_GAME_STATUS = "CarWashGameFlowSystem.MODIFY_GAME_STATUS"
var_0_0.UPDATE_GAME_STATE = "CarWashGameFlowSystem.UPDATE_GAME_STATE"
var_0_0.UPDATE_IS_SHOOTING = "CarWashGameFlowSystem.UPDATE_IS_SHOOTING"
var_0_0.UPDATE_CURRENT_GUN_TYPE = "CarWashGameFlowSystem.UPDATE_CURRENT_GUN_TYPE"
var_0_0.UPDATE_HEART_BEAT_VALUE = "CarWashGameFlowSystem.UPDATE_HEART_BEAT_VALUE"
var_0_0.UPDATE_LADY_POS = "CarWashGameFlowSystem.UPDATE_LADY_POS"
var_0_0.UPDATE_STAINS_COUNT_MAX = "CarWashGameFlowSystem.UPDATE_STAINS_COUNT_MAX"
var_0_0.UPDATE_STAINS_COUNT = "CarWashGameFlowSystem.UPDATE_STAINS_COUNT"
var_0_0.UPDATE_COUNTDOWN = "CarWashGameFlowSystem.UPDATE_COUNTDOWN"
var_0_0.SWITCH_SHOOTING = "CarWashGameFlowSystem.SWITCH_SHOOTING"
var_0_0.SWITCH_GUN_TYPE = "CarWashGameFlowSystem.SWITCH_GUN_TYPE"
var_0_0.SWITCH_LADY_POS = "CarWashGameFlowSystem.SWITCH_LADY_POS"
var_0_0.SWITCH_STATE = "CarWashGameFlowSystem.SWITCH_STATE"
var_0_0.SET_STAINS_COUNT_MAX = "CarWashGameFlowSystem.SET_STAINS_COUNT_MAX"
var_0_0.SET_STAINS_COUNT = "CarWashGameFlowSystem.SET_STAINS_COUNT"
var_0_0.DECREASE_STAINS_COUNT = "CarWashGameFlowSystem.DECREASE_STAINS_COUNT"
var_0_0.MODIFY_HEART_BEAT_VALUE = "CarWashGameFlowSystem.MODIFY_HEART_BEAT_VALUE"
var_0_0.PLAY_PHASE2_REACTION = "CarWashGameFlowSystem.PLAY_PHASE2_REACTION"
var_0_0.TRIGGER_HIDDEN_REACTION = "CarWashGameFlowSystem.TRIGGER_HIDDEN_REACTION"
var_0_0.UPDATE_PHASE2_REACTION_PROGRESS = "CarWashGameFlowSystem.UPDATE_PHASE2_REACTION_PROGRESS"

function var_0_0.OnInit(arg_1_0)
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

function var_0_0.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_0.START_GAME, function(arg_3_0, arg_3_1)
		arg_2_0:StartGame(arg_3_1)

		return
	end)
	arg_2_0:Bind(var_0_0.REQUEST_RESTART_GAME, function(arg_4_0)
		arg_2_0:RestartGame()

		return
	end)
	arg_2_0:Bind(var_0_0.MODIFY_GAME_STATUS, function(arg_5_0, arg_5_1, arg_5_2)
		arg_2_0:UpdateGameStatus(arg_5_1, arg_5_2)

		return
	end)
	arg_2_0:Bind(var_0_0.SWITCH_SHOOTING, function(arg_6_0)
		arg_2_0:SetShooting(not arg_2_0.contextData.gameStatus.isShooting)

		return
	end)
	arg_2_0:Bind(var_0_0.SWITCH_GUN_TYPE, function(arg_7_0, arg_7_1)
		arg_2_0:SetCurrentGunType(arg_7_1)

		return
	end)
	arg_2_0:Bind(var_0_0.SWITCH_LADY_POS, function(arg_8_0, arg_8_1)
		arg_2_0:SetLadyPos(pg.dorm3d_carwash_pos[arg_8_1])

		return
	end)
	arg_2_0:Bind(var_0_0.SWITCH_STATE, function(arg_9_0, arg_9_1)
		arg_2_0:SetGameState(arg_9_1)

		return
	end)
	arg_2_0:Bind(var_0_0.SET_STAINS_COUNT_MAX, function(arg_10_0, arg_10_1)
		arg_2_0:SetStainsCountMax(arg_10_1)

		return
	end)
	arg_2_0:Bind(var_0_0.SET_STAINS_COUNT, function(arg_11_0, arg_11_1)
		arg_2_0:SetStainsCount(arg_11_1)

		return
	end)
	arg_2_0:Bind(var_0_0.DECREASE_STAINS_COUNT, function(arg_12_0, arg_12_1)
		arg_2_0:DecreaseStainsCount(arg_12_1)

		return
	end)
	arg_2_0:Bind(var_0_0.MODIFY_HEART_BEAT_VALUE, function(arg_13_0, arg_13_1)
		arg_2_0:ModifyHeartBeatValue(arg_13_1)

		return
	end)
	arg_2_0:Bind(var_0_0.PLAY_PHASE2_REACTION, function(arg_14_0, arg_14_1)
		arg_2_0:PlayPhase2Reaction(arg_14_1)

		return
	end)
	arg_2_0:Bind(var_0_0.TRIGGER_HIDDEN_REACTION, function(arg_15_0, arg_15_1)
		arg_2_0:TriggerHiddenReaction(arg_15_1)

		return
	end)
	arg_2_0:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, function(arg_16_0, arg_16_1)
		arg_2_0.isTimelineSequencePlaying = true

		return
	end)
	arg_2_0:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, function(arg_17_0, arg_17_1)
		arg_2_0.isTimelineSequencePlaying = false

		return
	end)
	arg_2_0:Bind(CarWashTimelineSystem.TRANSITION_BEGIN, function(arg_18_0, arg_18_1)
		arg_2_0.isTransitionPlaying = true

		return
	end)
	arg_2_0:Bind(CarWashTimelineSystem.TRANSITION_END, function(arg_19_0, arg_19_1)
		arg_2_0.isTransitionPlaying = false

		return
	end)

	return
end

function var_0_0.OnDispose(arg_20_0)
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

function var_0_0.InitGameStatus(arg_21_0)
	arg_21_0.contextData.gameConfig = pg.dorm3d_carwash[arg_21_0.contextData.groupId]
	arg_21_0.contextData.gameStatus = {
		stainsCount = 0,
		stainsCountMax = 0,
		isShooting = false,
		heartBeatValue = 0,
		currentState = CarWashConst.GAME_STATE.NONE
	}

	return
end

function var_0_0.StartGame(arg_22_0, arg_22_1)
	arg_22_0:ResetRuntimeState()
	seriesAsync({
		function(arg_23_0)
			arg_22_0:SetCurrentGunType(CarWashConst.GUN_TYPE.WASHER)
			arg_22_0:SetLadyPos(pg.dorm3d_carwash_pos[arg_22_0.contextData.gameConfig.pos[1]])
			arg_22_0:Emit(CarWashDecalSystem.GENERATE_DECALS)
			arg_23_0()

			return
		end,
		function(arg_24_0)
			if PlayerPrefs.GetInt("CarWashGuideShown", 0) == 0 then
				PlayerPrefs.SetInt("CarWashGuideShown", 1)
				arg_22_0:Emit(CarWashMainPage.SHOW_HELP_BOX, arg_24_0)
			else
				arg_24_0()
			end

			return
		end,
		function(arg_25_0)
			arg_22_0:SetGameState(CarWashConst.GAME_STATE.PHASE_1)
			arg_25_0()

			return
		end
	}, function()
		existCall(arg_22_1)

		return
	end)

	return
end

function var_0_0.ResetRuntimeState(arg_27_0)
	arg_27_0.phase1LadyPosCache = nil
	arg_27_0.phase2ClickedTips = {}
	arg_27_0.isPhaseTransitioning = false
	arg_27_0.isEnding = false
	arg_27_0.isTimelineSequencePlaying = false
	arg_27_0.isTransitionPlaying = false
	arg_27_0.remainingTime = CarWashConst.GAME_DURATION
	arg_27_0.lastCountdownSeconds = nil

	arg_27_0:EmitCountdown()

	return
end

function var_0_0.OnUpdate(arg_28_0, arg_28_1)
	arg_28_0:UpdateCountdown(arg_28_1)

	return
end

function var_0_0.IsCountdownRunning(arg_29_0)
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

	return arg_29_0.contextData.gameStatus.currentState == CarWashConst.GAME_STATE.PHASE_1
end

function var_0_0.UpdateCountdown(arg_30_0, arg_30_1)
	if not arg_30_0:IsCountdownRunning() then
		return
	end

	arg_30_0.remainingTime = math.max(arg_30_0.remainingTime - arg_30_1, 0)

	arg_30_0:EmitCountdown()

	if arg_30_0.remainingTime <= 0 then
		arg_30_0:FinishGame()
	end

	return
end

function var_0_0.EmitCountdown(arg_31_0)
	local var_31_0 = arg_31_0.remainingTime or 0
	local var_31_1 = math.max(math.ceil(var_31_0), 0)

	if arg_31_0.lastCountdownSeconds == var_31_1 then
		return
	end

	arg_31_0.lastCountdownSeconds = var_31_1

	arg_31_0:Emit(var_0_0.UPDATE_COUNTDOWN, {
		remainingSeconds = var_31_1
	})

	return
end

function var_0_0.GetGameStatusEventName(arg_32_0, arg_32_1)
	return switch(arg_32_1, {
		currentState = function()
			return var_0_0.UPDATE_GAME_STATE
		end,
		isShooting = function()
			return var_0_0.UPDATE_IS_SHOOTING
		end,
		currentGunType = function()
			return var_0_0.UPDATE_CURRENT_GUN_TYPE
		end,
		heartBeatValue = function()
			return var_0_0.UPDATE_HEART_BEAT_VALUE
		end,
		ladyPos = function()
			return var_0_0.UPDATE_LADY_POS
		end,
		stainsCountMax = function()
			return var_0_0.UPDATE_STAINS_COUNT_MAX
		end,
		stainsCount = function()
			return var_0_0.UPDATE_STAINS_COUNT
		end
	})
end

function var_0_0.UpdateGameStatus(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0:GetGameStatusEventName(arg_40_1)

	assert(var_40_0, "CarWash gameStatus key not found: " .. tostring(arg_40_1))

	arg_40_0.contextData.gameStatus[arg_40_1] = arg_40_2

	arg_40_0:Emit(var_40_0, {
		key = arg_40_1,
		oldValue = arg_40_0.contextData.gameStatus[arg_40_1],
		newValue = arg_40_2
	})

	return
end

function var_0_0.SetGameState(arg_41_0, arg_41_1)
	if arg_41_1 == CarWashConst.GAME_STATE.PHASE_2 and arg_41_0.contextData.gameStatus.currentState ~= CarWashConst.GAME_STATE.PHASE_2 then
		arg_41_0.phase1LadyPosCache = arg_41_0.contextData.gameStatus.ladyPos

		arg_41_0:ResetPhase2Progress()
		arg_41_0:SetLadyPos(pg.dorm3d_carwash_pos[arg_41_0.contextData.gameConfig.pos_phase2])
	elseif arg_41_1 == CarWashConst.GAME_STATE.PHASE_1 and arg_41_0.phase1LadyPosCache then
		arg_41_0:SetLadyPos(arg_41_0.phase1LadyPosCache)

		arg_41_0.phase1LadyPosCache = nil

		arg_41_0:ResetPhase2Progress()
	elseif arg_41_1 == CarWashConst.GAME_STATE.END then
		arg_41_0:SetShooting(false)
	end

	arg_41_0:UpdateGameStatus("currentState", arg_41_1)

	return
end

function var_0_0.SetShooting(arg_42_0, arg_42_1)
	arg_42_0:UpdateGameStatus("isShooting", arg_42_1)

	return
end

function var_0_0.SetCurrentGunType(arg_43_0, arg_43_1)
	arg_43_0:UpdateGameStatus("currentGunType", arg_43_1)

	return
end

function var_0_0.ModifyHeartBeatValue(arg_44_0, arg_44_1)
	arg_44_0:SetHeartBeatValue((math.max(math.min(arg_44_0.contextData.gameStatus.heartBeatValue + arg_44_1, 100), 0)))

	return
end

function var_0_0.SetHeartBeatValue(arg_45_0, arg_45_1)
	arg_45_0:UpdateGameStatus("heartBeatValue", arg_45_1)
	arg_45_0:TryEnterPhase2ByHeartBeat(arg_45_1)

	return
end

function var_0_0.TryEnterPhase2ByHeartBeat(arg_46_0, arg_46_1)
	if not pg.dorm3d_carwash_pos[arg_46_0.contextData.gameConfig.pos_phase2] then
		return
	end

	if arg_46_1 < pg.dorm3d_carwash_pos[arg_46_0.contextData.gameConfig.pos_phase2].mood_value then
		return
	end

	if arg_46_0.contextData.gameStatus.currentState == CarWashConst.GAME_STATE.PHASE_2 then
		return
	end

	if arg_46_0.isPhaseTransitioning then
		return
	end

	arg_46_0:EnterPhase2WithTransition()

	return
end

function var_0_0.EnterPhase2WithTransition(arg_47_0)
	arg_47_0.isPhaseTransitioning = true

	arg_47_0:Emit(CarWashTimelineSystem.PLAY_TRANSITION, {
		waitHold = true,
		type = CarWashTimelineSystem.TRANSITION.WHITE,
		onHold = function(arg_48_0, arg_48_1)
			arg_47_0:SetGameState(CarWashConst.GAME_STATE.PHASE_2)
			arg_48_0()

			return
		end,
		onFinish = function(arg_49_0)
			arg_47_0.isPhaseTransitioning = false

			return
		end
	})

	return
end

function var_0_0.SetLadyPos(arg_50_0, arg_50_1)
	arg_50_0:UpdateGameStatus("ladyPos", arg_50_1)

	return
end

function var_0_0.SetStainsCountMax(arg_51_0, arg_51_1)
	arg_51_0:UpdateGameStatus("stainsCountMax", arg_51_1)

	return
end

function var_0_0.SetStainsCount(arg_52_0, arg_52_1)
	arg_52_0:UpdateGameStatus("stainsCount", arg_52_1)
	warning("Remain stains count:", arg_52_1)

	return
end

function var_0_0.DecreaseStainsCount(arg_53_0, arg_53_1)
	arg_53_0:SetStainsCount(math.max(arg_53_0.contextData.gameStatus.stainsCount - arg_53_1, 0))

	return
end

function var_0_0.ResetPhase2Progress(arg_54_0)
	arg_54_0.phase2ClickedTips = {}

	return
end

function var_0_0.PlayPhase2Reaction(arg_55_0, arg_55_1)
	assert(arg_55_1, "CarWash phase2 reaction request is nil")
	assert(arg_55_1.animId, "CarWash phase2 reaction animId is nil")

	if arg_55_0.contextData.gameStatus.currentState ~= CarWashConst.GAME_STATE.PHASE_2 then
		return
	end

	if arg_55_0.phase2ClickedTips[arg_55_1.animId] then
		return
	end

	arg_55_0:Emit(CarWashLadySystem.PLAY_PHASE2_REACTION, {
		animId = arg_55_1.animId,
		callback = function(arg_56_0)
			if not arg_56_0 then
				return
			end

			arg_55_0.phase2ClickedTips[arg_55_1.animId] = true

			arg_55_0:Emit(var_0_0.UPDATE_PHASE2_REACTION_PROGRESS, {
				animId = arg_55_1.animId,
				clickedTips = arg_55_0.phase2ClickedTips
			})
			arg_55_0:CheckAllPhase2TipsClicked()

			return
		end
	})

	return
end

function var_0_0.CheckAllPhase2TipsClicked(arg_57_0)
	assert(pg.dorm3d_carwash_pos[arg_57_0.contextData.gameConfig.pos_phase2], "CarWash phase2 pos config not found: " .. tostring(arg_57_0.contextData.gameConfig.pos_phase2))

	for iter_57_0, iter_57_1 in ipairs(pg.dorm3d_carwash_pos[arg_57_0.contextData.gameConfig.pos_phase2].fury_anim) do
		if not arg_57_0.phase2ClickedTips[iter_57_1] then
			return
		end
	end

	arg_57_0:ReturnToPhase1WithTransition()

	return
end

function var_0_0.ReturnToPhase1WithTransition(arg_58_0)
	if arg_58_0.isPhaseTransitioning then
		return
	end

	arg_58_0.isPhaseTransitioning = true

	arg_58_0:Emit(CarWashTimelineSystem.PLAY_TRANSITION, {
		waitHold = true,
		type = CarWashTimelineSystem.TRANSITION.WHITE,
		onHold = function(arg_59_0, arg_59_1)
			arg_58_0:SetHeartBeatValue(0)
			arg_58_0:SetGameState(CarWashConst.GAME_STATE.PHASE_1)
			arg_59_0()

			return
		end,
		onFinish = function(arg_60_0)
			arg_58_0.isPhaseTransitioning = false

			return
		end
	})

	return
end

function var_0_0.FinishGame(arg_61_0)
	if arg_61_0.isEnding then
		return
	end

	if arg_61_0.contextData.gameStatus.currentState == CarWashConst.GAME_STATE.END then
		return
	end

	arg_61_0.isEnding = true
	arg_61_0.remainingTime = 0

	arg_61_0:EmitCountdown()
	arg_61_0:SetGameState(CarWashConst.GAME_STATE.END)
	arg_61_0:PlayEndArtTimeline()

	return
end

function var_0_0.PlayEndArtTimeline(arg_62_0)
	arg_62_0:Emit(CarWashTimelineSystem.PLAY_ART_TIMELINE, arg_62_0.contextData.gameConfig.end_timeline)

	return
end

function var_0_0.RestartGame(arg_63_0)
	if arg_63_0.contextData.gameStatus.currentState ~= CarWashConst.GAME_STATE.END then
		return
	end

	arg_63_0:Emit(CarWashTimelineSystem.EXIT_ART_TIMELINE, {
		onHold = function(arg_64_0, arg_64_1)
			arg_63_0:InitGameStatus()
			arg_63_0:StartGame(arg_64_0)

			return
		end,
		onFinish = function(arg_65_0)
			return
		end
	})

	return
end

function var_0_0.TriggerHiddenReaction(arg_66_0, arg_66_1)
	if not arg_66_1 then
		return
	end

	arg_66_0:ModifyHeartBeatValue(arg_66_1.mood_value_plus)
	arg_66_0:Emit(CarWashTimelineSystem.PLAY_ART_TIMELINE, arg_66_1.hidden_reaction)

	return
end

return var_0_0
