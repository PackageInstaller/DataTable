class = var_0_10000

local var_0_0 = "BattleAirFightResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BattleResultLayer"))

function var_0_1.getUIName(arg_1_0)
	return "BattleAirFightResultUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._grade = var_1.Find(var_2_0, "grade")

	local var_2_1 = arg_2_0._grade

	arg_2_0._levelText = var_1.Find(var_2_1, "chapterName/Text22")

	local var_2_2 = arg_2_0._tf

	arg_2_0._main = var_1.Find(var_2_2, "main")

	local var_2_3 = arg_2_0._tf

	arg_2_0._blurConatiner = var_1.Find(var_2_3, "blur_container")

	local var_2_4 = arg_2_0._tf

	arg_2_0._bg = var_1.Find(var_2_4, "main/jiesuanbeijing")

	local var_2_5 = arg_2_0._blurConatiner

	arg_2_0._painting = var_1.Find(var_2_5, "painting")

	local var_2_6 = arg_2_0._painting

	arg_2_0._chat = var_1.Find(var_2_6, "chat")

	local var_2_7 = arg_2_0._blurConatiner

	arg_2_0._rightBottomPanel = var_1.Find(var_2_7, "rightBottomPanel")

	local var_2_8 = arg_2_0._rightBottomPanel

	arg_2_0._confirmBtn = var_1.Find(var_2_8, "confirmBtn")
	setText = var_1

	local var_2_9 = arg_2_0._confirmBtn
	local var_2_10 = var_3.Find(var_2_9, "Text")

	i18n = var_4

	var_1(var_2_10, var_4("text_confirm"))

	local var_2_11 = arg_2_0._rightBottomPanel

	arg_2_0._statisticsBtn = var_1.Find(var_2_11, "statisticsBtn")

	local var_2_12 = arg_2_0._tf

	arg_2_0._skipBtn = var_1.Find(var_2_12, "skipLayer")

	local var_2_13 = arg_2_0._tf

	arg_2_0._conditions = var_1.Find(var_2_13, "main/conditions")

	local var_2_14 = arg_2_0._conditions

	arg_2_0._conditionContainer = var_1.Find(var_2_14, "bg16/list")

	local var_2_15 = arg_2_0._conditions

	arg_2_0._conditionTpl = var_1.Find(var_2_15, "bg16/conditionTpl")

	local var_2_16 = arg_2_0._conditions

	arg_2_0._conditionSubTpl = var_1.Find(var_2_16, "bg16/conditionSubTpl")

	local var_2_17 = arg_2_0._conditions

	arg_2_0._conditionContributeTpl = var_1.Find(var_2_17, "bg16/conditionContributeTpl")

	local var_2_18 = arg_2_0._conditions

	arg_2_0._conditionBGContribute = var_1.Find(var_2_18, "bg16/bg_contribute")

	arg_2_0:setGradeLabel()

	SetActive = var_1

	var_1(arg_2_0._levelText, false)

	arg_2_0._delayLeanList = {}

	return
end

function var_0_1.setPlayer(arg_3_0)
	return
end

function var_0_1.setGradeLabel(arg_4_0)
	local var_4_0 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_2.Find(var_4_1, "grade/Xyz/bg13")
	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_3.Find(var_4_3, "grade/Xyz/bg14")
	local var_4_5
	local var_4_6
	local var_4_7
	local var_4_8 = arg_4_0.contextData.score

	ys = var_1_10008

	local var_4_9 = var_4_8 > var_1_10008.Battle.BattleConst.BattleScore.C

	setActive = var_1_10009

	local var_4_10 = arg_4_0._bg

	var_1_10009(var_11.Find(var_4_10, "jieuan01/BG/bg_victory"), var_4_9)

	setActive = var_1_10009

	local var_4_11 = arg_4_0._bg

	var_1_10009(var_11.Find(var_4_11, "jieuan01/BG/bg_fail"), not var_4_9)

	local var_4_12 = var_4_0[var_4_8 + 1]
	local var_4_13 = "battlescore/battle_score_" .. var_4_12 .. "/letter_" .. var_4_12
	local var_4_14 = "battlescore/battle_score_" .. var_4_12 .. "/label_" .. var_4_12

	LoadImageSpriteAsync = var_9

	var_9(var_4_13, var_4_2, false)

	LoadImageSpriteAsync = var_9

	var_9(var_4_14, var_4_4, false)

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:setStageName()

	rtf = var_1
	arg_5_0._gradeUpperLeftPos = var_1(arg_5_0._grade).localPosition
	Vector3 = var_2
	var_1.localPosition = var_2(0, 25, 0)
	pg = var_2

	local var_5_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_5_0, arg_5_0._tf)

	local var_5_1 = arg_5_0._grade.transform

	Vector3 = var_3
	var_5_1.localScale = var_3(1.5, 1.5, 0)
	LeanTween = var_5_1

	local var_5_2 = var_5_1.scale
	local var_5_3 = arg_5_0._grade

	Vector3 = var_5

	local var_5_4 = var_5_2(var_5_3, var_5(0.88, 0.88, 1), var_0_1.DURATION_WIN_SCALE)
	local var_5_5 = var_2.setOnComplete

	System = var_5

	var_5_5(var_5_4, var_5.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_5_0._levelText, true)

		local var_6_0 = arg_5_0

		var_0.rankAnimaFinish(var_6_0)

		return
	end))

	local var_5_6 = arg_5_0._tf
	local var_5_7 = var_2.GetComponent

	typeof = var_5
	Image = var_7

	local var_5_8 = var_5_7(var_5_6, var_5(var_7))

	Color = var_3
	var_5_8.color = var_3.New(0, 0, 0, 0.5)
	BattleResultLayer = var_5_8
	arg_5_0._stateFlag = var_5_8.STATE_RANK_ANIMA
	onButton = var_2

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0._skipBtn

	local function var_5_11()
		local var_7_0 = arg_5_0

		var_0.skip(var_7_0)

		return
	end

	SFX_CONFIRM = var_7

	var_2(var_5_9, var_5_10, var_5_11, var_7)

	return
end

function var_0_1.rankAnimaFinish(arg_8_0)
	local var_8_0 = arg_8_0._tf
	local var_8_1 = var_1.Find(var_8_0, "main/conditions")

	SetActive = var_1_10002

	var_1_10002(var_8_1, true)

	local var_8_2 = arg_8_0.contextData.statistics._airFightStatistics
	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.setCondition

	i18n = var_1_10006

	local var_8_5 = var_1_10006("fighterplane_destroy_tip") .. var_8_2.kill
	local var_8_6 = var_8_2.score

	COLOR_BLUE = var_8

	var_8_4(var_8_3, var_8_5, var_8_6, var_8)

	local var_8_7 = arg_8_0
	local var_8_8 = arg_8_0.setCondition

	i18n = var_8_5

	local var_8_9 = var_8_5("fighterplane_hit_tip") .. var_8_2.hit
	local var_8_10 = -var_8_2.lose

	COLOR_BLUE = var_8

	var_8_8(var_8_7, var_8_9, var_8_10, var_8)

	local var_8_11 = arg_8_0
	local var_8_12 = arg_8_0.setCondition

	i18n = var_8_9

	local var_8_13 = var_8_9("fighterplane_score_tip")
	local var_8_14 = var_8_2.total

	COLOR_YELLOW = var_8

	var_8_12(var_8_11, var_8_13, var_8_14, var_8)

	LeanTween = var_8_12

	local var_8_15 = var_8_12.delayedCall
	local var_8_16 = 1

	System = var_8_13

	local var_8_17 = var_8_15(var_8_16, var_8_13.Action(function()
		local var_9_0 = arg_8_0

		var_9_0._stateFlag = var_0_1.STATE_REPORTED
		SetActive = var_9_0

		local var_9_1 = arg_8_0._bg

		var_9_0(var_2.Find(var_9_1, "jieuan01/tips"), true)

		return
	end))

	table = var_4

	var_4.insert(arg_8_0._delayLeanList, var_8_17.id)

	arg_8_0._stateFlag = var_0_1.STATE_REPORT

	return
end

function var_0_1.setCondition(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	cloneTplTo = var_1_10004

	local var_10_0 = var_1_10004(arg_10_0._conditionContributeTpl, arg_10_0._conditionContainer)

	setActive = var_1_10005

	var_1_10005(var_10_0, false)

	local var_10_1
	local var_10_2 = var_10_0:Find("text")
	local var_10_3 = var_6.GetComponent

	typeof = var_9
	Text = var_1_10011

	local var_10_4 = var_10_3(var_10_2, var_9(var_1_10011))

	setColorStr = var_7
	var_10_4.text = var_7(arg_10_1, "#FFFFFFFF")

	local var_10_5 = var_10_0:Find("value")
	local var_10_6 = var_7.GetComponent

	typeof = var_10
	Text = var_1_10012

	local var_10_7 = var_10_6(var_10_5, var_10(var_1_10012))

	setColorStr = var_10_2
	var_10_7.text = var_10_2(arg_10_2, arg_10_3)

	local var_10_8 = arg_10_0._conditionContainer.childCount - 1
	local var_10_9

	if 0 < var_10_8 then
		LeanTween = var_10_9
		var_10_9 = var_10_9.delayedCall

		local var_10_10 = var_0_1.CONDITIONS_FREQUENCE * var_10_8

		System = var_1_10012
		var_10_9 = var_10_9(var_10_10, var_1_10012.Action(function()
			setActive = var_2_10000

			var_2_10000(var_10_0, true)

			return
		end))
		table = var_10

		var_10.insert(arg_10_0._delayLeanList, var_10_9.id)
	else
		setActive = var_10_9

		var_10_9(var_10_0, true)
	end

	return
end

function var_0_1.displayBG(arg_12_0)
	rtf = var_1_10001

	local var_12_0 = var_1_10001(arg_12_0._grade)

	LeanTween = var_1_10002

	local var_12_1 = var_1_10002.moveX

	rtf = var_1_10004

	var_12_1(var_1_10004(arg_12_0._conditions), 1300, var_0_1.DURATION_MOVE)

	LeanTween = var_12_1

	local var_12_2 = var_12_1.scale
	local var_12_3 = arg_12_0._grade

	Vector3 = var_5

	var_12_2(var_12_3, var_5(0.6, 0.6, 0), var_0_1.DURATION_MOVE)

	LeanTween = var_12_2

	local var_12_4 = var_12_2.moveLocal

	go = var_12_3

	local var_12_5 = var_12_4(var_12_3(var_12_0), arg_12_0._gradeUpperLeftPos, var_0_1.DURATION_MOVE)
	local var_12_6 = var_2.setOnComplete

	System = var_5

	var_12_6(var_12_5, var_5.Action(function()
		arg_12_0._stateFlag = var_0_1.STATE_DISPLAY

		local var_13_0 = arg_12_0

		var_0.showPainting(var_13_0)

		arg_12_0._stateFlag = var_0_1.STATE_DISPLAYED

		return
	end))

	setActive = var_12_6

	local var_12_7 = arg_12_0._bg

	var_12_6(var_4.Find(var_12_7, "jieuan01/Bomb"), false)

	return
end

function var_0_1.showPainting(arg_14_0)
	SetActive = var_1_10001

	var_1_10001(arg_14_0._painting, true)

	arg_14_0.paintingName = "yanzhan"
	setPaintingPrefabAsync = var_1

	var_1(arg_14_0._painting, arg_14_0.paintingName, "jiesuan", function()
		findTF = var_2_10000

		if var_2_10000(arg_14_0._painting, "fitter").childCount > 0 then
			ShipExpressionHelper = var_0

			local var_15_0 = var_0.SetExpression

			findTF = var_2

			local var_15_1 = var_2(arg_14_0._painting, "fitter")

			var_15_0(var_2.GetChild(var_15_1, 0), arg_14_0.paintingName, "win_mvp")
		end

		return
	end)

	local var_14_0 = arg_14_0.contextData.score

	if 1 < var_14_0 then
		ShipWordHelper = var_14_0

		if not var_14_0.WORD_TYPE_MVP then
			ShipWordHelper = var_14_0
			var_14_0 = var_14_0.WORD_TYPE_LOSE
		end

		ShipWordHelper = var_2

		local var_14_1, var_14_2, var_14_3 = var_2.GetWordAndCV(205020, var_14_0)

		setText = var_5

		local var_14_4 = arg_14_0._chat

		var_5(var_7.Find(var_14_4, "Text"), var_14_3)

		local var_14_5 = arg_14_0._chat
		local var_14_6 = var_5.Find(var_14_5, "Text")
		local var_14_7 = var_5.GetComponent

		typeof = var_8
		Text = var_10

		local var_14_8 = #var_14_7(var_14_6, var_8(var_10)).text

		CHAT_POP_STR_LEN = var_14_6

		if var_14_6 < var_14_8 then
			TextAnchor = var_14_8
			var_5.alignment = var_14_8.MiddleLeft
		else
			TextAnchor = var_14_8
			var_5.alignment = var_14_8.MiddleCenter
		end

		SetActive = var_14_8

		var_14_8(arg_14_0._chat, true)

		local var_14_9 = arg_14_0._chat.transform

		Vector3 = var_14_6
		var_14_9.localScale = var_14_6.New(0, 0, 0)
		LeanTween = var_14_9

		local var_14_10 = var_14_9.moveX

		rtf = var_8

		local var_14_11 = var_14_10(var_8(arg_14_0._painting), 50, 0.1)
		local var_14_12 = var_6.setOnComplete

		System = var_9

		var_14_12(var_14_11, var_9.Action(function()
			LeanTween = var_2_10000

			local var_16_0 = var_2_10000.scale

			rtf = var_2_10002

			local var_16_1 = var_2_10002(arg_14_0._chat.gameObject)

			Vector3 = var_2_10003

			local var_16_2 = var_16_0(var_16_1, var_2_10003.New(1, 1, 1), 0.1)
			local var_16_3 = var_0.setEase

			LeanTweenType = var_3

			var_16_3(var_16_2, var_3.easeOutBack)

			return
		end))

		return
	end
end

function var_0_1.skip(arg_17_0)
	local var_17_0 = arg_17_0._stateFlag

	BattleResultLayer = var_1_10002

	if var_17_0 == var_1_10002.STATE_REPORTED then
		local var_17_1 = arg_17_0
		local var_17_2 = arg_17_0.emit

		BattleResultMediator = var_1_10004

		var_17_2(var_17_1, var_1_10004.ON_BACK_TO_LEVEL_SCENE)
	end

	return
end

function var_0_1.showRightBottomPanel(arg_18_0)
	SetActive = var_1_10001

	var_1_10001(arg_18_0._skipBtn, false)

	SetActive = var_1_10001

	var_1_10001(arg_18_0._rightBottomPanel, true)

	SetActive = var_1_10001

	var_1_10001(arg_18_0._subToggle, false)

	onButton = var_1_10001

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0._confirmBtn

	local function var_18_2()
		local var_19_0 = arg_18_0
		local var_19_1 = var_0.emit

		BattleResultMediator = var_2_10003

		var_19_1(var_19_0, var_2_10003.ON_BACK_TO_LEVEL_SCENE)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_18_0, var_18_1, var_18_2, var_1_10006)

	arg_18_0._stateFlag = nil

	return
end

function var_0_1.onBackPressed(arg_20_0)
	triggerButton = var_1_10001

	var_1_10001(arg_20_0._skipBtn)

	return
end

function var_0_1.willExit(arg_21_0)
	LeanTween = var_1_10001

	local var_21_0 = var_1_10001.cancel

	go = var_1_10003

	var_21_0(var_1_10003(arg_21_0._tf))

	pg = var_21_0

	local var_21_1 = var_21_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_1, arg_21_0._tf)

	return
end

return var_0_1
