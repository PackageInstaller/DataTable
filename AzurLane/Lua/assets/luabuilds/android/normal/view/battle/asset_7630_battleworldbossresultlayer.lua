class = var_0_10000

local var_0_0 = "BattleWorldBossResultLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.DURATION_MOVE = 0.35
var_0_1.DURATION_WIN_SCALE = 0.4
var_0_1.CONDITIONS_FREQUENCE = 0.15
var_0_1.STATE_RANK_ANIMA = "rankAnima"
var_0_1.STATE_REPORT = "report"
var_0_1.STATE_REPORTED = "reported"
var_0_1.STATE_REWARD = "reward"
var_0_1.STATE_DISPLAY = "display"
var_0_1.STATE_DISPLAYED = "displayed"
var_0_1.STATE_SUB_DISPLAY = "subDisplay"
var_0_1.STATE_SUB_DISPLAYED = "subDisplayed"
var_0_1.ObjectiveList = {
	"battle_result_victory",
	"battle_result_undefeated",
	"battle_result_sink_limit",
	"battle_preCombatLayer_time_hold",
	"battle_result_time_limit",
	"battle_result_boss_destruct",
	"battle_preCombatLayer_damage_before_end",
	"battle_result_defeat_all_enemys"
}

function var_0_1.getUIName(arg_1_0)
	return "BattleResultUI"
end

function var_0_1.setRivalVO(arg_2_0, arg_2_1)
	arg_2_0.rivalVO = arg_2_1

	return
end

function var_0_1.setRank(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.player = arg_3_1
	arg_3_0.season = arg_3_2
	setText = var_1_10003

	var_1_10003(arg_3_0._playerName, "<color=#FFFFFF>" .. arg_3_0.player.name .. "</color><size=32> / C O M M A N D E R</size>")

	SeasonInfo = var_1_10003

	local var_3_0 = var_1_10003.getMilitaryRank(arg_3_2.score, arg_3_2.rank)

	SeasonInfo = var_4

	local var_3_1, var_3_2 = var_4.getNextMilitaryRank(arg_3_2.score, arg_3_2.rank)

	setText = var_6

	var_6(arg_3_0._playerLv, var_3_0.name)

	setText = var_6

	local var_3_3 = arg_3_0._playerExpLabel

	i18n = var_8

	var_6(var_3_3, var_8("word_rankScore"))

	local var_3_4 = arg_3_0._playerExpProgress
	local var_3_5 = var_6.GetComponent

	typeof = var_8
	Image = var_9

	local var_3_6 = var_3_5(var_3_4, var_8(var_9))

	var_3_6.fillAmount = arg_3_2.score / var_3_2
	setText = var_3_6

	var_3_6(arg_3_0._playerBonusExp, "+0")

	arg_3_0.calcPlayerProgress = arg_3_0.calcPlayerRank

	return
end

function var_0_1.setShips(arg_4_0, arg_4_1)
	arg_4_0.shipVOs = arg_4_1

	return
end

function var_0_1.setPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1
	setText = var_1_10002

	var_1_10002(arg_5_0._playerName, "<color=#FFFFFF>" .. arg_5_0.player.name .. "</color><size=32> / C O M M A N D E R</size>")

	setText = var_1_10002

	var_1_10002(arg_5_0._playerLv, "Lv." .. arg_5_0.player.level)

	getConfigFromLevel1 = var_1_10002
	pg = var_3

	local var_5_0 = var_1_10002(var_3.user_level, arg_5_0.player.level)
	local var_5_1 = arg_5_0._playerExpProgress
	local var_5_2 = var_3.GetComponent

	typeof = var_5
	Image = var_6
	var_5_2(var_5_1, var_5(var_6)).fillAmount = arg_5_0.player.exp / var_5_0.exp_interval

	local var_5_3 = arg_5_0.player.level

	pg = var_4

	local var_5_4 = var_4.user_level

	pg = var_5

	if var_5_3 == var_5_4[#var_5.user_level].level then
		local var_5_5 = arg_5_0._playerExpProgress

		var_5_3 = var_5_3.GetComponent
		typeof = var_5
		Image = var_6
		var_5_3 = var_5_3(var_5_5, var_5(var_6))
		var_5_3.fillAmount = 1
	end

	setText = var_5_3

	var_5_3(arg_5_0._playerBonusExp, "+0")

	arg_5_0.calcPlayerProgress = arg_5_0.calcPlayerExp

	local var_5_6 = arg_5_0.contextData.extraBuffList

	return
end

function var_0_1.setExpBuff(arg_6_0, arg_6_1)
	arg_6_0.expBuff = arg_6_1

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0._grade = var_1.Find(var_7_0, "grade")

	local var_7_1 = arg_7_0._grade

	arg_7_0._gradeLabel = var_1.Find(var_7_1, "label")

	local var_7_2 = arg_7_0._gradeLabel
	local var_7_3 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_7_0._gradeLabelImg = var_7_3(var_7_2, var_3(var_1_10004))

	local var_7_4 = arg_7_0._tf

	arg_7_0.title = var_1.Find(var_7_4, "main/title")

	local var_7_5 = arg_7_0._tf
	local var_7_6 = var_1.Find(var_7_5, "main/title/Text")
	local var_7_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_7_0.subTitleTxt = var_7_7(var_7_6, var_3(var_1_10004))

	local var_7_8 = arg_7_0._grade

	arg_7_0._levelText = var_1.Find(var_7_8, "chapterName/Text22")

	local var_7_9 = arg_7_0._tf

	arg_7_0.clearFX = var_1.Find(var_7_9, "clear")
	setParent = var_1

	var_1(arg_7_0.title, arg_7_0._tf)

	local var_7_10 = arg_7_0._tf

	arg_7_0._main = var_1.Find(var_7_10, "main")

	local var_7_11 = arg_7_0._tf

	arg_7_0._blurConatiner = var_1.Find(var_7_11, "blur_container")

	local var_7_12 = arg_7_0._tf

	arg_7_0._bg = var_1.Find(var_7_12, "main/jiesuanbeijing")

	local var_7_13 = arg_7_0._blurConatiner

	arg_7_0._painting = var_1.Find(var_7_13, "painting")

	local var_7_14 = arg_7_0._painting

	arg_7_0._failPainting = var_1.Find(var_7_14, "fail")

	local var_7_15 = arg_7_0._painting

	arg_7_0._chat = var_1.Find(var_7_15, "chat")

	local var_7_16 = arg_7_0._main

	arg_7_0._leftPanel = var_1.Find(var_7_16, "leftPanel")

	local var_7_17 = arg_7_0._leftPanel

	arg_7_0._expResult = var_1.Find(var_7_17, "expResult")

	local var_7_18 = arg_7_0._expResult

	arg_7_0._expContainer = var_1.Find(var_7_18, "expContainer")
	arg_7_0._extpl = arg_7_0:getTpl("ShipCardTpl", arg_7_0._expContainer)

	local var_7_19 = arg_7_0._leftPanel

	arg_7_0._playerExp = var_1.Find(var_7_19, "playerExp")

	local var_7_20 = arg_7_0._playerExp

	arg_7_0._playerName = var_1.Find(var_7_20, "name_text")

	local var_7_21 = arg_7_0._playerExp

	arg_7_0._playerLv = var_1.Find(var_7_21, "lv_text")

	local var_7_22 = arg_7_0._playerExp

	arg_7_0._playerExpLabel = var_1.Find(var_7_22, "exp_label")

	local var_7_23 = arg_7_0._playerExp

	arg_7_0._playerExpProgress = var_1.Find(var_7_23, "exp_progress")

	local var_7_24 = arg_7_0._playerExp

	arg_7_0._playerBonusExp = var_1.Find(var_7_24, "exp_text")

	local var_7_25 = arg_7_0._playerExp

	arg_7_0._playerExpExtra = var_1.Find(var_7_25, "operation_bonus")

	local var_7_26 = arg_7_0._blurConatiner

	arg_7_0._atkBG = var_1.Find(var_7_26, "atkPanel")

	local var_7_27 = arg_7_0._atkBG

	arg_7_0._atkPanel = var_1.Find(var_7_27, "atkResult")

	local var_7_28 = arg_7_0._atkBG

	arg_7_0._atkResult = var_1.Find(var_7_28, "atkResult/result")

	local var_7_29 = arg_7_0._atkResult

	arg_7_0._atkContainer = var_1.Find(var_7_29, "Grid")

	local var_7_30 = arg_7_0._atkResult

	arg_7_0._atkContainerNext = var_1.Find(var_7_30, "Grid_next")

	local var_7_31 = arg_7_0._atkPanel

	arg_7_0._atkToggle = var_1.Find(var_7_31, "switchAtk")
	arg_7_0._atkTpl = arg_7_0:getTpl("resulttpl", arg_7_0._atkResult)

	local var_7_32 = arg_7_0._atkPanel

	arg_7_0._mvpFX = var_1.Find(var_7_32, "mvpFX")

	local var_7_33 = arg_7_0._blurConatiner

	arg_7_0._rightBottomPanel = var_1.Find(var_7_33, "rightBottomPanel")

	local var_7_34 = arg_7_0._rightBottomPanel

	arg_7_0._confirmBtn = var_1.Find(var_7_34, "confirmBtn")
	setText = var_1

	local var_7_35 = arg_7_0._confirmBtn
	local var_7_36 = var_2.Find(var_7_35, "Text")

	i18n = var_7_35

	var_1(var_7_36, var_7_35("text_confirm"))

	local var_7_37 = arg_7_0._rightBottomPanel

	arg_7_0._statisticsBtn = var_1.Find(var_7_37, "statisticsBtn")

	local var_7_38 = arg_7_0._leftPanel

	arg_7_0._subExpResult = var_1.Find(var_7_38, "subExpResult")

	local var_7_39 = arg_7_0._subExpResult

	arg_7_0._subExpContainer = var_1.Find(var_7_39, "expContainer")

	local var_7_40 = arg_7_0._leftPanel

	arg_7_0._subToggle = var_1.Find(var_7_40, "switchFleet")

	local var_7_41 = arg_7_0._tf

	arg_7_0._skipBtn = var_1.Find(var_7_41, "skipLayer")
	pg = var_1
	arg_7_0.UIMain = var_1.UIMgr.GetInstance().UIMain
	pg = var_1
	arg_7_0.overlay = var_1.UIMgr.GetInstance().OverlayMain

	local var_7_42 = arg_7_0._tf

	arg_7_0._conditions = var_1.Find(var_7_42, "main/conditions")

	local var_7_43 = arg_7_0._conditions

	arg_7_0._conditionContainer = var_1.Find(var_7_43, "bg16/list")

	local var_7_44 = arg_7_0._conditions

	arg_7_0._conditionTpl = var_1.Find(var_7_44, "bg16/conditionTpl")

	local var_7_45 = arg_7_0._conditions

	arg_7_0._conditionSubTpl = var_1.Find(var_7_45, "bg16/conditionSubTpl")

	local var_7_46 = arg_7_0._leftPanel

	arg_7_0._cmdExp = var_1.Find(var_7_46, "commanderExp")

	local var_7_47 = arg_7_0._cmdExp

	arg_7_0._cmdContainer = var_1.Find(var_7_47, "commander_container")

	local var_7_48 = arg_7_0._cmdExp

	arg_7_0._cmdTpl = var_1.Find(var_7_48, "commander_tpl")

	local var_7_49 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_7_50 = arg_7_0._tf
	local var_7_51 = var_2.Find(var_7_50, "grade/Xyz/bg13")
	local var_7_52 = arg_7_0._tf
	local var_7_53 = var_3.Find(var_7_52, "grade/Xyz/bg14")
	local var_7_54
	local var_7_55
	local var_7_56
	local var_7_57 = arg_7_0.contextData.score
	local var_7_58
	local var_7_59 = var_7_57 > 0

	setActive = var_1_10010

	local var_7_60 = arg_7_0._bg

	var_1_10010(var_11.Find(var_7_60, "jieuan01/BG/bg_victory"), var_7_59)

	setActive = var_1_10010

	local var_7_61 = arg_7_0._bg

	var_1_10010(var_11.Find(var_7_61, "jieuan01/BG/bg_fail"), not var_7_59)

	if var_7_59 then
		var_7_56 = var_7_49[var_7_57 + 1]

		local var_7_62 = "battlescore/battle_score_" .. var_7_56 .. "/letter_" .. var_7_56
		local var_7_63 = "battlescore/battle_score_" .. var_7_56 .. "/label_" .. var_7_56
	else
		var_1_10010 = arg_7_0.contextData.statistics._scoreMark
		ys = var_11

		if var_1_10010 == var_11.Battle.BattleConst.DEAD_FLAG then
			var_7_56 = var_7_49[2]
			var_7_58 = "flag_destroy"
		else
			var_7_56 = var_7_49[1]
		end

		local var_7_64 = "battlescore/battle_score_" .. var_7_56 .. "/letter_" .. var_7_56
		local var_7_65 = "battlescore/battle_score_" .. var_7_56 .. "/label_" .. (var_7_58 or var_7_56)
	end

	SetActive = var_1_10010

	var_1_10010(arg_7_0._levelText, false)

	LoadImageSpriteAsync = var_1_10010

	var_1_10010("battlescore/grade_label_clear", arg_7_0._gradeLabel, true)

	setActive = var_1_10010

	var_1_10010(arg_7_0._gradeLabel, true)

	setActive = var_1_10010

	local var_7_66 = arg_7_0._grade

	var_1_10010(var_11.Find(var_7_66, "Xyz"), false)

	setActive = var_1_10010

	local var_7_67 = arg_7_0._grade

	var_1_10010(var_11.Find(var_7_67, "chapterName"), false)

	local var_7_68 = arg_7_0._gradeLabel

	Vector3 = var_11
	var_7_68.localScale = var_11(1.2, 1.2, 1)
	arg_7_0._delayLeanList = {}
	GetComponent = var_10

	local var_7_69 = arg_7_0._tf

	typeof = var_12
	AspectRatioFitter = var_13
	arg_7_0._ratioFitter = var_10(var_7_69, var_12(var_13))
	arg_7_0._ratioFitter.enabled = true

	local var_7_70 = arg_7_0._ratioFitter

	pg = var_11
	var_7_70.aspectRatio = var_11.CameraFixMgr.GetInstance().targetRatio
	pg = var_7_70

	local var_7_71 = var_7_70.CameraFixMgr.GetInstance()
	local var_7_72 = var_10.bind

	pg = var_12
	arg_7_0.camEventId = var_7_72(var_7_71, var_12.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_8_0, arg_8_1)
		arg_7_0._ratioFitter.aspectRatio = arg_8_1

		return
	end)

	return
end

function var_0_1.displayerCommanders(arg_9_0, arg_9_1)
	local var_9_0

	if not arg_9_0.contextData.commanderExps then
		var_9_0 = {}
	end

	arg_9_0.commanderExps = var_9_0
	getProxy = var_9_0
	CommanderProxy = var_1_10003

	local var_9_1 = var_9_0(var_1_10003)

	removeAllChildren = var_1_10003

	var_1_10003(arg_9_0._cmdContainer)

	local var_9_2

	if arg_9_1 then
		var_9_2 = arg_9_0.commanderExps.submarineCMD or {}
	else
		var_9_2 = arg_9_0.commanderExps.surfaceCMD or {}
	end

	setActive = var_4

	var_4(arg_9_0._cmdExp, true)

	ipairs = var_4

	for iter_9_0, iter_9_1 in var_4(var_9_2) do
		local var_9_3 = var_9_1
		local var_9_4 = var_9_1.getCommanderById(var_9_3, iter_9_1.commander_id)

		cloneTplTo = var_9_3

		local var_9_5 = var_9_3(arg_9_0._cmdTpl, arg_9_0._cmdContainer)

		GetImageSpriteFromAtlasAsync = var_11

		local var_9_6 = "commandericon/" .. var_9_4:getPainting()
		local var_9_7 = ""
		local var_9_8 = var_9_5

		var_11(var_9_6, var_9_7, var_9_5.Find(var_9_8, "icon/mask/pic"))

		setText = var_11

		var_11(var_9_5:Find("exp/name_text"), var_9_4:getName())

		setText = var_11

		var_11(var_9_5:Find("exp/lv_text"), "Lv." .. var_9_4.level)

		setText = var_11

		var_11(var_9_5:Find("exp/exp_text"), "+" .. iter_9_1.exp)

		local var_9_9
		local var_9_10 = var_9_4:isMaxLevel() and 1 or iter_9_1.curExp / var_9_4:getNextLevelExp()
		local var_9_11 = var_9_5:Find("exp/exp_progress")
		local var_9_12 = var_12.GetComponent

		typeof = var_14
		Image = var_9_8
		var_9_12(var_9_11, var_14(var_9_8)).fillAmount = var_9_10
	end

	return
end

function var_0_1.didEnter(arg_10_0)
	arg_10_0:setStageName()

	rtf = var_1
	arg_10_0._gradeUpperLeftPos = var_1(arg_10_0._grade).localPosition

	local var_10_0 = arg_10_0._gradeLabelImg

	Color = var_1_10003
	var_10_0.color = var_1_10003.New(1, 1, 1, 1)
	pg = var_10_0

	local var_10_1 = var_10_0.UIMgr.GetInstance()

	var_2.BlurPanel(var_10_1, arg_10_0._tf)

	local var_10_2 = arg_10_0._tf
	local var_10_3 = var_2.GetComponent

	typeof = var_4
	Image = var_5

	local var_10_4 = var_10_3(var_10_2, var_4(var_5))

	Color = var_10_2
	var_10_4.color = var_10_2.New(0, 0, 0, 0.5)
	SetActive = var_10_4

	var_10_4(arg_10_0._atkBG, false)

	arg_10_0._stateFlag = var_0_1.STATE_REPORTED
	setText = var_2

	var_2(arg_10_0.title, "")
	arg_10_0:skip()

	return
end

function var_0_1.setTitle(arg_11_0, arg_11_1)
	arg_11_0.name = arg_11_1

	return
end

function var_0_1.setStageName(arg_12_0)
	if arg_12_0.contextData.system then
		local var_12_0 = arg_12_0.contextData.system

		SYSTEM_DUEL = var_1_10002

		if var_12_0 == var_1_10002 then
			setText = var_12_0

			var_12_0(arg_12_0._levelText, arg_12_0.rivalVO.name)

			goto label_12_0
		end
	end

	do
		local var_12_1 = arg_12_0.contextData.stageId

		pg = var_1_10002

		local var_12_2 = var_1_10002.expedition_data_template[var_12_1]

		setText = var_1_10003

		var_1_10003(arg_12_0._levelText, var_12_2.name)
	end

	::label_12_0::

	return
end

function var_0_1.rankAnimaFinish(arg_13_0)
	local var_13_0 = arg_13_0._tf
	local var_13_1 = var_1.Find(var_13_0, "main/conditions")

	SetActive = var_13_0

	var_13_0(var_13_1, true)

	local var_13_2 = arg_13_0.contextData.stageId

	pg = var_3

	local var_13_3 = var_3.expedition_data_template[var_13_2]

	;(function(arg_14_0)
		type = var_2_10001

		if var_2_10001(arg_14_0) == "table" then
			i18n = var_1

			local var_14_0 = var_1(var_0_1.ObjectiveList[arg_14_0[1]], arg_14_0[2])
			local var_14_1 = arg_13_0

			var_2.setCondition(var_14_1, var_14_0, var_0_1.objectiveCheck(arg_14_0[1], arg_13_0.contextData))
		end

		return
	end)(var_13_3.objective_1)
	var_4(var_13_3.objective_2)
	var_4(var_13_3.objective_3)

	LeanTween = var_5

	local var_13_4 = var_5.delayedCall
	local var_13_5 = 1

	System = var_1_10007

	local var_13_6 = var_13_4(var_13_5, var_1_10007.Action(function()
		local var_15_0 = arg_13_0

		var_15_0._stateFlag = var_0_1.STATE_REPORTED
		SetActive = var_15_0

		local var_15_1 = arg_13_0._bg

		var_15_0(var_1.Find(var_15_1, "jieuan01/tips"), true)

		return
	end))

	table = var_13_5

	var_13_5.insert(arg_13_0._delayLeanList, var_13_6.id)

	arg_13_0._stateFlag = var_0_1.STATE_REPORT

	return
end

function var_0_1.objectiveCheck(arg_16_0, arg_16_1)
	if arg_16_0 == 1 or arg_16_0 == 4 or arg_16_0 == 8 then
		return arg_16_1.score > 1
	elseif arg_16_0 == 2 or arg_16_0 == 3 then
		return not arg_16_1.statistics._deadUnit
	elseif arg_16_0 == 6 then
		return arg_16_1.statistics._boss_destruct < 1
	elseif arg_16_0 == 5 then
		return not arg_16_1.statistics._badTime
	elseif arg_16_0 == 7 then
		return true
	end

	return
end

function var_0_1.setCondition(arg_17_0, arg_17_1, arg_17_2)
	cloneTplTo = var_1_10003

	local var_17_0 = var_1_10003(arg_17_0._conditionTpl, arg_17_0._conditionContainer)

	setActive = var_4

	var_4(var_17_0, false)

	local var_17_1
	local var_17_2 = var_17_0:Find("text")
	local var_17_3 = var_5.GetComponent

	typeof = var_7
	Text = var_1_10008

	local var_17_4 = var_17_3(var_17_2, var_7(var_1_10008))

	if arg_17_2 == nil then
		var_17_1 = "resources/condition_check"
		setColorStr = var_17_2
		var_17_4.text = var_17_2(arg_17_1, "#FFFFFFFF")
	elseif arg_17_2 == true then
		var_17_1 = "resources/condition_done"
		setColorStr = var_17_2
		var_17_4.text = var_17_2(arg_17_1, "#FFFFFFFF")
	else
		var_17_1 = "resources/condition_fail"
		setColorStr = var_17_2
		var_17_4.text = var_17_2(arg_17_1, "#FFFFFF80")
	end

	arg_17_0:setSpriteTo(var_17_1, var_17_0:Find("checkBox"), true)

	local var_17_5 = arg_17_0._conditionContainer.childCount - 1
	local var_17_6

	if 0 < var_17_5 then
		LeanTween = var_17_6
		var_17_6 = var_17_6.delayedCall

		local var_17_7 = var_0_1.CONDITIONS_FREQUENCE * var_17_5

		System = var_9
		var_17_6 = var_17_6(var_17_7, var_9.Action(function()
			setActive = var_2_10000

			var_2_10000(var_17_0, true)

			return
		end))
		table = var_17_7

		var_17_7.insert(arg_17_0._delayLeanList, var_17_6.id)
	else
		setActive = var_17_6

		var_17_6(var_17_0, true)
	end

	return
end

function var_0_1.showRewardInfo(arg_19_0, arg_19_1)
	arg_19_0._stateFlag = var_0_1.STATE_REWARD
	SetActive = var_2

	local var_19_0 = arg_19_0._bg

	var_2(var_3.Find(var_19_0, "jieuan01/tips"), false)

	setParent = var_2

	var_2(arg_19_0._tf, arg_19_0.UIMain)

	local var_19_1

	local function var_19_2()
		if var_19_1 then
			coroutine = var_0

			if var_0.status(var_19_1) == "suspended" then
				coroutine = var_0

				local var_20_0, var_20_1 = var_0.resume(var_19_1)

				assert = var_2_10002

				var_2_10002(var_20_0, var_20_1)
			end
		end

		return
	end

	coroutine = var_4
	var_19_1 = var_4.create(function()
		local var_21_0 = arg_19_0.contextData.drops
		local var_21_1 = {}

		ipairs = var_2_10002

		for iter_21_0, iter_21_1 in var_2_10002(arg_19_0.contextData.drops) do
			table = var_2_10007

			var_2_10007.insert(var_21_1, iter_21_1)
		end

		ipairs = var_2

		for iter_21_2, iter_21_3 in var_2(arg_19_0.contextData.extraDrops) do
			iter_21_3.riraty = true
			table = var_7

			var_7.insert(var_21_1, iter_21_3)
		end

		local var_21_2 = false
		local var_21_3 = arg_19_0.contextData.extraBuffList

		table = var_4

		local var_21_5

		if var_4.getCount(var_21_0) > 0 then
			local var_21_4 = arg_19_0

			var_21_5 = var_21_5.emit
			BaseUI = iter_21_3

			var_21_5(var_21_4, iter_21_3.ON_AWARD, {
				items = var_21_0,
				removeFunc = var_19_2
			})

			coroutine = var_21_5

			var_21_5.yield()

			_ = var_21_5
			var_21_5 = #var_21_5.filter(var_21_1, function(arg_22_0)
				local var_22_0 = arg_22_0.type

				DROP_TYPE_SHIP = var_3_10002

				return var_22_0 == var_3_10002
			end)
			getProxy = var_5
			BayProxy = var_6

			local var_21_6 = var_5(var_6)
			local var_21_7 = var_5.getNewShip(var_21_6, true)

			math = var_21_6

			for iter_21_4 = var_21_6.max(1, #var_21_7 - var_21_5 + 1), #var_21_7 do
				local var_21_8 = var_21_7[iter_21_4]

				PlayerPrefs = var_2_10012
				var_2_10012 = var_2_10012.GetInt
				DISPLAY_SHIP_GET_EFFECT = var_2_10013

				if var_2_10012(var_2_10013) ~= 1 then
					if not var_21_8.virgin then
						var_2_10013 = var_21_8
						var_2_10012 = var_21_8.getRarity(var_2_10013)
						ShipRarity = var_2_10013

						if not (var_2_10013.Purple <= var_2_10012) then
							var_2_10012 = false

							goto label_21_0
						end

						var_2_10012 = true
					end

					::label_21_0::

					if var_2_10012 then
						local var_21_9 = arg_19_0

						var_2_10013 = var_2_10013.emit
						BattleResultMediator = var_2_10015

						var_2_10013(var_21_9, var_2_10015.GET_NEW_SHIP, var_21_8, var_19_2)

						coroutine = var_2_10013

						var_2_10013.yield()
					end
				end
			end
		end

		setParent = var_21_5

		var_21_5(arg_19_0._tf, arg_19_0.overlay)
		arg_19_1()

		setActive = var_4

		local var_21_10 = arg_19_0._tf

		var_4(var_5.Find(var_21_10, "main/jiesuanbeijing"), false)

		setActive = var_4

		var_4(arg_19_0._conditions, false)

		return
	end)

	var_19_2()

	return
end

function var_0_1.displayPlayerInfo(arg_23_0)
	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.calcPlayerProgress(var_23_0)

	SetActive = var_23_0

	var_23_0(arg_23_0._leftPanel, true)

	SetActive = var_23_0

	var_23_0(arg_23_0._playerExp, true)

	local var_23_2 = arg_23_0._main
	local var_23_3 = var_2.GetComponent(var_23_2, "Animator")

	var_23_3.enabled = true
	LeanTween = var_23_3

	local var_23_4 = var_23_3.moveX

	rtf = var_3

	local var_23_5 = var_23_4(var_3(arg_23_0._leftPanel), 0, 0.5)
	local var_23_6 = var_2.setOnComplete

	System = var_4

	local var_23_7 = var_23_6(var_23_5, var_4.Action(function()
		LeanTween = var_2_10000

		local var_24_0 = var_2_10000.value

		go = var_2_10001

		local var_24_1 = var_24_0(var_2_10001(arg_23_0._tf), 0, var_23_1, 1)
		local var_24_2 = var_0.setOnUpdate

		System = var_2

		local var_24_3 = var_24_2(var_24_1, var_2.Action_float(function(arg_25_0)
			setText = var_3_10001

			local var_25_0 = arg_23_0._playerBonusExp
			local var_25_1 = "+"

			math = var_3_10004

			var_3_10001(var_25_0, var_25_1 .. var_3_10004.floor(arg_25_0))

			return
		end))

		table = var_24_1

		var_24_1.insert(arg_23_0._delayLeanList, var_24_3.id)

		return
	end))

	table = var_23_5

	var_23_5.insert(arg_23_0._delayLeanList, var_23_7.id)

	return
end

function var_0_1.calcPlayerExp(arg_26_0)
	local var_26_0 = arg_26_0.contextData.oldPlayer.level
	local var_26_1 = arg_26_0.player.level
	local var_26_2 = arg_26_0.player.exp - var_1.exp

	while var_26_0 < var_26_1 do
		pg = var_5
		var_26_2 = var_26_2 + var_5.user_level[var_26_0].exp
		var_26_0 = var_26_0 + 1
	end

	pg = var_5

	local var_26_3 = var_5.user_level

	pg = var_1_10006

	if var_26_0 == var_26_3[#var_1_10006.user_level].level then
		var_26_2 = 0
	end

	return var_26_2
end

function var_0_1.calcPlayerRank(arg_27_0)
	local var_27_0 = arg_27_0.contextData.oldRank.score

	return arg_27_0.season.score - var_1.score
end

function var_0_1.displayShips(arg_28_0)
	setActive = var_1_10001

	var_1_10001(arg_28_0.title, true)

	arg_28_0._expTFs = {}
	arg_28_0._initExp = {}
	arg_28_0._skipExp = {}
	arg_28_0._subSkipExp = {}
	arg_28_0._subCardAnimaFuncList = {}

	local var_28_0 = {}
	local var_28_1 = arg_28_0.shipVOs

	ipairs = var_3

	for iter_28_0, iter_28_1 in var_3(var_28_1) do
		var_28_0[iter_28_1.id] = iter_28_1
	end

	local var_28_2 = arg_28_0.contextData.statistics

	ipairs = var_4

	for iter_28_2, iter_28_3 in var_4(var_28_1) do
		if var_28_2[iter_28_3.id] then
			var_1_10009 = var_28_2[iter_28_3.id]
			var_1_10009.vo = iter_28_3
		end
	end

	local var_28_3
	local var_28_4

	if var_28_2.mvpShipID and var_28_2.mvpShipID ~= 0 then
		var_28_4 = var_28_2[var_28_2.mvpShipID].output
	else
		var_28_4 = 0
	end

	local var_28_5 = arg_28_0.contextData.oldMainShips

	arg_28_0._atkFuncs = {}
	arg_28_0._commonAtkTplList = {}
	arg_28_0._subAtkTplList = {}

	local var_28_6
	local var_28_7

	SetActive = var_1_10009

	local var_28_8 = arg_28_0._atkToggle
	local var_28_9 = #var_28_5

	var_1_10009(var_28_8, 6 < var_28_9)

	local var_28_12

	if #var_28_5 > 6 then
		onToggle = var_9

		local var_28_10 = arg_28_0
		local var_28_11 = arg_28_0._atkToggle

		function var_28_12(arg_29_0)
			SetActive = var_2_10001

			var_2_10001(arg_28_0._atkContainer, arg_29_0)

			SetActive = var_2_10001

			var_2_10001(arg_28_0._atkContainerNext, not arg_29_0)

			if arg_29_0 then
				local var_29_0 = arg_28_0

				var_1.skipAtkAnima(var_29_0, arg_28_0._atkContainerNext)
			else
				local var_29_1 = arg_28_0

				var_1.skipAtkAnima(var_29_1, arg_28_0._atkContainer)
			end

			return
		end

		SFX_PANEL = var_1_10013

		var_9(var_28_10, var_28_11, var_28_12, var_1_10013)
	end

	local var_28_13 = {}
	local var_28_14 = {}
	local var_28_15 = 0

	ipairs = var_28_12

	for iter_28_4, iter_28_5 in var_28_12(var_28_5) do
		var_1_10017 = var_28_0[iter_28_5.id]

		if var_28_2[iter_28_5.id] then
			ys = var_18

			local var_28_16 = var_18.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_28_5.configId).type

			table = var_19

			local var_28_17 = var_19.contains

			ShipType = var_1_10020

			local var_28_18 = var_28_17(var_1_10020.SubShipType, var_28_16)

			var_1_10020 = nil

			local var_28_19
			local var_28_20 = 0
			local var_28_21

			if 6 < iter_28_4 then
				var_28_19 = arg_28_0._atkContainerNext
				var_28_21 = 7
			else
				var_28_19 = arg_28_0._atkContainer
				var_28_21 = 1
			end

			cloneTplTo = var_23
			var_23.x = var_23(arg_28_0._atkTpl, var_28_19).localPosition.x + (iter_28_4 - var_28_21) * 74
			var_23.y = var_23.y + (iter_28_4 - var_28_21) * 4
			var_1_10020.localPosition = var_23

			local var_28_22 = var_1_10020:Find("result/mask/icon")
			local var_28_23 = var_1_10020:Find("result/type")
			local var_28_24 = var_28_22
			local var_28_25 = var_28_22.GetComponent

			typeof = var_1_10028
			Image = var_1_10029

			local var_28_26 = var_28_25(var_28_24, var_1_10028(var_1_10029))

			LoadSprite = var_28_24
			var_28_26.sprite = var_28_24("herohrzicon/" .. iter_28_5:getPainting())

			local var_28_27 = var_28_2[iter_28_5.id].output / var_28_4

			GetSpriteFromAtlas = var_27
			var_1_10028 = "shiptype"
			shipType2print = var_1_10029

			local var_28_28 = var_27(var_1_10028, var_1_10029(iter_28_5:getShipType()))

			setImageSprite = var_1_10028

			var_1_10028(var_28_23, var_28_28, true)

			var_1_10029 = arg_28_0

			arg_28_0.setAtkAnima(var_1_10029, var_1_10020, var_28_19, var_28_27, var_28_4, var_28_3 and iter_28_5.id == var_28_3.id, var_28_2[iter_28_5.id].output, var_28_2[iter_28_5.id].kill_count)

			var_28_15 = var_28_15 + var_28_2[iter_28_5.id].output
			var_1_10028 = nil
			var_1_10029 = nil

			if not var_28_18 then
				cloneTplTo = var_30
				var_1_10028 = var_30(arg_28_0._extpl, arg_28_0._expContainer)
				var_1_10029 = arg_28_0._skipExp
				table = var_30

				var_30.insert(var_28_13, var_1_10028)
			else
				cloneTplTo = var_30
				var_1_10028 = var_30(arg_28_0._extpl, arg_28_0._subExpContainer)
				var_1_10029 = arg_28_0._subSkipExp
				table = var_30

				var_30.insert(var_28_14, var_1_10028)
			end

			flushShipCard = var_30

			var_30(var_1_10028, iter_28_5)

			findTF = var_30

			local var_28_29 = var_30(var_1_10028, "content")

			findTF = var_31

			local var_28_30 = var_31(var_28_29, "exp")
			local var_28_31 = arg_28_0._expTFs

			var_28_31[#arg_28_0._expTFs + 1] = var_1_10028
			findTF = var_28_31

			local var_28_32 = var_28_31(var_1_10020, "result/stars")

			findTF = var_33

			local var_28_33 = var_33(var_1_10020, "result/stars/star_tpl")
			local var_28_34 = iter_28_5:getStar()
			local var_28_35 = iter_28_5:getMaxStar() - var_28_34

			findTF = var_1_10037
			var_1_10037 = var_1_10037(var_28_29, "heartsfly")
			findTF = var_38

			local var_28_36 = var_38(var_28_29, "heartsbroken")

			while 0 < var_28_38 do
				cloneTplTo = var_28_37

				local var_28_37 = var_28_37(var_28_33, var_28_32)

				SetActive = var_40

				var_40(var_28_37:Find("empty"), var_28_34 < var_28_38)

				SetActive = var_40

				var_40(var_28_37:Find("star"), var_28_38 <= var_28_34)

				local var_28_38 = var_28_38 - 1
			end

			setScrollText = var_28_37
			findTF = var_40

			var_28_37(var_40(var_28_29, "info/name_mask/name"), iter_28_5:GetColorName())

			if var_28_3 and iter_28_5.id == var_28_3.id then
				arg_28_0.mvpShipVO = iter_28_5
				SetActive = var_39
				findTF = var_40

				var_39(var_40(var_28_29, "mvp"), true)

				local var_28_39
				local var_28_40
				local var_28_41

				ShipWordHelper = var_42

				local var_28_42 = var_42.GetWordAndCV
				local var_28_43 = arg_28_0.mvpShipVO.skinId

				ShipWordHelper = var_1_10044

				local var_28_44, var_28_45

				var_28_44, var_28_45, var_1_10044 = var_28_42(var_28_43, var_1_10044.WORD_TYPE_MVP)

				local var_28_46 = var_1_10044
				local var_28_47 = var_28_45
				local var_28_48 = var_28_44

				if var_28_47 then
					arg_28_0._currentVoice = var_28_47
					pg = var_28_44

					local var_28_49 = var_28_44.CriMgr.GetInstance()

					var_42.PlaySoundEffect_V3(var_28_49, arg_28_0._currentVoice)
				end
			end

			if iter_28_5.id == var_28_2._flagShipID then
				arg_28_0.flagShipVO = iter_28_5
			end

			local var_28_50 = iter_28_5
			local var_28_51 = iter_28_5.getConfig(var_28_50, "rarity")

			findTF = var_28_50

			local var_28_52 = var_28_50(var_28_29, "dockyard/lv/Text")

			findTF = var_41

			local var_28_53 = var_41(var_28_29, "dockyard/lv_bg/levelUpLabel")

			findTF = var_42

			local var_28_54 = var_42(var_28_29, "dockyard/lv_bg/levelup")

			findTF = var_43

			local var_28_55 = var_43(var_28_30, "exp_text")

			findTF = var_1_10044

			local var_28_56 = var_1_10044(var_28_30, "exp_progress")
			local var_28_57 = var_1_10044.GetComponent

			typeof = var_1_10047
			Image = var_1_10048

			local var_28_58 = var_28_57(var_28_56, var_1_10047(var_1_10048))

			findTF = var_28_56

			local var_28_59 = var_28_56(var_28_30, "exp_buff_mask/exp_buff")

			setActive = var_1_10047

			var_1_10047(var_28_59, arg_28_0.expBuff)

			if arg_28_0.expBuff then
				setText = var_1_10047
				var_1_10048 = var_28_59
				var_1_10050 = arg_28_0.expBuff

				var_1_10047(var_1_10048, var_49.getConfig(var_1_10050, "name"))
			end

			function var_1_10047()
				SetActive = var_2_10000

				var_2_10000(var_28_30, true)

				SetActive = var_2_10000

				local var_30_0 = var_1_10037
				local var_30_1 = iter_28_5
				local var_30_2 = var_2.getIntimacy(var_30_1)
				local var_30_3 = var_1_10017

				var_2_10000(var_30_0, var_30_2 < var_3.getIntimacy(var_30_3))

				SetActive = var_2_10000

				local var_30_4 = var_28_36
				local var_30_5 = iter_28_5
				local var_30_6 = var_2.getIntimacy(var_30_5)
				local var_30_7 = var_1_10017

				var_2_10000(var_30_4, var_30_6 > var_3.getIntimacy(var_30_7))

				getExpByRarityFromLv1 = var_2_10000

				local var_30_8 = var_2_10000(var_28_51, iter_28_5.level)

				getExpByRarityFromLv1 = var_1

				local var_30_9 = var_1(var_28_51, var_1_10017.level)
				local var_30_10 = var_28_58
				local var_30_11 = iter_28_5

				var_30_10.fillAmount = var_3.getExp(var_30_11) / var_30_8

				local var_30_12

				if iter_28_5.level < var_1_10017.level then
					var_30_12 = 0

					for iter_30_0 = iter_28_5.level, var_1_10017.level - 1 do
						getExpByRarityFromLv1 = var_2_10007
						var_30_12 = var_30_12 + var_2_10007(var_28_51, iter_30_0)
					end

					local var_30_13 = arg_28_0
					local var_30_14 = var_3.PlayAnimation
					local var_30_15 = var_1_10028
					local var_30_16 = 0
					local var_30_17 = var_1_10017
					local var_30_18 = var_30_12 + var_7.getExp(var_30_17)
					local var_30_19 = iter_28_5

					var_30_14(var_30_13, var_30_15, var_30_16, var_30_18 - var_8.getExp(var_30_19), 1, 0, function(arg_31_0)
						setText = var_3_10001

						local var_31_0 = var_28_55
						local var_31_1 = "+"

						math = var_3_10004

						var_3_10001(var_31_0, var_31_1 .. var_3_10004.ceil(arg_31_0))

						return
					end)

					local function var_30_20(arg_32_0)
						SetActive = var_3_10001

						var_3_10001(var_28_53, true)

						SetActive = var_3_10001

						var_3_10001(var_28_54, true)

						local var_32_0 = var_28_53.localPosition

						LeanTween = var_2

						local var_32_1 = var_2.moveY

						rtf = var_3

						local var_32_2 = var_32_1(var_3(var_28_53), var_32_0.y + 30, 0.5)
						local var_32_3 = var_2.setOnComplete

						System = var_4

						var_32_3(var_32_2, var_4.Action(function()
							SetActive = var_4_10000

							var_4_10000(var_28_53, false)

							local var_33_0 = var_28_53

							var_33_0.localPosition = var_32_0
							pg = var_33_0

							local var_33_1 = var_33_0.CriMgr.GetInstance()
							local var_33_2 = var_0.PlaySoundEffect_V3

							SFX_BOAT_LEVEL_UP = var_2

							var_33_2(var_33_1, var_2)

							return
						end))

						if arg_32_0 <= var_1_10017.level then
							setText = var_2

							var_2(var_28_52, arg_32_0)
						end

						return
					end

					local var_30_21 = iter_28_5.level

					local function var_30_22(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
						LeanTween = var_3_10004

						local var_34_0 = var_3_10004.value

						go = var_3_10005

						local var_34_1 = var_34_0(var_3_10005(var_1_10028), arg_34_0, arg_34_1, arg_34_2)
						local var_34_2 = var_4.setOnUpdate

						System = var_6

						local var_34_3 = var_34_2(var_34_1, var_6.Action_float(function(arg_35_0)
							var_28_58.fillAmount = arg_35_0

							return
						end))
						local var_34_4 = var_4.setOnComplete

						System = var_6

						var_34_4(var_34_3, var_6.Action(function()
							var_30_21 = var_30_21 + 1

							if arg_34_3 then
								var_30_20(var_30_21)
							end

							if var_1_10017.level == var_30_21 then
								local var_36_0 = var_30_21
								local var_36_1 = var_1_10017

								if var_36_0 == var_1.getMaxLevel(var_36_1) then
									var_28_58.fillAmount = 1
								else
									local var_36_2 = var_0
									local var_36_3 = 0
									local var_36_4 = var_1_10017

									var_36_2(var_36_3, var_2.getExp(var_36_4) / var_30_9, 1, false)
								end
							elseif var_1_10017.level > var_30_21 then
								var_0(0, 1, 0.7, true)
							end

							return
						end))

						return
					end

					local var_30_23 = iter_28_5

					var_30_22(var_7.getExp(var_30_23) / var_30_8, 1, 0.7, true)
				else
					math = var_30_12

					local var_30_24 = var_30_12.ceil
					local var_30_25 = var_1_10017
					local var_30_26 = var_3.getExp(var_30_25)
					local var_30_27 = iter_28_5
					local var_30_28 = var_30_24(var_30_26 - var_4.getExp(var_30_27))

					setText = var_3

					var_3(var_28_55, "+" .. var_30_28)

					local var_30_29 = iter_28_5.level
					local var_30_30 = iter_28_5

					if var_30_29 == var_4.getMaxLevel(var_30_30) then
						var_28_58.fillAmount = 1

						return
					end

					local var_30_31 = arg_28_0
					local var_30_32 = var_3.PlayAnimation
					local var_30_33 = var_1_10028
					local var_30_34 = iter_28_5
					local var_30_35 = var_6.getExp(var_30_34) / var_30_8
					local var_30_36 = var_1_10017

					var_30_32(var_30_31, var_30_33, var_30_35, var_7.getExp(var_30_36) / var_30_8, 1, 0, function(arg_37_0)
						var_28_58.fillAmount = arg_37_0

						return
					end)
				end

				return
			end

			local var_28_60 = var_1_10028

			var_1_10048 = var_1_10028.GetComponent
			typeof = var_1_10050
			DftAniEvent = var_1_10051
			var_1_10050 = var_1_10048(var_28_60, var_1_10050(var_1_10051))

			var_1_10048.SetTriggerEvent(var_1_10050, function(arg_38_0)
				var_1_10047()

				return
			end)

			setActive = var_28_61

			var_28_61(var_1_10028, false)

			local var_28_61

			if var_28_18 then
				if not var_28_7 then
					arg_28_0._subFirstExpTF = var_1_10028
				else
					var_1_10050 = var_28_7
					var_28_61 = var_28_7.GetComponent
					typeof = var_1_10051
					DftAniEvent = var_1_10052
					var_1_10051 = var_28_61(var_1_10050, var_1_10051(var_1_10052))

					var_28_61.SetEndEvent(var_1_10051, function(arg_39_0)
						setActive = var_2_10001

						var_2_10001(var_1_10028, true)

						return
					end)
				end

				var_28_7 = var_1_10028
			else
				if var_28_6 then
					var_1_10050 = var_28_6
					var_28_61 = var_28_6.GetComponent
					typeof = var_1_10051
					DftAniEvent = var_1_10052
					var_1_10051 = var_28_61(var_1_10050, var_1_10051(var_1_10052))

					var_28_61.SetEndEvent(var_1_10051, function(arg_40_0)
						setActive = var_2_10001

						var_2_10001(var_1_10028, true)

						return
					end)
				else
					setActive = var_28_61

					var_28_61(var_1_10028, true)
				end

				var_28_6 = var_1_10028
			end

			var_1_10029[#var_1_10029 + 1] = function()
				local var_41_0 = var_1_10028
				local var_41_1 = var_0.GetComponent

				typeof = var_2_10002
				Animator = var_2_10003

				local var_41_2 = var_41_1(var_41_0, var_2_10002(var_2_10003))

				var_41_2.enabled = false
				SetActive = var_41_2

				var_41_2(var_1_10028, true)

				SetActive = var_41_2

				var_41_2(var_28_29, true)

				SetActive = var_41_2

				var_41_2(var_28_30, true)

				local var_41_3 = var_1_10028
				local var_41_4 = var_0.GetComponent

				typeof = var_2
				CanvasGroup = var_2_10003

				local var_41_5 = var_41_4(var_41_3, var_2(var_2_10003))

				var_41_5.alpha = 1
				LeanTween = var_41_5

				local var_41_6 = var_41_5.cancel

				go = var_1

				var_41_6(var_1(var_28_53))

				LeanTween = var_41_6

				local var_41_7 = var_41_6.cancel

				go = var_1

				var_41_7(var_1(var_1_10028))

				SetActive = var_41_7

				local var_41_8 = var_1_10037
				local var_41_9 = iter_28_5
				local var_41_10 = var_2.getIntimacy(var_41_9)
				local var_41_11 = var_1_10017

				var_41_7(var_41_8, var_41_10 < var_3.getIntimacy(var_41_11))

				SetActive = var_41_7

				local var_41_12 = var_28_36
				local var_41_13 = iter_28_5
				local var_41_14 = var_2.getIntimacy(var_41_13)
				local var_41_15 = var_1_10017

				var_41_7(var_41_12, var_41_14 > var_3.getIntimacy(var_41_15))

				local var_41_16 = var_28_29

				Vector3 = var_41_12
				var_41_16.localPosition = var_41_12(0, 0, 0)
				setText = var_41_16

				var_41_16(var_28_52, var_1_10017.level)

				local var_41_17 = iter_28_5.level
				local var_41_18 = iter_28_5
				local var_41_21

				if var_41_17 == var_1.getMaxLevel(var_41_18) then
					setText = var_41_17

					local var_41_19 = var_28_55
					local var_41_20 = "+"

					math = var_41_21
					var_41_21 = var_41_21.ceil
					var_2_10005 = var_1_10017

					local var_41_22 = var_4.getExp(var_2_10005)
					local var_41_23 = iter_28_5

					var_41_17(var_41_19, var_41_20 .. var_41_21(var_41_22 - var_2_10005.getExp(var_41_23)))

					var_41_17 = var_28_58
					var_41_17.fillAmount = 1
				else
					if iter_28_5.level < var_1_10017.level then
						var_41_17 = 0

						for iter_41_0 = iter_28_5.level, var_1_10017.level - 1 do
							getExpByRarityFromLv1 = var_2_10005
							var_41_17 = var_41_17 + var_2_10005(var_28_51, iter_41_0)
						end

						setText = var_1

						local var_41_24 = var_28_55

						var_41_21 = "+"

						local var_41_25 = var_1_10017
						local var_41_26 = var_41_17 + var_4.getExp(var_41_25)
						local var_41_27 = iter_28_5

						var_1(var_41_24, var_41_21 .. var_41_26 - var_5.getExp(var_41_27))
					else
						setText = var_41_17

						local var_41_28 = var_28_55
						local var_41_29 = "+"

						math = var_41_21

						local var_41_30 = var_41_21.ceil
						local var_41_31 = var_1_10017
						local var_41_32 = var_4.getExp(var_41_31)
						local var_41_33 = iter_28_5

						var_41_17(var_41_28, var_41_29 .. var_41_30(var_41_32 - var_5.getExp(var_41_33)))
					end

					var_41_17 = var_28_58

					local var_41_34 = var_1_10017
					local var_41_35 = var_1.getExp(var_41_34)

					getExpByRarityFromLv1 = var_41_34
					var_41_17.fillAmount = var_41_35 / var_41_34(var_28_51, var_1_10017.level)
				end

				SetActive = var_41_17

				var_41_17(var_28_53, false)

				return
			end
		end
	end

	if var_28_13[#var_28_13] then
		local var_28_62 = var_12
		local var_28_63 = var_12.GetComponent

		typeof = iter_28_4
		DftAniEvent = iter_28_5

		local var_28_64 = var_28_63(var_28_62, iter_28_4(iter_28_5))

		var_13.SetEndEvent(var_28_64, function(arg_42_0)
			arg_28_0._stateFlag = var_0_1.STATE_DISPLAYED

			if not arg_28_0._subFirstExpTF then
				local var_42_0 = arg_28_0

				var_1.skip(var_42_0)
			end

			return
		end)
	end

	if #var_28_14 > 0 then
		local var_28_65 = var_28_14[#var_28_14]
		local var_28_66 = var_13.GetComponent

		typeof = iter_28_5
		DftAniEvent = var_1_10017

		local var_28_67 = var_28_66(var_28_65, iter_28_5(var_1_10017))

		var_14.SetEndEvent(var_28_67, function(arg_43_0)
			arg_28_0._stateFlag = var_0_1.STATE_SUB_DISPLAYED

			local var_43_0 = arg_28_0

			var_1.skip(var_43_0)

			return
		end)
	end

	arg_28_0.subTitleTxt.text = arg_28_0.contextData.statistics.specificDamage

	return
end

function var_0_1.setAtkAnima(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5, arg_44_6, arg_44_7)
	local var_44_0 = arg_44_1:Find("result")
	local var_44_1 = arg_44_1:Find("result/atk")
	local var_44_2 = arg_44_1:Find("result/dmg_progress/progress_bar")
	local var_44_3 = arg_44_1:Find("result/killCount")
	local var_44_4 = var_44_0
	local var_44_5 = var_44_0.GetComponent

	typeof = var_1_10014
	DftAniEvent = var_1_10015

	local var_44_6 = var_44_5(var_44_4, var_1_10014(var_1_10015))

	setText = var_44_4

	var_44_4(var_44_1, 0)

	setText = var_44_4

	var_44_4(var_44_3, 0)

	local var_44_7 = var_44_2
	local var_44_8 = var_44_2.GetComponent

	typeof = var_15
	Image = var_1_10016
	var_44_8(var_44_7, var_15(var_1_10016)).fillAmount = 0

	if arg_44_5 then
		local var_44_9 = arg_44_1
		local var_44_10 = arg_44_1.Find(var_44_9, "result/mvpBG")

		setParent = var_44_9

		var_44_9(arg_44_0._mvpFX, var_44_10)

		local var_44_11 = arg_44_0._mvpFX

		Vector3 = var_15
		var_44_11.localPosition = var_15(-368.5, 0, 0)
		setActive = var_44_11

		var_44_11(var_44_10, true)

		setActive = var_44_11
		var_1_10016 = arg_44_1

		var_44_11(arg_44_1.Find(var_1_10016, "result/bg"), false)
	end

	var_44_6:SetEndEvent(function(arg_45_0)
		if arg_44_5 then
			setActive = var_1

			var_1(arg_44_0._mvpFX, true)
		end

		LeanTween = var_1

		local var_45_0 = var_1.value

		go = var_2_10002

		local var_45_1 = var_45_0(var_2_10002(var_44_0), 0, arg_44_3, arg_44_3)
		local var_45_2 = var_1.setOnUpdate

		System = var_3

		var_45_2(var_45_1, var_3.Action_float(function(arg_46_0)
			local var_46_0 = var_44_2
			local var_46_1 = var_1.GetComponent

			typeof = var_3_10003
			Image = var_3_10004
			var_46_1(var_46_0, var_3_10003(var_3_10004)).fillAmount = arg_46_0

			return
		end))

		if arg_44_4 ~= 0 then
			LeanTween = var_1

			local var_45_3 = var_1.value

			go = var_45_1

			local var_45_4 = var_45_3(var_45_1(var_44_0), 0, arg_44_6, arg_44_3)
			local var_45_5 = var_1.setOnUpdate

			System = var_3

			var_45_5(var_45_4, var_3.Action_float(function(arg_47_0)
				setText = var_3_10001

				local var_47_0 = var_44_1

				math = var_3_10003

				var_3_10001(var_47_0, var_3_10003.floor(arg_47_0))

				return
			end))

			LeanTween = var_45_5

			local var_45_6 = var_45_5.value

			go = var_45_4

			local var_45_7 = var_45_6(var_45_4(var_44_0), 0, arg_44_7, arg_44_3)
			local var_45_8 = var_1.setOnUpdate

			System = var_3

			var_45_8(var_45_7, var_3.Action_float(function(arg_48_0)
				setText = var_3_10001

				local var_48_0 = var_44_3

				math = var_3_10003

				var_3_10001(var_48_0, var_3_10003.floor(arg_48_0))

				return
			end))
		end

		return
	end)

	if arg_44_2.childCount > 1 then
		local var_44_12 = arg_44_2:GetChild(arg_44_2.childCount - 2)
		local var_44_13 = var_13.Find(var_44_12, "result")
		local var_44_14 = var_13.GetComponent

		typeof = var_1_10016
		DftAniEvent = var_1_10017

		local var_44_15 = var_44_14(var_44_13, var_1_10016(var_1_10017))

		var_14.SetTriggerEvent(var_44_15, function(arg_49_0)
			setActive = var_2_10001

			var_2_10001(var_44_0, true)

			return
		end)
	else
		setActive = var_13

		var_13(var_44_0, true)
	end

	local function var_44_16()
		local var_50_0 = var_44_2
		local var_50_1 = var_0.GetComponent

		typeof = var_2_10002
		Image = var_2_10003

		local var_50_2 = var_50_1(var_50_0, var_2_10002(var_2_10003))

		var_50_2.fillAmount = arg_44_3
		setText = var_50_2

		var_50_2(var_44_1, arg_44_6)

		setText = var_50_2

		var_50_2(var_44_3, arg_44_7)

		local var_50_3 = var_44_0

		Vector3 = var_1
		var_50_3.localPosition = var_1(280, 46, 0)

		local var_50_4 = var_44_0
		local var_50_5 = var_0.GetComponent

		typeof = var_2
		Animator = var_3

		local var_50_6 = var_50_5(var_50_4, var_2(var_3))

		var_50_6.enabled = false
		setActive = var_50_6

		var_50_6(var_44_0, true)

		setActive = var_50_6

		var_50_6(arg_44_0._mvpFX, true)

		return
	end

	local var_44_17

	if arg_44_0._atkFuncs[arg_44_2] == nil then
		var_44_17 = arg_44_0._atkFuncs
		var_44_17[arg_44_2] = {}
	end

	table = var_44_17

	var_44_17.insert(arg_44_0._atkFuncs[arg_44_2], var_44_16)

	return
end

function var_0_1.skipAtkAnima(arg_51_0, arg_51_1)
	if arg_51_0._atkFuncs[arg_51_1] then
		ipairs = var_2

		for iter_51_0, iter_51_1 in var_2(arg_51_0._atkFuncs[arg_51_1]) do
			iter_51_1()
		end

		arg_51_0._atkFuncs[arg_51_1] = nil
	end

	return
end

function var_0_1.showPainting(arg_52_0)
	local var_52_0
	local var_52_1
	local var_52_2

	SetActive = var_1_10004

	var_1_10004(arg_52_0._painting, true)

	local var_52_3

	if not arg_52_0.mvpShipVO then
		var_52_3 = arg_52_0.flagShipVO
	end

	arg_52_0.paintingName = var_52_3:getPainting()
	setPaintingPrefabAsync = var_5

	var_5(arg_52_0._painting, arg_52_0.paintingName, "jiesuan", function()
		findTF = var_2_10000

		local var_53_0 = var_2_10000(arg_52_0._painting, "fitter").childCount

		if 0 < var_53_0 then
			ShipExpressionHelper = var_53_0

			local var_53_1 = var_53_0.SetExpression

			findTF = var_1

			local var_53_2 = var_1(arg_52_0._painting, "fitter")

			var_53_1(var_1.GetChild(var_53_2, 0), arg_52_0.paintingName, "win_mvp")
		end

		return
	end)

	ShipWordHelper = var_5

	local var_52_4 = var_5.GetWordAndCV
	local var_52_5 = var_52_3.skinId

	ShipWordHelper = var_7

	local var_52_6, var_52_7, var_52_8 = var_52_4(var_52_5, var_7.WORD_TYPE_MVP)
	local var_52_9 = var_52_8
	local var_52_10 = var_52_7
	local var_52_11 = var_52_6

	SetActive = var_52_6

	var_52_6(arg_52_0._failPainting, false)

	setText = var_52_6

	local var_52_12 = arg_52_0._chat

	var_52_6(var_6.Find(var_52_12, "Text"), var_52_9)

	local var_52_13 = arg_52_0._chat
	local var_52_14 = var_5.Find(var_52_13, "Text")
	local var_52_15 = var_5.GetComponent

	typeof = var_7
	Text = var_8

	local var_52_16 = #var_52_15(var_52_14, var_7(var_8)).text

	CHAT_POP_STR_LEN = var_7

	if var_7 < var_52_16 then
		TextAnchor = var_52_16
		var_5.alignment = var_52_16.MiddleLeft
	else
		TextAnchor = var_52_16
		var_5.alignment = var_52_16.MiddleCenter
	end

	SetActive = var_52_16

	var_52_16(arg_52_0._chat, true)

	local var_52_17 = arg_52_0._chat.transform

	Vector3 = var_7
	var_52_17.localScale = var_7.New(0, 0, 0)
	LeanTween = var_52_17

	local var_52_18 = var_52_17.cancel

	go = var_7

	var_52_18(var_7(arg_52_0._painting))

	LeanTween = var_52_18

	local var_52_19 = var_52_18.moveX

	rtf = var_7

	local var_52_20 = var_52_19(var_7(arg_52_0._painting), 50, 0)
	local var_52_21 = var_6.setOnComplete

	System = var_8

	var_52_21(var_52_20, var_8.Action(function()
		LeanTween = var_2_10000

		local var_54_0 = var_2_10000.scale

		rtf = var_2_10001

		local var_54_1 = var_2_10001(arg_52_0._chat.gameObject)

		Vector3 = var_2

		local var_54_2 = var_54_0(var_54_1, var_2.New(1, 1, 1), 0)
		local var_54_3 = var_0.setEase

		LeanTweenType = var_2

		local var_54_4 = var_54_3(var_54_2, var_2.easeOutBack)
		local var_54_5 = var_0.setOnComplete

		System = var_2

		var_54_5(var_54_4, var_2.Action(function()
			local var_55_0 = arg_52_0._statisticsBtn

			var_0.GetComponent(var_55_0, "Button").enabled = true

			local var_55_1 = arg_52_0._confirmBtn

			var_0.GetComponent(var_55_1, "Button").enabled = true

			local var_55_2 = arg_52_0._atkBG

			var_0.GetComponent(var_55_2, "Button").enabled = true

			return
		end))

		return
	end))

	return
end

function var_0_1.hidePainting(arg_56_0)
	SetActive = var_1_10001

	var_1_10001(arg_56_0._chat, false)

	local var_56_0 = arg_56_0._chat.transform

	Vector3 = var_2
	var_56_0.localScale = var_2.New(0, 0, 0)
	LeanTween = var_56_0

	local var_56_1 = var_56_0.cancel

	go = var_2

	var_56_1(var_2(arg_56_0._painting))

	LeanTween = var_56_1

	local var_56_2 = var_56_1.scale

	rtf = var_2

	local var_56_3 = var_2(arg_56_0._chat.gameObject)

	Vector3 = var_3

	local var_56_4 = var_56_2(var_56_3, var_3.New(0, 0, 0), 0.1)
	local var_56_5 = var_1.setEase

	LeanTweenType = var_3

	var_56_5(var_56_4, var_3.easeOutBack)

	LeanTween = var_56_5

	local var_56_6 = var_56_5.moveX

	rtf = var_56_4

	local var_56_7 = var_56_6(var_56_4(arg_56_0._painting), 720, 0.2)
	local var_56_8 = var_1.setOnComplete

	System = var_3

	var_56_8(var_56_7, var_3.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_56_0._painting, false)

		return
	end))

	return
end

function var_0_1.skip(arg_58_0)
	local var_58_0 = {
		function(arg_59_0)
			local var_59_0 = arg_58_0

			var_1.showRewardInfo(var_59_0, arg_59_0)

			return
		end,
		function(arg_60_0)
			local var_60_0 = arg_58_0

			var_1.displayShips(var_60_0)

			local var_60_1 = arg_58_0

			var_1.showRightBottomPanel(var_60_1)

			return
		end
	}

	seriesAsync = var_2

	var_2(var_58_0)

	return
end

function var_0_1.playSubExEnter(arg_61_0)
	arg_61_0._stateFlag = var_0_1.STATE_SUB_DISPLAY

	if arg_61_0._subFirstExpTF then
		triggerToggle = var_1

		var_1(arg_61_0._subToggle, false)

		setActive = var_1

		var_1(arg_61_0._subFirstExpTF, true)
	else
		arg_61_0:showRightBottomPanel()
	end

	return
end

function var_0_1.showRightBottomPanel(arg_62_0)
	SetActive = var_1_10001

	var_1_10001(arg_62_0._skipBtn, false)

	SetActive = var_1_10001

	var_1_10001(arg_62_0._rightBottomPanel, true)

	SetActive = var_1_10001

	var_1_10001(arg_62_0._subToggle, arg_62_0._subFirstExpTF ~= nil)

	setActive = var_1_10001

	var_1_10001(arg_62_0._statisticsBtn, false)

	onButton = var_1_10001

	local var_62_0 = arg_62_0
	local var_62_1 = arg_62_0._confirmBtn

	local function var_62_2()
		local var_63_0 = arg_62_0
		local var_63_1 = var_0.emit

		BattleResultMediator = var_2_10002

		var_63_1(var_63_0, var_2_10002.ON_BACK_TO_LEVEL_SCENE)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_62_0, var_62_1, var_62_2, var_1_10005)

	arg_62_0._stateFlag = nil
	arg_62_0._subFirstExpTF = nil

	arg_62_0:showStatistics()

	return
end

function var_0_1.showStatistics(arg_64_0)
	setActive = var_1_10001

	var_1_10001(arg_64_0._leftPanel, false)
	arg_64_0:enabledStatisticsGizmos(false)

	SetActive = var_1

	var_1(arg_64_0._atkBG, true)

	local var_64_0 = arg_64_0._atkBG

	var_1.GetComponent(var_64_0, "Button").enabled = false

	local var_64_1 = arg_64_0._confirmBtn

	var_1.GetComponent(var_64_1, "Button").enabled = false

	local var_64_2 = arg_64_0._statisticsBtn

	var_1.GetComponent(var_64_2, "Button").enabled = false

	local var_64_3 = arg_64_0

	arg_64_0.showPainting(var_64_3)

	LeanTween = var_1

	local var_64_4 = var_1.moveX

	rtf = var_64_3

	local var_64_5 = var_64_4(var_64_3(arg_64_0._atkPanel), 0, 0.25)
	local var_64_6 = var_1.setOnComplete

	System = var_3

	var_64_6(var_64_5, var_3.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_64_0._atkContainer, true)

		return
	end))

	return
end

function var_0_1.closeStatistics(arg_66_0)
	setActive = var_1_10001

	var_1_10001(arg_66_0._leftPanel, true)
	arg_66_0:skipAtkAnima(arg_66_0._atkContainerNext)
	arg_66_0:skipAtkAnima(arg_66_0._atkContainer)
	arg_66_0:enabledStatisticsGizmos(true)
	arg_66_0:hidePainting()

	local var_66_0 = arg_66_0._atkBG
	local var_66_1 = var_1.GetComponent(var_66_0, "Button")

	var_66_1.enabled = false
	LeanTween = var_66_1

	var_66_1.cancel(arg_66_0._atkPanel.gameObject)

	LeanTween = var_1

	local var_66_2 = var_1.moveX

	rtf = var_2

	local var_66_3 = var_66_2(var_2(arg_66_0._atkPanel), -700, 0.2)
	local var_66_4 = var_1.setOnComplete

	System = var_3

	var_66_4(var_66_3, var_3.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_66_0._atkBG, false)

		return
	end))

	return
end

function var_0_1.enabledStatisticsGizmos(arg_68_0, arg_68_1)
	setActive = var_1_10002

	local var_68_0 = arg_68_0._main

	var_1_10002(var_3.Find(var_68_0, "gizmos/xuxian_down"), arg_68_1)

	setActive = var_1_10002

	local var_68_1 = arg_68_0._main

	var_1_10002(var_3.Find(var_68_1, "gizmos/xuxian_middle"), arg_68_1)

	return
end

function var_0_1.PlayAnimation(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4, arg_69_5, arg_69_6)
	LeanTween = var_1_10007

	local var_69_0 = var_1_10007.value(arg_69_1.gameObject, arg_69_2, arg_69_3, arg_69_4)
	local var_69_1 = var_7.setDelay(var_69_0, arg_69_5)
	local var_69_2 = var_7.setOnUpdate

	System = var_9

	var_69_2(var_69_1, var_9.Action_float(function(arg_70_0)
		arg_69_6(arg_70_0)

		return
	end))

	return
end

function var_0_1.onBackPressed(arg_71_0)
	if arg_71_0._stateFlag == var_0_1.STATE_RANK_ANIMA then
		-- block empty
	elseif arg_71_0._stateFlag == var_0_1.STATE_REPORT then
		triggerButton = var_1

		var_1(arg_71_0._bg)
	elseif arg_71_0._stateFlag == var_0_1.STATE_DISPLAY then
		triggerButton = var_1

		var_1(arg_71_0._skipBtn)
	else
		triggerButton = var_1

		var_1(arg_71_0._confirmBtn)
	end

	return
end

function var_0_1.willExit(arg_72_0)
	setActive = var_1_10001

	var_1_10001(arg_72_0.title, false)

	arg_72_0._atkFuncs = nil
	LeanTween = var_1

	local var_72_0 = var_1.cancel

	go = var_2

	var_72_0(var_2(arg_72_0._tf))

	if arg_72_0._atkBG.gameObject.activeSelf then
		pg = var_1

		local var_72_1 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_72_1, arg_72_0._blurConatiner, arg_72_0._tf)
	end

	if arg_72_0.paintingName then
		retPaintingPrefab = var_1

		var_1(arg_72_0._painting, arg_72_0.paintingName)
	end

	if arg_72_0._rightTimer then
		local var_72_2 = arg_72_0._rightTimer

		var_1.Stop(var_72_2)
	end

	pg = var_1

	local var_72_3 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_72_3, arg_72_0._tf)

	if arg_72_0._currentVoice then
		pg = var_1

		local var_72_4 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_72_4, arg_72_0._currentVoice)
	end

	arg_72_0._currentVoice = nil
	pg = var_1

	local var_72_5 = var_1.CameraFixMgr.GetInstance()

	var_1.disconnect(var_72_5, arg_72_0.camEventId)

	return
end

return var_0_1
