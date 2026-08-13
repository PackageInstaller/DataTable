class = var_0_10000

local var_0_0 = "GuessForkGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = {
	100,
	50
}
local var_0_3 = {
	10
}
local var_0_4 = {
	20
}
local var_0_5 = {
	3,
	3,
	3,
	4,
	4,
	4,
	5,
	5,
	5,
	6,
	6,
	6,
	7,
	7,
	7,
	8,
	8,
	8,
	8,
	9,
	9,
	9,
	9,
	9,
	10,
	10,
	10,
	10,
	10,
	10,
	11,
	11,
	11,
	11,
	11,
	12
}
local var_0_6 = {
	1000,
	200
}
local var_0_7 = 10000
local var_0_8 = 2
local var_0_9 = 2
local var_0_10 = "event:/ui/ddldaoshu2"
local var_0_11 = "event:/ui/taosheng"
local var_0_12 = "event:/ui/zhengque"
local var_0_13 = "event:/ui/shibai"
local var_0_14 = "backyard"
local var_0_15 = {
	"Cup_B",
	"Cup_G",
	"Cup_P",
	"Cup_R",
	"Cup_Y"
}
local var_0_16 = 3
local var_0_17 = 0.5
local var_0_18 = "Thinking_Loop"
local var_0_19 = {
	"Select_L",
	"Select_M",
	"Select_R"
}
local var_0_20 = {
	"Correct_L",
	"Correct_M",
	"Correct_R"
}
local var_0_21 = {
	"Incorrect_L",
	"Incorrect_M",
	"Incorrect_R"
}
local var_0_22 = "Manjuu_Correct"
local var_0_23 = {
	"Ayanami",
	"Cheshire",
	"Eldridge",
	"Formidable",
	"Javelin",
	"Laffey",
	"LeMalin",
	"Merkuria",
	"PingHai",
	"Roon",
	"Saratoga",
	"Shiratsuyu",
	"Yukikaze",
	"Z23"
}

function var_0_1.getUIName(arg_1_0)
	return "GuessForkGameUI"
end

function var_0_1.getBGM(arg_2_0)
	return var_0_14
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.countUI = var_1.Find(var_3_0, "count_ui")

	local var_3_1 = arg_3_0.countUI
	local var_3_2 = var_1.Find(var_3_1, "count_bg/count")
	local var_3_3 = var_1.GetComponent

	typeof = var_3
	Animator = var_1_10004
	arg_3_0.countAnimator = var_3_3(var_3_2, var_3(var_1_10004))

	local var_3_4 = arg_3_0.countUI
	local var_3_5 = var_1.Find(var_3_4, "count_bg/count")
	local var_3_6 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_3_0.countDft = var_3_6(var_3_5, var_3(var_1_10004))

	local var_3_7 = arg_3_0.countDft

	var_1.SetEndEvent(var_3_7, function()
		setActive = var_2_10000

		var_2_10000(arg_3_0.countUI, false)

		local var_4_0 = arg_3_0

		var_0.startGame(var_4_0)

		return
	end)

	local var_3_8 = arg_3_0._tf

	arg_3_0.pauseUI = var_1.Find(var_3_8, "pause_ui")

	local var_3_9 = arg_3_0.pauseUI

	arg_3_0.resuemBtn = var_1.Find(var_3_9, "box/sure_btn")
	setText = var_1

	local var_3_10 = arg_3_0.pauseUI
	local var_3_11 = var_2.Find(var_3_10, "box/content")

	i18n = var_3_10

	var_1(var_3_11, var_3_10("idolmaster_game_tip1"))

	local var_3_12 = arg_3_0._tf

	arg_3_0.exitUI = var_1.Find(var_3_12, "exit_ui")

	local var_3_13 = arg_3_0.exitUI

	arg_3_0.exitSureBtn = var_1.Find(var_3_13, "box/sure_btn")

	local var_3_14 = arg_3_0.exitUI

	arg_3_0.exitCancelBtn = var_1.Find(var_3_14, "box/cancel_btn")
	setText = var_1

	local var_3_15 = arg_3_0.exitUI
	local var_3_16 = var_2.Find(var_3_15, "box/content")

	i18n = var_3_15

	var_1(var_3_16, var_3_15("idolmaster_game_tip2"))

	local var_3_17 = arg_3_0._tf

	arg_3_0.endUI = var_1.Find(var_3_17, "end_ui")

	local var_3_18 = arg_3_0.endUI

	arg_3_0.endSureBtn = var_1.Find(var_3_18, "box/sure_btn")
	setText = var_1

	local var_3_19 = arg_3_0.endUI
	local var_3_20 = var_2.Find(var_3_19, "box/cur_score")

	i18n = var_3_19

	var_1(var_3_20, var_3_19("idolmaster_game_tip3"))

	local var_3_21 = arg_3_0.endUI

	arg_3_0.endScoreTxt = var_1.Find(var_3_21, "box/cur_score/score")

	local var_3_22 = arg_3_0.endScoreTxt

	arg_3_0.newTag = var_1.Find(var_3_22, "new")
	setText = var_1

	local var_3_23 = arg_3_0.endUI
	local var_3_24 = var_2.Find(var_3_23, "box/highest_score")

	i18n = var_3_23

	var_1(var_3_24, var_3_23("idolmaster_game_tip4"))

	local var_3_25 = arg_3_0.endUI

	arg_3_0.highestScoreTxt = var_1.Find(var_3_25, "box/highest_score/score")

	local var_3_26 = arg_3_0._tf

	arg_3_0.gameUI = var_1.Find(var_3_26, "game_ui")

	local var_3_27 = arg_3_0.gameUI

	arg_3_0.returnBtn = var_1.Find(var_3_27, "top/return_btn")

	local var_3_28 = arg_3_0.gameUI

	arg_3_0.pauseBtn = var_1.Find(var_3_28, "top/pause_btn")

	local var_3_29 = arg_3_0.gameUI

	arg_3_0.roundTxt = var_1.Find(var_3_29, "top/title/round/num")
	arg_3_0.roundNum = 0

	local var_3_30 = arg_3_0.gameUI

	arg_3_0.curScoreTxt = var_1.Find(var_3_30, "top/title/score_title/score")
	arg_3_0.curScore = 0
	setText = var_1

	var_1(arg_3_0.curScoreTxt, arg_3_0.curScore)

	local var_3_31 = arg_3_0.gameUI

	arg_3_0.curTimeTxt = var_1.Find(var_3_31, "top/time_bg/time")
	arg_3_0.curTime = 0
	setText = var_1

	local var_3_32 = arg_3_0.gameUI
	local var_3_33 = var_2.Find(var_3_32, "top/title/score_title")

	i18n = var_3_32

	var_1(var_3_33, var_3_32("idolmaster_game_tip5"))

	local var_3_34 = arg_3_0.gameUI

	arg_3_0.correctBar = var_1.Find(var_3_34, "correct_bar")

	local var_3_35 = arg_3_0.gameUI

	arg_3_0.failBar = var_1.Find(var_3_35, "fail_bar")

	local var_3_36 = arg_3_0.gameUI

	arg_3_0.manjuu = var_1.Find(var_3_36, "play/manjuu")

	local var_3_37 = arg_3_0.manjuu
	local var_3_38 = var_1.GetComponent

	typeof = var_3
	Animator = var_4
	arg_3_0.manjuuAnimator = var_3_38(var_3_37, var_3(var_4))

	local var_3_39 = arg_3_0.manjuu
	local var_3_40 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4
	arg_3_0.manjuuDft = var_3_40(var_3_39, var_3(var_4))

	local var_3_41 = arg_3_0.gameUI

	arg_3_0.result = var_1.Find(var_3_41, "result")

	local var_3_42 = arg_3_0.result
	local var_3_43 = var_1.GetComponent

	typeof = var_3
	Animator = var_4
	arg_3_0.resultAnimator = var_3_43(var_3_42, var_3(var_4))

	local var_3_44 = arg_3_0.result
	local var_3_45 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4
	arg_3_0.resultDft = var_3_45(var_3_44, var_3(var_4))

	local var_3_46 = arg_3_0.gameUI

	arg_3_0.scoreAni = var_1.Find(var_3_46, "score")

	local var_3_47 = arg_3_0.gameUI

	arg_3_0.cupContainer = var_1.Find(var_3_47, "cup_container")

	local var_3_48 = arg_3_0.gameUI

	arg_3_0.fork = var_1.Find(var_3_48, "fork")
	arg_3_0.isGuessTime = false

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.pauseBtn

	local function var_5_2()
		setActive = var_2_10000

		var_2_10000(arg_5_0.pauseUI, true)

		local var_6_0 = arg_5_0

		var_0.pauseGame(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.resuemBtn

	local function var_5_5()
		setActive = var_2_10000

		var_2_10000(arg_5_0.pauseUI, false)

		local var_7_0 = arg_5_0

		var_0.resumeGame(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.returnBtn

	local function var_5_8()
		setActive = var_2_10000

		var_2_10000(arg_5_0.exitUI, true)

		local var_8_0 = arg_5_0

		var_0.pauseGame(var_8_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10005)

	onButton = var_1_10001

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.exitSureBtn

	local function var_5_11()
		setActive = var_2_10000

		var_2_10000(arg_5_0.exitUI, false)

		local var_9_0 = arg_5_0

		var_0.enterResultUI(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_9, var_5_10, var_5_11, var_1_10005)

	onButton = var_1_10001

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.exitCancelBtn

	local function var_5_14()
		setActive = var_2_10000

		var_2_10000(arg_5_0.exitUI, false)

		local var_10_0 = arg_5_0

		var_0.resumeGame(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_12, var_5_13, var_5_14, var_1_10005)

	onButton = var_1_10001

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0.endSureBtn

	local function var_5_17()
		local var_11_0 = arg_5_0

		var_0.emit(var_11_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_15, var_5_16, var_5_17, var_1_10005)

	eachChild = var_1_10001

	var_1_10001(arg_5_0.cupContainer, function(arg_12_0)
		onButton = var_2_10001

		local var_12_0 = arg_5_0
		local var_12_1 = arg_12_0

		local function var_12_2()
			if not arg_5_0.isGuessTime then
				return
			end

			setActive = var_0

			local var_13_0 = arg_12_0

			var_0(var_1.Find(var_13_0, "select"), true)

			local var_13_1 = arg_5_0

			var_13_1.isGuessTime = false
			string = var_13_1

			local var_13_2 = var_13_1.gsub(arg_12_0.name, "cup_", "")
			local var_13_3 = arg_5_0

			tonumber = var_2
			var_13_3.selectIndex = var_2(var_13_2)

			local var_13_4 = arg_5_0

			var_1.endRound(var_13_4, arg_5_0.selectIndex == arg_5_0.forkIndex)

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_12_0, var_12_1, var_12_2, var_2_10005)

		return
	end)
	arg_5_0:initGameData()

	setActive = var_1

	var_1(arg_5_0.countUI, true)

	local var_5_18 = arg_5_0.countAnimator

	var_1.Play(var_5_18, "countDown")

	pg = var_1

	local var_5_19 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_5_19, var_0_10)

	return
end

function var_0_1.initGameData(arg_14_0)
	math = var_1_10001

	local var_14_0 = var_1_10001.random(#var_0_15)
	local var_14_1 = var_0_15[var_14_0]

	eachChild = var_1_10003

	var_1_10003(arg_14_0.cupContainer, function(arg_15_0)
		GetSpriteFromAtlasAsync = var_2_10001

		var_2_10001("ui/minigameui/guessforkgameui", var_14_1, function(arg_16_0)
			setImageSprite = var_3_10001

			local var_16_0 = arg_15_0

			var_3_10001(var_2.Find(var_16_0, "front"), arg_16_0, true)

			return
		end)

		return
	end)

	math = var_1_10003
	arg_14_0.forkIndex = var_1_10003.random(var_0_16)
	arg_14_0.selectIndex = nil
	arg_14_0.roundNum = arg_14_0.roundNum + 1
	setText = var_3

	var_3(arg_14_0.roundTxt, arg_14_0.roundNum)

	local var_14_2

	if not var_0_4[arg_14_0.roundNum] then
		var_14_2 = var_0_4[#var_0_4]
	end

	arg_14_0.curTime = var_14_2
	setText = var_14_2

	var_14_2(arg_14_0.curTimeTxt, arg_14_0.curTime)

	setActive = var_14_2

	var_14_2(arg_14_0.result, false)

	return
end

function var_0_1.startGame(arg_17_0)
	local var_17_0 = arg_17_0.manjuuAnimator

	var_1.Play(var_17_0, var_0_18)

	local var_17_1

	if not var_0_5[arg_17_0.roundNum] then
		var_17_1 = var_0_5[#var_0_5]
	end

	arg_17_0:playForkAni(function()
		local var_18_0 = arg_17_0

		var_0.startSwap(var_18_0, var_17_1)

		return
	end)

	arg_17_0.gameStartFlag = true

	return
end

function var_0_1.playForkAni(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.cupContainer
	local var_19_1 = var_2.Find(var_19_0, "cup_" .. arg_19_0.forkIndex)

	setParent = var_19_0

	var_19_0(arg_19_0.fork, var_19_1:Find("fork_node"), false)

	setLocalScale = var_19_0

	local var_19_2 = arg_19_0.fork

	Vector3 = var_5

	var_19_0(var_19_2, var_5.one)

	setLocalPosition = var_19_0

	local var_19_3 = arg_19_0.fork

	Vector3 = var_5

	var_19_0(var_19_3, var_5(0, 50, 0))

	setActive = var_19_0

	var_19_0(arg_19_0.fork, true)

	local var_19_4 = arg_19_0
	local var_19_5 = arg_19_0.managedTween

	LeanTween = var_5

	var_19_5(var_19_4, var_5.delayedCall, function()
		local var_20_0 = arg_19_0
		local var_20_1 = var_0.managedTween

		LeanTween = var_2_10002

		local var_20_2 = var_20_1(var_20_0, var_2_10002.moveY, function()
			setActive = var_3_10000

			var_3_10000(arg_19_0.fork, false)

			if arg_19_1 then
				arg_19_1()
			end

			return
		end, arg_19_0.fork, -20, var_0_17)
		local var_20_3 = var_0.setEase

		LeanTweenType = var_2

		var_20_3(var_20_2, var_2.linear)

		return
	end, 0.5, nil)

	return
end

function var_0_1.startSwap(arg_22_0, arg_22_1)
	if arg_22_1 < 1 then
		arg_22_0.isGuessTime = true
		var_1_10003 = arg_22_0

		arg_22_0.startTimer(var_1_10003)

		return
	end

	local var_22_0 = {
		1,
		2,
		3
	}

	math = var_1_10003

	local var_22_1 = var_1_10003.random(#var_22_0)

	table = var_4

	var_4.remove(var_22_0, var_22_1)

	local var_22_2 = arg_22_0.cupContainer
	local var_22_3 = var_4.Find(var_22_2, "cup_" .. var_22_0[1])
	local var_22_4 = arg_22_0.cupContainer
	local var_22_5 = var_5.Find(var_22_4, "cup_" .. var_22_0[2])

	arg_22_0:swapCup(var_22_3, var_22_5, function()
		local var_23_0 = arg_22_0

		var_0.startSwap(var_23_0, arg_22_1 - 1)

		return
	end)

	return
end

function var_0_1.swapCup(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	pg = var_1_10004

	local var_24_0 = var_1_10004.CriMgr.GetInstance()

	var_4.PlaySoundEffect_V3(var_24_0, var_0_11)

	local var_24_1 = var_0_6[1] + (arg_24_0.roundNum - 1) * var_0_6[2] < var_0_7 and var_4 or var_0_7
	local var_24_2 = arg_24_2.anchoredPosition
	local var_24_3 = arg_24_1.anchoredPosition

	math = var_1_10008

	local var_24_4 = var_1_10008.abs(var_24_2.x - var_24_3.x) / var_24_1
	local var_24_5 = arg_24_0
	local var_24_6 = arg_24_0.managedTween

	LeanTween = var_1_10011

	local var_24_7 = var_24_6(var_24_5, var_1_10011.moveX, nil, arg_24_1, var_24_2.x, var_24_4)
	local var_24_8 = var_9.setEase

	LeanTweenType = var_11

	var_24_8(var_24_7, var_11.linear)

	local var_24_9 = arg_24_0
	local var_24_10 = arg_24_0.managedTween

	LeanTween = var_11

	local var_24_11 = var_24_10(var_24_9, var_11.moveX, function()
		if arg_24_3 then
			arg_24_3()
		end

		return
	end, arg_24_2, var_24_3.x, var_24_4)
	local var_24_12 = var_9.setEase

	LeanTweenType = var_11

	var_24_12(var_24_11, var_11.linear)

	return
end

function var_0_1.startTimer(arg_26_0)
	local var_26_0 = arg_26_0.curTime

	Timer = var_1_10002
	arg_26_0.timer = var_1_10002.New(function()
		arg_26_0.curTime = arg_26_0.curTime - 1

		if arg_26_0.curTime <= 0 then
			local var_27_0 = arg_26_0

			var_0.endRound(var_27_0, false)
		end

		setText = var_0

		var_0(arg_26_0.curTimeTxt, arg_26_0.curTime)

		return
	end, 1, -1)

	local var_26_1 = arg_26_0.timer

	var_2.Start(var_26_1)

	return
end

function var_0_1.stopTimer(arg_28_0)
	if arg_28_0.timer then
		local var_28_0 = arg_28_0.timer

		var_1.Stop(var_28_0)

		arg_28_0.timer = nil
	end

	return
end

function var_0_1.pauseGame(arg_29_0)
	arg_29_0:pauseManagedTween()

	if arg_29_0.timer then
		local var_29_0 = arg_29_0.timer

		var_1.Pause(var_29_0)
	end

	arg_29_0.manjuuAnimator.speed = 0
	arg_29_0.resultAnimator.speed = 0

	return
end

function var_0_1.resumeGame(arg_30_0)
	arg_30_0:resumeManagedTween()

	if arg_30_0.timer then
		local var_30_0 = arg_30_0.timer

		var_1.Resume(var_30_0)
	end

	arg_30_0.manjuuAnimator.speed = 1
	arg_30_0.resultAnimator.speed = 1

	return
end

function var_0_1.endRound(arg_31_0, arg_31_1)
	arg_31_0:stopTimer()

	if arg_31_0.selectIndex then
		arg_31_0:playManjuuAni(arg_31_1)
	else
		arg_31_0:playTimeOutAni()
		arg_31_0:endGame()
	end

	return
end

function var_0_1.playManjuuAni(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.cupContainer
	local var_32_1 = (var_2.Find(var_32_0, "cup_" .. arg_32_0.selectIndex).anchoredPosition.x + 480) / 480 + 1
	local var_32_2 = arg_32_0.manjuuAnimator

	var_5.Play(var_32_2, var_0_19[var_32_1])

	local var_32_3 = arg_32_0.manjuuDft

	var_5.SetEndEvent(var_32_3, function()
		local var_33_0 = arg_32_0.manjuuDft

		var_0.SetEndEvent(var_33_0, nil)

		local var_33_1

		if not arg_32_1 or not var_0_20[var_32_1] then
			var_33_1 = var_0_21[var_32_1]
		end

		setActive = var_33_0

		local var_33_2 = var_0

		var_33_0(var_2.Find(var_33_2, "select"), false)

		local var_33_3 = arg_32_0.manjuuAnimator

		var_1.Play(var_33_3, var_33_1)

		local var_33_4 = arg_32_0

		var_1.playResultAni(var_33_4, arg_32_1)

		return
	end)

	return
end

function var_0_1.playResultAni(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.cupContainer
	local var_34_1 = var_2.Find(var_34_0, "cup_" .. arg_34_0.selectIndex)

	setParent = var_34_0

	var_34_0(arg_34_0.result, var_34_1:Find("result_node"), false)

	setLocalScale = var_34_0

	local var_34_2 = arg_34_0.result

	Vector3 = var_5

	var_34_0(var_34_2, var_5.one)

	setLocalPosition = var_34_0

	local var_34_3 = arg_34_0.result

	Vector3 = var_5

	var_34_0(var_34_3, var_5.zero)

	setActive = var_34_0

	var_34_0(arg_34_0.result, true)

	if arg_34_1 then
		pg = var_34_0

		local var_34_4 = var_34_0.CriMgr.GetInstance()

		var_34_0.PlaySoundEffect_V3(var_34_4, var_0_12)

		local var_34_5 = arg_34_0.resultAnimator

		var_34_0.Play(var_34_5, var_0_22)

		local var_34_6 = arg_34_0.resultDft

		var_34_0.SetEndEvent(var_34_6, function()
			local var_35_0 = arg_34_0.resultDft

			var_0.SetEndEvent(var_35_0, nil)

			local var_35_1 = arg_34_0

			var_0.showCorrectBar(var_35_1)

			return
		end)
	else
		pg = var_34_0

		local var_34_7 = var_34_0.CriMgr.GetInstance()

		var_3.PlaySoundEffect_V3(var_34_7, var_0_13)

		local var_34_8 = var_0_23

		math = var_34_7

		local var_34_9 = var_34_8[var_34_7.random(#var_0_23)]
		local var_34_10 = arg_34_0.resultAnimator

		var_4.Play(var_34_10, var_34_9)

		local var_34_11 = arg_34_0.resultDft

		var_4.SetEndEvent(var_34_11, function()
			local var_36_0 = arg_34_0.resultDft

			var_0.SetEndEvent(var_36_0, nil)

			local var_36_1 = arg_34_0

			var_0.endGame(var_36_1)

			return
		end)
	end

	return
end

function var_0_1.showCorrectBar(arg_37_0)
	setActive = var_1_10001

	var_1_10001(arg_37_0.correctBar, true)

	local var_37_0 = var_0_2[1] + (arg_37_0.roundNum - 1) * var_0_2[2]

	arg_37_0.curScore = arg_37_0.curScore + var_37_0
	setText = var_2

	var_2(arg_37_0.curScoreTxt, arg_37_0.curScore)

	setLocalPosition = var_2

	local var_37_1 = arg_37_0.scoreAni

	Vector3 = var_4

	var_2(var_37_1, var_4(0, 250, 0))

	setText = var_2

	var_2(arg_37_0.scoreAni, "+" .. var_37_0)

	setActive = var_2

	var_2(arg_37_0.scoreAni, true)

	LeanTween = var_2

	local var_37_2 = var_2.moveY(arg_37_0.scoreAni, 300, 1)
	local var_37_3 = var_2.setOnComplete

	System = var_4

	var_37_3(var_37_2, var_4.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_37_0.scoreAni, false)

		return
	end))

	local var_37_4 = 0.5
	local var_37_5

	if not var_0_3[arg_37_0.roundNum] then
		var_37_5 = var_0_3[#var_0_3]
	end

	local var_37_6 = arg_37_0.curScore + var_37_5 * arg_37_0.curTime

	LeanTween = var_5

	local var_37_7 = var_5.value

	go = var_6

	local var_37_8 = var_37_7(var_6(arg_37_0.curScoreTxt), arg_37_0.curScore, var_37_6, var_37_4)
	local var_37_9 = var_5.setOnUpdate

	System = var_7

	local var_37_10 = var_37_9(var_37_8, var_7.Action_float(function(arg_39_0)
		setText = var_2_10001

		local var_39_0 = arg_37_0.curScoreTxt

		math = var_2_10003

		var_2_10001(var_39_0, var_2_10003.ceil(arg_39_0))

		return
	end))
	local var_37_11 = var_5.setOnComplete

	System = var_7

	var_37_11(var_37_10, var_7.Action(function()
		local var_40_0 = arg_37_0

		var_40_0.curScore = var_37_6
		setText = var_40_0

		var_40_0(arg_37_0.curScoreTxt, arg_37_0.curScore)

		return
	end))

	LeanTween = var_37_11

	local var_37_12 = var_37_11.value

	go = var_37_10

	local var_37_13 = var_37_12(var_37_10(arg_37_0.curTimeTxt), arg_37_0.curTime, 0, var_37_4)
	local var_37_14 = var_5.setOnUpdate

	System = var_7

	local var_37_15 = var_37_14(var_37_13, var_7.Action_float(function(arg_41_0)
		setText = var_2_10001

		local var_41_0 = arg_37_0.curTimeTxt

		math = var_2_10003

		var_2_10001(var_41_0, var_2_10003.ceil(arg_41_0))

		return
	end))
	local var_37_16 = var_5.setOnComplete

	System = var_7

	var_37_16(var_37_15, var_7.Action(function()
		local var_42_0 = arg_37_0

		var_42_0.curScore = var_37_6
		setText = var_42_0

		var_42_0(arg_37_0.curTimeTxt, 0)

		return
	end))

	onButton = var_37_16

	local var_37_17 = arg_37_0
	local var_37_18 = arg_37_0.correctBar

	local function var_37_19()
		setActive = var_2_10000

		var_2_10000(arg_37_0.correctBar, false)

		setActive = var_2_10000

		var_2_10000(arg_37_0.scoreAni, false)

		local var_43_0 = arg_37_0

		var_0.initGameData(var_43_0)

		local var_43_1 = arg_37_0

		var_0.startGame(var_43_1)

		return
	end

	SFX_PANEL = var_9

	var_37_16(var_37_17, var_37_18, var_37_19, var_9)

	local var_37_20 = arg_37_0
	local var_37_21 = arg_37_0.managedTween

	LeanTween = var_37_18

	var_37_21(var_37_20, var_37_18.delayedCall, function()
		isActive = var_2_10000

		if var_2_10000(arg_37_0.correctBar) then
			triggerButton = var_0

			var_0(arg_37_0.correctBar)
		end

		return
	end, var_0_8, nil)

	return
end

function var_0_1.playTimeOutAni(arg_45_0)
	local var_45_0 = arg_45_0.cupContainer
	local var_45_1 = var_1.Find(var_45_0, "cup_" .. arg_45_0.forkIndex)

	setParent = var_45_0

	var_45_0(arg_45_0.result, var_45_1:Find("result_node"), false)

	setLocalScale = var_45_0

	local var_45_2 = arg_45_0.result

	Vector3 = var_4

	var_45_0(var_45_2, var_4.one)

	setLocalPosition = var_45_0

	local var_45_3 = arg_45_0.result

	Vector3 = var_4

	var_45_0(var_45_3, var_4.zero)

	setActive = var_45_0

	var_45_0(arg_45_0.result, true)

	local var_45_4 = arg_45_0.resultAnimator

	var_2.Play(var_45_4, var_0_22)

	local var_45_5 = arg_45_0.resultDft

	var_2.SetEndEvent(var_45_5, function()
		local var_46_0 = arg_45_0.resultDft

		var_0.SetEndEvent(var_46_0, nil)

		return
	end)

	return
end

function var_0_1.endGame(arg_47_0)
	setActive = var_1_10001

	var_1_10001(arg_47_0.failBar, true)

	onButton = var_1_10001

	local var_47_0 = arg_47_0
	local var_47_1 = arg_47_0.failBar

	local function var_47_2()
		setActive = var_2_10000

		var_2_10000(arg_47_0.failBar, false)

		local var_48_0 = arg_47_0

		var_0.enterResultUI(var_48_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_47_0, var_47_1, var_47_2, var_1_10005)

	local var_47_3 = arg_47_0
	local var_47_4 = arg_47_0.managedTween

	LeanTween = var_47_1

	var_47_4(var_47_3, var_47_1.delayedCall, function()
		isActive = var_2_10000

		if var_2_10000(arg_47_0.failBar) then
			triggerButton = var_0

			var_0(arg_47_0.failBar)
		end

		return
	end, var_0_8, nil)

	return
end

function var_0_1.enterResultUI(arg_50_0)
	arg_50_0.gameStartFlag = false
	setActive = var_1

	var_1(arg_50_0.endUI, true)

	setText = var_1

	var_1(arg_50_0.endScoreTxt, arg_50_0.curScore)

	local var_50_0 = arg_50_0:GetMGData()

	if var_1.GetRuntimeData(var_50_0, "elements") then
		local var_50_1 = #var_1
		local var_50_2

		if not (0 < var_50_1) or not var_1[1] then
			var_50_2 = 0
		end

		setActive = var_3

		var_3(arg_50_0.newTag, var_50_2 < arg_50_0.curScore)

		if var_50_2 <= arg_50_0.curScore then
			var_50_2 = arg_50_0.curScore

			arg_50_0:StoreDataToServer({
				var_50_2
			})
		end

		setText = var_3

		var_3(arg_50_0.highestScoreTxt, var_50_2)

		if arg_50_0:GetMGHubData().count > 0 then
			arg_50_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.OnGetAwardDone(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1.cmd

	MiniGameOPCommand = var_1_10003

	if var_51_0 == var_1_10003.CMD_COMPLETE and arg_51_0:GetMGHubData().ultimate == 0 then
		local var_51_1 = var_2.usedtime
		local var_51_2 = var_2

		if var_51_1 >= var_2.getConfig(var_51_2, "reward_need") then
			pg = var_51_1

			local var_51_3 = var_51_1.m02
			local var_51_4 = var_3.sendNotification

			GAME = var_51_2

			local var_51_5 = var_51_2.SEND_MINI_GAME_OP
			local var_51_6 = {
				hubid = var_2.id
			}

			MiniGameOPCommand = var_7
			var_51_6.cmd = var_7.CMD_ULTIMATE
			var_51_6.args1 = {}

			var_51_4(var_51_3, var_51_5, var_51_6)
		end
	end

	return
end

function var_0_1.onBackPressed(arg_52_0)
	if not arg_52_0.gameStartFlag then
		arg_52_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		setActive = var_1

		var_1(arg_52_0.exitUI, true)
		arg_52_0:pauseGame()
	end

	return
end

return var_0_1
