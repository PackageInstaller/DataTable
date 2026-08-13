class = var_0_10000

local var_0_0 = "EatFoodLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))
local var_0_2 = {
	"ui-mini_throw",
	"ui-paishou_qing",
	"ui-paishou"
}
local var_0_3 = {
	0,
	0,
	0
}
local var_0_4 = 60
local var_0_5 = "ui/eatfoodgameui_atlas"
local var_0_6 = 67
local var_0_7
local var_0_8 = 4
local var_0_9 = 3
local var_0_10 = {
	0,
	630
}
local var_0_11 = {
	150,
	120,
	100,
	120,
	100,
	80,
	150,
	100,
	90,
	150,
	80,
	150,
	80,
	100,
	70
}
local var_0_12 = {
	8,
	10,
	15,
	9,
	12,
	18,
	11,
	13,
	15,
	15,
	8,
	17,
	15,
	10,
	18,
	10,
	18,
	20
}
local var_0_13 = {
	{
		-50,
		50
	},
	{
		-80,
		80
	},
	{
		-50,
		90
	},
	{
		-50,
		50
	},
	{
		-50,
		50
	},
	{
		-50,
		100
	},
	{
		-50,
		80
	},
	{
		-50,
		80
	},
	{
		-50,
		70
	},
	{
		-50,
		80
	},
	{
		-50,
		80
	},
	{
		-50,
		80
	},
	{
		-50,
		50
	},
	{
		-50,
		70
	},
	{
		-50,
		90
	}
}
local var_0_14 = 400
local var_0_15 = 0
local var_0_16 = "event touch"
local var_0_17 = {
	35,
	100
}
local var_0_18 = {
	300,
	10
}
local var_0_19 = {
	"add_1",
	"add_2"
}
local var_0_20 = {
	1000
}
local var_0_21 = {
	-100
}
local var_0_22 = {
	"sub_1"
}
local var_0_23 = {
	{
		126,
		530,
		2
	},
	{
		-100,
		110,
		3
	},
	{
		530,
		1000,
		3
	}
}
local var_0_24 = {
	300,
	10,
	-100
}
local var_0_25 = {
	"add_1",
	"add_2",
	"sub_1"
}
local var_0_26 = 0.8
local var_0_27 = 0.05
local var_0_28 = 1.4
local var_0_29 = 100

local function var_0_30(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			setActive = var_1

			var_1(arg_2_0._tf, false)

			findTF = var_1
			arg_2_0.sliderTouch = var_1(arg_2_0._tf, "touch")
			setActive = var_1

			var_1(arg_2_0.sliderTouch, true)

			findTF = var_1
			arg_2_0.sliderRange = var_1(arg_2_0._tf, "range")

			local var_2_0 = arg_2_0.sliderRange

			Vector2 = var_2_10002
			var_2_0.anchoredPosition = var_2_10002(0, var_0_14)

			return
		end,
		start = function(arg_3_0)
			arg_3_0.sliderIndex = 1
			arg_3_0.nextSliderTime = var_0_9
			Vector2 = var_1
			arg_3_0.sliderTouchPos = var_1(var_0_10[1], 0)

			arg_3_0:setSliderBarVisible(false)

			return
		end,
		step = function(arg_4_0)
			if arg_4_0.nextSliderTime then
				arg_4_0.nextSliderTime = arg_4_0.nextSliderTime - var_0_7

				if arg_4_0.nextSliderTime <= 0 then
					arg_4_0:setSliderBarVisible(true)
					arg_4_0:startSliderBar()

					arg_4_0.nextSliderTime = arg_4_0.nextSliderTime + var_0_8
				end
			end

			if arg_4_0.sliderBeginning then
				arg_4_0.sliderTouchPos.y = arg_4_0.sliderTouchPos.y + arg_4_0.speed
				arg_4_0.sliderTouch.anchoredPosition = arg_4_0.sliderTouchPos

				if arg_4_0.sliderTouchPos.y > var_0_10[2] then
					arg_4_0:touch(false)
				end
			end

			return
		end,
		setSliderBarVisible = function(arg_5_0, arg_5_1)
			setActive = var_2_10002

			var_2_10002(arg_5_0._tf, arg_5_1)

			return
		end,
		startSliderBar = function(arg_6_0)
			if arg_6_0.sliderIndex > #var_0_11 then
				arg_6_0.sliderIndex = #var_0_11
			end

			arg_6_0.sliderWidth = var_0_11[arg_6_0.sliderIndex]
			arg_6_0.speed = var_0_12[arg_6_0.sliderIndex]
			arg_6_0.speed = var_0_12[arg_6_0.sliderIndex]
			arg_6_0.sliderTouchPos.y = var_0_10[1]
			arg_6_0.sliderBeginning = true

			local var_6_0 = arg_6_0.sliderRange

			Vector2 = var_2
			var_6_0.sizeDelta = var_2(arg_6_0.sliderRange.sizeDelta.x, arg_6_0.sliderWidth)

			local var_6_1 = arg_6_0.sliderRange

			Vector2 = var_2

			local var_6_2 = 0
			local var_6_3 = var_0_14

			math = var_2_10006
			var_6_1.anchoredPosition = var_2(var_6_2, var_6_3 + var_2_10006.random(var_0_13[arg_6_0.sliderIndex][1], var_0_13[arg_6_0.sliderIndex][2]))

			return
		end,
		touch = function(arg_7_0, arg_7_1)
			if not arg_7_0.sliderBeginning then
				return
			end

			arg_7_0.sliderBeginning = false

			arg_7_0:setSliderBarVisible(false)

			local var_7_0 = false
			local var_7_1 = 0
			local var_7_2 = 1
			local var_7_3 = 1
			local var_7_4 = 1
			local var_7_5 = arg_7_0.sliderTouchPos.y

			math = var_2_10008

			local var_7_6

			if var_2_10008.abs(arg_7_0.sliderTouchPos.y - arg_7_0.sliderRange.anchoredPosition.y) < arg_7_0.sliderWidth / 2 then
				var_7_6 = var_0_24[1]
				var_7_2 = 1
				var_7_1 = var_7_6
				arg_7_0.sliderIndex = arg_7_0.sliderIndex + 1
				var_7_0 = true
			else
				ipairs = var_7_6

				for iter_7_0, iter_7_1 in var_7_6(var_0_23) do
					if var_7_5 >= iter_7_1[1] and var_7_5 <= iter_7_1[2] then
						var_7_4 = iter_7_1[3]
					end
				end

				var_7_6 = var_0_24[var_7_4]
				var_7_2 = var_7_4
				var_7_1 = var_7_6
				arg_7_0.nextSliderTime = arg_7_0.nextSliderTime + var_0_15
				var_7_0 = false
			end

			pg = var_7_6

			local var_7_7 = var_7_6.CriMgr.GetInstance()

			var_9.PlaySE_V3(var_7_7, var_0_2[var_7_4])

			local var_7_8 = arg_7_0._event

			var_9.emit(var_7_8, var_0_16, {
				flag = var_7_0,
				score = var_7_1,
				hit_index = var_7_2,
				hit_area = var_7_4
			}, function()
				return
			end)

			return
		end,
		getSubScore = function(arg_9_0, arg_9_1)
			local var_9_0 = var_0_21[1]
			local var_9_1 = 1

			for iter_9_0 = #var_0_20, 1, -1 do
				if arg_9_1 < var_0_20[iter_9_0] then
					var_9_0 = var_0_21[iter_9_0]
					var_9_1 = iter_9_0

					return var_9_0, var_9_1
				end
			end

			return var_9_0, var_9_1
		end,
		getScore = function(arg_10_0, arg_10_1)
			local var_10_0 = 0
			local var_10_1 = #var_0_17

			for iter_10_0 = 1, #var_0_17 do
				if arg_10_1 < var_0_17[iter_10_0] then
					var_10_0 = var_0_18[iter_10_0]
					var_10_1 = iter_10_0
					print = var_8

					var_8("hit range" .. arg_10_1)

					return var_10_0, var_10_1
				end
			end

			return var_10_0, var_10_1
		end,
		destroy = function(arg_11_0)
			return
		end
	}

	var_2.ctor(var_1_0)

	return var_2
end

function var_0_1.getUIName(arg_12_0)
	return "EatFoodLayerUI"
end

function var_0_1.didEnter(arg_13_0)
	arg_13_0:initEvent()
	arg_13_0:initData()
	arg_13_0:initUI()
	arg_13_0:initGameUI()
	arg_13_0:readyStart()

	return
end

function var_0_1.initEvent(arg_14_0)
	arg_14_0:bind(var_0_16, function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_1.score and arg_15_1.score ~= 0 then
			local var_15_0 = arg_14_0

			var_3.addScore(var_15_0, arg_15_1.score, arg_15_1.hit_index, arg_15_1.hit_area)
		end

		return
	end)

	return
end

function var_0_1.initData(arg_16_0)
	Application = var_1_10001

	local var_16_0

	if not var_1_10001.targetFrameRate then
		var_16_0 = 60
	end

	if var_16_0 > 60 then
		var_16_0 = 60
	end

	arg_16_0.stepCount = 1 / var_16_0 * 0.9
	Time = var_2
	arg_16_0.realTimeStartUp = var_2.realtimeSinceStartup
	Timer = var_2
	arg_16_0.timer = var_2.New(function()
		Time = var_2_10000

		local var_17_0 = var_2_10000.realtimeSinceStartup - arg_16_0.realTimeStartUp

		if arg_16_0.stepCount < var_17_0 then
			local var_17_1 = arg_16_0

			var_0.onTimer(var_17_1)

			local var_17_2 = arg_16_0

			Time = var_1
			var_17_2.realTimeStartUp = var_1.realtimeSinceStartup
		end

		return
	end, 1 / var_16_0, -1)

	return
end

function var_0_1.initUI(arg_18_0)
	findTF = var_1_10001
	arg_18_0.backSceneTf = var_1_10001(arg_18_0._tf, "scene_container/scene_background")
	findTF = var_1
	arg_18_0.sceneTf = var_1(arg_18_0._tf, "scene_container/scene")
	findTF = var_1
	arg_18_0.bgTf = var_1(arg_18_0._tf, "bg")
	findTF = var_1
	arg_18_0.clickMask = var_1(arg_18_0._tf, "clickMask")
	findTF = var_1
	arg_18_0.settlementUI = var_1(arg_18_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_18_0 = arg_18_0

	findTF = var_4

	local var_18_1 = var_4(arg_18_0.settlementUI, "btnOver")

	local function var_18_2()
		local var_19_0 = arg_18_0

		var_0.checkGameExit(var_19_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_18_0, var_18_1, var_18_2, var_6)

	SetActive = var_1

	var_1(arg_18_0.settlementUI, false)

	if not arg_18_0.handle then
		UpdateBeat = var_1
		arg_18_0.handle = var_1:CreateListener(arg_18_0.Update, arg_18_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_18_0.handle)

	return
end

function var_0_1.initGameUI(arg_20_0)
	findTF = var_1_10001
	arg_20_0.gameUI = var_1_10001(arg_20_0._tf, "ui/gameUI")
	onButton = var_1

	local var_20_0 = arg_20_0

	findTF = var_4

	var_1(var_20_0, var_4(arg_20_0.gameUI, "btnLeave"), function()
		local var_21_0 = arg_20_0

		var_0.checkGameExit(var_21_0)

		return
	end)

	GetOrAddComponent = var_1
	arg_20_0.dragDelegate = var_1(arg_20_0.sceneTf, "EventTriggerListener")
	arg_20_0.dragDelegate.enabled = true

	local var_20_1 = arg_20_0.dragDelegate

	var_1.AddPointDownFunc(var_20_1, function(arg_22_0, arg_22_1)
		if arg_20_0.sliderController then
			local var_22_0 = arg_20_0.sliderController

			var_2.touch(var_22_0, true)
		end

		return
	end)

	findTF = var_1
	arg_20_0.gameTimeS = var_1(arg_20_0.gameUI, "top/time/s")
	findTF = var_1
	arg_20_0.scoreTf = var_1(arg_20_0.gameUI, "top/score")
	findTF = var_1
	arg_20_0.scoreTextTf = var_1(arg_20_0.scoreTf, "text")
	findTF = var_1
	arg_20_0.sceneScoreTf = var_1(arg_20_0.sceneTf, "score")
	setActive = var_1

	var_1(arg_20_0.sceneScoreTf, false)

	local var_20_2 = var_0_30

	findTF = var_3
	arg_20_0.sliderController = var_20_2(var_3(arg_20_0.sceneTf, "collider"), arg_20_0)

	return
end

function var_0_1.Update(arg_23_0)
	arg_23_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_24_0)
	if arg_24_0.gameStop or arg_24_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		-- block empty
	end

	return
end

function var_0_1.clearUI(arg_25_0)
	setActive = var_1_10001

	var_1_10001(arg_25_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_25_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_25_0.gameUI, false)

	return
end

function var_0_1.readyStart(arg_26_0)
	arg_26_0:gameStart()

	return
end

function var_0_1.gameStart(arg_27_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_27_0._tf, "scene_container"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_27_0.bgTf, "on"), false)

	setActive = var_1_10001

	var_1_10001(arg_27_0.gameUI, true)

	arg_27_0.gameStartFlag = true
	arg_27_0.scoreNum = 0
	arg_27_0.playerPosIndex = 2
	arg_27_0.gameStepTime = 0
	arg_27_0.gameTime = var_0_4

	if arg_27_0.sliderController then
		local var_27_0 = arg_27_0.sliderController

		var_1.start(var_27_0)
	end

	arg_27_0:updateGameUI()
	arg_27_0:timerStart()

	return
end

function var_0_1.transformColor(arg_28_0, arg_28_1)
	tonumber = var_1_10002
	string = var_1_10004

	local var_28_0 = var_1_10002(var_1_10004.sub(arg_28_1, 1, 2), 16)

	tonumber = var_1_10003
	string = var_5

	local var_28_1 = var_1_10003(var_5.sub(arg_28_1, 3, 4), 16)

	tonumber = var_4
	string = var_6

	local var_28_2 = var_4(var_6.sub(arg_28_1, 5, 6), 16)

	Color = var_5

	return var_5.New(var_28_0 / 255, var_28_1 / 255, var_28_2 / 255)
end

function var_0_1.addScore(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	setActive = var_1_10004

	var_1_10004(arg_29_0.sceneScoreTf, false)

	if arg_29_1 then
		arg_29_0.scoreNum = arg_29_0.scoreNum + arg_29_1

		local var_29_0 = 1

		setActive = var_1_10005
		findTF = var_7

		var_1_10005(var_7(arg_29_0.sceneScoreTf, "anim/add_1"), false)

		setActive = var_1_10005
		findTF = var_7

		var_1_10005(var_7(arg_29_0.sceneScoreTf, "anim/add_2"), false)

		setActive = var_1_10005
		findTF = var_7

		var_1_10005(var_7(arg_29_0.sceneScoreTf, "anim/sub_1"), false)

		local var_29_1

		if 0 <= arg_29_1 then
			setActive = var_6
			findTF = var_8

			var_6(var_8(arg_29_0.sceneScoreTf, "anim/" .. var_0_25[arg_29_3]), true)

			var_29_1 = true
		else
			setActive = var_6
			findTF = var_8

			var_6(var_8(arg_29_0.sceneScoreTf, "anim/" .. var_0_25[arg_29_3]), true)

			var_29_1 = false
		end

		local var_29_2 = arg_29_0
		local var_29_3 = arg_29_0.emit

		Dorm3dMiniGameMediator = var_9

		var_29_3(var_29_2, var_9.GAME_OPERATION, {
			operationCode = "GAME_HIT_AREA",
			success = var_29_1,
			index = arg_29_3,
			miniGameId = var_0_6
		})

		setActive = var_29_3

		var_29_3(arg_29_0.sceneScoreTf, true)
	end

	arg_29_0:updateGameUI()

	return
end

function var_0_1.onTimer(arg_30_0)
	arg_30_0:gameStep()

	return
end

function var_0_1.gameStep(arg_31_0)
	Time = var_1_10001
	var_0_7 = var_1_10001.realtimeSinceStartup - arg_31_0.realTimeStartUp
	arg_31_0.gameTime = arg_31_0.gameTime - var_0_7
	arg_31_0.gameStepTime = arg_31_0.gameStepTime + var_0_7

	if arg_31_0.gameTime < 0 then
		arg_31_0.gameTime = 0
	end

	arg_31_0:updateGameUI()

	if arg_31_0.sliderController then
		local var_31_0 = arg_31_0.sliderController

		var_1.step(var_31_0)
	end

	if arg_31_0.gameTime <= 0 then
		arg_31_0:onGameOver(0)

		return
	end

	return
end

function var_0_1.timerStart(arg_32_0)
	if not arg_32_0.timer.running then
		Time = var_1
		arg_32_0.realTimeStartUp = var_1.realtimeSinceStartup

		local var_32_0 = arg_32_0.timer

		var_1.Start(var_32_0)
	end

	return
end

function var_0_1.timerStop(arg_33_0)
	if arg_33_0.timer.running then
		local var_33_0 = arg_33_0.timer

		var_1.Stop(var_33_0)
	end

	return
end

function var_0_1.updateGameUI(arg_34_0)
	setText = var_1_10001

	var_1_10001(arg_34_0.scoreTextTf, arg_34_0.scoreNum)

	setText = var_1_10001

	local var_34_0 = arg_34_0.gameTimeS

	math = var_4

	var_1_10001(var_34_0, var_4.ceil(arg_34_0.gameTime))

	return
end

function var_0_1.onGameOver(arg_35_0, arg_35_1)
	if arg_35_0.settlementFlag then
		return
	end

	arg_35_0:timerStop()

	arg_35_0.settlementFlag = true
	setActive = var_2

	var_2(arg_35_0.clickMask, true)

	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_35_0._tf, "scene_container"), false)

	setActive = var_2

	var_2(arg_35_0.gameUI, false)

	LeanTween = var_2

	local var_35_0 = var_2.delayedCall

	go = var_4

	local var_35_1 = var_4(arg_35_0._tf)
	local var_35_2 = arg_35_1

	System = var_6

	var_35_0(var_35_1, var_35_2, var_6.Action(function()
		arg_35_0.settlementFlag = false

		local var_36_0 = arg_35_0

		var_36_0.gameStartFlag = false
		setActive = var_36_0

		var_36_0(arg_35_0.clickMask, false)

		local var_36_1 = arg_35_0

		var_0.showSettlement(var_36_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_37_0)
	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.emit

	Dorm3dMiniGameMediator = var_1_10004

	var_37_1(var_37_0, var_1_10004.GAME_OPERATION, {
		operationCode = "GAME_RESULT",
		win = arg_37_0.scoreNum >= var_0_29,
		score = arg_37_0.scoreNum,
		miniGameId = var_0_6
	})

	setActive = var_37_1

	var_37_1(arg_37_0.settlementUI, true)

	local var_37_2 = arg_37_0.scoreNum

	getProxy = var_1_10002
	PlayerProxy = var_4

	local var_37_3 = var_1_10002(var_4)
	local var_37_4 = var_2.getPlayerId(var_37_3)

	PlayerPrefs = var_3

	local var_37_5 = var_3.GetInt
	local var_37_6 = "mg_score_"

	tostring = var_6

	local var_37_7

	if not var_37_5(var_37_6 .. var_6(var_37_4) .. "_" .. var_0_6) then
		var_37_7 = 0
	end

	setActive = var_37_3
	findTF = var_6

	var_37_3(var_6(arg_37_0.settlementUI, "ad/new"), var_37_7 < var_37_2)

	if var_37_7 <= var_37_2 then
		var_37_7 = var_37_2
		PlayerPrefs = var_37_3
		var_37_3 = var_37_3.SetInt

		local var_37_8 = "mg_score_"

		tostring = var_7

		var_37_3(var_37_8 .. var_7(var_37_4) .. "_" .. var_0_6, var_37_7)
	end

	findTF = var_37_3

	local var_37_9 = var_37_3(arg_37_0.settlementUI, "ad/highText")

	findTF = var_5

	local var_37_10 = var_5(arg_37_0.settlementUI, "ad/currentText")

	setText = var_6

	var_6(var_37_9, var_37_7)

	setText = var_6

	var_6(var_37_10, var_37_2)

	return
end

function var_0_1.resumeGame(arg_38_0)
	arg_38_0.gameStop = false

	arg_38_0:timerStart()

	return
end

function var_0_1.stopGame(arg_39_0)
	arg_39_0.gameStop = true

	arg_39_0:timerStop()

	return
end

function var_0_1.getMiniGameData(arg_40_0)
	if not arg_40_0._mgData then
		getProxy = var_1
		MiniGameProxy = var_1_10003

		local var_40_0 = var_1(var_1_10003)

		arg_40_0._mgData = var_1.GetMiniGameData(var_40_0, var_0_6)
	end

	return arg_40_0._mgData
end

function var_0_1.onBackPressed(arg_41_0)
	arg_41_0:checkGameExit()

	return
end

function var_0_1.checkGameExit(arg_42_0)
	if not arg_42_0.gameStartFlag then
		local var_42_0 = arg_42_0
		local var_42_1 = arg_42_0.emit

		Dorm3dMiniGameMediator = var_1_10004

		var_42_1(var_42_0, var_1_10004.GAME_OPERATION, {
			operationCode = "GAME_CLOSE",
			doTrack = true,
			miniGameId = var_0_6
		})
		arg_42_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_42_0.gameStop then
			return
		end

		arg_42_0:stopGame()

		local var_42_3

		if arg_42_0.contextData.isDorm3d then
			pg = var_42_3

			local var_42_2 = var_42_3.NewStyleMsgboxMgr.GetInstance()

			var_42_3 = var_42_3.Show
			pg = var_1_10004

			local var_42_4 = var_1_10004.NewStyleMsgboxMgr.TYPE_MSGBOX

			var_1_10005 = {}
			i18n = var_1_10006
			var_1_10005.contentText = var_1_10006("mini_game_leave")

			function var_1_10005.onConfirm()
				local var_43_0 = arg_42_0
				local var_43_1 = var_0.emit

				Dorm3dMiniGameMediator = var_2_10003

				var_43_1(var_43_0, var_2_10003.GAME_OPERATION, {
					operationCode = "GAME_CLOSE",
					doTrack = false,
					miniGameId = var_0_6
				})

				local var_43_2 = arg_42_0

				var_0.emit(var_43_2, var_0_1.ON_BACK_PRESSED)

				return
			end

			function var_1_10005.onClose()
				local var_44_0 = arg_42_0

				var_0.resumeGame(var_44_0)

				return
			end

			var_42_3(var_42_2, var_42_4, var_1_10005)
		else
			pg = var_42_3

			local var_42_5 = var_42_3.MsgboxMgr.GetInstance()
			local var_42_6 = var_1.ShowMsgBox
			local var_42_7 = {}

			i18n = var_1_10005
			var_42_7.content = var_1_10005("mini_game_leave")

			function var_42_7.onYes()
				local var_45_0 = arg_42_0
				local var_45_1 = var_0.emit

				Dorm3dMiniGameMediator = var_2_10003

				var_45_1(var_45_0, var_2_10003.GAME_OPERATION, {
					operationCode = "GAME_CLOSE",
					doTrack = false,
					miniGameId = var_0_6
				})

				local var_45_2 = arg_42_0

				var_0.emit(var_45_2, var_0_1.ON_BACK_PRESSED)

				return
			end

			function var_42_7.onNo()
				local var_46_0 = arg_42_0

				var_0.resumeGame(var_46_0)

				return
			end

			var_42_6(var_42_5, var_42_7)
		end
	end

	return
end

function var_0_1.willExit(arg_47_0)
	if arg_47_0.handle then
		UpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_47_0.handle)
	end

	if arg_47_0._tf then
		LeanTween = var_1

		local var_47_0 = var_1.isTweening

		go = var_1_10003

		if var_47_0(var_1_10003(arg_47_0._tf)) then
			LeanTween = var_1

			local var_47_1 = var_1.cancel

			go = var_3

			var_47_1(var_3(arg_47_0._tf))
		end
	end

	if arg_47_0.timer and arg_47_0.timer.running then
		local var_47_2 = arg_47_0.timer

		var_1.Stop(var_47_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_47_0.timer = nil

	return
end

return var_0_1
