local var_0_0 = class("CarWashTimelineSystem", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_0.PLAY_TRANSITION = "CarWashTimelineSystem.PLAY_TRANSITION"
var_0_0.PLAY_ART_TIMELINE = "CarWashTimelineSystem.PLAY_ART_TIMELINE"
var_0_0.EXIT_ART_TIMELINE = "CarWashTimelineSystem.EXIT_ART_TIMELINE"
var_0_0.TRANSITION_BEGIN = "CarWashTimelineSystem.TRANSITION_BEGIN"
var_0_0.TRANSITION_HOLD = "CarWashTimelineSystem.TRANSITION_HOLD"
var_0_0.TRANSITION_END = "CarWashTimelineSystem.TRANSITION_END"
var_0_0.TIMELINE_SEQUENCE_BEGIN = "CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN"
var_0_0.TIMELINE_SEQUENCE_END = "CarWashTimelineSystem.TIMELINE_SEQUENCE_END"
var_0_0.ART_TIMELINE_SIGNAL = "CarWashTimelineSystem.ART_TIMELINE_SIGNAL"
var_0_0.TRANSITION = {
	WHITE = "white",
	BLACK = "black"
}
var_0_0.SIGNAL = {
	EXIT_TRANSITION = "ExitTransition",
	TRANSITION_HOLD = "TransitionHold",
	TIMELINE_END = "TimelineEnd"
}
var_0_0.DEFAULT_SEQUENCE_PATH = "[sequence]"
var_0_0.DEFAULT_TRANSITION_ASSETS = {
	black = "dorm3d/scenesres/scenes/carwash/gameplayasset/pla_fade-in-out_blacktimeline",
	white = "dorm3d/scenesres/scenes/carwash/gameplayasset/pla_fade-in-out_whitetimeline"
}

function var_0_0.OnInit(arg_1_0)
	arg_1_0.transitionAssets = {}

	return
end

function var_0_0.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_0.PLAY_TRANSITION, function(arg_3_0, arg_3_1)
		arg_2_0:PlayTransition(arg_3_1)

		return
	end)
	arg_2_0:Bind(var_0_0.PLAY_ART_TIMELINE, function(arg_4_0, arg_4_1)
		arg_2_0:PlayArtTimeline(arg_4_1)

		return
	end)
	arg_2_0:Bind(var_0_0.EXIT_ART_TIMELINE, function(arg_5_0, arg_5_1)
		arg_2_0:StartArtExitTransition(arg_5_1)

		return
	end)

	return
end

function var_0_0.OnDispose(arg_6_0)
	arg_6_0.exited = true

	arg_6_0:StopTransition()
	arg_6_0:DisposeArtPlayer()

	if arg_6_0.artSceneInfo then
		SceneOpMgr.Inst:UnloadSceneAsync(arg_6_0.artSceneInfo.path, arg_6_0.artSceneInfo.name)

		arg_6_0.artSceneInfo = nil
	end

	if arg_6_0.transitionPlayer and arg_6_0.transitionPlayer.signalReceiver then
		arg_6_0.transitionPlayer.signalReceiver:SetCommonEvent(nil)
	end

	if arg_6_0.transitionGO then
		Destroy(arg_6_0.transitionGO)
	end

	arg_6_0.transitionPlayer = nil
	arg_6_0.transitionDirector = nil
	arg_6_0.transitionGO = nil
	arg_6_0.transitionContext = nil
	arg_6_0.transitionAssets = nil
	arg_6_0.artContext = nil

	return
end

function var_0_0.GetOrCreateTransitionDirector(arg_7_0)
	if arg_7_0.transitionDirector then
		return arg_7_0.transitionDirector
	end

	arg_7_0.transitionGO = GameObject.New("[CarWashTransitionDirector]")
	arg_7_0.transitionDirector = GetOrAddComponent(arg_7_0.transitionGO, typeof(UnityEngine.Playables.PlayableDirector))
	arg_7_0.transitionDirector.playOnAwake = false

	return arg_7_0.transitionDirector
end

function var_0_0.SetTransitionAsset(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetOrCreateTransitionDirector()

	var_8_0:Stop()

	var_8_0.playableAsset = arg_8_1
	arg_8_0.transitionPlayer = arg_8_0.transitionPlayer or TimelinePlayer.New(var_8_0.transform, UnityEngine.Playables.DirectorWrapMode.None)

	arg_8_0.transitionPlayer:Register(nil, function(arg_9_0, arg_9_1, arg_9_2)
		arg_8_0:OnTransitionSignal(arg_9_1)

		return
	end)

	return arg_8_0.transitionPlayer
end

function var_0_0.PlayTransition(arg_10_0, arg_10_1)
	assert(arg_10_1, "CarWash transition data is nil")
	assert(arg_10_1.type, "CarWash transition type is nil")
	assert(var_0_0.DEFAULT_TRANSITION_ASSETS[arg_10_1.type], "CarWash transition asset config not found: " .. tostring(arg_10_1.type))
	assert(not arg_10_0.isTransitionPlaying, "CarWash transition is already playing: " .. tostring(arg_10_1.type))
	arg_10_0:LoadTransitionAsset(arg_10_1, function(arg_11_0)
		assert(not arg_10_0.exited, "CarWash transition asset loaded after system disposed")

		local var_11_0 = arg_10_0:SetTransitionAsset(arg_11_0)

		arg_10_0.transitionContext = {
			holdResumed = false,
			type = arg_10_1.type,
			data = arg_10_1
		}
		arg_10_0.isTransitionPlaying = true

		arg_10_0:Emit(var_0_0.TRANSITION_BEGIN, {
			type = arg_10_1.type,
			data = arg_10_1
		})
		var_11_0:SetTime(0)
		var_11_0:Start()

		return
	end)

	return
end

function var_0_0.LoadTransitionAsset(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.type

	if arg_12_0.transitionAssets[arg_12_1.type] then
		existCall(arg_12_2, arg_12_0.transitionAssets[arg_12_1.type])

		return
	end

	local var_12_1 = var_0_0.DEFAULT_TRANSITION_ASSETS[arg_12_1.type]

	assert(var_0_0.DEFAULT_TRANSITION_ASSETS[arg_12_1.type], "CarWash transition asset path is nil: " .. tostring(arg_12_1.type))
	arg_12_0:GetLoader():LoadReference(var_12_1, "", typeof(UnityEngine.Playables.PlayableAsset), function(arg_13_0)
		assert(arg_13_0, "CarWash transition asset load failed: " .. tostring(var_12_1))

		arg_12_0.transitionAssets[var_12_0] = arg_13_0

		existCall(arg_12_2, arg_13_0)

		return
	end)

	return
end

function var_0_0.OnTransitionSignal(arg_14_0, arg_14_1)
	if arg_14_1.stringParameter == var_0_0.SIGNAL.TRANSITION_HOLD then
		arg_14_0:OnTransitionHold(arg_14_1)
	elseif arg_14_1.stringParameter == var_0_0.SIGNAL.TIMELINE_END then
		arg_14_0:OnTransitionEnd(arg_14_1)
	else
		assert(false, "Unknown CarWash transition signal: " .. tostring(arg_14_1.stringParameter))
	end

	return
end

function var_0_0.OnTransitionHold(arg_15_0, arg_15_1)
	assert(arg_15_0.transitionContext, "CarWash transition context is nil")
	assert(not arg_15_0.transitionContext.holdResumed, "CarWash transition hold signal triggered more than once")
	assert(arg_15_0.transitionPlayer, "CarWash transition player is nil")

	arg_15_0.transitionContext.holdResumed = true

	arg_15_0.transitionPlayer:SetSpeed(0)

	local var_15_0 = false

	arg_15_0:Emit(var_0_0.TRANSITION_HOLD, {
		type = arg_15_0.transitionContext.type,
		data = arg_15_0.transitionContext.data,
		event = arg_15_1,
		resume = function()
			assert(not var_15_0, "CarWash transition resumed more than once")
			assert(arg_15_0.transitionPlayer, "CarWash transition player is nil")

			var_15_0 = true

			arg_15_0.transitionPlayer:SetSpeed(1)

			return
		end
	})

	if arg_15_0.transitionContext.data.onHold then
		arg_15_0.transitionContext.data.onHold(function()
			assert(not var_15_0, "CarWash transition resumed more than once")
			assert(arg_15_0.transitionPlayer, "CarWash transition player is nil")

			var_15_0 = true

			arg_15_0.transitionPlayer:SetSpeed(1)

			return
		end, arg_15_1)
	elseif not arg_15_0.transitionContext.data.waitHold then
		(function()
			assert(not var_15_0, "CarWash transition resumed more than once")
			assert(arg_15_0.transitionPlayer, "CarWash transition player is nil")

			var_15_0 = true

			arg_15_0.transitionPlayer:SetSpeed(1)

			return
		end)()
	end

	return
end

function var_0_0.OnTransitionEnd(arg_17_0, arg_17_1)
	assert(arg_17_0.transitionContext, "CarWash transition context is nil")

	arg_17_0.isTransitionPlaying = false
	arg_17_0.transitionContext = nil

	arg_17_0:Emit(var_0_0.TRANSITION_END, {
		type = arg_17_0.transitionContext.type,
		data = arg_17_0.transitionContext.data,
		event = arg_17_1
	})

	if arg_17_0.transitionContext.data and arg_17_0.transitionContext.data.onFinish then
		arg_17_0.transitionContext.data.onFinish(arg_17_1)
	end

	return
end

function var_0_0.StopTransition(arg_18_0)
	if arg_18_0.transitionPlayer then
		arg_18_0.transitionPlayer:SetSpeed(1)
		arg_18_0.transitionPlayer:Stop()
	end

	arg_18_0.isTransitionPlaying = false
	arg_18_0.transitionContext = nil

	return
end

function var_0_0.PlayArtTimeline(arg_19_0, arg_19_1)
	assert(arg_19_1, "CarWash art timeline data is nil")
	assert(not arg_19_0.artContext, "CarWash art timeline is already playing")

	arg_19_0.artContext = {
		exitTransitionStarted = false,
		data = arg_19_1
	}

	arg_19_0:PlayTransition({
		waitHold = true,
		type = arg_19_0.artContext.data.enter,
		onHold = function(arg_20_0)
			arg_19_0:LoadArtScene(arg_19_1, function()
				arg_19_0:Emit(var_0_0.TIMELINE_SEQUENCE_BEGIN, {
					data = arg_19_1
				})
				arg_19_0:StartArtPlayer(arg_19_1)
				arg_20_0()

				return
			end)

			return
		end
	})

	return
end

function var_0_0.LoadArtScene(arg_22_0, arg_22_1, arg_22_2)
	assert(arg_22_1.sceneAB, "CarWash art timeline sceneAB is nil")
	assert(arg_22_1.sceneName, "CarWash art timeline sceneName is nil")

	arg_22_0.artSceneInfo = {
		path = arg_22_1.sceneAB,
		name = arg_22_1.sceneName
	}

	SceneOpMgr.Inst:LoadSceneAsync(arg_22_1.sceneAB, arg_22_1.sceneName, LoadSceneMode.Additive, function(arg_23_0, arg_23_1)
		assert(not arg_22_0.exited, "CarWash art timeline scene loaded after system disposed")
		existCall(arg_22_2, arg_23_0, arg_23_1)

		return
	end)

	return
end

function var_0_0.StartArtPlayer(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:FindArtDirector(arg_24_1)

	assert(var_24_0, "CarWash art timeline director not found")

	arg_24_0.artDirector = var_24_0
	arg_24_0.artDirector.playOnAwake = false

	TimelineSupport.DisablePlayOnAwake(arg_24_0.artDirector)

	arg_24_0.artPlayer = TimelinePlayer.New(arg_24_0.artDirector.transform, UnityEngine.Playables.DirectorWrapMode.Loop)

	arg_24_0.artPlayer:Register(nil, function(arg_25_0, arg_25_1, arg_25_2)
		arg_24_0:OnArtTimelineSignal(arg_25_1)

		return
	end)

	local var_24_1 = arg_24_1.time or 0

	arg_24_0.artPlayer:SetTime(var_24_1)
	arg_24_0.artPlayer.comDirector:Evaluate()
	arg_24_0.artPlayer:Start()

	return
end

function var_0_0.FindArtDirector(arg_26_0, arg_26_1)
	local var_26_0

	if not arg_26_1.sequencePath then
		var_26_0 = var_0_0.DEFAULT_SEQUENCE_PATH
	end

	local var_26_1 = SceneManager.GetSceneByName(arg_26_1.sceneName)
	local var_26_2

	table.IpairsCArray(var_26_1:GetRootGameObjects(), function(arg_27_0, arg_27_1)
		if var_26_2 then
			return
		end

		local var_27_0 = tf(arg_27_1)
		local var_27_1 = var_27_0.name == var_26_0 and var_27_0 or var_27_0:Find(var_26_0)

		if var_27_1 then
			var_26_2 = var_27_1:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
		end

		return
	end)

	return nil
end

function var_0_0.OnArtTimelineSignal(arg_28_0, arg_28_1)
	assert(arg_28_0.artContext, "CarWash art timeline context is nil")
	arg_28_0:Emit(var_0_0.ART_TIMELINE_SIGNAL, {
		data = arg_28_0.artContext.data,
		event = arg_28_1,
		signal = arg_28_1.stringParameter
	})

	if arg_28_1.stringParameter == var_0_0.SIGNAL.EXIT_TRANSITION then
		arg_28_0:StartArtExitTransition()
	else
		assert(false, "Unknown CarWash art timeline signal: " .. tostring(arg_28_1.stringParameter))
	end

	return
end

function var_0_0.StartArtExitTransition(arg_29_0, arg_29_1)
	if not arg_29_0.artContext then
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

	assert(arg_29_0.artContext, "CarWash art timeline context is nil")
	assert(not arg_29_0.artContext.exitTransitionStarted, "CarWash ExitTransition signal triggered more than once")

	arg_29_0.artContext.exitTransitionStarted = true

	local var_29_0 = arg_29_0.artContext.data

	arg_29_0:PlayTransition({
		waitHold = true,
		type = arg_29_0.artContext.data.exit,
		onHold = function(arg_31_0, arg_31_1)
			arg_29_0:UnloadArtScene(function()
				arg_29_0:Emit(var_0_0.TIMELINE_SEQUENCE_END, {
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

			arg_29_0:FinishArtTimeline(arg_33_0)

			return
		end
	})

	return
end

function var_0_0.UnloadArtScene(arg_34_0, arg_34_1)
	arg_34_0:DisposeArtPlayer()
	assert(arg_34_0.artSceneInfo, "CarWash art timeline scene info is nil")

	arg_34_0.artSceneInfo = nil

	SceneOpMgr.Inst:UnloadSceneAsync(arg_34_0.artSceneInfo.path, arg_34_0.artSceneInfo.name, function()
		existCall(arg_34_1)

		return
	end)

	return
end

function var_0_0.DisposeArtPlayer(arg_36_0)
	if arg_36_0.artPlayer then
		if arg_36_0.artPlayer.signalReceiver then
			arg_36_0.artPlayer.signalReceiver:SetCommonEvent(nil)
		end

		arg_36_0.artPlayer:Stop()
		arg_36_0.artPlayer:Dispose()

		arg_36_0.artPlayer = nil
	end

	arg_36_0.artDirector = nil

	return
end

function var_0_0.FinishArtTimeline(arg_37_0, arg_37_1)
	assert(arg_37_0.artContext, "CarWash art timeline context is nil")

	arg_37_0.artContext = nil

	if arg_37_0.artContext.data.onFinish then
		arg_37_0.artContext.data.onFinish(arg_37_1)
	end

	return
end

return var_0_0
