class = var_0_10000

local var_0_0 = "IslandTimelineMgr"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_1.getUIName(arg_1_0)
	return "IslandTimelineUI"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.poolMgr = arg_2_1

	var_0_1.super.Ctor(arg_2_0, arg_2_2, arg_2_3, arg_2_4)

	return
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.skipBtn = var_1.Find(var_3_0, "adapt/skip_button")

	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_1.Find(var_3_1, "mask")
	local var_3_3 = var_1.GetComponent

	typeof = var_3
	CanvasGroup = var_1_10004
	arg_3_0.maskCG = var_3_3(var_3_2, var_3(var_1_10004))
	arg_3_0.state = var_0_2

	return
end

function var_0_1.GetPoolMgr(arg_4_0)
	return arg_4_0.poolMgr
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.skipBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		if not var_0.IsPlaying(var_6_0) then
			return
		end

		local var_6_1 = arg_5_0

		var_0.Stop(var_6_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	return
end

function var_0_1.IsPlaying(arg_7_0)
	return arg_7_0.state == var_0_3
end

function var_0_1.Show(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0:IsPlaying() then
		return
	end

	var_0_1.super.Show(arg_8_0)

	arg_8_0.state = var_0_3
	arg_8_0.callback = arg_8_3
	arg_8_0.loadCharacterList = {}

	arg_8_0:PlaySceneTimeline(arg_8_1, arg_8_2, function()
		local var_9_0 = arg_8_0

		var_0.Stop(var_9_0)

		return
	end)

	return
end

function var_0_1.PlaySceneTimeline(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	setActive = var_1_10004

	var_1_10004(arg_10_0.skipBtn, false)

	pg = var_1_10004

	local var_10_0 = var_1_10004.island_scene_timeline[arg_10_1]

	assert = var_5

	var_5(var_10_0, "island_scene_timeline >>>>" .. arg_10_1)

	IslandSceneSwitcher = var_5

	local var_10_1 = var_5.New()

	arg_10_0:Mask()

	seriesAsync = var_6

	var_6({
		function(arg_11_0)
			local var_11_0 = var_10_1

			var_1.Load(var_11_0, var_10_0.name, nil, {
				function(arg_12_0)
					arg_12_0()
					arg_11_0()

					return
				end
			}, 2)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_10_0

			var_1.ApplyReplace(var_13_0, var_10_0, arg_10_2, arg_13_0)

			return
		end,
		function(arg_14_0)
			onNextTick = var_2_10001

			var_2_10001(arg_14_0)

			return
		end,
		function(arg_15_0)
			setActive = var_2_10001

			var_2_10001(arg_10_0.skipBtn, true)

			local var_15_0 = arg_10_0

			var_1.PlayTimeline(var_15_0, var_10_0.sequence, arg_15_0)

			return
		end,
		function(arg_16_0)
			local var_16_0 = arg_10_0

			if not var_1.IsPlaying(var_16_0) then
				arg_16_0()

				return
			end

			local var_16_1 = arg_10_0

			var_1.UnloadCharacter(var_16_1)

			local var_16_2 = arg_10_0

			var_1.RevertReplace(var_16_2)

			local var_16_3 = var_10_1

			var_1.UnLoad(var_16_3)

			_IslandCore = var_1

			local var_16_4 = var_1:GetView().weatherSystem

			var_1.Play(var_16_4)

			gcAll = var_1

			var_1(false)

			SceneOpMgr = var_1

			local var_16_5 = var_1.Inst

			var_1.SetActiveSceneByIndex(var_16_5, 1)
			arg_16_0()

			return
		end
	}, arg_10_3)

	arg_10_0.sceneLoader = var_10_1

	return
end

function var_0_1.RevertReplace(arg_17_0)
	ipairs = var_1_10001

	local var_17_0

	if not arg_17_0.revertGo then
		var_17_0 = {}
	end

	for iter_17_0, iter_17_1 in var_1_10001(var_17_0) do
		setParent = var_1_10006

		var_1_10006(iter_17_1.go, iter_17_1.container)

		var_1_10006 = iter_17_1.go.transform
		var_1_10006.localPosition = iter_17_1.position
		var_1_10006 = iter_17_1.go.transform
		var_1_10006.localEulerAngles = iter_17_1.rotation
		var_1_10006 = iter_17_1.go.transform
		var_1_10006.localScale = iter_17_1.scale
		_IslandCore = var_1_10006

		if var_1_10006 and iter_17_1.unitId >= 0 then
			if iter_17_1.unitId == 0 then
				_IslandCore = var_1_10006

				if not var_1_10006:GetView().player then
					_IslandCore = var_1_10006

					local var_17_1 = var_1_10006:GetView()

					var_1_10006 = var_1_10006.GetUnitModule(var_17_1, iter_17_1.unitId)
				end

				if var_1_10006 then
					var_1_10006:Enable()
				end
			end
		end
	end

	arg_17_0.revertGo = {}

	return
end

function var_0_1.ApplyReplace(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0:ReplcaeCamTracks(arg_18_1.sequence)

	if #arg_18_1.obj <= 0 then
		arg_18_3()

		return
	end

	local var_18_0 = {}

	arg_18_0.revertGo = {}
	ipairs = var_5

	for iter_18_0, iter_18_1 in var_5(arg_18_1.obj) do
		local var_18_1 = arg_18_1.tracks[iter_18_0]

		table = var_1_10011

		var_1_10011.insert(var_18_0, function(arg_19_0)
			local var_19_0 = arg_18_0

			var_1.ReplaceTimelineRes(var_19_0, iter_18_1, var_18_1, arg_18_2, arg_19_0)

			return
		end)
	end

	parallelAsync = var_5

	var_5(var_18_0, arg_18_3)

	return
end

function var_0_1.ReplaceTimelineRes(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = arg_20_1[1]

	BuildVector3 = var_1_10006

	local var_20_1 = var_1_10006(arg_20_1[2])

	BuildVector3 = var_7

	local var_20_2 = var_7(arg_20_1[3])
	local var_20_3 = arg_20_1[4][1]
	local var_20_4 = arg_20_1[4][2]
	local var_20_5 = {}
	local var_20_6
	local var_20_7 = false
	local var_20_8 = -1

	IslandConst = var_1_10014

	if var_20_3 == var_1_10014.TIMELINE_REPLACE_TYPE_CREATE then
		table = var_14

		var_14.insert(var_20_5, function(arg_21_0)
			local var_21_0 = arg_20_0

			var_1.LoadCharacter(var_21_0, var_20_4, function(arg_22_0)
				var_20_6 = arg_22_0

				arg_21_0()

				return
			end)

			return
		end)
	else
		IslandConst = var_14

		if var_20_3 == var_14.TIMELINE_REPLACE_TYPE_PLAYER then
			_IslandCore = var_14

			if var_14 then
				_IslandCore = var_14

				if var_14:GetView().player then
					var_20_8 = 0

					var_14:Disable()

					var_20_6 = var_14._go
				end
			end

			var_20_7 = true
		else
			IslandConst = var_14

			if var_20_3 == var_14.TIMELINE_REPLACE_TYPE_GEN_OBJ then
				_IslandCore = var_14

				if var_14 then
					_IslandCore = var_14

					local var_20_9 = var_14:GetView()

					if var_14.GetUnitModule(var_20_9, var_20_4) then
						var_20_8 = var_14.id

						var_14:Disable()

						var_20_6 = var_14._go
					end
				end

				var_20_7 = true
			else
				IslandConst = var_14

				if var_20_3 == var_14.TIMELINE_REPLACE_TYPE_STATIC_OBJ then
					GameObject = var_14
					var_20_6 = var_14.Find(var_20_4)
					var_20_7 = true
				else
					IslandConst = var_14

					if var_20_3 == var_14.TIMELINE_REPLACE_TYPE_CODE_OBJ then
						table = var_14

						var_14.insert(var_20_5, function(arg_23_0)
							local var_23_0 = arg_20_0

							var_1.LoadCharacter(var_23_0, arg_20_3[1], function(arg_24_0)
								var_20_6 = arg_24_0

								arg_23_0()

								return
							end)

							return
						end)
					end
				end
			end
		end
	end

	if var_20_7 and var_20_6 then
		table = var_14

		var_14.insert(arg_20_0.revertGo, {
			go = var_20_6,
			container = var_20_6.transform.parent,
			position = var_20_6.transform.localPosition,
			rotation = var_20_6.transform.localEulerAngles,
			scale = var_20_6.transform.localScale,
			unitId = var_20_8
		})
	end

	table = var_14

	var_14.insert(var_20_5, function(arg_25_0)
		if not var_20_6 then
			arg_25_0()

			return
		end

		setActive = var_1

		var_1(var_20_6, true)

		GameObject = var_1

		local var_25_0 = var_1.Find(var_20_0)

		setParent = var_2

		var_2(var_20_6, var_25_0)

		var_20_6.transform.localPosition = var_20_1
		var_20_6.transform.localEulerAngles = var_20_2

		local var_25_1 = arg_20_0

		var_2.ReplaceTracks(var_25_1, var_20_6, arg_20_2, arg_25_0)

		return
	end)

	seriesAsync = var_14

	var_14(var_20_5, arg_20_4)

	return
end

local function var_0_5(arg_26_0, arg_26_1)
	if arg_26_1 == "Animator" then
		local var_26_0 = arg_26_0.transform
		local var_26_1 = var_2.GetChild(var_26_0, 0)
		local var_26_2 = var_2.GetComponent

		typeof = var_1_10005
		Animator = var_1_10006

		if var_26_2(var_26_1, var_1_10005(var_1_10006)) then
			return var_3
		end

		GetOrAddComponent = var_26_1

		local var_26_3 = arg_26_0

		typeof = var_1_10006
		Animator = var_1_10007

		return (var_26_1(var_26_3, var_1_10006(var_1_10007)))
	elseif arg_26_1 == "Transform" then
		return arg_26_0.transform
	else
		return arg_26_0
	end

	return
end

function var_0_1.ReplaceTracks(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = {}

	ipairs = var_1_10005

	for iter_27_0, iter_27_1 in var_1_10005(arg_27_2) do
		var_1_10010 = iter_27_1[1]

		local var_27_1 = iter_27_1[2]
		local var_27_2 = iter_27_1[3]

		if not var_27_0[var_1_10010] then
			var_27_0[var_1_10010] = {}
		end

		table = var_1_10013

		var_1_10013.insert(var_27_0[var_1_10010], {
			var_27_1,
			var_27_2
		})
	end

	pairs = var_5

	for iter_27_2, iter_27_3 in var_5(var_27_0) do
		GameObject = var_1_10010

		local var_27_3 = var_1_10010.Find(iter_27_2)
		local var_27_4 = var_1_10010.GetComponent

		typeof = var_1_10013
		UnityEngine = var_1_10014

		local var_27_5 = var_27_4(var_27_3, var_1_10013(var_1_10014.Playables.PlayableDirector))

		TimelineHelper = var_27_3
		var_1_10013 = var_27_3.GetTimelineTracks(var_27_5)

		local var_27_6 = var_12.ToTable(var_1_10013)

		var_1_10013 = {}
		ipairs = var_1_10014

		for iter_27_4, iter_27_5 in var_1_10014(var_27_6) do
			var_1_10013[iter_27_5.name] = iter_27_5
		end

		ipairs = var_1_10014

		for iter_27_6, iter_27_7 in var_1_10014(iter_27_3) do
			tonumber = var_1_10019

			local var_27_7

			if not var_1_10019(iter_27_7[1]) or not var_27_6[var_1_10019 + 1] then
				var_27_7 = var_1_10013[iter_27_7[1]]
			end

			if var_27_7 then
				TimelineHelper = var_1_10021

				var_1_10021.SetSceneBinding(var_27_5, var_27_7, var_0_5(arg_27_1, iter_27_7[2]))
			end
		end
	end

	arg_27_3()

	return
end

function var_0_1.ReplcaeCamTracks(arg_28_0, arg_28_1)
	GameObject = var_1_10002

	if not var_1_10002.Find(arg_28_1) then
		return
	end

	local var_28_0 = var_2.transform
	local var_28_1 = var_3.GetComponentsInChildren

	typeof = var_1_10005
	UnityEngine = var_1_10006

	local var_28_2 = var_28_1(var_28_0, var_1_10005(var_1_10006.Playables.PlayableDirector), true)
	local var_28_3 = var_3.ToTable(var_28_2)

	ipairs = var_28_2

	for iter_28_0, iter_28_1 in var_28_2(var_28_3) do
		TimelineHelper = var_1_10009

		local var_28_4 = var_1_10009.GetTimelineTracks(iter_28_1)

		var_1_10009 = var_1_10009.ToTable(var_28_4)
		ipairs = var_28_4

		for iter_28_2, iter_28_3 in var_28_4(var_1_10009) do
			local var_28_5 = iter_28_3:GetType()

			if var_15.ToString(var_28_5) == "CinemachineTrack" then
				TimelineHelper = var_28_5

				local var_28_6 = var_28_5.SetSceneBinding
				local var_28_7 = iter_28_1
				local var_28_8 = iter_28_3

				IslandCameraMgr = var_1_10019

				var_28_6(var_28_7, var_28_8, var_1_10019.instance.cinemachineBrain)
			end
		end
	end

	return
end

function var_0_1.LoadCharacter(arg_29_0, arg_29_1, arg_29_2)
	pg = var_1_10003

	local var_29_0 = var_1_10003.island_unit_character[arg_29_1]
	local var_29_1 = arg_29_0:GetPoolMgr()

	var_4.GetCharacter(var_29_1, var_29_0.model, var_29_0.animator, function(arg_30_0)
		table = var_2_10001

		var_2_10001.insert(arg_29_0.loadCharacterList, {
			data = var_29_0,
			go = arg_30_0
		})
		arg_29_2(arg_30_0)

		return
	end)

	return
end

function var_0_1.UnloadCharacter(arg_31_0, arg_31_1)
	ipairs = var_1_10002

	for iter_31_0, iter_31_1 in var_1_10002(arg_31_0.loadCharacterList) do
		local var_31_0 = arg_31_0:GetPoolMgr()

		var_7.ReturnCharacter(var_31_0, iter_31_1.data.model, iter_31_1.data.animator, iter_31_1.go)
	end

	arg_31_0.loadCharacterList = {}

	return
end

function var_0_1.Mask(arg_32_0)
	arg_32_0.maskCG.alpha = 1
	arg_32_0.maskCG.blocksRaycasts = true

	return
end

function var_0_1.UnMask(arg_33_0)
	arg_33_0.maskCG.alpha = 0
	arg_33_0.maskCG.blocksRaycasts = false

	return
end

function var_0_1.PlayTimeline(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_0:IsPlaying() then
		arg_34_2()

		return
	end

	arg_34_0:UnMask()

	GameObject = var_3

	local var_34_0 = var_3.Find(arg_34_1)

	assert = var_4

	var_4(var_34_0, arg_34_1)

	if not var_34_0 then
		return
	end

	local var_34_1 = var_34_0
	local var_34_2 = var_34_0.GetComponent

	typeof = var_6
	UnityEngine = var_1_10007

	local var_34_3 = var_34_2(var_34_1, var_6(var_1_10007.Playables.PlayableDirector))

	GetOrAddComponent = var_34_1

	local var_34_4 = var_34_1(var_34_0, "DftCommonSignalReceiver")

	var_5.SetCommonEvent(var_34_4, function(arg_35_0)
		if arg_35_0.stringParameter == "TimelineEnd" then
			local var_35_0 = var_34_3

			var_1.Stop(var_35_0)

			local var_35_1 = var_0

			var_1.SetCommonEvent(var_35_1, nil)

			arg_34_0.dftCommonSignalReceiver = nil
			arg_34_0.playableDirector = nil

			arg_34_2()
		end

		return
	end)
	var_34_3:Play()

	arg_34_0.playableDirector = var_34_3
	arg_34_0.dftCommonSignalReceiver = var_5

	return
end

function var_0_1.Stop(arg_36_0)
	arg_36_0:UnloadCharacter()
	arg_36_0:RevertReplace()

	if arg_36_0.playableDirector then
		local var_36_0 = arg_36_0.playableDirector

		var_1.Stop(var_36_0)

		arg_36_0.playableDirector = nil
	end

	if arg_36_0.dftCommonSignalReceiver then
		local var_36_1 = arg_36_0.dftCommonSignalReceiver

		var_1.SetCommonEvent(var_36_1, nil)

		arg_36_0.dftCommonSignalReceiver = nil
	end

	if arg_36_0.sceneLoader then
		local var_36_2 = arg_36_0.sceneLoader

		var_1.UnLoad(var_36_2)

		SceneOpMgr = var_1

		local var_36_3 = var_1.Inst

		var_1.SetActiveSceneByIndex(var_36_3, 1)

		arg_36_0.sceneLoader = nil
	end

	if arg_36_0.callback then
		arg_36_0.callback()
	end

	arg_36_0.callback = nil
	arg_36_0.state = var_0_4

	arg_36_0:Hide()

	return
end

function var_0_1.Hide(arg_37_0)
	var_0_1.super.Hide(arg_37_0)
	arg_37_0:UnMask()

	return
end

function var_0_1.OnDestroy(arg_38_0)
	if arg_38_0:isShowing() then
		arg_38_0:Stop()
	end

	return
end

return var_0_1
