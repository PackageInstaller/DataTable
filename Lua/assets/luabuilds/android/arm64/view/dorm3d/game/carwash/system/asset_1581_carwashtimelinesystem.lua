local CarWashTimelineSystem = class("CarWashTimelineSystem", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

CarWashTimelineSystem.PLAY_TRANSITION = "CarWashTimelineSystem.PLAY_TRANSITION"
CarWashTimelineSystem.PLAY_ART_TIMELINE = "CarWashTimelineSystem.PLAY_ART_TIMELINE"
CarWashTimelineSystem.EXIT_ART_TIMELINE = "CarWashTimelineSystem.EXIT_ART_TIMELINE"
CarWashTimelineSystem.TRANSITION_BEGIN = "CarWashTimelineSystem.TRANSITION_BEGIN"
CarWashTimelineSystem.TRANSITION_HOLD = "CarWashTimelineSystem.TRANSITION_HOLD"
CarWashTimelineSystem.TRANSITION_END = "CarWashTimelineSystem.TRANSITION_END"
CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN = "CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN"
CarWashTimelineSystem.TIMELINE_SEQUENCE_END = "CarWashTimelineSystem.TIMELINE_SEQUENCE_END"
CarWashTimelineSystem.ART_TIMELINE_SIGNAL = "CarWashTimelineSystem.ART_TIMELINE_SIGNAL"
CarWashTimelineSystem.TRANSITION = {
	WHITE = "white",
	BLACK = "black"
}
CarWashTimelineSystem.SIGNAL = {
	EXIT_TRANSITION = "ExitTransition",
	TRANSITION_HOLD = "TransitionHold",
	TIMELINE_END = "TimelineEnd"
}
CarWashTimelineSystem.DEFAULT_SEQUENCE_PATH = "[sequence]"
CarWashTimelineSystem.DEFAULT_TRANSITION_ASSETS = {
	black = "dorm3d/scenesres/scenes/carwash/gameplayasset/pla_fade-in-out_blacktimeline",
	white = "dorm3d/scenesres/scenes/carwash/gameplayasset/pla_fade-in-out_whitetimeline"
}

function CarWashTimelineSystem:OnInit()
	self.transitionAssets = {}

	return
end

function CarWashTimelineSystem:RegisterEvents()
	self:Bind(CarWashTimelineSystem.PLAY_TRANSITION, function(arg_3_0, arg_3_1)
		self:PlayTransition(arg_3_1)

		return
	end)
	self:Bind(CarWashTimelineSystem.PLAY_ART_TIMELINE, function(arg_4_0, arg_4_1)
		self:PlayArtTimeline(arg_4_1)

		return
	end)
	self:Bind(CarWashTimelineSystem.EXIT_ART_TIMELINE, function(arg_5_0, arg_5_1)
		self:StartArtExitTransition(arg_5_1)

		return
	end)

	return
end

function CarWashTimelineSystem:OnDispose()
	self.exited = true

	self:StopTransition()
	self:DisposeArtPlayer()

	if self.artSceneInfo then
		SceneOpMgr.Inst:UnloadSceneAsync(self.artSceneInfo.path, self.artSceneInfo.name)

		self.artSceneInfo = nil
	end

	if self.transitionPlayer and self.transitionPlayer.signalReceiver then
		self.transitionPlayer.signalReceiver:SetCommonEvent(nil)
	end

	if self.transitionGO then
		Destroy(self.transitionGO)
	end

	self.transitionPlayer = nil
	self.transitionDirector = nil
	self.transitionGO = nil
	self.transitionContext = nil
	self.transitionAssets = nil
	self.artContext = nil

	return
end

function CarWashTimelineSystem:GetOrCreateTransitionDirector()
	if self.transitionDirector then
		return self.transitionDirector
	end

	self.transitionGO = GameObject.New("[CarWashTransitionDirector]")
	self.transitionDirector = GetOrAddComponent(self.transitionGO, typeof(UnityEngine.Playables.PlayableDirector))
	self.transitionDirector.playOnAwake = false

	return self.transitionDirector
end

function CarWashTimelineSystem:SetTransitionAsset(arg_8_1)
	local var_8_0 = self:GetOrCreateTransitionDirector()

	var_8_0:Stop()

	var_8_0.playableAsset = arg_8_1
	self.transitionPlayer = self.transitionPlayer or TimelinePlayer.New(var_8_0.transform, UnityEngine.Playables.DirectorWrapMode.None)

	self.transitionPlayer:Register(nil, function(arg_9_0, arg_9_1, arg_9_2)
		self:OnTransitionSignal(arg_9_1)

		return
	end)

	return self.transitionPlayer
end

function CarWashTimelineSystem:PlayTransition(arg_10_1)
	assert(arg_10_1, "CarWash transition data is nil")
	assert(arg_10_1.type, "CarWash transition type is nil")
	assert(CarWashTimelineSystem.DEFAULT_TRANSITION_ASSETS[arg_10_1.type], "CarWash transition asset config not found: " .. tostring(arg_10_1.type))
	assert(not self.isTransitionPlaying, "CarWash transition is already playing: " .. tostring(arg_10_1.type))
	self:LoadTransitionAsset(arg_10_1, function(arg_11_0)
		assert(not self.exited, "CarWash transition asset loaded after system disposed")

		local var_11_0 = self:SetTransitionAsset(arg_11_0)

		self.transitionContext = {
			holdResumed = false,
			type = arg_10_1.type,
			data = arg_10_1
		}
		self.isTransitionPlaying = true

		self:Emit(CarWashTimelineSystem.TRANSITION_BEGIN, {
			type = arg_10_1.type,
			data = arg_10_1
		})
		var_11_0:SetTime(0)
		var_11_0:Start()

		return
	end)

	return
end

function CarWashTimelineSystem:LoadTransitionAsset(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.type

	if self.transitionAssets[arg_12_1.type] then
		existCall(arg_12_2, self.transitionAssets[arg_12_1.type])

		return
	end

	local var_12_1 = CarWashTimelineSystem.DEFAULT_TRANSITION_ASSETS[arg_12_1.type]

	assert(CarWashTimelineSystem.DEFAULT_TRANSITION_ASSETS[arg_12_1.type], "CarWash transition asset path is nil: " .. tostring(arg_12_1.type))
	self:GetLoader():LoadReference(var_12_1, "", typeof(UnityEngine.Playables.PlayableAsset), function(arg_13_0)
		assert(arg_13_0, "CarWash transition asset load failed: " .. tostring(var_12_1))

		self.transitionAssets[var_12_0] = arg_13_0

		existCall(arg_12_2, arg_13_0)

		return
	end)

	return
end

function CarWashTimelineSystem:OnTransitionSignal(arg_14_1)
	if arg_14_1.stringParameter == CarWashTimelineSystem.SIGNAL.TRANSITION_HOLD then
		self:OnTransitionHold(arg_14_1)
	elseif arg_14_1.stringParameter == CarWashTimelineSystem.SIGNAL.TIMELINE_END then
		self:OnTransitionEnd(arg_14_1)
	else
		assert(false, "Unknown CarWash transition signal: " .. tostring(arg_14_1.stringParameter))
	end

	return
end

function CarWashTimelineSystem:OnTransitionHold(arg_15_1)
	assert(self.transitionContext, "CarWash transition context is nil")
	assert(not self.transitionContext.holdResumed, "CarWash transition hold signal triggered more than once")
	assert(self.transitionPlayer, "CarWash transition player is nil")

	self.transitionContext.holdResumed = true

	self.transitionPlayer:SetSpeed(0)

	local var_15_0 = false

	local function var_15_1()
		assert(not var_15_0, "CarWash transition resumed more than once")
		assert(self.transitionPlayer, "CarWash transition player is nil")

		var_15_0 = true

		self.transitionPlayer:SetSpeed(1)

		return
	end

	self:Emit(CarWashTimelineSystem.TRANSITION_HOLD, {
		type = self.transitionContext.type,
		data = self.transitionContext.data,
		event = arg_15_1,
		resume = var_15_1
	})

	if self.transitionContext.data.onHold then
		self.transitionContext.data.onHold(var_15_1, arg_15_1)
	elseif not self.transitionContext.data.waitHold then
		var_15_1()
	end

	return
end

function CarWashTimelineSystem:OnTransitionEnd(arg_17_1)
	assert(self.transitionContext, "CarWash transition context is nil")

	self.isTransitionPlaying = false
	self.transitionContext = nil

	self:Emit(CarWashTimelineSystem.TRANSITION_END, {
		type = self.transitionContext.type,
		data = self.transitionContext.data,
		event = arg_17_1
	})

	if self.transitionContext.data and self.transitionContext.data.onFinish then
		self.transitionContext.data.onFinish(arg_17_1)
	end

	return
end

function CarWashTimelineSystem:StopTransition()
	if self.transitionPlayer then
		self.transitionPlayer:SetSpeed(1)
		self.transitionPlayer:Stop()
	end

	self.isTransitionPlaying = false
	self.transitionContext = nil

	return
end

function CarWashTimelineSystem:PlayArtTimeline(arg_19_1)
	assert(arg_19_1, "CarWash art timeline data is nil")
	assert(not self.artContext, "CarWash art timeline is already playing")

	self.artContext = {
		exitTransitionStarted = false,
		data = arg_19_1
	}

	self:PlayTransition({
		waitHold = true,
		type = self.artContext.data.enter,
		onHold = function(arg_20_0)
			self:LoadArtScene(arg_19_1, function()
				self:Emit(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, {
					data = arg_19_1
				})
				self:StartArtPlayer(arg_19_1)
				arg_20_0()

				return
			end)

			return
		end
	})

	return
end

function CarWashTimelineSystem:LoadArtScene(arg_22_1, arg_22_2)
	assert(arg_22_1.sceneAB, "CarWash art timeline sceneAB is nil")
	assert(arg_22_1.sceneName, "CarWash art timeline sceneName is nil")

	self.artSceneInfo = {
		path = arg_22_1.sceneAB,
		name = arg_22_1.sceneName
	}

	SceneOpMgr.Inst:LoadSceneAsync(arg_22_1.sceneAB, arg_22_1.sceneName, LoadSceneMode.Additive, function(arg_23_0, arg_23_1)
		assert(not self.exited, "CarWash art timeline scene loaded after system disposed")
		existCall(arg_22_2, arg_23_0, arg_23_1)

		return
	end)

	return
end

function CarWashTimelineSystem:StartArtPlayer(arg_24_1)
	local var_24_0 = self:FindArtDirector(arg_24_1)

	assert(var_24_0, "CarWash art timeline director not found")

	self.artDirector = var_24_0
	self.artDirector.playOnAwake = false

	TimelineSupport.DisablePlayOnAwake(self.artDirector)

	self.artPlayer = TimelinePlayer.New(self.artDirector.transform, UnityEngine.Playables.DirectorWrapMode.Loop)

	self.artPlayer:Register(nil, function(arg_25_0, arg_25_1, arg_25_2)
		self:OnArtTimelineSignal(arg_25_1)

		return
	end)
	self.artPlayer:SetTime(arg_24_1.time or 0)
	self.artPlayer.comDirector:Evaluate()
	self.artPlayer:Start()

	return
end

function CarWashTimelineSystem:FindArtDirector(arg_26_1)
	local var_26_0 = arg_26_1.sequencePath or CarWashTimelineSystem.DEFAULT_SEQUENCE_PATH
	local var_26_1

	table.IpairsCArray(SceneManager.GetSceneByName(arg_26_1.sceneName):GetRootGameObjects(), function(arg_27_0, arg_27_1)
		if var_26_1 then
			return
		end

		local var_27_0 = tf(arg_27_1)
		local var_27_1 = var_27_0.name == var_26_0 and var_27_0 or var_27_0:Find(var_26_0)

		if var_27_1 then
			var_26_1 = var_27_1:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
		end

		return
	end)

	return nil
end

function CarWashTimelineSystem:OnArtTimelineSignal(arg_28_1)
	assert(self.artContext, "CarWash art timeline context is nil")
	self:Emit(CarWashTimelineSystem.ART_TIMELINE_SIGNAL, {
		data = self.artContext.data,
		event = arg_28_1,
		signal = arg_28_1.stringParameter
	})

	if arg_28_1.stringParameter == CarWashTimelineSystem.SIGNAL.EXIT_TRANSITION then
		self:StartArtExitTransition()
	else
		assert(false, "Unknown CarWash art timeline signal: " .. tostring(arg_28_1.stringParameter))
	end

	return
end

function CarWashTimelineSystem:StartArtExitTransition(arg_29_1)
	if not self.artContext then
		if arg_29_1 and arg_29_1.onHold then
			arg_29_1.onHold(function()
				if arg_29_1.onFinish then
					arg_29_1.onFinish()
				end

				return
			end)
		elseif arg_29_1 and arg_29_1.onFinish then
			arg_29_1.onFinish()
		end

		return
	end

	assert(self.artContext, "CarWash art timeline context is nil")
	assert(not self.artContext.exitTransitionStarted, "CarWash ExitTransition signal triggered more than once")

	self.artContext.exitTransitionStarted = true

	local var_29_0 = self.artContext.data

	self:PlayTransition({
		waitHold = true,
		type = self.artContext.data.exit,
		onHold = function(arg_31_0, arg_31_1)
			self:UnloadArtScene(function()
				self:Emit(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, {
					data = var_29_0
				})

				if arg_29_1 and arg_29_1.onHold then
					arg_29_1.onHold(arg_31_0, arg_31_1)
				else
					arg_31_0()
				end

				return
			end)

			return
		end,
		onFinish = function(arg_33_0)
			if arg_29_1 and arg_29_1.onFinish then
				arg_29_1.onFinish(arg_33_0)
			end

			self:FinishArtTimeline(arg_33_0)

			return
		end
	})

	return
end

function CarWashTimelineSystem:UnloadArtScene(arg_34_1)
	self:DisposeArtPlayer()
	assert(self.artSceneInfo, "CarWash art timeline scene info is nil")

	self.artSceneInfo = nil

	SceneOpMgr.Inst:UnloadSceneAsync(self.artSceneInfo.path, self.artSceneInfo.name, function()
		existCall(arg_34_1)

		return
	end)

	return
end

function CarWashTimelineSystem:DisposeArtPlayer()
	if self.artPlayer then
		if self.artPlayer.signalReceiver then
			self.artPlayer.signalReceiver:SetCommonEvent(nil)
		end

		self.artPlayer:Stop()
		self.artPlayer:Dispose()

		self.artPlayer = nil
	end

	self.artDirector = nil

	return
end

function CarWashTimelineSystem:FinishArtTimeline(arg_37_1)
	assert(self.artContext, "CarWash art timeline context is nil")

	self.artContext = nil

	if self.artContext.data.onFinish then
		self.artContext.data.onFinish(arg_37_1)
	end

	return
end

return CarWashTimelineSystem
