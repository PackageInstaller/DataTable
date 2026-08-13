class = var_0_10000

local var_0_0 = "BattleDodgemResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BattleResultLayer"))

function var_0_1.didEnter(arg_1_0)
	local var_1_0 = arg_1_0.contextData.stageId

	pg = var_1_10002

	local var_1_1 = var_1_10002.expedition_data_template[var_1_0]

	setText = var_1_10003

	var_1_10003(arg_1_0._levelText, var_1_1.name)

	setText = var_1_10003
	findTF = var_5

	local var_1_2 = var_5(arg_1_0._conditions, "bg17")

	i18n = var_6

	var_1_10003(var_1_2, var_6("battle_result_targets"))

	rtf = var_1_10003
	arg_1_0._gradeUpperLeftPos = var_1_10003(arg_1_0._grade).localPosition
	Vector3 = var_4
	var_3.localPosition = var_4(0, 25, 0)
	pg = var_4

	local var_1_3 = var_4.UIMgr.GetInstance()

	var_4.BlurPanel(var_1_3, arg_1_0._tf)

	local var_1_4 = arg_1_0._grade.transform

	Vector3 = var_5
	var_1_4.localScale = var_5(1.5, 1.5, 0)
	LeanTween = var_1_4

	local var_1_5 = var_1_4.scale
	local var_1_6 = arg_1_0._grade

	Vector3 = var_7

	local var_1_7 = var_1_5(var_1_6, var_7(0.88, 0.88, 1), var_0_1.DURATION_WIN_SCALE)
	local var_1_8 = var_4.setOnComplete

	System = var_7

	var_1_8(var_1_7, var_7.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_1_0._levelText, true)

		local var_2_0 = arg_1_0

		var_0.rankAnimaFinish(var_2_0)

		return
	end))

	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_4.GetComponent

	typeof = var_7
	Image = var_9

	local var_1_11 = var_1_10(var_1_9, var_7(var_9))

	Color = var_5
	var_1_11.color = var_5.New(0, 0, 0, 0.5)
	BattleResultLayer = var_1_11
	arg_1_0._stateFlag = var_1_11.STATE_RANK_ANIMA
	onButton = var_4

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0._skipBtn

	local function var_1_14()
		local var_3_0 = arg_1_0

		var_0.skip(var_3_0)

		return
	end

	SFX_CONFIRM = var_9

	var_4(var_1_12, var_1_13, var_1_14, var_9)

	return
end

function var_0_1.rankAnimaFinish(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "main/conditions")

	SetActive = var_1_10002

	var_1_10002(var_4_1, true)

	SetActive = var_1_10002

	var_1_10002(arg_4_0._conditionBGNormal, false)

	SetActive = var_1_10002

	var_1_10002(arg_4_0._conditionBGContribute, true)

	local var_4_2 = arg_4_0.contextData.statistics.dodgemResult
	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.setCondition

	i18n = var_1_10006

	local var_4_5 = var_1_10006("battle_result_total_score")
	local var_4_6 = var_4_2.score

	COLOR_BLUE = var_8

	var_4_4(var_4_3, var_4_5, var_4_6, var_8)

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.setCondition

	i18n = var_4_5

	local var_4_9 = var_4_5("battle_result_max_combo")
	local var_4_10 = var_4_2.maxCombo

	COLOR_YELLOW = var_8

	var_4_8(var_4_7, var_4_9, var_4_10, var_8)

	LeanTween = var_4_8

	local var_4_11 = var_4_8.delayedCall
	local var_4_12 = 1

	System = var_4_9

	local var_4_13 = var_4_11(var_4_12, var_4_9.Action(function()
		local var_5_0 = arg_4_0

		var_5_0._stateFlag = var_0_1.STATE_REPORTED
		SetActive = var_5_0

		local var_5_1 = arg_4_0._bg

		var_5_0(var_2.Find(var_5_1, "jieuan01/tips"), true)

		return
	end))

	table = var_4

	var_4.insert(arg_4_0._delayLeanList, var_4_13.id)

	arg_4_0._stateFlag = var_0_1.STATE_REPORT

	return
end

function var_0_1.displayBG(arg_6_0)
	rtf = var_1_10001

	local var_6_0 = var_1_10001(arg_6_0._grade)

	LeanTween = var_1_10002

	local var_6_1 = var_1_10002.moveX

	rtf = var_1_10004

	var_6_1(var_1_10004(arg_6_0._conditions), 1300, var_0_1.DURATION_MOVE)

	LeanTween = var_6_1

	local var_6_2 = var_6_1.scale
	local var_6_3 = arg_6_0._grade

	Vector3 = var_5

	var_6_2(var_6_3, var_5(0.6, 0.6, 0), var_0_1.DURATION_MOVE)

	LeanTween = var_6_2

	local var_6_4 = var_6_2.moveLocal

	go = var_6_3

	local var_6_5 = var_6_4(var_6_3(var_6_0), arg_6_0._gradeUpperLeftPos, var_0_1.DURATION_MOVE)
	local var_6_6 = var_2.setOnComplete

	System = var_5

	var_6_6(var_6_5, var_5.Action(function()
		local var_7_0 = arg_6_0

		var_0.showPainting(var_7_0)

		return
	end))

	setActive = var_6_6

	local var_6_7 = arg_6_0._bg

	var_6_6(var_4.Find(var_6_7, "jieuan01/Bomb"), false)

	return
end

function var_0_1.setCondition(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	cloneTplTo = var_1_10004

	local var_8_0 = var_1_10004(arg_8_0._conditionContributeTpl, arg_8_0._conditionContainer)

	setActive = var_1_10005

	var_1_10005(var_8_0, false)

	local var_8_1
	local var_8_2 = var_8_0:Find("text")
	local var_8_3 = var_6.GetComponent

	typeof = var_9
	Text = var_1_10011

	local var_8_4 = var_8_3(var_8_2, var_9(var_1_10011))

	setColorStr = var_7
	var_8_4.text = var_7(arg_8_1, "#FFFFFFFF")

	local var_8_5 = var_8_0:Find("value")
	local var_8_6 = var_7.GetComponent

	typeof = var_10
	Text = var_1_10012

	local var_8_7 = var_8_6(var_8_5, var_10(var_1_10012))

	setColorStr = var_8_2
	var_8_7.text = var_8_2(arg_8_2, arg_8_3)

	local var_8_8 = arg_8_0._conditionContainer.childCount - 1
	local var_8_9

	if 0 < var_8_8 then
		LeanTween = var_8_9
		var_8_9 = var_8_9.delayedCall

		local var_8_10 = var_0_1.CONDITIONS_FREQUENCE * var_8_8

		System = var_1_10012
		var_8_9 = var_8_9(var_8_10, var_1_10012.Action(function()
			setActive = var_2_10000

			var_2_10000(var_8_0, true)

			return
		end))
		table = var_10

		var_10.insert(arg_8_0._delayLeanList, var_8_9.id)
	else
		setActive = var_8_9

		var_8_9(var_8_0, true)
	end

	return
end

function var_0_1.showPainting(arg_10_0)
	local var_10_0
	local var_10_1
	local var_10_2

	SetActive = var_1_10004

	var_1_10004(arg_10_0._painting, true)

	arg_10_0.paintingName = "yanzhan"
	setPaintingPrefabAsync = var_4

	var_4(arg_10_0._painting, arg_10_0.paintingName, "jiesuan", function()
		findTF = var_2_10000

		if var_2_10000(arg_10_0._painting, "fitter").childCount > 0 then
			ShipExpressionHelper = var_0

			local var_11_0 = var_0.SetExpression

			findTF = var_2

			local var_11_1 = var_2(arg_10_0._painting, "fitter")

			var_11_0(var_2.GetChild(var_11_1, 0), arg_10_0.paintingName, "win_mvp")
		end

		return
	end)

	SetActive = var_4

	var_4(arg_10_0._failPainting, false)

	local var_10_3

	if arg_10_0.contextData.score > 1 then
		ShipWordHelper = var_10_3
		var_10_3 = var_10_3.GetWordAndCV

		local var_10_4 = 205020

		ShipWordHelper = var_7

		local var_10_5, var_10_6

		var_10_3, var_10_5, var_10_6 = var_10_3(var_10_4, var_7.WORD_TYPE_MVP)
		var_10_1 = var_10_6

		local var_10_7 = var_10_5
		local var_10_8 = var_10_3
	else
		ShipWordHelper = var_10_3
		var_10_3 = var_10_3.GetWordAndCV

		local var_10_9 = 205020

		ShipWordHelper = var_7

		local var_10_10, var_10_11

		var_10_3, var_10_10, var_10_11 = var_10_3(var_10_9, var_7.WORD_TYPE_LOSE)
		var_10_1 = var_10_11

		local var_10_12 = var_10_10
		local var_10_13 = var_10_3
	end

	setText = var_10_3

	local var_10_14 = arg_10_0._chat

	var_10_3(var_6.Find(var_10_14, "Text"), var_10_1)

	local var_10_15 = arg_10_0._chat
	local var_10_16 = var_4.Find(var_10_15, "Text")
	local var_10_17 = var_4.GetComponent

	typeof = var_7
	Text = var_9

	local var_10_18 = #var_10_17(var_10_16, var_7(var_9)).text

	CHAT_POP_STR_LEN = var_10_16

	if var_10_16 < var_10_18 then
		TextAnchor = var_10_18
		var_4.alignment = var_10_18.MiddleLeft
	else
		TextAnchor = var_10_18
		var_4.alignment = var_10_18.MiddleCenter
	end

	SetActive = var_10_18

	var_10_18(arg_10_0._chat, true)

	local var_10_19 = arg_10_0._chat.transform

	Vector3 = var_10_16
	var_10_19.localScale = var_10_16.New(0, 0, 0)
	LeanTween = var_10_19

	local var_10_20 = var_10_19.moveX

	rtf = var_7

	local var_10_21 = var_10_20(var_7(arg_10_0._painting), 50, 0.1)
	local var_10_22 = var_5.setOnComplete

	System = var_8

	var_10_22(var_10_21, var_8.Action(function()
		LeanTween = var_2_10000

		local var_12_0 = var_2_10000.scale

		rtf = var_2_10002

		local var_12_1 = var_2_10002(arg_10_0._chat.gameObject)

		Vector3 = var_2_10003

		local var_12_2 = var_12_0(var_12_1, var_2_10003.New(1, 1, 1), 0.1)
		local var_12_3 = var_0.setEase

		LeanTweenType = var_3

		var_12_3(var_12_2, var_3.easeOutBack)

		return
	end))

	BattleResultLayer = var_10_22
	arg_10_0._stateFlag = var_10_22.STATE_DISPLAYED

	return
end

function var_0_1.skip(arg_13_0)
	local var_13_0 = arg_13_0._stateFlag

	BattleResultLayer = var_1_10002

	if var_13_0 == var_1_10002.STATE_REPORTED then
		arg_13_0:displayBG()
	else
		local var_13_1 = arg_13_0._stateFlag

		BattleResultLayer = var_2

		if var_13_1 == var_2.STATE_DISPLAYED then
			local var_13_2 = arg_13_0
			local var_13_3 = arg_13_0.emit

			BattleResultMediator = var_1_10004

			var_13_3(var_13_2, var_1_10004.ON_BACK_TO_LEVEL_SCENE)
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

	go = var_1_10003

	var_15_0(var_1_10003(arg_15_0._tf))

	pg = var_15_0

	local var_15_1 = var_15_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_1, arg_15_0._tf)

	pg = var_1

	local var_15_2 = var_1.CameraFixMgr.GetInstance()

	var_1.disconnect(var_15_2, arg_15_0.camEventId)

	return
end

return var_0_1
