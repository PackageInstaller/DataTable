class = var_0_10000

local var_0_0 = "BattleSubmarineRunResultLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.DURATION_WIN_FADE_IN = 0.5
var_0_1.DURATION_LOSE_FADE_IN = 1.5
var_0_1.DURATION_GRADE_LAST = 1.5
var_0_1.DURATION_MOVE = 0.7
var_0_1.DURATION_WIN_SCALE = 0.7

function var_0_1.getUIName(arg_1_0)
	return "BattleResultUI"
end

function var_0_1.setPlayer(arg_2_0)
	return
end

function var_0_1.setShips(arg_3_0)
	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0._grade = var_1.Find(var_4_0, "grade")

	local var_4_1 = arg_4_0._grade

	arg_4_0._levelText = var_1.Find(var_4_1, "chapterName/Text22")

	local var_4_2 = arg_4_0._tf

	arg_4_0.clearFX = var_1.Find(var_4_2, "clear")

	local var_4_3 = arg_4_0._tf

	arg_4_0._main = var_1.Find(var_4_3, "main")

	local var_4_4 = arg_4_0._tf

	arg_4_0._blurConatiner = var_1.Find(var_4_4, "blur_container")

	local var_4_5 = arg_4_0._tf

	arg_4_0._bg = var_1.Find(var_4_5, "main/jiesuanbeijing")

	local var_4_6 = arg_4_0._blurConatiner

	arg_4_0._painting = var_1.Find(var_4_6, "painting")

	local var_4_7 = arg_4_0._painting

	arg_4_0._failPainting = var_1.Find(var_4_7, "fail")

	local var_4_8 = arg_4_0._painting

	arg_4_0._chat = var_1.Find(var_4_8, "chat")

	local var_4_9 = arg_4_0._main

	arg_4_0._rightBottomPanel = var_1.Find(var_4_9, "dodgem_confirm")

	local var_4_10 = arg_4_0._rightBottomPanel

	arg_4_0._exitBtn = var_1.Find(var_4_10, "confirm_btn")

	local var_4_11 = arg_4_0._tf

	arg_4_0._skipBtn = var_1.Find(var_4_11, "skipLayer")
	pg = var_1
	arg_4_0.UIMain = var_1.UIMgr.GetInstance().UIMain
	pg = var_1
	arg_4_0.overlay = var_1.UIMgr.GetInstance().OverlayMain

	local var_4_12 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_4_13 = arg_4_0._tf
	local var_4_14 = var_2.Find(var_4_13, "grade/Xyz/bg13")
	local var_4_15 = arg_4_0._tf
	local var_4_16 = var_3.Find(var_4_15, "grade/Xyz/bg14")
	local var_4_17
	local var_4_18
	local var_4_19
	local var_4_20 = arg_4_0.contextData.score > 0

	setActive = var_1_10009

	local var_4_21 = arg_4_0._bg

	var_1_10009(var_10.Find(var_4_21, "jieuan01/BG/bg_victory"), var_4_20)

	setActive = var_1_10009

	local var_4_22 = arg_4_0._bg

	var_1_10009(var_10.Find(var_4_22, "jieuan01/BG/bg_fail"), not var_4_20)

	if var_4_20 then
		local var_4_23 = var_4_12[var_7 + 1]

		var_4_17 = "battlescore/battle_score_" .. var_4_23 .. "/letter_" .. var_4_23
		var_4_18 = "battlescore/battle_score_" .. var_4_23 .. "/label_" .. var_4_23
	else
		local var_4_24 = var_4_12[1]

		var_4_17 = "battlescore/battle_score_" .. var_4_24 .. "/letter_" .. var_4_24
		var_4_18 = "battlescore/battle_score_" .. var_4_24 .. "/label_" .. var_4_24
	end

	LoadImageSpriteAsync = var_1_10009

	var_1_10009(var_4_17, var_4_14, false)

	LoadImageSpriteAsync = var_1_10009

	var_1_10009(var_4_18, var_4_16, false)

	SetActive = var_1_10009

	var_1_10009(arg_4_0._levelText, false)

	SetActive = var_1_10009

	local var_4_25 = arg_4_0._tf

	var_1_10009(var_10.Find(var_4_25, "main/conditions"), false)

	GetComponent = var_1_10009

	local var_4_26 = arg_4_0._tf

	typeof = var_11
	AspectRatioFitter = var_12
	arg_4_0._ratioFitter = var_1_10009(var_4_26, var_11(var_12))
	arg_4_0._ratioFitter.enabled = true

	local var_4_27 = arg_4_0._ratioFitter

	pg = var_10
	var_4_27.aspectRatio = var_10.CameraFixMgr.GetInstance().targetRatio
	pg = var_4_27

	local var_4_28 = var_4_27.CameraFixMgr.GetInstance()
	local var_4_29 = var_9.bind

	pg = var_11
	arg_4_0.camEventId = var_4_29(var_4_28, var_11.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_5_0, arg_5_1)
		arg_4_0._ratioFitter.aspectRatio = arg_5_1

		return
	end)

	return
end

function var_0_1.didEnter(arg_6_0)
	local var_6_0 = arg_6_0.contextData.stageId

	pg = var_1_10002

	local var_6_1 = var_1_10002.expedition_data_template[var_6_0]

	setText = var_1_10003

	var_1_10003(arg_6_0._levelText, var_6_1.name)

	rtf = var_1_10003
	arg_6_0._gradeUpperLeftPos = var_1_10003(arg_6_0._grade).localPosition
	Vector3 = var_4
	var_3.localPosition = var_4(0, 25, 0)
	pg = var_4

	local var_6_2 = var_4.UIMgr.GetInstance()

	var_4.BlurPanel(var_6_2, arg_6_0._tf)

	local var_6_3 = arg_6_0._grade.transform

	Vector3 = var_6_2
	var_6_3.localScale = var_6_2(1.5, 1.5, 0)
	LeanTween = var_6_3

	local var_6_4 = var_6_3.scale
	local var_6_5 = arg_6_0._grade

	Vector3 = var_6

	local var_6_6 = var_6_4(var_6_5, var_6(0.88, 0.88, 1), var_0_1.DURATION_WIN_SCALE)
	local var_6_7 = var_4.setOnComplete

	System = var_6

	var_6_7(var_6_6, var_6.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_6_0._levelText, true)

		local var_7_0 = arg_6_0

		var_0.rankAnimaFinish(var_7_0)

		return
	end))

	local var_6_8 = arg_6_0._tf
	local var_6_9 = var_4.GetComponent

	typeof = var_6
	Image = var_7

	local var_6_10 = var_6_9(var_6_8, var_6(var_7))

	Color = var_6_8
	var_6_10.color = var_6_8.New(0, 0, 0, 0.5)
	BattleResultLayer = var_6_10
	arg_6_0._stateFlag = var_6_10.STATE_RANK_ANIMA
	onButton = var_4

	local var_6_11 = arg_6_0
	local var_6_12 = arg_6_0._skipBtn

	local function var_6_13()
		local var_8_0 = arg_6_0

		var_0.skip(var_8_0)

		return
	end

	SFX_CONFIRM = var_8

	var_4(var_6_11, var_6_12, var_6_13, var_8)
	arg_6_0:showPainting()

	return
end

function var_0_1.rankAnimaFinish(arg_9_0)
	BattleResultLayer = var_1_10001
	arg_9_0._stateFlag = var_1_10001.STATE_REPORTED

	return
end

function var_0_1.showPainting(arg_10_0)
	local var_10_0
	local var_10_1
	local var_10_2

	SetActive = var_1_10004

	var_1_10004(arg_10_0._painting, true)

	arg_10_0.paintingName = "u556"
	setPaintingPrefabAsync = var_4

	var_4(arg_10_0._painting, arg_10_0.paintingName, "jiesuan", function()
		findTF = var_2_10000

		local var_11_0 = var_2_10000(arg_10_0._painting, "fitter").childCount

		if 0 < var_11_0 then
			ShipExpressionHelper = var_11_0

			local var_11_1 = var_11_0.SetExpression

			findTF = var_1

			local var_11_2 = var_1(arg_10_0._painting, "fitter")

			var_11_1(var_1.GetChild(var_11_2, 0), arg_10_0.paintingName, "win_mvp")
		end

		return
	end)

	SetActive = var_4

	var_4(arg_10_0._failPainting, false)

	local var_10_3, var_10_6

	if arg_10_0.contextData.score > 1 then
		ShipWordHelper = var_10_3
		var_10_3 = var_10_3.GetWordAndCV

		local var_10_4 = 900180

		ShipWordHelper = var_10_6

		local var_10_5

		var_10_3, var_10_5, var_10_6 = var_10_3(var_10_4, var_10_6.WORD_TYPE_MVP)
		var_10_1 = var_10_6

		local var_10_7 = var_10_5
		local var_10_8 = var_10_3
	else
		ShipWordHelper = var_10_3
		var_10_3 = var_10_3.GetWordAndCV

		local var_10_9 = 900180

		ShipWordHelper = var_10_6

		local var_10_10, var_10_11

		var_10_3, var_10_10, var_10_11 = var_10_3(var_10_9, var_10_6.WORD_TYPE_LOSE)
		var_10_1 = var_10_11

		local var_10_12 = var_10_10
		local var_10_13 = var_10_3
	end

	setText = var_10_3

	local var_10_14 = arg_10_0._chat

	var_10_3(var_5.Find(var_10_14, "Text"), var_10_1)

	local var_10_15 = arg_10_0._chat
	local var_10_16 = var_4.Find(var_10_15, "Text")
	local var_10_17 = var_4.GetComponent

	typeof = var_6
	Text = var_7

	local var_10_18 = #var_10_17(var_10_16, var_6(var_7)).text

	CHAT_POP_STR_LEN = var_6

	if var_6 < var_10_18 then
		TextAnchor = var_10_18
		var_4.alignment = var_10_18.MiddleLeft
	else
		TextAnchor = var_10_18
		var_4.alignment = var_10_18.MiddleCenter
	end

	SetActive = var_10_18

	var_10_18(arg_10_0._chat, true)

	local var_10_19 = arg_10_0._chat.transform

	Vector3 = var_6
	var_10_19.localScale = var_6.New(0, 0, 0)
	LeanTween = var_10_19

	local var_10_20 = var_10_19.moveX

	rtf = var_6

	local var_10_21 = var_10_20(var_6(arg_10_0._painting), 50, 0.1)
	local var_10_22 = var_5.setOnComplete

	System = var_7

	var_10_22(var_10_21, var_7.Action(function()
		LeanTween = var_2_10000

		local var_12_0 = var_2_10000.scale

		rtf = var_2_10001

		local var_12_1 = var_2_10001(arg_10_0._chat.gameObject)

		Vector3 = var_2

		local var_12_2 = var_12_0(var_12_1, var_2.New(1, 1, 1), 0.1)
		local var_12_3 = var_0.setEase

		LeanTweenType = var_2

		var_12_3(var_12_2, var_2.easeOutBack)

		return
	end))

	return
end

function var_0_1.skip(arg_13_0)
	local var_13_0 = arg_13_0._stateFlag

	BattleResultLayer = var_1_10002

	if var_13_0 == var_1_10002.STATE_RANK_ANIMA then
		-- block empty
	else
		local var_13_1 = arg_13_0._stateFlag

		BattleResultLayer = var_2

		if var_13_1 == var_2.STATE_REPORTED then
			local var_13_2 = arg_13_0
			local var_13_3 = arg_13_0.emit

			BattleResultMediator = var_1_10003

			var_13_3(var_13_2, var_1_10003.ON_BACK_TO_LEVEL_SCENE)
		end
	end

	return
end

function var_0_1.onBackPressed(arg_14_0)
	triggerButton = var_1_10001

	var_1_10001(arg_14_0._skipBtn)

	return
end

function var_0_1.willExit(arg_15_0)
	LeanTween = var_1_10001

	local var_15_0 = var_1_10001.cancel

	go = var_1_10002

	var_15_0(var_1_10002(arg_15_0._tf))

	pg = var_15_0

	local var_15_1 = var_15_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_1, arg_15_0._tf)

	pg = var_1

	local var_15_2 = var_1.CameraFixMgr.GetInstance()

	var_1.disconnect(var_15_2, arg_15_0.camEventId)

	return
end

return var_0_1
