class = var_0_10000

local var_0_0 = "Dorm3dSlideScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.Dorm3dGameTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dSlideUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.contextData.groupId

	pg = var_1_10003
	arg_2_0.gameConfig = var_1_10003.dorm3d_minigame_slide[var_2_0]

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.SetApartment

	getProxy = var_1_10006
	ApartmentProxy = var_1_10008

	local var_2_3 = var_1_10006(var_1_10008)

	var_2_2(var_2_1, var_6.getApartment(var_2_3, var_2_0))

	arg_2_0.sceneInfo = {
		{
			path = arg_2_0.gameConfig.peform_scene_info[1],
			name = arg_2_0.gameConfig.peform_scene_info[2]
		},
		{
			path = arg_2_0.gameConfig.perform_timeline_info[1],
			name = arg_2_0.gameConfig.perform_timeline_info[2]
		}
	}
	seriesAsync = var_3

	var_3({
		function(arg_3_0)
			SceneOpMgr = var_2_10001

			local var_3_0 = var_2_10001.Inst
			local var_3_1 = var_1.LoadSceneAsync
			local var_3_2 = arg_2_0.sceneInfo[1].path
			local var_3_3 = arg_2_0.sceneInfo[1].name

			LoadSceneMode = var_2_10006

			var_3_1(var_3_0, var_3_2, var_3_3, var_2_10006.Additive, function(arg_4_0, arg_4_1)
				SceneManager = var_3_10002

				var_3_10002.SetActiveScene(arg_4_0)
				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			SceneOpMgr = var_2_10001

			local var_5_0 = var_2_10001.Inst
			local var_5_1 = var_1.LoadSceneAsync
			local var_5_2 = arg_2_0.sceneInfo[2].path
			local var_5_3 = arg_2_0.sceneInfo[2].name

			LoadSceneMode = var_2_10006

			var_5_1(var_5_0, var_5_2, var_5_3, var_2_10006.Additive, function(arg_6_0, arg_6_1)
				arg_5_0()

				return
			end)

			return
		end
	}, arg_2_1)

	return
end

function var_0_1.init(arg_7_0)
	arg_7_0:InitScene()
	arg_7_0:InitUI()

	Dorm3dHxHelper = var_1

	local var_7_0 = var_1.GetTimelineMainCharacter()

	Dorm3dHxHelper = var_1_10002

	var_1_10002.ReplaceCharacterParts(var_7_0)

	Dorm3dHxHelper = var_2

	var_2.HideCharacterPart(var_7_0, nil, true)

	Dorm3dHxHelper = var_2

	var_2.ShowHolyLight({
		var_7_0
	}, arg_7_0.holyLightRoot)

	return
end

function var_0_1.InitUI(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0._tf
	local var_8_2 = var_4.Find(var_8_1, "GameUI/Title/BackBtn")

	local function var_8_3()
		local var_9_0 = arg_8_0

		var_0.emit(var_9_0, var_0_1.ON_BACK)

		return
	end

	SFX_DORM_CLICK = var_8_1

	var_1_10001(var_8_0, var_8_2, var_8_3, var_8_1)

	local var_8_4 = arg_8_0._tf

	arg_8_0.qteTF = var_1.Find(var_8_4, "GameUI/QTE")
	setActive = var_1

	var_1(arg_8_0.qteTF, false)

	local var_8_5 = arg_8_0._tf

	arg_8_0.countTF = var_1.Find(var_8_5, "GameUI/Count")
	setActive = var_1

	var_1(arg_8_0.countTF, false)

	local var_8_6 = arg_8_0.countTF
	local var_8_7 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_8_1

	local var_8_8 = var_8_7(var_8_6, var_4(var_8_1))

	var_1.SetEndEvent(var_8_8, function()
		setActive = var_2_10000

		var_2_10000(arg_8_0.countTF, false)

		return
	end)

	local var_8_9 = arg_8_0._tf

	arg_8_0.endUI = var_1.Find(var_8_9, "EndUI")
	setText = var_1

	local var_8_10 = arg_8_0._tf
	local var_8_11 = var_3.Find(var_8_10, "GameUI/Title/Text")

	i18n = var_4

	var_1(var_8_11, var_4("3ddorm_beach_slide_tip7"))

	arg_8_0.ltList = {}
	arg_8_0.timerList = {}

	local var_8_12 = arg_8_0._tf

	arg_8_0.holyLightRoot = var_1.Find(var_8_12, "HolyLightRoot")

	return
end

function var_0_1.InitScene(arg_11_0)
	SceneManager = var_1_10001

	local var_11_0 = var_1_10001.GetSceneByName(arg_11_0.sceneInfo[1].name)
	local var_11_1 = var_1.GetRootGameObjects(var_11_0)

	table = var_1_10002

	var_1_10002.IpairsCArray(var_11_1, function(arg_12_0, arg_12_1)
		return
	end)

	arg_11_0.timelineDic = {}
	SceneManager = var_2

	local var_11_2 = var_2.GetSceneByName(arg_11_0.sceneInfo[2].name)
	local var_11_3 = var_2.GetRootGameObjects(var_11_2)

	table = var_11_0

	var_11_0.IpairsCArray(var_11_3, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_1.transform

		if var_2.Find(var_13_0, "[sequence]") then
			local var_13_1 = var_2
			local var_13_2 = var_2.GetComponent

			typeof = var_2_10006
			UnityEngine = var_2_10008

			local var_13_3 = var_13_2(var_13_1, var_2_10006(var_2_10008.Playables.PlayableDirector))
			local var_13_4 = arg_11_0.timelineDic

			var_13_4[arg_13_1.name] = {
				obj = arg_13_1,
				seq = var_2,
				director = var_13_3
			}
			TimelineSupport = var_13_4

			var_13_4.DisablePlayOnAwake(var_13_3)

			setActive = var_4

			var_4(arg_13_1, true)
		end

		return
	end)

	GetOrAddComponent = var_3

	local var_11_4 = arg_11_0.timelineDic[arg_11_0.gameConfig.perform_catch].seq

	typeof = var_6
	TimelineSpeed = var_1_10008
	arg_11_0.speedComp = var_3(var_11_4, var_6(var_1_10008))

	return
end

function var_0_1.didEnter(arg_14_0)
	arg_14_0:StartGame()

	return
end

function var_0_1.ShowCountDown(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.countTF, true)

	return
end

function var_0_1.StartQTE(arg_16_0)
	local var_16_0 = {}

	arg_16_0.resultList = {}

	local var_16_1 = 1

	SlideConst = var_1_10003

	for iter_16_0 = var_16_1, var_1_10003.QTE_COUNT do
		table = var_1_10006

		var_1_10006.insert(var_16_0, function(arg_17_0)
			cloneTplTo = var_2_10001

			local var_17_0 = arg_16_0.qteTF
			local var_17_1 = arg_16_0._tf
			local var_17_2 = var_2_10001(var_17_0, var_4.Find(var_17_1, "GameUI"))
			local var_17_3 = var_1.Find(var_17_2, "animroot/Perfect")

			SlideConst = var_17_0

			local var_17_4 = var_17_0.QTE_TIME

			SlideConst = var_17_2

			local var_17_5 = var_17_4 - var_17_2.QTE_SUCCESS_RANGE[1]

			SlideConst = var_4

			local var_17_6 = var_17_5 / var_4.QTE_TIME

			setLocalScale = var_4

			local var_17_7 = var_17_3

			Vector3 = var_7

			var_4(var_17_7, var_7(var_17_6, var_17_6, var_17_6))

			local var_17_8 = var_1
			local var_17_9 = var_1.Find(var_17_8, "animroot/Centres")

			SlideConst = var_5

			local var_17_10 = var_5.QTE_TIME

			SlideConst = var_17_8

			local var_17_11 = var_17_10 - var_17_8.QTE_SUCCESS_RANGE[2]

			SlideConst = var_6

			local var_17_12 = var_17_11 / var_6.QTE_TIME

			setLocalScale = var_6

			local var_17_13 = var_17_9

			Vector3 = var_9

			var_6(var_17_13, var_9(var_17_12, var_17_12, var_17_12))

			setAnchoredPosition = var_6

			var_6(var_1, {
				x = arg_16_0.gameConfig.qte_position[iter_16_0][1],
				y = arg_16_0.gameConfig.qte_position[iter_16_0][2]
			})

			setActive = var_6

			var_6(var_1, true)

			local var_17_14 = var_1
			local var_17_15 = var_1.Find(var_17_14, "animroot/Trigger")
			local var_17_16 = 0

			Timer = var_17_14

			local var_17_17 = var_17_14.New(function()
				local var_18_0 = var_17_16

				SlideConst = var_3_10001

				if var_3_10001.QTE_TIME <= var_18_0 then
					local var_18_1 = arg_16_0.timerList[iter_16_0]

					var_0.Stop(var_18_1)

					setActive = var_0

					var_0(var_0, false)

					return
				end

				var_17_16 = var_17_16 + 0.016666666666666666

				local var_18_2 = var_17_15

				Vector3 = var_1

				local var_18_3 = var_1.Lerp

				Vector3 = var_3_10003

				local var_18_4 = var_3_10003(1, 1, 1)

				Vector3 = var_3_10004

				local var_18_5 = var_3_10004(0, 0, 0)
				local var_18_6 = var_17_16

				SlideConst = var_6
				var_18_2.localScale = var_18_3(var_18_4, var_18_5, var_18_6 / var_6.QTE_TIME)

				return
			end, 0.016666666666666666, -1)

			var_8.Start(var_17_17)

			local var_17_18 = arg_16_0.timerList

			var_17_18[iter_16_0] = var_8
			onButton = var_17_18

			var_17_18(arg_16_0, var_1, function()
				local var_19_0 = arg_16_0.timerList[iter_16_0]

				var_0.Stop(var_19_0)

				local var_19_1 = var_17_16

				SlideConst = var_1

				if var_1.QTE_SUCCESS_RANGE[1] <= var_19_1 then
					local var_19_2 = var_17_16

					SlideConst = var_1

					if var_19_2 <= var_1.QTE_SUCCESS_RANGE[2] then
						local var_19_3 = arg_16_0.resultList

						var_19_3[iter_16_0] = true
						setActive = var_19_3

						local var_19_4 = var_0

						var_19_3(var_2.Find(var_19_4, "animroot/Result/Hit"), true)

						goto label_19_0
					end
				end

				do
					local var_19_5 = arg_16_0.resultList

					var_19_5[iter_16_0] = false
					setActive = var_19_5

					local var_19_6 = var_0

					var_19_5(var_2.Find(var_19_6, "animroot/Result/Miss"), true)
				end

				::label_19_0::

				return
			end)

			table = var_17_18

			local var_17_19 = var_17_18.insert
			local var_17_20 = arg_16_0.ltList

			LeanTween = var_12

			local var_17_21 = var_12.delayedCall
			local var_17_22 = iter_16_0

			SlideConst = var_2_10015

			if var_17_22 == var_2_10015.QTE_COUNT then
				SlideConst = var_17_22

				if not var_17_22.QTE_TIME then
					SlideConst = var_17_22
					var_17_22 = var_17_22.QTE_INTERVAL
				end

				System = var_15

				var_17_19(var_17_20, var_17_21(var_17_22, var_15.Action(arg_17_0)).uniqueId)

				return
			end
		end)
	end

	seriesAsync = var_16_1

	var_16_1(var_16_0, function()
		local var_20_0 = arg_16_0

		var_0.EndQTE(var_20_0)

		return
	end)

	local var_16_2 = arg_16_0.speedComp
	local var_16_3 = var_2.SetTimelineSpeed

	SlideConst = var_5

	var_16_3(var_16_2, var_5.QTE_SLOW_SPEED)

	return
end

function var_0_1.EndQTE(arg_21_0)
	local var_21_0 = arg_21_0.speedComp

	var_1.SetTimelineSpeed(var_21_0, 1)

	arg_21_0.catchSuccess = true

	local var_21_1 = 1

	SlideConst = var_1_10002

	for iter_21_0 = var_21_1, var_1_10002.QTE_COUNT do
		if not arg_21_0.resultList[iter_21_0] then
			arg_21_0.catchSuccess = false

			break
		end
	end

	setActive = var_21_1

	var_21_1(arg_21_0.endUI, true)

	setActive = var_21_1

	local var_21_2 = arg_21_0.endUI

	var_21_1(var_3.Find(var_21_2, "Title/Victory"), arg_21_0.catchSuccess)

	setActive = var_21_1

	local var_21_3 = arg_21_0.endUI

	var_21_1(var_3.Find(var_21_3, "Title/Defeat"), not arg_21_0.catchSuccess)

	onDelayTick = var_21_1

	var_21_1(function()
		quickPlayAnimation = var_2_10000

		var_2_10000(arg_21_0.endUI, "Anim_Dorm3d_volleyball_end_out")

		onDelayTick = var_2_10000

		var_2_10000(function()
			setActive = var_3_10000

			var_3_10000(arg_21_0.endUI, false)

			return
		end, 0.1)

		return
	end, 1.167)

	return
end

function var_0_1.StartGame(arg_24_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_25_0)
			local var_25_0 = arg_24_0

			var_1.PlayTimeline(var_25_0, arg_24_0.gameConfig.perform_ready, arg_25_0)

			return
		end,
		function(arg_26_0)
			local var_26_0 = arg_24_0

			var_1.PlayTimeline(var_26_0, arg_24_0.gameConfig.perform_down, arg_26_0)

			return
		end,
		function(arg_27_0)
			local var_27_0 = arg_24_0

			var_1.PlayTimeline(var_27_0, arg_24_0.gameConfig.perform_catch, arg_27_0)

			return
		end,
		function(arg_28_0)
			if arg_24_0.catchSuccess then
				local var_28_0 = arg_24_0

				var_1.PlayTimeline(var_28_0, arg_24_0.gameConfig.perform_success, arg_28_0)
			else
				local var_28_1 = arg_24_0

				var_1.PlayTimeline(var_28_1, arg_24_0.gameConfig.perform_fail, arg_28_0)
			end

			return
		end
	}, function()
		local var_29_0 = arg_24_0

		var_0.emit(var_29_0, var_0_1.ON_BACK)

		return
	end)

	return
end

function var_0_1.PlayTimeline(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.timelineDic[arg_30_1].seq
	local var_30_1 = arg_30_0.timelineDic[arg_30_1].director

	GetOrAddComponent = var_1_10005

	local var_30_2 = var_1_10005(var_30_0, "DftCommonSignalReceiver")

	var_5.SetCommonEvent(var_30_2, function(arg_31_0)
		switch = var_2_10001

		var_2_10001(arg_31_0.stringParameter, {
			PrepareQTE = function()
				local var_32_0 = arg_30_0

				var_0.ShowCountDown(var_32_0)

				return
			end,
			StartQTE = function()
				local var_33_0 = arg_30_0

				var_0.StartQTE(var_33_0)

				return
			end,
			TimelineEnd = function()
				local var_34_0 = var_30_1

				var_0.Stop(var_34_0)

				existCall = var_0

				var_0(arg_30_2)

				return
			end,
			Vibrate = function()
				return
			end
		}, function()
			warning = var_3_10000

			var_3_10000("other event trigger:" .. arg_31_0.stringParameter)

			return
		end)

		return
	end)
	var_30_1:Play()

	return
end

function var_0_1.willExit(arg_37_0)
	ipairs = var_1_10001

	for iter_37_0, iter_37_1 in var_1_10001(arg_37_0.ltList) do
		LeanTween = var_1_10006

		if var_1_10006.isTweening(iter_37_1) then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_37_1)
		end
	end

	pairs = var_1

	for iter_37_2, iter_37_3 in var_1(arg_37_0.timerList) do
		iter_37_3:Stop()
	end

	underscore = var_1

	local var_37_0 = var_1.map(arg_37_0.sceneInfo, function(arg_38_0)
		return function(arg_39_0)
			SceneOpMgr = var_3_10001

			local var_39_0 = var_3_10001.Inst

			var_1.UnloadSceneAsync(var_39_0, arg_38_0.path, arg_38_0.name, arg_39_0)

			return
		end
	end)

	seriesAsync = var_2

	var_2(var_37_0, function()
		return
	end)

	return
end

return var_0_1
