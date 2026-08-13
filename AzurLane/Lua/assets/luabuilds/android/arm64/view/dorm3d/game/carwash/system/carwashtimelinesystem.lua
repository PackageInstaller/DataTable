class = var_0_10000

local var_0_0 = "CarWashTimelineSystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_1.PLAY_TRANSITION = "CarWashTimelineSystem.PLAY_TRANSITION"
var_0_1.PLAY_ART_TIMELINE = "CarWashTimelineSystem.PLAY_ART_TIMELINE"
var_0_1.EXIT_ART_TIMELINE = "CarWashTimelineSystem.EXIT_ART_TIMELINE"
var_0_1.TRANSITION_BEGIN = "CarWashTimelineSystem.TRANSITION_BEGIN"
var_0_1.TRANSITION_HOLD = "CarWashTimelineSystem.TRANSITION_HOLD"
var_0_1.TRANSITION_END = "CarWashTimelineSystem.TRANSITION_END"
var_0_1.TIMELINE_SEQUENCE_BEGIN = "CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN"
var_0_1.TIMELINE_SEQUENCE_END = "CarWashTimelineSystem.TIMELINE_SEQUENCE_END"
var_0_1.ART_TIMELINE_SIGNAL = "CarWashTimelineSystem.ART_TIMELINE_SIGNAL"
var_0_1.TRANSITION = {
	WHITE = "white",
	BLACK = "black"
}
var_0_1.SIGNAL = {
	EXIT_TRANSITION = "ExitTransition",
	TRANSITION_HOLD = "TransitionHold",
	TIMELINE_END = "TimelineEnd"
}
var_0_1.DEFAULT_SEQUENCE_PATH = "[sequence]"
var_0_1.DEFAULT_TRANSITION_ASSETS = {
	black = "dorm3d/scenesres/scenes/carwash/gameplayasset/pla_fade-in-out_blacktimeline",
	white = "dorm3d/scenesres/scenes/carwash/gameplayasset/pla_fade-in-out_whitetimeline"
}

function var_0_1.OnInit(arg_1_0)
	arg_1_0.transitionAssets = {}

	return
end

function var_0_1.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_1.PLAY_TRANSITION, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.PlayTransition(var_3_0, arg_3_1)

		return
	end)
	arg_2_0:Bind(var_0_1.PLAY_ART_TIMELINE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.PlayArtTimeline(var_4_0, arg_4_1)

		return
	end)
	arg_2_0:Bind(var_0_1.EXIT_ART_TIMELINE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.StartArtExitTransition(var_5_0, arg_5_1)

		return
	end)

	return
end

function var_0_1.OnDispose(arg_6_0)
	arg_6_0.exited = true

	arg_6_0:StopTransition()
	arg_6_0:DisposeArtPlayer()

	if arg_6_0.artSceneInfo then
		SceneOpMgr = var_1

		local var_6_0 = var_1.Inst

		var_1.UnloadSceneAsync(var_6_0, arg_6_0.artSceneInfo.path, arg_6_0.artSceneInfo.name)

		arg_6_0.artSceneInfo = nil
	end

	if arg_6_0.transitionPlayer and arg_6_0.transitionPlayer.signalReceiver then
		local var_6_1 = arg_6_0.transitionPlayer.signalReceiver

		var_1.SetCommonEvent(var_6_1, nil)
	end

	if arg_6_0.transitionGO then
		Destroy = var_1

		var_1(arg_6_0.transitionGO)
	end

	arg_6_0.transitionPlayer = nil
	arg_6_0.transitionDirector = nil
	arg_6_0.transitionGO = nil
	arg_6_0.transitionContext = nil
	arg_6_0.transitionAssets = nil
	arg_6_0.artContext = nil

	return
end

function var_0_1.GetOrCreateTransitionDirector(arg_7_0)
	if arg_7_0.transitionDirector then
		return arg_7_0.transitionDirector
	end

	GameObject = var_1
	arg_7_0.transitionGO = var_1.New("[CarWashTransitionDirector]")
	GetOrAddComponent = var_1

	local var_7_0 = arg_7_0.transitionGO

	typeof = var_1_10004
	UnityEngine = var_1_10006
	arg_7_0.transitionDirector = var_1(var_7_0, var_1_10004(var_1_10006.Playables.PlayableDirector))
	arg_7_0.transitionDirector.playOnAwake = false

	return arg_7_0.transitionDirector
end

function var_0_1.SetTransitionAsset(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetOrCreateTransitionDirector()

	var_2.Stop(var_8_0)

	var_2.playableAsset = arg_8_1

	if not arg_8_0.transitionPlayer then
		TimelinePlayer = var_3

		local var_8_1 = var_3.New
		local var_8_2 = var_2.transform

		UnityEngine = var_1_10006
		arg_8_0.transitionPlayer = var_8_1(var_8_2, var_1_10006.Playables.DirectorWrapMode.None)
	end

	local var_8_3 = arg_8_0.transitionPlayer

	var_3.Register(var_8_3, nil, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_8_0

		var_3.OnTransitionSignal(var_9_0, arg_9_1)

		return
	end)

	return arg_8_0.transitionPlayer
end

function var_0_1.PlayTransition(arg_10_0, arg_10_1)
	assert = var_1_10002

	var_1_10002(arg_10_1, "CarWash transition data is nil")

	assert = var_1_10002

	var_1_10002(arg_10_1.type, "CarWash transition type is nil")

	assert = var_1_10002

	local var_10_0 = var_0_1.DEFAULT_TRANSITION_ASSETS[arg_10_1.type]
	local var_10_1 = "CarWash transition asset config not found: "

	tostring = var_1_10006

	var_1_10002(var_10_0, var_10_1 .. var_1_10006(arg_10_1.type))

	assert = var_1_10002

	local var_10_2 = not arg_10_0.isTransitionPlaying
	local var_10_3 = "CarWash transition is already playing: "

	tostring = var_6

	var_1_10002(var_10_2, var_10_3 .. var_6(arg_10_1.type))
	arg_10_0:LoadTransitionAsset(arg_10_1, function(arg_11_0)
		assert = var_2_10001

		var_2_10001(not arg_10_0.exited, "CarWash transition asset loaded after system disposed")

		local var_11_0 = arg_10_0
		local var_11_1 = var_1.SetTransitionAsset(var_11_0, arg_11_0)

		arg_10_0.transitionContext = {
			holdResumed = false,
			type = arg_10_1.type,
			data = arg_10_1
		}
		arg_10_0.isTransitionPlaying = true

		local var_11_2 = arg_10_0

		var_2.Emit(var_11_2, var_0_1.TRANSITION_BEGIN, {
			type = arg_10_1.type,
			data = arg_10_1
		})
		var_11_1:SetTime(0)
		var_11_1:Start()

		return
	end)

	return
end

function var_0_1.LoadTransitionAsset(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.type

	if arg_12_0.transitionAssets[var_12_0] then
		existCall = var_4

		var_4(arg_12_2, arg_12_0.transitionAssets[var_12_0])

		return
	end

	local var_12_1 = var_0_1.DEFAULT_TRANSITION_ASSETS[arg_12_1.type]

	assert = var_5

	local var_12_2 = var_12_1
	local var_12_3 = "CarWash transition asset path is nil: "

	tostring = var_1_10009

	var_5(var_12_2, var_12_3 .. var_1_10009(arg_12_1.type))

	local var_12_4 = arg_12_0:GetLoader()
	local var_12_5 = var_5.LoadReference
	local var_12_6 = var_12_1
	local var_12_7 = ""

	typeof = var_1_10010
	UnityEngine = var_1_10012

	var_12_5(var_12_4, var_12_6, var_12_7, var_1_10010(var_1_10012.Playables.PlayableAsset), function(arg_13_0)
		assert = var_2_10001

		local var_13_0 = arg_13_0
		local var_13_1 = "CarWash transition asset load failed: "

		tostring = var_2_10005

		var_2_10001(var_13_0, var_13_1 .. var_2_10005(var_12_1))

		local var_13_2 = arg_12_0.transitionAssets

		var_13_2[var_12_0] = arg_13_0
		existCall = var_13_2

		var_13_2(arg_12_2, arg_13_0)

		return
	end)

	return
end

function var_0_1.OnTransitionSignal(arg_14_0, arg_14_1)
	if arg_14_1.stringParameter == var_0_1.SIGNAL.TRANSITION_HOLD then
		arg_14_0:OnTransitionHold(arg_14_1)
	elseif var_2 == var_0_1.SIGNAL.TIMELINE_END then
		arg_14_0:OnTransitionEnd(arg_14_1)
	else
		assert = var_3

		local var_14_0 = false
		local var_14_1 = "Unknown CarWash transition signal: "

		tostring = var_1_10007

		var_3(var_14_0, var_14_1 .. var_1_10007(var_2))
	end

	return
end

function var_0_1.OnTransitionHold(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.transitionContext

	assert = var_1_10003

	var_1_10003(var_15_0, "CarWash transition context is nil")

	assert = var_1_10003

	var_1_10003(not var_15_0.holdResumed, "CarWash transition hold signal triggered more than once")

	assert = var_1_10003

	var_1_10003(arg_15_0.transitionPlayer, "CarWash transition player is nil")

	var_15_0.holdResumed = true

	local var_15_1 = arg_15_0.transitionPlayer

	var_3.SetSpeed(var_15_1, 0)

	local var_15_2 = false

	local function var_15_3()
		assert = var_2_10000

		var_2_10000(not var_15_2, "CarWash transition resumed more than once")

		assert = var_2_10000

		var_2_10000(arg_15_0.transitionPlayer, "CarWash transition player is nil")

		var_15_2 = true

		local var_16_0 = arg_15_0.transitionPlayer

		var_0.SetSpeed(var_16_0, 1)

		return
	end

	local var_15_4 = var_15_0.data

	arg_15_0:Emit(var_0_1.TRANSITION_HOLD, {
		type = var_15_0.type,
		data = var_15_4,
		event = arg_15_1,
		resume = var_15_3
	})

	if var_15_4.onHold then
		var_15_4.onHold(var_15_3, arg_15_1)
	elseif not var_15_4.waitHold then
		var_15_3()
	end

	return
end

function var_0_1.OnTransitionEnd(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.transitionContext

	assert = var_1_10003

	var_1_10003(var_17_0, "CarWash transition context is nil")

	local var_17_1 = var_17_0.data
	local var_17_2 = var_17_0.type

	arg_17_0.isTransitionPlaying = false
	arg_17_0.transitionContext = nil

	arg_17_0:Emit(var_0_1.TRANSITION_END, {
		type = var_17_2,
		data = var_17_1,
		event = arg_17_1
	})

	if var_17_1 and var_17_1.onFinish then
		var_17_1.onFinish(arg_17_1)
	end

	return
end

function var_0_1.StopTransition(arg_18_0)
	if arg_18_0.transitionPlayer then
		local var_18_0 = arg_18_0.transitionPlayer

		var_1.SetSpeed(var_18_0, 1)

		local var_18_1 = arg_18_0.transitionPlayer

		var_1.Stop(var_18_1)
	end

	arg_18_0.isTransitionPlaying = false
	arg_18_0.transitionContext = nil

	return
end

function var_0_1.PlayArtTimeline(arg_19_0, arg_19_1)
	assert = var_1_10002

	var_1_10002(arg_19_1, "CarWash art timeline data is nil")

	assert = var_1_10002

	var_1_10002(not arg_19_0.artContext, "CarWash art timeline is already playing")

	arg_19_0.artContext = {
		exitTransitionStarted = false,
		data = arg_19_1
	}

	arg_19_0:PlayTransition({
		waitHold = true,
		type = arg_19_0.artContext.data.enter,
		onHold = function(arg_20_0)
			local var_20_0 = arg_19_0

			var_1.LoadArtScene(var_20_0, arg_19_1, function()
				local var_21_0 = arg_19_0

				var_0.Emit(var_21_0, var_0_1.TIMELINE_SEQUENCE_BEGIN, {
					data = arg_19_1
				})

				local var_21_1 = arg_19_0

				var_0.StartArtPlayer(var_21_1, arg_19_1)
				arg_20_0()

				return
			end)

			return
		end
	})

	return
end

function var_0_1.LoadArtScene(arg_22_0, arg_22_1, arg_22_2)
	assert = var_1_10003

	var_1_10003(arg_22_1.sceneAB, "CarWash art timeline sceneAB is nil")

	assert = var_1_10003

	var_1_10003(arg_22_1.sceneName, "CarWash art timeline sceneName is nil")

	arg_22_0.artSceneInfo = {
		path = arg_22_1.sceneAB,
		name = arg_22_1.sceneName
	}
	SceneOpMgr = var_3

	local var_22_0 = var_3.Inst
	local var_22_1 = var_3.LoadSceneAsync
	local var_22_2 = arg_22_1.sceneAB
	local var_22_3 = arg_22_1.sceneName

	LoadSceneMode = var_1_10008

	var_22_1(var_22_0, var_22_2, var_22_3, var_1_10008.Additive, function(arg_23_0, arg_23_1)
		assert = var_2_10002

		var_2_10002(not arg_22_0.exited, "CarWash art timeline scene loaded after system disposed")

		existCall = var_2_10002

		var_2_10002(arg_22_2, arg_23_0, arg_23_1)

		return
	end)

	return
end

function var_0_1.StartArtPlayer(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:FindArtDirector(arg_24_1)

	assert = var_1_10003

	var_1_10003(var_24_0, "CarWash art timeline director not found")

	arg_24_0.artDirector = var_24_0

	local var_24_1 = arg_24_0.artDirector

	var_24_1.playOnAwake = false
	TimelineSupport = var_24_1

	var_24_1.DisablePlayOnAwake(arg_24_0.artDirector)

	TimelinePlayer = var_3

	local var_24_2 = var_3.New
	local var_24_3 = arg_24_0.artDirector.transform

	UnityEngine = var_6
	arg_24_0.artPlayer = var_24_2(var_24_3, var_6.Playables.DirectorWrapMode.Loop)

	local var_24_4 = arg_24_0.artPlayer

	var_3.Register(var_24_4, nil, function(arg_25_0, arg_25_1, arg_25_2)
		local var_25_0 = arg_24_0

		var_3.OnArtTimelineSignal(var_25_0, arg_25_1)

		return
	end)

	local var_24_5 = arg_24_0.artPlayer
	local var_24_6 = var_3.SetTime
	local var_24_7

	if not arg_24_1.time then
		var_24_7 = 0
	end

	var_24_6(var_24_5, var_24_7)

	local var_24_8 = arg_24_0.artPlayer.comDirector

	var_3.Evaluate(var_24_8)

	local var_24_9 = arg_24_0.artPlayer

	var_3.Start(var_24_9)

	return
end

function var_0_1.FindArtDirector(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.sceneName
	local var_26_1

	if not arg_26_1.sequencePath then
		var_26_1 = var_0_1.DEFAULT_SEQUENCE_PATH
	end

	SceneManager = var_1_10004

	local var_26_2 = var_1_10004.GetSceneByName(var_26_0)
	local var_26_3 = var_4.GetRootGameObjects(var_26_2)
	local var_26_4

	table = var_26_2

	var_26_2.IpairsCArray(var_26_3, function(arg_27_0, arg_27_1)
		if var_26_4 then
			return
		end

		tf = var_2

		if var_2(arg_27_1).name == var_26_1 and var_2 or var_2:Find(var_26_1) then
			local var_27_0 = var_3
			local var_27_1 = var_3.GetComponent

			typeof = var_2_10007
			UnityEngine = var_2_10009
			var_26_4 = var_27_1(var_27_0, var_2_10007(var_2_10009.Playables.PlayableDirector))
		end

		return
	end)

	return var_26_4
end

function var_0_1.OnArtTimelineSignal(arg_28_0, arg_28_1)
	assert = var_1_10002

	var_1_10002(arg_28_0.artContext, "CarWash art timeline context is nil")

	local var_28_0 = arg_28_0.artContext.data
	local var_28_1 = arg_28_1.stringParameter

	arg_28_0:Emit(var_0_1.ART_TIMELINE_SIGNAL, {
		data = var_28_0,
		event = arg_28_1,
		signal = var_28_1
	})

	if var_28_1 == var_0_1.SIGNAL.EXIT_TRANSITION then
		arg_28_0:StartArtExitTransition()
	else
		assert = var_4

		local var_28_2 = false
		local var_28_3 = "Unknown CarWash art timeline signal: "

		tostring = var_8

		var_4(var_28_2, var_28_3 .. var_8(var_28_1))
	end

	return
end

function var_0_1.StartArtExitTransition(arg_29_0, arg_29_1)
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

	assert = var_2

	var_2(arg_29_0.artContext, "CarWash art timeline context is nil")

	assert = var_2

	var_2(not arg_29_0.artContext.exitTransitionStarted, "CarWash ExitTransition signal triggered more than once")

	arg_29_0.artContext.exitTransitionStarted = true

	local var_29_0 = arg_29_0.artContext.data

	arg_29_0:PlayTransition({
		waitHold = true,
		type = arg_29_0.artContext.data.exit,
		onHold = function(arg_31_0, arg_31_1)
			local var_31_0 = arg_29_0

			var_2.UnloadArtScene(var_31_0, function()
				local var_32_0 = arg_29_0

				var_0.Emit(var_32_0, var_0_1.TIMELINE_SEQUENCE_END, {
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

			local var_33_0 = arg_29_0

			var_1.FinishArtTimeline(var_33_0, arg_33_0)

			return
		end
	})

	return
end

function var_0_1.UnloadArtScene(arg_34_0, arg_34_1)
	arg_34_0:DisposeArtPlayer()

	assert = var_2

	var_2(arg_34_0.artSceneInfo, "CarWash art timeline scene info is nil")

	local var_34_0 = arg_34_0.artSceneInfo

	arg_34_0.artSceneInfo = nil
	SceneOpMgr = var_3

	local var_34_1 = var_3.Inst

	var_3.UnloadSceneAsync(var_34_1, var_34_0.path, var_34_0.name, function()
		existCall = var_2_10000

		var_2_10000(arg_34_1)

		return
	end)

	return
end

function var_0_1.DisposeArtPlayer(arg_36_0)
	if arg_36_0.artPlayer then
		if arg_36_0.artPlayer.signalReceiver then
			local var_36_0 = arg_36_0.artPlayer.signalReceiver

			var_1.SetCommonEvent(var_36_0, nil)
		end

		local var_36_1 = arg_36_0.artPlayer

		var_1.Stop(var_36_1)

		local var_36_2 = arg_36_0.artPlayer

		var_1.Dispose(var_36_2)

		arg_36_0.artPlayer = nil
	end

	arg_36_0.artDirector = nil

	return
end

function var_0_1.FinishArtTimeline(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.artContext

	assert = var_1_10003

	var_1_10003(var_37_0, "CarWash art timeline context is nil")

	local var_37_1 = var_37_0.data

	arg_37_0.artContext = nil

	if var_37_1.onFinish then
		var_37_1.onFinish(arg_37_1)
	end

	return
end

return var_0_1
