class = var_0_10000

local var_0_0 = "Dorm3dVolleyballScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Game.Dorm3dGameTemplate"))
local var_0_2 = "ui-dorm_countdown"
local var_0_3 = "ui-dorm_qte_appear"
local var_0_4 = "ui-dorm_qte_hit"
local var_0_5 = "ui-dorm_qte_citical"
local var_0_6 = "ui-dorm_qte_miss"
local var_0_7 = "ui-dorm_scoring"
local var_0_8 = "ui-dorm_victory"
local var_0_9 = "ui-dorm_pop_up"

var_0_1.QTE_RESULT = {
	MISS = "Miss",
	PERFECT = "Critical",
	HIT = "Hit"
}
var_0_1.ROUND_RESULT = {
	OUR_WIN = 1,
	OTHER_WIN = 2
}
var_0_1.GAME_RESULT = {
	DEFEAT = 2,
	VICTORY = 1
}
var_0_1.hitRadiusMax = 231
var_0_1.hitRadiusMin = 50
var_0_1.perfectRadiusMax = 139
var_0_1.perfectRadiusMin = 85
var_0_1.perfectScaleRandoms = {
	0.7,
	1.7
}
var_0_1.triggerRadius = 255
var_0_1.endScore = 6
Vector3 = var_9
var_0_1.BallInitPos = var_9(22, 4.5, -22.4)
var_0_1.BallSpeed = 0.1
var_0_1.BallQTESpeed = 0.01
var_0_1.BallRandomDelat = {
	Top = 300,
	Left = 300,
	Bottom = 300,
	Right = 300
}

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dVolleyballUI"
end

local var_0_10

function var_0_1.Ctor(arg_2_0, ...)
	var_0_1.super.Ctor(arg_2_0, ...)

	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.preload(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.contextData.groupId
	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.SetApartment

	getProxy = var_1_10005
	ApartmentProxy = var_1_10006

	local var_3_3 = var_1_10005(var_1_10006)

	var_3_2(var_3_1, var_5.getApartment(var_3_3, var_3_0))

	pg = var_3_2
	arg_3_0.volleyballCfg = var_3_2.dorm3d_volleyball[var_3_0]
	arg_3_0.sceneRootName = "beach"
	arg_3_0.sceneName = "map_beach_01"
	pg = var_3
	arg_3_0.timelineSceneRootName = var_3.dorm3d_dorm_template[var_3_0].asset_name
	arg_3_0.timelineSceneName = arg_3_0.volleyballCfg.scene_name
	seriesAsync = var_3

	var_3({
		function(arg_4_0)
			SceneOpMgr = var_2_10001

			local var_4_0 = var_2_10001.Inst
			local var_4_1 = var_1.LoadSceneAsync

			string = var_2_10003

			local var_4_2 = var_2_10003.lower("dorm3d/scenesres/scenes/" .. arg_3_0.sceneRootName .. "/" .. arg_3_0.sceneName .. "_scene")
			local var_4_3 = arg_3_0.sceneName

			LoadSceneMode = var_5

			var_4_1(var_4_0, var_4_2, var_4_3, var_5.Additive, function(arg_5_0, arg_5_1)
				local var_5_0 = arg_3_0

				var_2.InitGameParam(var_5_0)

				SceneManager = var_2

				var_2.SetActiveScene(arg_5_0)
				arg_4_0()

				return
			end)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_3_0.timelineSceneRootName
			local var_6_1 = arg_3_0.timelineSceneName

			SceneOpMgr = var_2_10003

			local var_6_2 = var_2_10003.Inst
			local var_6_3 = var_3.LoadSceneAsync

			string = var_2_10005

			local var_6_4 = var_2_10005.lower("dorm3d/character/" .. var_6_0 .. "/timeline/" .. var_6_1 .. "/" .. var_6_1 .. "_scene")
			local var_6_5 = var_6_1

			LoadSceneMode = var_7

			var_6_3(var_6_2, var_6_4, var_6_5, var_7.Additive, function(arg_7_0, arg_7_1)
				arg_6_0()

				return
			end)

			return
		end
	}, arg_3_1)

	return
end

function var_0_1.InitGameParam(arg_8_0)
	var_0_1.BallSpeed = arg_8_0.volleyballCfg.BallSpeedParam[1]
	var_0_1.BallQTESpeed = arg_8_0.volleyballCfg.BallSpeedParam[2]
	var_0_1.endScore = arg_8_0.volleyballCfg.endScore

	return
end

function var_0_1.init(arg_9_0)
	arg_9_0:initUI()
	arg_9_0:initScene()

	local var_9_0 = arg_9_0

	arg_9_0.BindEvent(var_9_0)

	Dorm3dHxHelper = var_1

	local var_9_1 = var_1.GetTimelineMainCharacter()

	Dorm3dHxHelper = var_9_0

	var_9_0.ReplaceCharacterParts(var_9_1)

	Dorm3dHxHelper = var_2

	var_2.HideCharacterPart(var_9_1, nil, true)

	Dorm3dHxHelper = var_2

	var_2.ShowHolyLight({
		var_9_1
	}, arg_9_0.holyLightRoot)

	return
end

function var_0_1.initUI(arg_10_0)
	local var_10_0 = arg_10_0._tf

	arg_10_0.skipUI = var_1.Find(var_10_0, "SkipUI")
	setActive = var_1

	var_1(arg_10_0.skipUI, false)

	local var_10_1 = arg_10_0._tf

	arg_10_0.gameUI = var_1.Find(var_10_1, "GameUI")
	setText = var_1

	local var_10_2 = arg_10_0.gameUI
	local var_10_3 = var_2.Find(var_10_2, "Title/Text")

	i18n = var_10_2

	var_1(var_10_3, var_10_2("dorm3d_volleyball_title"))

	local var_10_4 = arg_10_0.gameUI

	arg_10_0.ourScoreTF = var_1.Find(var_10_4, "Score/Content/Left")

	local var_10_5 = arg_10_0.gameUI

	arg_10_0.otherScoreTF = var_1.Find(var_10_5, "Score/Content/Right")

	local var_10_6 = arg_10_0.gameUI

	arg_10_0.qteTF = var_1.Find(var_10_6, "QTE")

	local var_10_7 = arg_10_0.gameUI

	arg_10_0.qteTriggerTF = var_1.Find(var_10_7, "QTE/animroot/Trigger")
	setActive = var_1

	var_1(arg_10_0.qteTF, false)

	setActive = var_1

	var_1(arg_10_0.gameUI, false)

	local var_10_8 = arg_10_0.gameUI
	local var_10_9 = var_1.Find(var_10_8, "Count")
	local var_10_10 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4

	local var_10_11 = var_10_10(var_10_9, var_3(var_4))

	var_1.SetEndEvent(var_10_11, function()
		if not arg_10_0.isStartGame then
			return
		end

		local var_11_0 = arg_10_0

		var_11_0.isStartGame = false
		setActive = var_11_0

		local var_11_1 = arg_10_0.gameUI

		var_11_0(var_1.Find(var_11_1, "Count"), false)

		local var_11_2 = arg_10_0

		var_0.StartOneRound(var_11_2)

		setActive = var_0

		local var_11_3 = arg_10_0.gameUI

		var_0(var_1.Find(var_11_3, "Score"), true)

		return
	end)

	local var_10_12 = arg_10_0._tf

	arg_10_0.scoreUI = var_1.Find(var_10_12, "ScoreUI")
	setActive = var_1

	var_1(arg_10_0.scoreUI, false)

	local var_10_13 = arg_10_0._tf

	arg_10_0.endUI = var_1.Find(var_10_13, "EndUI")
	setActive = var_1

	var_1(arg_10_0.endUI, false)

	local var_10_14 = arg_10_0._tf

	arg_10_0.resultUI = var_1.Find(var_10_14, "ResultUI")
	setActive = var_1

	var_1(arg_10_0.resultUI, false)

	setText = var_1

	local var_10_15 = arg_10_0.resultUI
	local var_10_16 = var_2.Find(var_10_15, "AgainBtn/Text")

	i18n = var_10_15

	var_1(var_10_16, var_10_15("dorm3d_minigame_again"))

	setText = var_1

	local var_10_17 = arg_10_0.resultUI
	local var_10_18 = var_2.Find(var_10_17, "CloseBtn/Text")

	i18n = var_10_17

	var_1(var_10_18, var_10_17("dorm3d_minigame_close"))

	local var_10_19 = arg_10_0.scoreUI
	local var_10_20 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4

	local var_10_21 = var_10_20(var_10_19, var_3(var_4))

	var_1.SetEndEvent(var_10_21, function()
		if not arg_10_0.isEndOneRound then
			return
		end

		local var_12_0 = arg_10_0

		var_12_0.isEndOneRound = false
		quickPlayAnimation = var_12_0

		var_12_0(arg_10_0.scoreUI, "Anim_Dorm3d_volleyball_score_out")

		onDelayTick = var_12_0

		var_12_0(function()
			setActive = var_3_10000

			var_3_10000(arg_10_0.scoreUI, false)

			return
		end, 0.1)

		local var_12_1 = arg_10_0

		if var_0.CheckEndGame(var_12_1) then
			local var_12_2 = arg_10_0

			var_0.EndGame(var_12_2)
		else
			setActive = var_0

			var_0(arg_10_0.gameUI, true)

			local var_12_3 = arg_10_0

			var_0.StartOneRound(var_12_3)
		end

		return
	end)

	local var_10_22 = arg_10_0._tf
	local var_10_23 = var_1.Find(var_10_22, "Debug")

	setActive = var_10_22

	var_10_22(var_10_23, false)

	local var_10_24 = var_10_23:Find("Timeline")
	local var_10_25 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_10_0.debugTimelineName = var_10_25(var_10_24, var_4(var_1_10005))

	local var_10_26 = var_10_23:Find("Track")
	local var_10_27 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_10_0.debugTrackName = var_10_27(var_10_26, var_4(var_1_10005))

	local var_10_28 = arg_10_0._tf

	arg_10_0.holyLightRoot = var_2.Find(var_10_28, "HolyLightRoot")

	return
end

function var_0_1.BindEvent(arg_14_0)
	onButton = var_1_10001

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.gameUI
	local var_14_2 = var_3.Find(var_14_1, "Title/BackBtn")

	local function var_14_3()
		local var_15_0 = arg_14_0

		var_0.onBackPressed(var_15_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_14_0, var_14_2, var_14_3, var_5)

	onButton = var_1_10001

	var_1_10001(arg_14_0, arg_14_0.gameUI, function()
		if not arg_14_0.startQTEUI then
			return
		end

		local var_16_0 = arg_14_0

		var_0.EndQTE(var_16_0)

		return
	end)

	onButton = var_1_10001

	local var_14_4 = arg_14_0
	local var_14_5 = arg_14_0.skipUI
	local var_14_6 = var_3.Find(var_14_5, "SkipBtn")

	local function var_14_7()
		setActive = var_2_10000

		var_2_10000(arg_14_0.skipUI, false)

		local var_17_0 = arg_14_0

		var_0.StopPlayingTimeline(var_17_0)

		local var_17_1 = arg_14_0

		var_0.StartGame(var_17_1)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_14_4, var_14_6, var_14_7, var_5)

	onButton = var_1_10001

	local var_14_8 = arg_14_0
	local var_14_9 = arg_14_0.endUI

	local function var_14_10()
		local var_18_0 = arg_14_0
		local var_18_1 = var_0.emit

		Dorm3dGameMediatorTemplate = var_2_10002

		var_18_1(var_18_0, var_2_10002.TRIGGER_FAVOR, arg_14_0.apartment.configId)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_14_8, var_14_9, var_14_10, var_5)

	onButton = var_1_10001

	local var_14_11 = arg_14_0
	local var_14_12 = arg_14_0.resultUI
	local var_14_13 = var_3.Find(var_14_12, "AgainBtn")

	local function var_14_14()
		setActive = var_2_10000

		var_2_10000(arg_14_0.resultUI, false)

		local var_19_0 = arg_14_0

		var_0.StartGame(var_19_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_14_11, var_14_13, var_14_14, var_5)

	onButton = var_1_10001

	local var_14_15 = arg_14_0
	local var_14_16 = arg_14_0.resultUI
	local var_14_17 = var_3.Find(var_14_16, "CloseBtn")

	local function var_14_18()
		local var_20_0 = arg_14_0

		var_0.closeView(var_20_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_14_15, var_14_17, var_14_18, var_5)

	return
end

function var_0_1.initScene(arg_21_0)
	SceneManager = var_1_10001

	local var_21_0 = var_1_10001.GetSceneByName(arg_21_0.sceneName)
	local var_21_1 = var_1.GetRootGameObjects(var_21_0)

	table = var_21_0

	var_21_0.IpairsCArray(var_21_1, function(arg_22_0, arg_22_1)
		if arg_22_1.name == "[MainBlock]" then
			local var_22_0 = arg_21_0

			tf = var_2_10003

			local var_22_1 = var_2_10003(arg_22_1)

			var_22_0.modelRoot = var_3.Find(var_22_1, "[Model]/scene_root")

			local var_22_2 = arg_21_0
			local var_22_3 = arg_21_0.modelRoot

			var_22_2.ballTF = var_3.Find(var_22_3, "fbx/litmap05/pre_db_sportinggoods03")

			local var_22_4 = arg_21_0.ballTF

			var_22_4.position = var_0_1.BallInitPos
			setActive = var_22_4

			var_22_4(arg_21_0.ballTF, false)
		elseif arg_22_1.name == "MainCamera" then
			local var_22_5 = arg_21_0

			var_22_5.mainCamera = arg_22_1.transform
			setActive = var_22_5

			var_22_5(arg_21_0.mainCamera, false)
		elseif arg_22_1.name == "PlayerCamera" then
			arg_21_0.ballCamera = arg_22_1.transform

			local var_22_6 = arg_21_0
			local var_22_7 = arg_21_0.ballCamera
			local var_22_8 = var_3.GetComponent

			typeof = var_2_10005
			Camera = var_2_10006
			var_22_6.ballCameraComp = var_22_8(var_22_7, var_2_10005(var_2_10006))
			setActive = var_22_6

			var_22_6(arg_21_0.ballCamera, false)
		elseif arg_22_1.name == "TriggerPlane" then
			setActive = var_2

			var_2(arg_22_1, false)

			tf = var_2

			local var_22_9 = var_2(arg_22_1)
			local var_22_10 = var_2.Find(var_22_9, "BallCreate")
			local var_22_11 = var_2.GetComponent

			typeof = var_2_10005
			UnityEngine = var_2_10006

			local var_22_12 = var_22_11(var_22_10, var_2_10005(var_2_10006.MeshCollider)).sharedMesh
			local var_22_13 = arg_21_0

			Plane = var_5

			local var_22_14 = var_5.New
			local var_22_15 = var_22_12.normals[0]

			Vector3 = var_2_10007
			var_22_13.ballCreatePlane = var_22_14(var_22_15, -var_2_10007.Dot(var_2.position, var_22_12.normals[0]))
			tf = var_22_13

			local var_22_16 = var_22_13(arg_22_1)
			local var_22_17 = var_4.Find(var_22_16, "BallQte")

			setLocalPosition = var_22_16

			local var_22_18 = var_22_17

			Vector3 = var_7

			var_22_16(var_22_18, var_7(arg_21_0.volleyballCfg.BallQtePlane[1][1], arg_21_0.volleyballCfg.BallQtePlane[1][2], arg_21_0.volleyballCfg.BallQtePlane[1][3]))

			setLocalEulerAngles = var_22_16

			local var_22_19 = var_22_17

			Vector3 = var_7

			var_22_16(var_22_19, var_7(arg_21_0.volleyballCfg.BallQtePlane[2][1], arg_21_0.volleyballCfg.BallQtePlane[2][2], arg_21_0.volleyballCfg.BallQtePlane[2][3]))

			local var_22_20 = var_22_17
			local var_22_21 = var_22_17.GetComponent

			typeof = var_7
			UnityEngine = var_8

			local var_22_22 = var_22_21(var_22_20, var_7(var_8.MeshCollider)).sharedMesh
			local var_22_23 = arg_21_0

			Plane = var_7

			local var_22_24 = var_7.New
			local var_22_25 = var_22_22.normals[0]

			Vector3 = var_9
			var_22_23.ballQtePlane = var_22_24(var_22_25, -var_9.Dot(var_22_17.position, var_22_22.normals[0]))
			tf = var_22_23

			local var_22_26 = var_22_23(arg_22_1)
			local var_22_27 = var_6.Find(var_22_26, "BallMiss")

			setLocalPosition = var_22_26

			local var_22_28 = var_22_27

			Vector3 = var_9

			var_22_26(var_22_28, var_9(arg_21_0.volleyballCfg.BallMissPlane[1][1], arg_21_0.volleyballCfg.BallMissPlane[1][2], arg_21_0.volleyballCfg.BallMissPlane[1][3]))

			setLocalEulerAngles = var_22_26

			local var_22_29 = var_22_27

			Vector3 = var_9

			var_22_26(var_22_29, var_9(arg_21_0.volleyballCfg.BallMissPlane[2][1], arg_21_0.volleyballCfg.BallMissPlane[2][2], arg_21_0.volleyballCfg.BallMissPlane[2][3]))

			local var_22_30 = var_22_27
			local var_22_31 = var_22_27.GetComponent

			typeof = var_9
			UnityEngine = var_10

			local var_22_32 = var_22_31(var_22_30, var_9(var_10.MeshCollider)).sharedMesh
			local var_22_33 = arg_21_0

			Plane = var_9

			local var_22_34 = var_9.New
			local var_22_35 = var_22_32.normals[0]

			Vector3 = var_11
			var_22_33.ballMissPlane = var_22_34(var_22_35, -var_11.Dot(var_22_27.position, var_22_32.normals[0]))
		end

		return
	end)
	arg_21_0:InitLightSettings()

	SceneManager = var_2

	local var_21_2 = var_2.GetSceneByName(arg_21_0.timelineSceneName)
	local var_21_3 = var_2.GetRootGameObjects(var_21_2)

	arg_21_0.totalDirectorList = {}
	table = var_4

	var_4.IpairsCArray(var_21_3, function(arg_23_0, arg_23_1)
		tf = var_2_10002

		local var_23_0 = var_2_10002(arg_23_1)
		local var_23_1 = var_2.Find(var_23_0, "[sequence]")

		IsNil = var_23_0

		if var_23_0(var_23_1) then
			return
		end

		local var_23_2 = var_23_1
		local var_23_3 = var_23_1.GetComponent

		typeof = var_2_10005
		UnityEngine = var_2_10006

		local var_23_4 = var_23_3(var_23_2, var_2_10005(var_2_10006.Playables.PlayableDirector))

		var_23_4.playOnAwake = false

		var_23_4:Stop()

		local var_23_5 = var_23_1
		local var_23_6 = var_23_1.GetComponentsInChildren

		typeof = var_6
		UnityEngine = var_2_10007

		local var_23_7 = var_23_6(var_23_5, var_6(var_2_10007.Playables.PlayableDirector))
		local var_23_8 = var_4.ToTable(var_23_7)

		ipairs = var_23_7

		for iter_23_0, iter_23_1 in var_23_7(var_23_8) do
			iter_23_1.playOnAwake = false

			iter_23_1:Stop()
		end

		table = var_5

		var_5.insert(arg_21_0.totalDirectorList, {
			name = arg_23_1.name,
			director = var_23_4
		})

		setActive = var_5

		var_5(arg_23_1, false)

		return
	end)

	return
end

function var_0_1.InitLightSettings(arg_24_0)
	GameObject = var_1_10001
	arg_24_0.globalVolume = var_1_10001.Find("GlobalVolume")
	GameObject = var_1
	arg_24_0.characterLight = var_1.Find("CharacterLight")
	GameObject = var_1

	local var_24_0 = var_1.Find("[Lighting]").transform

	table = var_2

	local var_24_1 = var_2.IpairsCArray
	local var_24_2 = var_24_0
	local var_24_3 = var_24_0.GetComponentsInChildren

	typeof = var_1_10005
	Light = var_1_10006

	var_24_1(var_24_3(var_24_2, var_1_10005(var_1_10006)), function(arg_25_0, arg_25_1)
		UnityEngine = var_2_10002
		arg_25_1.shadows = var_2_10002.LightShadows.None

		return
	end)

	return
end

function var_0_1.didEnter(arg_26_0)
	arg_26_0:InitData()

	setActive = var_1

	var_1(arg_26_0.skipUI, true)
	arg_26_0:PlayTimeline({
		name = arg_26_0:GetWeightTimeline("jinchang")
	}, function()
		if not arg_26_0.playingFlag then
			setActive = var_0

			var_0(arg_26_0.skipUI, false)

			local var_27_0 = arg_26_0

			var_0.StartGame(var_27_0)
		end

		return
	end)

	return
end

function var_0_1.InitData(arg_28_0)
	return
end

function var_0_1.PlayTimeline(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1.name
	local var_29_1 = arg_29_1.track

	_ = var_1_10005

	local var_29_2 = var_1_10005.detect(arg_29_0.totalDirectorList, function(arg_30_0)
		return arg_30_0.name == var_29_0
	end)

	assert = var_6

	var_6(var_29_2, "Missing director " .. var_29_0)

	local var_29_3 = arg_29_0
	local var_29_4 = arg_29_0.StopPlayingTimeline

	tobool = var_8

	var_29_4(var_29_3, var_8(var_29_2))

	if not var_29_2 then
		existCall = var_29_4

		var_29_4(arg_29_2)

		return
	end

	local var_29_5 = {}

	arg_29_0.playingDirector = var_29_2.director

	local var_29_6 = arg_29_0.playingDirector.transform
	local var_29_7 = arg_29_0.debugTimelineName

	var_29_7.text = var_29_6.parent.name
	table = var_29_7

	var_29_7.insert(var_29_5, function(arg_31_0)
		local var_31_0

		if arg_29_1.time then
			var_31_0 = arg_29_0.playingDirector
			math = var_2_10002
			var_31_0.time = var_2_10002.clamp(arg_29_1.time, 0, arg_29_0.playingDirector.duration)
		end

		TimelineSupport = var_31_0

		var_31_0.InitTimeline(arg_29_0.playingDirector)

		local var_31_1 = {}

		GetOrAddComponent = var_2

		local var_31_2 = var_2(var_29_6, "DftCommonSignalReceiver")

		var_2.SetCommonEvent(var_31_2, function(arg_32_0)
			switch = var_3_10001

			var_3_10001(arg_32_0.stringParameter, {
				TimelineRandomTrack = function()
					local var_33_0 = arg_29_0

					var_0.DoTimelineRandomTrack(var_33_0, arg_29_0.playingDirector)

					return
				end,
				TimelineLoop = function()
					arg_29_0.playingDirector.time = arg_32_0.floatParameter

					return
				end,
				TimelineEnd = function()
					var_31_1.finish = true

					local var_35_0 = arg_29_0.playingDirector

					var_0.Stop(var_35_0)

					setActive = var_0
					tf = var_35_0

					var_0(var_35_0(arg_29_0.playingDirector).parent, false)

					return
				end
			}, function()
				warning = var_4_10000

				var_4_10000("other event trigger:" .. arg_32_0.stringParameter)

				return
			end)

			if var_31_1.finish then
				arg_29_0.timelineMark = var_31_1
				arg_29_0.debugTimelineName.text = ""
				arg_29_0.debugTrackName.text = ""

				arg_31_0()
			end

			return
		end)

		local var_31_3 = arg_29_0.playingDirector

		var_3.Evaluate(var_31_3)

		local var_31_4 = arg_29_0

		var_3.DoTimelineRandomTrack(var_31_4, arg_29_0.playingDirector)

		setActive = var_3
		tf = var_31_4

		var_3(var_31_4(arg_29_0.playingDirector).parent, true)

		local var_31_5 = arg_29_0.playingDirector

		var_3.Play(var_31_5)

		setActive = var_3

		var_3(arg_29_0.mainCamera, false)

		if arg_29_0.activeDirectorInfo then
			arg_29_0.lastDirectorInfo = arg_29_0.activeDirectorInfo
		end

		arg_29_0.activeDirectorInfo = var_29_2

		return
	end)

	seriesAsync = var_8

	var_8(var_29_5, function()
		setActive = var_2_10000

		var_2_10000(arg_29_0.mainCamera, true)

		arg_29_0.playingDirector = nil

		local var_37_0 = arg_29_0.timelineMark
		local var_37_1 = arg_29_0

		var_37_1.timelineMark = nil
		existCall = var_37_1

		var_37_1(arg_29_2, var_37_0)

		return
	end)

	return
end

function var_0_1.StopPlayingTimeline(arg_38_0, arg_38_1)
	if arg_38_0.playingDirector then
		local var_38_0 = arg_38_0.playingDirector

		var_2.Stop(var_38_0)

		setActive = var_2
		tf = var_38_0

		var_2(var_38_0(arg_38_0.playingDirector).parent, false)

		arg_38_0.debugTimelineName.text = ""
		arg_38_0.debugTrackName.text = ""
		arg_38_0.playingDirector = nil

		if not arg_38_1 then
			setActive = var_2

			var_2(arg_38_0.mainCamera, true)
		end
	end

	return
end

function var_0_1.StartGame(arg_39_0)
	setActive = var_1_10001

	var_1_10001(arg_39_0.mainCamera, true)

	arg_39_0.playingFlag = true
	arg_39_0.gameResult = nil

	local var_39_0 = 0

	arg_39_0.otherScore = 0
	arg_39_0.ourScore = var_39_0
	setActive = var_39_0

	var_39_0(arg_39_0.gameUI, true)

	setActive = var_39_0

	local var_39_1 = arg_39_0.gameUI

	var_39_0(var_2.Find(var_39_1, "Score"), false)

	local var_39_2 = arg_39_0.gameUI
	local var_39_3 = var_1.Find(var_39_2, "Count")

	setActive = var_39_2

	var_39_2(var_39_3, true)

	arg_39_0.isStartGame = true
	pg = var_2

	local var_39_4 = var_2.CriMgr.GetInstance()

	var_2.PlaySE_V3(var_39_4, var_0_2)

	return
end

function var_0_1.UpdateGameScore(arg_40_0)
	setText = var_1_10001

	var_1_10001(arg_40_0.ourScoreTF, arg_40_0.ourScore)

	setText = var_1_10001

	var_1_10001(arg_40_0.otherScoreTF, arg_40_0.otherScore)

	return
end

function var_0_1.UpdateScoreTpl(arg_41_0, arg_41_1)
	setText = var_1_10002

	var_1_10002(arg_41_1:Find("Left/Tens/Text"), 0)

	setText = var_1_10002

	var_1_10002(arg_41_1:Find("Left/Units/Text"), arg_41_0.ourScore % 10)

	setText = var_1_10002

	var_1_10002(arg_41_1:Find("Right/Tens/Text"), 0)

	setText = var_1_10002

	var_1_10002(arg_41_1:Find("Right/Units/Text"), arg_41_0.otherScore % 10)

	return
end

function var_0_1.StartOneRound(arg_42_0)
	arg_42_0:UpdateGameScore()

	arg_42_0.roundEndFlag = false
	arg_42_0.roundResult = nil
	seriesAsync = var_1

	var_1({
		function(arg_43_0)
			local var_43_0 = arg_42_0

			var_1.FaQiuOP(var_43_0, arg_43_0)

			return
		end,
		function(arg_44_0)
			local var_44_0 = arg_42_0

			var_1.OneQTE(var_44_0)

			return
		end
	})

	return
end

function var_0_1.OneQTE(arg_45_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_46_0)
			local var_46_0 = arg_45_0

			var_1.StartQTE(var_46_0, arg_46_0)

			return
		end,
		function(arg_47_0)
			switch = var_2_10001

			var_2_10001(arg_45_0.qteResult, {
				[var_0_1.QTE_RESULT.MISS] = function()
					local var_48_0 = arg_45_0

					var_0.QteMissOP(var_48_0, function()
						arg_45_0.roundEndFlag = true
						arg_45_0.roundResult = var_0_1.ROUND_RESULT.OTHER_WIN

						arg_47_0()

						return
					end)

					return
				end,
				[var_0_1.QTE_RESULT.HIT] = function()
					local var_50_0 = arg_45_0

					var_0.QteHitOP(var_50_0, arg_47_0)

					return
				end,
				[var_0_1.QTE_RESULT.PERFECT] = function()
					local var_51_0 = arg_45_0

					var_0.QtePerfectOP(var_51_0, function()
						arg_45_0.roundEndFlag = true
						arg_45_0.roundResult = var_0_1.ROUND_RESULT.OUR_WIN

						arg_47_0()

						return
					end)

					return
				end
			}, function()
				assert = var_3_10000

				var_3_10000(false, "unknow qte result" .. arg_45_0.qteResult)

				return
			end)

			return
		end
	}, function()
		if not arg_45_0.roundEndFlag then
			local var_54_0 = arg_45_0

			var_0.OneQTE(var_54_0)
		else
			local var_54_1 = arg_45_0

			var_0.EndOneRound(var_54_1)
		end

		return
	end)

	return
end

function var_0_1.EndOneRound(arg_55_0)
	pg = var_1_10001

	local var_55_0 = var_1_10001.CriMgr.GetInstance()

	var_1.PlaySE_V3(var_55_0, var_0_7)

	arg_55_0.isEndOneRound = true
	setActive = var_1

	var_1(arg_55_0.gameUI, false)

	local var_55_1 = arg_55_0
	local var_55_2 = arg_55_0.UpdateScoreTpl
	local var_55_3 = arg_55_0.scoreUI

	var_55_2(var_55_1, var_3.Find(var_55_3, "ScoreTpl"))

	setText = var_55_2

	local var_55_4 = arg_55_0.scoreUI

	var_55_2(var_2.Find(var_55_4, "ScoreTpl/Left/Units/new/newText"), arg_55_0.ourScore % 10)

	setText = var_55_2

	local var_55_5 = arg_55_0.scoreUI

	var_55_2(var_2.Find(var_55_5, "ScoreTpl/Right/Units/new/newText"), arg_55_0.otherScore % 10)

	switch = var_55_2

	var_55_2(arg_55_0.roundResult, {
		[var_0_1.ROUND_RESULT.OUR_WIN] = function()
			local var_56_0 = arg_55_0

			var_56_0.ourScore = arg_55_0.ourScore + 1
			setText = var_56_0

			local var_56_1 = arg_55_0.scoreUI

			var_56_0(var_1.Find(var_56_1, "ScoreTpl/Left/Units/new/newText"), arg_55_0.ourScore % 10)

			setActive = var_56_0

			var_56_0(arg_55_0.scoreUI, true)

			quickPlayAnimation = var_56_0

			var_56_0(arg_55_0.scoreUI, "Anim_Dorm3d_volleyball_score_leftin")

			return
		end,
		[var_0_1.ROUND_RESULT.OTHER_WIN] = function()
			local var_57_0 = arg_55_0

			var_57_0.otherScore = arg_55_0.otherScore + 1
			setText = var_57_0

			local var_57_1 = arg_55_0.scoreUI

			var_57_0(var_1.Find(var_57_1, "ScoreTpl/Right/Units/new/newText"), arg_55_0.otherScore % 10)

			setActive = var_57_0

			var_57_0(arg_55_0.scoreUI, true)

			quickPlayAnimation = var_57_0

			var_57_0(arg_55_0.scoreUI, "Anim_Dorm3d_volleyball_score_rightin")

			return
		end
	}, function()
		assert = var_2_10000

		var_2_10000(false, "unknow round result" .. arg_55_0.roundResult)

		return
	end)

	return
end

function var_0_1.CheckEndGame(arg_59_0)
	if arg_59_0.ourScore >= var_0_1.endScore then
		arg_59_0.gameResult = var_0_1.GAME_RESULT.VICTORY

		return true
	end

	if arg_59_0.otherScore >= var_0_1.endScore then
		arg_59_0.gameResult = var_0_1.GAME_RESULT.DEFEAT

		return true
	end

	return false
end

function var_0_1.EndGame(arg_60_0)
	if arg_60_0.gameResult == var_0_1.GAME_RESULT.VICTORY then
		pg = var_1

		local var_60_0 = var_1.CriMgr.GetInstance()

		var_1.PlaySE_V3(var_60_0, var_0_8)
	end

	seriesAsync = var_1

	var_1({
		function(arg_61_0)
			local var_61_0 = arg_60_0.gameResult == var_0_1.GAME_RESULT.VICTORY and "shibai" or "shengli"
			local var_61_1 = arg_60_0
			local var_61_2 = var_2.PlayTimeline
			local var_61_3 = {}
			local var_61_4 = arg_60_0

			var_61_3.name = var_5.GetWeightTimeline(var_61_4, var_61_0)

			var_61_2(var_61_1, var_61_3, arg_61_0)

			return
		end
	}, function()
		local var_62_0 = arg_60_0
		local var_62_1 = var_0.PlayTimeline
		local var_62_2 = {}
		local var_62_3 = arg_60_0

		var_62_2.name = var_3.GetWeightTimeline(var_62_3, "daiji")

		var_62_1(var_62_0, var_62_2, function()
			return
		end)

		setActive = var_62_1

		var_62_1(arg_60_0.endUI, true)

		setActive = var_62_1

		local var_62_4 = arg_60_0.endUI

		var_62_1(var_1.Find(var_62_4, "Title/Victory"), arg_60_0.gameResult == var_0_1.GAME_RESULT.VICTORY)

		setActive = var_62_1

		local var_62_5 = arg_60_0.endUI

		var_62_1(var_1.Find(var_62_5, "Title/Defeat"), arg_60_0.gameResult == var_0_1.GAME_RESULT.DEFEAT)

		local var_62_6 = arg_60_0
		local var_62_7 = var_0.UpdateScoreTpl
		local var_62_8 = arg_60_0.endUI

		var_62_7(var_62_6, var_2.Find(var_62_8, "ScoreTpl"))

		return
	end)

	return
end

function var_0_1.ShowResultUI(arg_64_0, arg_64_1)
	(function()
		local var_65_0 = arg_64_0.contextData.roomId
		local var_65_1 = arg_64_0.contextData.groupId
		local var_65_2

		if not arg_64_0.contextData.groupIds then
			var_65_2 = {
				var_65_1
			}
		end

		table = var_2_10003

		local var_65_3 = var_2_10003.concat(var_65_2, ",")
		local var_65_4 = arg_64_0.ourScore .. ":" .. arg_64_0.otherScore

		pg = var_5

		local var_65_5 = var_5.m02
		local var_65_6 = var_5.sendNotification

		GAME = var_2_10007

		local var_65_7 = var_2_10007.APARTMENT_TRACK

		Dorm3dTrackCommand = var_2_10008

		var_65_6(var_65_5, var_65_7, var_2_10008.BuildDataRoom(var_65_0, 8, var_65_3, var_65_4))

		return
	end)()

	pg = var_3

	local var_64_0 = var_3.CriMgr.GetInstance()

	var_3.PlaySE_V3(var_64_0, var_0_9)

	seriesAsync = var_3

	var_3({
		function(arg_66_0)
			quickPlayAnimation = var_2_10001

			var_2_10001(arg_64_0.endUI, "Anim_Dorm3d_volleyball_end_out")

			onDelayTick = var_2_10001

			var_2_10001(function()
				setActive = var_3_10000

				var_3_10000(arg_64_0.endUI, false)

				return
			end, 0.1)

			if arg_64_0.gameResult == var_0_1.GAME_RESULT.VICTORY then
				local var_66_0 = arg_64_0
				local var_66_1 = var_1.PlayTimeline
				local var_66_2 = {}
				local var_66_3 = arg_64_0

				var_66_2.name = var_4.GetWeightTimeline(var_66_3, "jiangli")

				var_66_1(var_66_0, var_66_2, arg_66_0)
			else
				local var_66_4 = arg_64_0

				var_1.StopPlayingTimeline(var_66_4)
				arg_66_0()
			end

			return
		end
	}, function()
		setActive = var_2_10000

		var_2_10000(arg_64_0.resultUI, true)

		local var_68_0

		var_68_0 = arg_64_0.gameResult == var_0_1.GAME_RESULT.VICTORY and "Victory" or "Defeat"
		setText = var_1

		local var_68_1 = arg_64_0.resultUI
		local var_68_2 = var_2.Find(var_68_1, "Panel/Text")

		i18n = var_68_1

		local var_68_3 = "volleyball_end_tip"
		local var_68_4 = arg_64_0.apartment

		var_1(var_68_2, var_68_1(var_68_3, var_5.getConfig(var_68_4, "name")))

		if arg_64_1 and arg_64_1.cost > 0 then
			setActive = var_1

			local var_68_5 = arg_64_0.resultUI

			var_1(var_2.Find(var_68_5, "Panel/Award"), true)

			setText = var_1

			local var_68_6 = arg_64_0.resultUI
			local var_68_7 = var_2.Find(var_68_6, "Panel/Award/Text")

			i18n = var_68_6

			local var_68_8 = "volleyball_end_award"
			local var_68_9 = arg_64_0.apartment

			var_1(var_68_7, var_68_6(var_68_8, var_5.getConfig(var_68_9, "name")))
		else
			setActive = var_1

			local var_68_10 = arg_64_0.resultUI

			var_1(var_2.Find(var_68_10, "Panel/Award"), false)
		end

		gcAll = var_1

		var_1()

		return
	end)

	return
end

function var_0_1.FaQiuOP(arg_69_0, arg_69_1)
	arg_69_0:PlayTimeline({
		name = arg_69_0:GetWeightTimeline("faqiu")
	}, arg_69_1)

	return
end

function var_0_1.StartQTE(arg_70_0, arg_70_1)
	arg_70_0.qteCallback = arg_70_1
	setActive = var_1_10002

	var_1_10002(arg_70_0.ballCamera, true)

	setActive = var_1_10002

	var_1_10002(arg_70_0.mainCamera, false)

	Vector2 = var_1_10002
	math = var_3

	local var_70_0 = var_3.random
	local var_70_1 = var_0_1.BallRandomDelat.Left

	Screen = var_1_10005

	local var_70_2 = var_70_0(var_70_1, var_1_10005.width - var_0_1.BallRandomDelat.Right)

	math = var_70_1

	local var_70_3 = var_70_1.random
	local var_70_4 = var_0_1.BallRandomDelat.Bottom

	Screen = var_6
	arg_70_0.randomScreenPos = var_1_10002(var_70_2, var_70_3(var_70_4, var_6.height - var_0_1.BallRandomDelat.Top))

	local var_70_5 = arg_70_0.ballCameraComp
	local var_70_6 = var_2.ScreenPointToRay(var_70_5, arg_70_0.randomScreenPos)

	math = var_70_5
	arg_70_0.randomScale = var_70_5.random(var_0_1.perfectScaleRandoms[1] * 10, arg_70_0.perfectScaleRandoms[2] * 10) / 10

	local var_70_7 = (var_0_1.perfectRadiusMax + var_0_1.perfectRadiusMin) / 2 * arg_70_0.randomScale / var_0_1.triggerRadius
	local var_70_8 = arg_70_0.ballQtePlane.distance + (arg_70_0.ballMissPlane.distance - arg_70_0.ballQtePlane.distance) * (1 - var_70_7)

	Plane = var_5

	local var_70_9 = var_5.New(arg_70_0.ballQtePlane.normal, var_70_8)
	local var_70_10, var_70_11 = var_5.Raycast(var_70_9, var_70_6)

	assert = var_8

	var_8(var_70_10, "retPerfect plane not in view")

	local var_70_12 = var_70_6:GetPoint(var_70_11) - var_0_1.BallInitPos

	arg_70_0.ballDir = var_9.Normalize(var_70_12)
	Ray = var_9

	local var_70_13 = var_9.New(arg_70_0.ballDir, var_0_1.BallInitPos)
	local var_70_14 = arg_70_0.ballQtePlane
	local var_70_15, var_70_16 = var_10.Raycast(var_70_14, var_70_13)

	assert = var_12

	var_12(var_70_15, "qte plane not in view")

	local var_70_17 = var_70_13:GetPoint(var_70_16)
	local var_70_18 = arg_70_0.ballMissPlane
	local var_70_19, var_70_20 = var_13.Raycast(var_70_18, var_70_13)

	assert = var_15

	var_15(var_70_19, "miss plane not in view")

	local var_70_21 = var_70_13:GetPoint(var_70_20)
	local var_70_22 = 0
	local var_70_23 = var_70_17 - var_70_21

	arg_70_0.qteUITime = var_17.Magnitude(var_70_23) / var_0_1.BallQTESpeed
	Timer = var_17
	arg_70_0.ballTimer = var_17.New(function()
		if var_70_22 >= var_70_20 then
			local var_71_0 = arg_70_0.ballTimer

			var_0.Stop(var_71_0)

			local var_71_1 = arg_70_0

			var_71_1.ballTimer = nil
			setActive = var_71_1

			var_71_1(arg_70_0.ballTF, false)

			arg_70_0.ballTF.position = var_0_1.BallInitPos

			if arg_70_0.startQTEUI then
				setLocalScale = var_0

				var_0(arg_70_0.qteTriggerTF, {
					x = 0,
					y = 0
				})

				local var_71_2 = arg_70_0

				var_0.EndQTE(var_71_2, var_0_1.QTE_RESULT.MISS)
			end
		elseif var_70_22 >= var_70_16 then
			var_70_22 = var_70_22 + var_0_1.BallQTESpeed

			local var_71_3 = arg_70_0.ballTF
			local var_71_4 = var_70_13

			var_71_3.position = var_1.GetPoint(var_71_4, var_70_22)

			if not arg_70_0.startQTEUI then
				local var_71_5 = arg_70_0

				var_0.StartQTEUI(var_71_5)
			end

			local var_71_6 = arg_70_0

			var_71_6.curScale = arg_70_0.curScale - 1 / arg_70_0.qteUITime
			setLocalScale = var_71_6

			var_71_6(arg_70_0.qteTriggerTF, {
				x = arg_70_0.curScale,
				y = arg_70_0.curScale
			})

			arg_70_0.curRadius = var_0_1.triggerRadius * arg_70_0.curScale

			if arg_70_0.curScale < 0 then
				local var_71_7 = arg_70_0

				var_0.EndQTE(var_71_7)
			end
		else
			var_70_22 = var_70_22 + var_0_1.BallSpeed

			local var_71_8 = arg_70_0.ballTF
			local var_71_9 = var_70_13

			var_71_8.position = var_1.GetPoint(var_71_9, var_70_22)
		end

		return
	end, 0.016666666666666666, -1)
	setActive = var_17

	var_17(arg_70_0.ballTF, true)

	local var_70_24 = arg_70_0.ballTimer

	var_17.Start(var_70_24)

	return
end

function var_0_1.StartQTEUI(arg_72_0)
	pg = var_1_10001

	local var_72_0 = var_1_10001.CriMgr.GetInstance()

	var_1.PlaySE_V3(var_72_0, var_0_3)

	setLocalScale = var_1

	var_1(arg_72_0.qteTriggerTF, {
		x = 1,
		y = 1
	})

	eachChild = var_1

	local var_72_1 = arg_72_0.qteTF

	var_1(var_2.Find(var_72_1, "animroot/Result"), function(arg_73_0)
		setActive = var_2_10001

		var_2_10001(arg_73_0, false)

		return
	end)

	arg_72_0.qteResult = nil
	arg_72_0.curRadius = var_0_1.triggerRadius
	arg_72_0.curPerfectRadiusMax = var_0_1.perfectRadiusMax * arg_72_0.randomScale
	arg_72_0.curPerfectRadiusMin = var_0_1.perfectRadiusMin * arg_72_0.randomScale
	setLocalScale = var_1

	local var_72_2 = arg_72_0.qteTF

	var_1(var_2.Find(var_72_2, "animroot/Perfect"), {
		x = arg_72_0.randomScale,
		y = arg_72_0.randomScale
	})

	arg_72_0.curScale = 1
	setLocalPosition = var_1

	local var_72_3 = arg_72_0.qteTF

	LuaHelper = var_3

	local var_72_4 = var_3.ScreenToLocal
	local var_72_5 = arg_72_0.qteTF.parent
	local var_72_6 = arg_72_0.randomScreenPos

	pg = var_1_10006

	var_1(var_72_3, var_72_4(var_72_5, var_72_6, var_1_10006.UIMgr.GetInstance().uiCameraComp))

	setActive = var_1

	var_1(arg_72_0.qteTF, true)

	arg_72_0.startQTEUI = true

	return
end

function var_0_1.EndQTE(arg_74_0, arg_74_1)
	arg_74_0.startQTEUI = nil
	setActive = var_2

	var_2(arg_74_0.mainCamera, true)

	setActive = var_2

	var_2(arg_74_0.ballCamera, false)

	if arg_74_1 then
		arg_74_0.qteResult = arg_74_1
	elseif arg_74_0.curRadius < var_0_1.hitRadiusMin or arg_74_0.curRadius > var_0_1.hitRadiusMax then
		arg_74_0.qteResult = var_0_1.QTE_RESULT.MISS
	elseif arg_74_0.curRadius <= arg_74_0.curPerfectRadiusMax and arg_74_0.curRadius >= arg_74_0.curPerfectRadiusMin then
		arg_74_0.qteResult = var_0_1.QTE_RESULT.PERFECT
	else
		arg_74_0.qteResult = var_0_1.QTE_RESULT.HIT
	end

	eachChild = var_2

	local var_74_0 = arg_74_0.qteTF

	var_2(var_3.Find(var_74_0, "animroot/Result"), function(arg_75_0)
		setActive = var_2_10001

		var_2_10001(arg_75_0, arg_75_0.name == arg_74_0.qteResult)

		return
	end)

	if arg_74_0.ballTimer then
		local var_74_1 = arg_74_0.ballTimer

		var_2.Stop(var_74_1)

		arg_74_0.ballTimer = nil
		setActive = var_2

		var_2(arg_74_0.ballTF, false)

		arg_74_0.ballTF.position = var_0_1.BallInitPos
	end

	if arg_74_0.qteCallback then
		arg_74_0.qteCallback()

		arg_74_0.qteCallback = nil
	end

	onDelayTick = var_2

	var_2(function()
		setActive = var_2_10000

		var_2_10000(arg_74_0.qteTF, false)

		return
	end, 1)

	return
end

function var_0_1.QteMissOP(arg_77_0, arg_77_1)
	pg = var_1_10002

	local var_77_0 = var_1_10002.CriMgr.GetInstance()

	var_2.PlaySE_V3(var_77_0, var_0_6)
	arg_77_0:PlayTimeline({
		name = arg_77_0:GetWeightTimeline("shiqiu")
	}, arg_77_1)

	return
end

function var_0_1.QteHitOP(arg_78_0, arg_78_1)
	pg = var_1_10002

	local var_78_0 = var_1_10002.CriMgr.GetInstance()

	var_2.PlaySE_V3(var_78_0, var_0_4)

	seriesAsync = var_2

	var_2({
		function(arg_79_0)
			local var_79_0 = arg_78_0
			local var_79_1 = var_1.PlayTimeline
			local var_79_2 = {}
			local var_79_3 = arg_78_0

			var_79_2.name = var_4.GetWeightTimeline(var_79_3, "fly")

			var_79_1(var_79_0, var_79_2, arg_79_0)

			return
		end,
		function(arg_80_0)
			local var_80_0 = arg_78_0
			local var_80_1 = var_1.PlayTimeline
			local var_80_2 = {}
			local var_80_3 = arg_78_0

			var_80_2.name = var_4.GetWeightTimeline(var_80_3, "jieqiu")

			var_80_1(var_80_0, var_80_2, arg_80_0)

			return
		end
	}, arg_78_1)

	return
end

function var_0_1.QtePerfectOP(arg_81_0, arg_81_1)
	pg = var_1_10002

	local var_81_0 = var_1_10002.CriMgr.GetInstance()

	var_2.PlaySE_V3(var_81_0, var_0_5)

	seriesAsync = var_2

	var_2({
		function(arg_82_0)
			local var_82_0 = arg_81_0
			local var_82_1 = var_1.PlayTimeline
			local var_82_2 = {}
			local var_82_3 = arg_81_0

			var_82_2.name = var_4.GetWeightTimeline(var_82_3, "max_fly")

			var_82_1(var_82_0, var_82_2, arg_82_0)

			return
		end,
		function(arg_83_0)
			local var_83_0 = arg_81_0
			local var_83_1 = var_1.PlayTimeline
			local var_83_2 = {}
			local var_83_3 = arg_81_0

			var_83_2.name = var_4.GetWeightTimeline(var_83_3, "shouji")

			var_83_1(var_83_0, var_83_2, arg_83_0)

			return
		end
	}, arg_81_1)

	return
end

function var_0_1.GetWeightTimeline(arg_84_0, arg_84_1)
	local var_84_0 = arg_84_0.volleyballCfg[arg_84_1]

	assert = var_1_10003

	var_1_10003(var_84_0 ~= "", "volleyball cfg is empty string" .. arg_84_1)

	assert = var_1_10003

	var_1_10003(#var_84_0 ~= 0, "volleyball cfg is empty table:" .. arg_84_1)

	underscore = var_1_10003

	local var_84_1 = var_1_10003.reduce(var_84_0, 0, function(arg_85_0, arg_85_1)
		return arg_85_0 + arg_85_1[2]
	end)

	math = var_4

	local var_84_2 = var_4.random() * var_84_1
	local var_84_3 = 0

	ipairs = var_6

	for iter_84_0, iter_84_1 in var_6(var_84_0) do
		if var_84_2 <= var_84_3 + iter_84_1[2] then
			return iter_84_1[1]
		end
	end

	return
end

function var_0_1.DoTimelineRandomTrack(arg_86_0, arg_86_1)
	local var_86_0 = {}

	ipairs = var_1_10003
	TimelineHelper = var_1_10004

	local var_86_1 = var_1_10004.GetTimelineTracks(arg_86_1)

	for iter_86_0, iter_86_1 in var_1_10003(var_4.ToTable(var_86_1)) do
		if iter_86_1.name ~= "Markers" then
			iter_86_1.muted = true
			table = var_8

			var_8.insert(var_86_0, iter_86_1)
		end
	end

	if #var_86_0 > 0 then
		math = var_3

		local var_86_2 = var_86_0[var_3.random(#var_86_0)]

		underscore = var_4

		var_4.each(var_86_0, function(arg_87_0)
			if arg_87_0.name == var_86_2.name then
				arg_87_0.muted = false
			end

			return
		end)

		arg_86_0.debugTrackName.text = var_86_2.name
	else
		arg_86_0.debugTrackName.text = "track cnt 0"
	end

	return
end

function var_0_1.OnPause(arg_88_0)
	if arg_88_0.ballTimer then
		local var_88_0 = arg_88_0.ballTimer

		var_1.Stop(var_88_0)
	end

	if arg_88_0.playingDirector then
		local var_88_1 = arg_88_0.playingDirector

		var_1.Pause(var_88_1)
	end

	return
end

function var_0_1.OnResume(arg_89_0)
	if arg_89_0.ballTimer then
		local var_89_0 = arg_89_0.ballTimer

		var_1.Start(var_89_0)
	end

	if arg_89_0.playingDirector then
		local var_89_1 = arg_89_0.playingDirector

		var_1.Play(var_89_1)
	end

	return
end

function var_0_1.onBackPressed(arg_90_0)
	if arg_90_0.playingFlag then
		isActive = var_1
		var_1_10003 = arg_90_0.gameUI

		if not var_1(var_2.Find(var_1_10003, "Count")) then
			isActive = var_1

			if var_1(arg_90_0.endUI) then
				return
			end

			arg_90_0:OnPause()

			pg = var_1

			local var_90_0 = var_1.NewStyleMsgboxMgr.GetInstance()
			local var_90_1 = var_1.Show

			pg = var_1_10003

			local var_90_2 = var_1_10003.NewStyleMsgboxMgr.TYPE_MSGBOX
			local var_90_3 = {}

			i18n = var_1_10005
			var_90_3.contentText = var_1_10005("sure_exit_volleyball")

			function var_90_3.onConfirm()
				local var_91_0 = arg_90_0

				var_0.emit(var_91_0, var_0_1.ON_BACK)

				return
			end

			function var_90_3.onClose()
				local var_92_0 = arg_90_0

				var_0.OnResume(var_92_0)

				return
			end

			var_90_1(var_90_0, var_90_2, var_90_3)

			return
		end
	end
end

function var_0_1.willExit(arg_93_0)
	local var_93_0 = arg_93_0.loader

	var_1.Clear(var_93_0)

	if arg_93_0.ballTimer then
		local var_93_1 = arg_93_0.ballTimer

		var_1.Stop(var_93_1)

		arg_93_0.ballTimer = nil
	end

	local var_93_2 = {}
	local var_93_3 = {}

	string = var_1_10003
	var_93_3.path = var_1_10003.lower("dorm3d/character/" .. arg_93_0.timelineSceneRootName .. "/timeline/" .. arg_93_0.timelineSceneName .. "/" .. arg_93_0.timelineSceneName .. "_scene")
	var_93_3.name = arg_93_0.timelineSceneName
	var_93_2[1] = var_93_3

	local var_93_4 = {}

	string = var_3
	var_93_4.path = var_3.lower("dorm3d/scenesres/scenes/common/" .. arg_93_0.sceneRootName .. "/" .. arg_93_0.sceneName .. "_scene")
	var_93_4.name = arg_93_0.sceneName
	var_93_2[2] = var_93_4
	underscore = var_93_4

	local var_93_5 = var_93_4.map(var_93_2, function(arg_94_0)
		return function(arg_95_0)
			SceneOpMgr = var_3_10001

			local var_95_0 = var_3_10001.Inst

			var_1.UnloadSceneAsync(var_95_0, arg_94_0.path, arg_94_0.name, arg_95_0)

			return
		end
	end)

	seriesAsync = var_3

	var_3(var_93_5, function()
		ReflectionHelp = var_2_10000

		local var_96_0 = var_2_10000.RefSetProperty

		typeof = var_2_10001

		var_96_0(var_2_10001("UnityEngine.LightmapSettings"), "lightmaps", nil, nil)

		return
	end)

	return
end

return var_0_1
