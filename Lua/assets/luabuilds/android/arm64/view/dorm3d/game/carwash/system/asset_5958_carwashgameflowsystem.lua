local CarWashGameFlowSystem = class("CarWashGameFlowSystem", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

CarWashGameFlowSystem.START_GAME = "CarWashGameFlowSystem.START_GAME"
CarWashGameFlowSystem.REQUEST_RESTART_GAME = "CarWashGameFlowSystem.REQUEST_RESTART_GAME"
CarWashGameFlowSystem.MODIFY_GAME_STATUS = "CarWashGameFlowSystem.MODIFY_GAME_STATUS"
CarWashGameFlowSystem.UPDATE_GAME_STATE = "CarWashGameFlowSystem.UPDATE_GAME_STATE"
CarWashGameFlowSystem.UPDATE_IS_SHOOTING = "CarWashGameFlowSystem.UPDATE_IS_SHOOTING"
CarWashGameFlowSystem.UPDATE_CURRENT_GUN_TYPE = "CarWashGameFlowSystem.UPDATE_CURRENT_GUN_TYPE"
CarWashGameFlowSystem.UPDATE_HEART_BEAT_VALUE = "CarWashGameFlowSystem.UPDATE_HEART_BEAT_VALUE"
CarWashGameFlowSystem.UPDATE_LADY_POS = "CarWashGameFlowSystem.UPDATE_LADY_POS"
CarWashGameFlowSystem.UPDATE_STAINS_COUNT_MAX = "CarWashGameFlowSystem.UPDATE_STAINS_COUNT_MAX"
CarWashGameFlowSystem.UPDATE_STAINS_COUNT = "CarWashGameFlowSystem.UPDATE_STAINS_COUNT"
CarWashGameFlowSystem.UPDATE_COUNTDOWN = "CarWashGameFlowSystem.UPDATE_COUNTDOWN"
CarWashGameFlowSystem.SWITCH_SHOOTING = "CarWashGameFlowSystem.SWITCH_SHOOTING"
CarWashGameFlowSystem.SWITCH_GUN_TYPE = "CarWashGameFlowSystem.SWITCH_GUN_TYPE"
CarWashGameFlowSystem.SWITCH_LADY_POS = "CarWashGameFlowSystem.SWITCH_LADY_POS"
CarWashGameFlowSystem.SWITCH_STATE = "CarWashGameFlowSystem.SWITCH_STATE"
CarWashGameFlowSystem.SET_STAINS_COUNT_MAX = "CarWashGameFlowSystem.SET_STAINS_COUNT_MAX"
CarWashGameFlowSystem.SET_STAINS_COUNT = "CarWashGameFlowSystem.SET_STAINS_COUNT"
CarWashGameFlowSystem.DECREASE_STAINS_COUNT = "CarWashGameFlowSystem.DECREASE_STAINS_COUNT"
CarWashGameFlowSystem.MODIFY_HEART_BEAT_VALUE = "CarWashGameFlowSystem.MODIFY_HEART_BEAT_VALUE"
CarWashGameFlowSystem.PLAY_PHASE2_REACTION = "CarWashGameFlowSystem.PLAY_PHASE2_REACTION"
CarWashGameFlowSystem.TRIGGER_HIDDEN_REACTION = "CarWashGameFlowSystem.TRIGGER_HIDDEN_REACTION"
CarWashGameFlowSystem.UPDATE_PHASE2_REACTION_PROGRESS = "CarWashGameFlowSystem.UPDATE_PHASE2_REACTION_PROGRESS"

function CarWashGameFlowSystem:OnInit()
	self.contextData = self:GetContextData()
	self.phase2ClickedTips = {}
	self.isPhaseTransitioning = false
	self.remainingTime = 0
	self.lastCountdownSeconds = nil
	self.isEnding = false
	self.isTimelineSequencePlaying = false
	self.isTransitionPlaying = false

	self:InitGameStatus()

	return
end

function CarWashGameFlowSystem:RegisterEvents()
	self:Bind(CarWashGameFlowSystem.START_GAME, function(arg_3_0, arg_3_1)
		self:StartGame(arg_3_1)

		return
	end)
	self:Bind(CarWashGameFlowSystem.REQUEST_RESTART_GAME, function(arg_4_0)
		self:RestartGame()

		return
	end)
	self:Bind(CarWashGameFlowSystem.MODIFY_GAME_STATUS, function(arg_5_0, arg_5_1, arg_5_2)
		self:UpdateGameStatus(arg_5_1, arg_5_2)

		return
	end)
	self:Bind(CarWashGameFlowSystem.SWITCH_SHOOTING, function(arg_6_0)
		self:SetShooting(not self.contextData.gameStatus.isShooting)

		return
	end)
	self:Bind(CarWashGameFlowSystem.SWITCH_GUN_TYPE, function(arg_7_0, arg_7_1)
		self:SetCurrentGunType(arg_7_1)

		return
	end)
	self:Bind(CarWashGameFlowSystem.SWITCH_LADY_POS, function(arg_8_0, arg_8_1)
		self:SetLadyPos(pg.dorm3d_carwash_pos[arg_8_1])

		return
	end)
	self:Bind(CarWashGameFlowSystem.SWITCH_STATE, function(arg_9_0, arg_9_1)
		self:SetGameState(arg_9_1)

		return
	end)
	self:Bind(CarWashGameFlowSystem.SET_STAINS_COUNT_MAX, function(arg_10_0, arg_10_1)
		self:SetStainsCountMax(arg_10_1)

		return
	end)
	self:Bind(CarWashGameFlowSystem.SET_STAINS_COUNT, function(arg_11_0, arg_11_1)
		self:SetStainsCount(arg_11_1)

		return
	end)
	self:Bind(CarWashGameFlowSystem.DECREASE_STAINS_COUNT, function(arg_12_0, arg_12_1)
		self:DecreaseStainsCount(arg_12_1)

		return
	end)
	self:Bind(CarWashGameFlowSystem.MODIFY_HEART_BEAT_VALUE, function(arg_13_0, arg_13_1)
		self:ModifyHeartBeatValue(arg_13_1)

		return
	end)
	self:Bind(CarWashGameFlowSystem.PLAY_PHASE2_REACTION, function(arg_14_0, arg_14_1)
		self:PlayPhase2Reaction(arg_14_1)

		return
	end)
	self:Bind(CarWashGameFlowSystem.TRIGGER_HIDDEN_REACTION, function(arg_15_0, arg_15_1)
		self:TriggerHiddenReaction(arg_15_1)

		return
	end)
	self:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, function(arg_16_0, arg_16_1)
		self.isTimelineSequencePlaying = true

		return
	end)
	self:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, function(arg_17_0, arg_17_1)
		self.isTimelineSequencePlaying = false

		return
	end)
	self:Bind(CarWashTimelineSystem.TRANSITION_BEGIN, function(arg_18_0, arg_18_1)
		self.isTransitionPlaying = true

		return
	end)
	self:Bind(CarWashTimelineSystem.TRANSITION_END, function(arg_19_0, arg_19_1)
		self.isTransitionPlaying = false

		return
	end)

	return
end

function CarWashGameFlowSystem:OnDispose()
	self.contextData = nil
	self.phase1LadyPosCache = nil
	self.phase2ClickedTips = nil
	self.isPhaseTransitioning = nil
	self.remainingTime = nil
	self.lastCountdownSeconds = nil
	self.isEnding = nil
	self.isTimelineSequencePlaying = nil
	self.isTransitionPlaying = nil

	return
end

function CarWashGameFlowSystem:InitGameStatus()
	self.contextData.gameConfig = pg.dorm3d_carwash[self.contextData.groupId]
	self.contextData.gameStatus = {
		stainsCount = 0,
		stainsCountMax = 0,
		isShooting = false,
		heartBeatValue = 0,
		currentState = CarWashConst.GAME_STATE.NONE
	}

	return
end

function CarWashGameFlowSystem:StartGame(arg_22_1)
	self:ResetRuntimeState()
	seriesAsync({
		function(arg_23_0)
			self:SetCurrentGunType(CarWashConst.GUN_TYPE.WASHER)
			self:SetLadyPos(pg.dorm3d_carwash_pos[self.contextData.gameConfig.pos[1]])
			self:Emit(CarWashDecalSystem.GENERATE_DECALS)
			arg_23_0()

			return
		end,
		function(arg_24_0)
			if PlayerPrefs.GetInt("CarWashGuideShown", 0) == 0 then
				PlayerPrefs.SetInt("CarWashGuideShown", 1)
				self:Emit(CarWashMainPage.SHOW_HELP_BOX, arg_24_0)
			else
				arg_24_0()
			end

			return
		end,
		function(arg_25_0)
			self:SetGameState(CarWashConst.GAME_STATE.PHASE_1)
			arg_25_0()

			return
		end
	}, function()
		existCall(arg_22_1)

		return
	end)

	return
end

function CarWashGameFlowSystem:ResetRuntimeState()
	self.phase1LadyPosCache = nil
	self.phase2ClickedTips = {}
	self.isPhaseTransitioning = false
	self.isEnding = false
	self.isTimelineSequencePlaying = false
	self.isTransitionPlaying = false
	self.remainingTime = CarWashConst.GAME_DURATION
	self.lastCountdownSeconds = nil

	self:EmitCountdown()

	return
end

function CarWashGameFlowSystem:OnUpdate(arg_28_1)
	self:UpdateCountdown(arg_28_1)

	return
end

function CarWashGameFlowSystem:IsCountdownRunning()
	if self.isEnding then
		return false
	end

	if self.isPhaseTransitioning then
		return false
	end

	if self.isTimelineSequencePlaying then
		return false
	end

	if self.isTransitionPlaying then
		return false
	end

	return self.contextData.gameStatus.currentState == CarWashConst.GAME_STATE.PHASE_1
end

function CarWashGameFlowSystem:UpdateCountdown(arg_30_1)
	if not self:IsCountdownRunning() then
		return
	end

	self.remainingTime = math.max(self.remainingTime - arg_30_1, 0)

	self:EmitCountdown()

	if self.remainingTime <= 0 then
		self:FinishGame()
	end

	return
end

function CarWashGameFlowSystem:EmitCountdown()
	local var_31_1 = math.max(math.ceil(self.remainingTime or 0), 0)

	if self.lastCountdownSeconds == var_31_1 then
		return
	end

	self.lastCountdownSeconds = var_31_1

	self:Emit(CarWashGameFlowSystem.UPDATE_COUNTDOWN, {
		remainingSeconds = var_31_1
	})

	return
end

function CarWashGameFlowSystem:GetGameStatusEventName(arg_32_1)
	return switch(arg_32_1, {
		currentState = function()
			return CarWashGameFlowSystem.UPDATE_GAME_STATE
		end,
		isShooting = function()
			return CarWashGameFlowSystem.UPDATE_IS_SHOOTING
		end,
		currentGunType = function()
			return CarWashGameFlowSystem.UPDATE_CURRENT_GUN_TYPE
		end,
		heartBeatValue = function()
			return CarWashGameFlowSystem.UPDATE_HEART_BEAT_VALUE
		end,
		ladyPos = function()
			return CarWashGameFlowSystem.UPDATE_LADY_POS
		end,
		stainsCountMax = function()
			return CarWashGameFlowSystem.UPDATE_STAINS_COUNT_MAX
		end,
		stainsCount = function()
			return CarWashGameFlowSystem.UPDATE_STAINS_COUNT
		end
	})
end

function CarWashGameFlowSystem:UpdateGameStatus(arg_40_1, arg_40_2)
	local var_40_0 = self:GetGameStatusEventName(arg_40_1)

	assert(var_40_0, "CarWash gameStatus key not found: " .. tostring(arg_40_1))

	self.contextData.gameStatus[arg_40_1] = arg_40_2

	self:Emit(var_40_0, {
		key = arg_40_1,
		oldValue = self.contextData.gameStatus[arg_40_1],
		newValue = arg_40_2
	})

	return
end

function CarWashGameFlowSystem:SetGameState(arg_41_1)
	if arg_41_1 == CarWashConst.GAME_STATE.PHASE_2 and self.contextData.gameStatus.currentState ~= CarWashConst.GAME_STATE.PHASE_2 then
		self.phase1LadyPosCache = self.contextData.gameStatus.ladyPos

		self:ResetPhase2Progress()
		self:SetLadyPos(pg.dorm3d_carwash_pos[self.contextData.gameConfig.pos_phase2])
	elseif arg_41_1 == CarWashConst.GAME_STATE.PHASE_1 and self.phase1LadyPosCache then
		self:SetLadyPos(self.phase1LadyPosCache)

		self.phase1LadyPosCache = nil

		self:ResetPhase2Progress()
	elseif arg_41_1 == CarWashConst.GAME_STATE.END then
		self:SetShooting(false)
	end

	self:UpdateGameStatus("currentState", arg_41_1)

	return
end

function CarWashGameFlowSystem:SetShooting(arg_42_1)
	self:UpdateGameStatus("isShooting", arg_42_1)

	return
end

function CarWashGameFlowSystem:SetCurrentGunType(arg_43_1)
	self:UpdateGameStatus("currentGunType", arg_43_1)

	return
end

function CarWashGameFlowSystem:ModifyHeartBeatValue(arg_44_1)
	self:SetHeartBeatValue((math.max(math.min(self.contextData.gameStatus.heartBeatValue + arg_44_1, 100), 0)))

	return
end

function CarWashGameFlowSystem:SetHeartBeatValue(arg_45_1)
	self:UpdateGameStatus("heartBeatValue", arg_45_1)
	self:TryEnterPhase2ByHeartBeat(arg_45_1)

	return
end

function CarWashGameFlowSystem:TryEnterPhase2ByHeartBeat(arg_46_1)
	if not pg.dorm3d_carwash_pos[self.contextData.gameConfig.pos_phase2] then
		return
	end

	if arg_46_1 < pg.dorm3d_carwash_pos[self.contextData.gameConfig.pos_phase2].mood_value then
		return
	end

	if self.contextData.gameStatus.currentState == CarWashConst.GAME_STATE.PHASE_2 then
		return
	end

	if self.isPhaseTransitioning then
		return
	end

	self:EnterPhase2WithTransition()

	return
end

function CarWashGameFlowSystem:EnterPhase2WithTransition()
	self.isPhaseTransitioning = true

	self:Emit(CarWashTimelineSystem.PLAY_TRANSITION, {
		waitHold = true,
		type = CarWashTimelineSystem.TRANSITION.WHITE,
		onHold = function(arg_48_0, arg_48_1)
			self:SetGameState(CarWashConst.GAME_STATE.PHASE_2)
			arg_48_0()

			return
		end,
		onFinish = function(arg_49_0)
			self.isPhaseTransitioning = false

			return
		end
	})

	return
end

function CarWashGameFlowSystem:SetLadyPos(arg_50_1)
	self:UpdateGameStatus("ladyPos", arg_50_1)

	return
end

function CarWashGameFlowSystem:SetStainsCountMax(arg_51_1)
	self:UpdateGameStatus("stainsCountMax", arg_51_1)

	return
end

function CarWashGameFlowSystem:SetStainsCount(arg_52_1)
	self:UpdateGameStatus("stainsCount", arg_52_1)
	warning("Remain stains count:", arg_52_1)

	return
end

function CarWashGameFlowSystem:DecreaseStainsCount(arg_53_1)
	self:SetStainsCount(math.max(self.contextData.gameStatus.stainsCount - arg_53_1, 0))

	return
end

function CarWashGameFlowSystem:ResetPhase2Progress()
	self.phase2ClickedTips = {}

	return
end

function CarWashGameFlowSystem:PlayPhase2Reaction(arg_55_1)
	assert(arg_55_1, "CarWash phase2 reaction request is nil")
	assert(arg_55_1.animId, "CarWash phase2 reaction animId is nil")

	if self.contextData.gameStatus.currentState ~= CarWashConst.GAME_STATE.PHASE_2 then
		return
	end

	if self.phase2ClickedTips[arg_55_1.animId] then
		return
	end

	self:Emit(CarWashLadySystem.PLAY_PHASE2_REACTION, {
		animId = arg_55_1.animId,
		callback = function(arg_56_0)
			if not arg_56_0 then
				return
			end

			self.phase2ClickedTips[arg_55_1.animId] = true

			self:Emit(CarWashGameFlowSystem.UPDATE_PHASE2_REACTION_PROGRESS, {
				animId = arg_55_1.animId,
				clickedTips = self.phase2ClickedTips
			})
			self:CheckAllPhase2TipsClicked()

			return
		end
	})

	return
end

function CarWashGameFlowSystem:CheckAllPhase2TipsClicked()
	assert(pg.dorm3d_carwash_pos[self.contextData.gameConfig.pos_phase2], "CarWash phase2 pos config not found: " .. tostring(self.contextData.gameConfig.pos_phase2))

	for iter_57_0, iter_57_1 in ipairs(pg.dorm3d_carwash_pos[self.contextData.gameConfig.pos_phase2].fury_anim) do
		if not self.phase2ClickedTips[iter_57_1] then
			return
		end
	end

	self:ReturnToPhase1WithTransition()

	return
end

function CarWashGameFlowSystem:ReturnToPhase1WithTransition()
	if self.isPhaseTransitioning then
		return
	end

	self.isPhaseTransitioning = true

	self:Emit(CarWashTimelineSystem.PLAY_TRANSITION, {
		waitHold = true,
		type = CarWashTimelineSystem.TRANSITION.WHITE,
		onHold = function(arg_59_0, arg_59_1)
			self:SetHeartBeatValue(0)
			self:SetGameState(CarWashConst.GAME_STATE.PHASE_1)
			arg_59_0()

			return
		end,
		onFinish = function(arg_60_0)
			self.isPhaseTransitioning = false

			return
		end
	})

	return
end

function CarWashGameFlowSystem:FinishGame()
	if self.isEnding then
		return
	end

	if self.contextData.gameStatus.currentState == CarWashConst.GAME_STATE.END then
		return
	end

	self.isEnding = true
	self.remainingTime = 0

	self:EmitCountdown()
	self:SetGameState(CarWashConst.GAME_STATE.END)
	self:PlayEndArtTimeline()

	return
end

function CarWashGameFlowSystem:PlayEndArtTimeline()
	self:Emit(CarWashTimelineSystem.PLAY_ART_TIMELINE, self.contextData.gameConfig.end_timeline)

	return
end

function CarWashGameFlowSystem:RestartGame()
	if self.contextData.gameStatus.currentState ~= CarWashConst.GAME_STATE.END then
		return
	end

	self:Emit(CarWashTimelineSystem.EXIT_ART_TIMELINE, {
		onHold = function(arg_64_0, arg_64_1)
			self:InitGameStatus()
			self:StartGame(arg_64_0)

			return
		end,
		onFinish = function(arg_65_0)
			return
		end
	})

	return
end

function CarWashGameFlowSystem:TriggerHiddenReaction(arg_66_1)
	if not arg_66_1 then
		return
	end

	self:ModifyHeartBeatValue(arg_66_1.mood_value_plus)
	self:Emit(CarWashTimelineSystem.PLAY_ART_TIMELINE, arg_66_1.hidden_reaction)

	return
end

return CarWashGameFlowSystem
