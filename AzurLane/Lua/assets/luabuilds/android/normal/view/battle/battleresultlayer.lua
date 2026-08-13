class = var_0_10000

local var_0_0 = "BattleResultLayer"

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

function var_0_1.getGroupName(arg_2_0)
	return "BattleScene"
end

function var_0_1.setRivalVO(arg_3_0, arg_3_1)
	arg_3_0.rivalVO = arg_3_1

	return
end

function var_0_1.setRank(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.player = arg_4_1
	arg_4_0.season = arg_4_2
	setText = var_1_10003

	var_1_10003(arg_4_0._playerName, "<color=#FFFFFF>" .. arg_4_0.player.name .. "</color><size=32> / C O M M A N D E R</size>")

	SeasonInfo = var_1_10003

	local var_4_0 = var_1_10003.getMilitaryRank(arg_4_2.score, arg_4_2.rank)

	SeasonInfo = var_4

	local var_4_1, var_4_2 = var_4.getNextMilitaryRank(arg_4_2.score, arg_4_2.rank)

	setText = var_6

	var_6(arg_4_0._playerLv, var_4_0.name)

	setText = var_6

	local var_4_3 = arg_4_0._playerExpLabel

	i18n = var_8

	var_6(var_4_3, var_8("word_rankScore"))

	local var_4_4 = arg_4_0._playerExpProgress
	local var_4_5 = var_6.GetComponent

	typeof = var_8
	Image = var_9

	local var_4_6 = var_4_5(var_4_4, var_8(var_9))

	var_4_6.fillAmount = arg_4_2.score / var_4_2
	setText = var_4_6

	var_4_6(arg_4_0._playerBonusExp, "+0")

	arg_4_0.calcPlayerProgress = arg_4_0.calcPlayerRank

	return
end

function var_0_1.setShips(arg_5_0, arg_5_1)
	arg_5_0.shipVOs = arg_5_1

	return
end

function var_0_1.setPlayer(arg_6_0, arg_6_1)
	arg_6_0.player = arg_6_1
	setText = var_1_10002

	var_1_10002(arg_6_0._playerName, "<color=#FFFFFF>" .. arg_6_0.player.name .. "</color><size=32> / C O M M A N D E R</size>")

	setText = var_1_10002

	var_1_10002(arg_6_0._playerLv, "Lv." .. arg_6_0.player.level)

	getConfigFromLevel1 = var_1_10002
	pg = var_3

	local var_6_0 = var_1_10002(var_3.user_level, arg_6_0.player.level)
	local var_6_1 = arg_6_0._playerExpProgress
	local var_6_2 = var_3.GetComponent

	typeof = var_5
	Image = var_6
	var_6_2(var_6_1, var_5(var_6)).fillAmount = arg_6_0.player.exp / var_6_0.exp_interval

	local var_6_3 = arg_6_0.player.level

	pg = var_4

	local var_6_4 = var_4.user_level

	pg = var_5

	if var_6_3 == var_6_4[#var_5.user_level].level then
		local var_6_5 = arg_6_0._playerExpProgress

		var_6_3 = var_6_3.GetComponent
		typeof = var_5
		Image = var_6
		var_6_3 = var_6_3(var_6_5, var_5(var_6))
		var_6_3.fillAmount = 1
	end

	setText = var_6_3

	var_6_3(arg_6_0._playerBonusExp, "+0")

	arg_6_0.calcPlayerProgress = arg_6_0.calcPlayerExp

	local var_6_6 = arg_6_0.contextData.extraBuffList

	ipairs = var_4

	for iter_6_0, iter_6_1 in var_4(var_6_6) do
		pg = var_1_10009

		local var_6_7 = var_1_10009.benefit_buff_template[iter_6_1].benefit_type

		Chapter = var_1_10011

		if var_6_7 == var_1_10011.OPERATION_BUFF_TYPE_EXP then
			setActive = var_1_10011

			var_1_10011(arg_6_0._playerExpExtra, true)
		end
	end

	return
end

function var_0_1.setExpBuff(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.expBuff = arg_7_1
	arg_7_0.shipBuff = arg_7_2

	return
end

function var_0_1.init(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0._grade = var_1.Find(var_8_0, "grade")

	local var_8_1 = arg_8_0._grade

	arg_8_0._levelText = var_1.Find(var_8_1, "chapterName/Text22")

	local var_8_2 = arg_8_0._tf

	arg_8_0.clearFX = var_1.Find(var_8_2, "clear")

	local var_8_3 = arg_8_0._tf

	arg_8_0._main = var_1.Find(var_8_3, "main")

	local var_8_4 = arg_8_0._tf

	arg_8_0._blurConatiner = var_1.Find(var_8_4, "blur_container")

	local var_8_5 = arg_8_0._tf

	arg_8_0._bg = var_1.Find(var_8_5, "main/jiesuanbeijing")

	local var_8_6 = arg_8_0._blurConatiner

	arg_8_0._painting = var_1.Find(var_8_6, "painting")

	local var_8_7 = arg_8_0._painting

	arg_8_0._failPainting = var_1.Find(var_8_7, "fail")

	local var_8_8 = arg_8_0._painting

	arg_8_0._chat = var_1.Find(var_8_8, "chat")

	local var_8_9 = arg_8_0._main

	arg_8_0._leftPanel = var_1.Find(var_8_9, "leftPanel")

	local var_8_10 = arg_8_0._leftPanel

	arg_8_0._expResult = var_1.Find(var_8_10, "expResult")

	local var_8_11 = arg_8_0._expResult

	arg_8_0._expContainer = var_1.Find(var_8_11, "expContainer")
	arg_8_0._extpl = arg_8_0:getTpl("ShipCardTpl", arg_8_0._expContainer)

	local var_8_12 = arg_8_0._leftPanel

	arg_8_0._playerExp = var_1.Find(var_8_12, "playerExp")

	local var_8_13 = arg_8_0._playerExp

	arg_8_0._playerName = var_1.Find(var_8_13, "name_text")

	local var_8_14 = arg_8_0._playerExp

	arg_8_0._playerLv = var_1.Find(var_8_14, "lv_text")

	local var_8_15 = arg_8_0._playerExp

	arg_8_0._playerExpLabel = var_1.Find(var_8_15, "exp_label")

	local var_8_16 = arg_8_0._playerExp

	arg_8_0._playerExpProgress = var_1.Find(var_8_16, "exp_progress")

	local var_8_17 = arg_8_0._playerExp

	arg_8_0._playerBonusExp = var_1.Find(var_8_17, "exp_text")

	local var_8_18 = arg_8_0._playerExp

	arg_8_0._playerExpExtra = var_1.Find(var_8_18, "operation_bonus")

	local var_8_19 = arg_8_0._blurConatiner

	arg_8_0._atkBG = var_1.Find(var_8_19, "atkPanel")

	local var_8_20 = arg_8_0._atkBG

	arg_8_0._atkPanel = var_1.Find(var_8_20, "atkResult")

	local var_8_21 = arg_8_0._atkBG

	arg_8_0._atkResult = var_1.Find(var_8_21, "atkResult/result")

	local var_8_22 = arg_8_0._atkResult

	arg_8_0._atkContainer = var_1.Find(var_8_22, "Grid")

	local var_8_23 = arg_8_0._atkResult

	arg_8_0._atkContainerNext = var_1.Find(var_8_23, "Grid_next")

	local var_8_24 = arg_8_0._atkPanel

	arg_8_0._atkToggle = var_1.Find(var_8_24, "switchAtk")
	arg_8_0._atkTpl = arg_8_0:getTpl("resulttpl", arg_8_0._atkResult)

	local var_8_25 = arg_8_0._atkPanel

	arg_8_0._mvpFX = var_1.Find(var_8_25, "mvpFX")

	local var_8_26 = arg_8_0._blurConatiner

	arg_8_0._rightBottomPanel = var_1.Find(var_8_26, "rightBottomPanel")

	local var_8_27 = arg_8_0._rightBottomPanel

	arg_8_0._confirmBtn = var_1.Find(var_8_27, "confirmBtn")
	setText = var_1

	local var_8_28 = arg_8_0._confirmBtn
	local var_8_29 = var_2.Find(var_8_28, "Text")

	i18n = var_8_28

	var_1(var_8_29, var_8_28("text_confirm"))

	local var_8_30 = arg_8_0._rightBottomPanel

	arg_8_0._statisticsBtn = var_1.Find(var_8_30, "statisticsBtn")

	local var_8_31 = arg_8_0._leftPanel

	arg_8_0._subExpResult = var_1.Find(var_8_31, "subExpResult")

	local var_8_32 = arg_8_0._subExpResult

	arg_8_0._subExpContainer = var_1.Find(var_8_32, "expContainer")

	local var_8_33 = arg_8_0._leftPanel

	arg_8_0._subToggle = var_1.Find(var_8_33, "switchFleet")
	setActive = var_1

	var_1(arg_8_0._subToggle, false)

	local var_8_34 = arg_8_0._tf

	arg_8_0._skipBtn = var_1.Find(var_8_34, "skipLayer")
	pg = var_1
	arg_8_0.UIMain = var_1.UIMgr.GetInstance().UIMain
	pg = var_1
	arg_8_0.overlay = var_1.UIMgr.GetInstance().OverlayMain

	local var_8_35 = arg_8_0._tf

	arg_8_0._conditions = var_1.Find(var_8_35, "main/conditions")

	local var_8_36 = arg_8_0._conditions

	arg_8_0._conditionContainer = var_1.Find(var_8_36, "bg16/list")

	local var_8_37 = arg_8_0._conditions

	arg_8_0._conditionTpl = var_1.Find(var_8_37, "bg16/conditionTpl")

	local var_8_38 = arg_8_0._conditions

	arg_8_0._conditionSubTpl = var_1.Find(var_8_38, "bg16/conditionSubTpl")

	local var_8_39 = arg_8_0._conditions

	arg_8_0._conditionContributeTpl = var_1.Find(var_8_39, "bg16/conditionContributeTpl")

	local var_8_40 = arg_8_0._conditions

	arg_8_0._conditionBGNormal = var_1.Find(var_8_40, "bg16/bg_normal")

	local var_8_41 = arg_8_0._conditions

	arg_8_0._conditionBGContribute = var_1.Find(var_8_41, "bg16/bg_contribute")

	local var_8_42 = arg_8_0._leftPanel

	arg_8_0._cmdExp = var_1.Find(var_8_42, "commanderExp")

	local var_8_43 = arg_8_0._cmdExp

	arg_8_0._cmdContainer = var_1.Find(var_8_43, "commander_container")

	local var_8_44 = arg_8_0._cmdExp

	arg_8_0._cmdTpl = var_1.Find(var_8_44, "commander_tpl")

	arg_8_0:setGradeLabel()

	SetActive = var_1

	var_1(arg_8_0._levelText, false)

	arg_8_0._delayLeanList = {}
	GetComponent = var_1

	local var_8_45 = arg_8_0._tf

	typeof = var_3
	AspectRatioFitter = var_4
	arg_8_0._ratioFitter = var_1(var_8_45, var_3(var_4))
	arg_8_0._ratioFitter.enabled = true

	local var_8_46 = arg_8_0._ratioFitter

	pg = var_2
	var_8_46.aspectRatio = var_2.CameraFixMgr.GetInstance().targetRatio
	pg = var_8_46

	local var_8_47 = var_8_46.CameraFixMgr.GetInstance()
	local var_8_48 = var_1.bind

	pg = var_3
	arg_8_0.camEventId = var_8_48(var_8_47, var_3.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_9_0, arg_9_1)
		arg_8_0._ratioFitter.aspectRatio = arg_9_1

		return
	end)

	return
end

function var_0_1.customsLang(arg_10_0)
	setText = var_1_10001
	findTF = var_1_10002

	local var_10_0 = var_1_10002(arg_10_0._confirmBtn, "Text")

	i18n = var_3

	var_1_10001(var_10_0, var_3("battle_result_confirm"))

	setText = var_1_10001
	findTF = var_10_0

	local var_10_1 = var_10_0(arg_10_0._bg, "jieuan01/tips/dianjijixu/bg20")

	i18n = var_3

	var_1_10001(var_10_1, var_3("battle_result_continue"))

	setText = var_1_10001
	findTF = var_10_1

	local var_10_2 = var_10_1(arg_10_0._atkTpl, "result/dmg_count_label")

	i18n = var_3

	var_1_10001(var_10_2, var_3("battle_result_dmg"))

	setText = var_1_10001
	findTF = var_10_2

	local var_10_3 = var_10_2(arg_10_0._atkTpl, "result/kill_count_label")

	i18n = var_3

	var_1_10001(var_10_3, var_3("battle_result_kill_count"))

	setText = var_1_10001
	findTF = var_10_3

	local var_10_4 = var_10_3(arg_10_0._subToggle, "on")

	i18n = var_3

	var_1_10001(var_10_4, var_3("battle_result_toggle_on"))

	setText = var_1_10001
	findTF = var_10_4

	local var_10_5 = var_10_4(arg_10_0._subToggle, "off")

	i18n = var_3

	var_1_10001(var_10_5, var_3("battle_result_toggle_off"))

	setText = var_1_10001
	findTF = var_10_5

	local var_10_6 = var_10_5(arg_10_0._conditions, "bg17")

	i18n = var_3

	var_1_10001(var_10_6, var_3("battle_result_targets"))

	return
end

function var_0_1.setGradeLabel(arg_11_0)
	local var_11_0 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_11_1 = arg_11_0._tf
	local var_11_2 = var_2.Find(var_11_1, "grade/Xyz/bg13")
	local var_11_3 = arg_11_0._tf
	local var_11_4 = var_3.Find(var_11_3, "grade/Xyz/bg14")
	local var_11_5
	local var_11_6
	local var_11_7
	local var_11_8 = arg_11_0.contextData.score
	local var_11_9
	local var_11_10 = var_11_8 > 0

	setActive = var_1_10010

	local var_11_11 = arg_11_0._bg

	var_1_10010(var_11.Find(var_11_11, "jieuan01/BG/bg_victory"), var_11_10)

	setActive = var_1_10010

	local var_11_12 = arg_11_0._bg

	var_1_10010(var_11.Find(var_11_12, "jieuan01/BG/bg_fail"), not var_11_10)

	if var_11_10 then
		var_11_7 = var_11_0[var_11_8 + 1]
		var_11_5 = "battlescore/battle_score_" .. var_11_7 .. "/letter_" .. var_11_7
		var_11_6 = "battlescore/battle_score_" .. var_11_7 .. "/label_" .. var_11_7
	else
		var_1_10010 = arg_11_0.contextData.statistics._scoreMark
		ys = var_11

		if var_1_10010 == var_11.Battle.BattleConst.DEAD_FLAG then
			var_11_7 = var_11_0[2]
			var_11_9 = "flag_destroy"
		else
			var_11_7 = var_11_0[1]
		end

		var_11_5 = "battlescore/battle_score_" .. var_11_7 .. "/letter_" .. var_11_7
		var_11_6 = "battlescore/battle_score_" .. var_11_7 .. "/label_" .. (var_11_9 or var_11_7)
	end

	LoadImageSpriteAsync = var_1_10010

	var_1_10010(var_11_5, var_11_2, false)

	LoadImageSpriteAsync = var_1_10010

	var_1_10010(var_11_6, var_11_4, false)

	local var_11_13 = arg_11_0.contextData.system

	SYSTEM_SCENARIO = var_11

	if var_11_13 ~= var_11 then
		SYSTEM_ROUTINE = var_11

		if var_11_13 ~= var_11 then
			SYSTEM_SUB_ROUTINE = var_11

			if var_11_13 ~= var_11 then
				SYSTEM_DUEL = var_11

				if var_11_13 == var_11 then
					if var_11_7 == var_11_0[1] or var_11_7 == var_11_0[2] then
						arg_11_0.failTag = true
					end
				end

				return
			end
		end
	end
end

function var_0_1.displayerCommanders(arg_12_0, arg_12_1)
	local var_12_0

	if not arg_12_0.contextData.commanderExps then
		var_12_0 = {}
	end

	arg_12_0.commanderExps = var_12_0
	getProxy = var_12_0
	CommanderProxy = var_1_10003

	local var_12_1 = var_12_0(var_1_10003)

	removeAllChildren = var_1_10003

	var_1_10003(arg_12_0._cmdContainer)

	local var_12_2

	if arg_12_1 then
		var_12_2 = arg_12_0.commanderExps.submarineCMD or {}
	else
		var_12_2 = arg_12_0.commanderExps.surfaceCMD or {}
	end

	setActive = var_4

	var_4(arg_12_0._cmdExp, true)

	ipairs = var_4

	for iter_12_0, iter_12_1 in var_4(var_12_2) do
		local var_12_3 = var_12_1
		local var_12_4 = var_12_1.getCommanderById(var_12_3, iter_12_1.commander_id)

		cloneTplTo = var_12_3

		local var_12_5 = var_12_3(arg_12_0._cmdTpl, arg_12_0._cmdContainer)

		GetImageSpriteFromAtlasAsync = var_11

		local var_12_6 = "commandericon/" .. var_12_4:getPainting()
		local var_12_7 = ""
		local var_12_8 = var_12_5

		var_11(var_12_6, var_12_7, var_12_5.Find(var_12_8, "icon/mask/pic"))

		setText = var_11

		var_11(var_12_5:Find("exp/name_text"), var_12_4:getName())

		setText = var_11

		var_11(var_12_5:Find("exp/lv_text"), "Lv." .. var_12_4.level)

		setText = var_11

		var_11(var_12_5:Find("exp/exp_text"), "+" .. iter_12_1.exp)

		local var_12_9
		local var_12_10 = var_12_4:isMaxLevel() and 1 or iter_12_1.curExp / var_12_4:getNextLevelExp()
		local var_12_11 = var_12_5:Find("exp/exp_progress")
		local var_12_12 = var_12.GetComponent

		typeof = var_14
		Image = var_12_8
		var_12_12(var_12_11, var_14(var_12_8)).fillAmount = var_12_10
	end

	return
end

function var_0_1.didEnter(arg_13_0)
	arg_13_0:setStageName()
	arg_13_0:customsLang()

	local var_13_0 = {}

	arg_13_0._subShipResultCardList = {}
	arg_13_0._shipResultCardList = var_13_0
	rtf = var_13_0
	arg_13_0._gradeUpperLeftPos = var_13_0(arg_13_0._grade).localPosition
	Vector3 = var_2
	var_1.localPosition = var_2(0, 25, 0)

	local var_13_1 = arg_13_0

	arg_13_0.BlurPanel(var_13_1, arg_13_0._tf, {
		staticBlur = true,
		lockGlobalBlur = true
	})

	local var_13_2 = arg_13_0.contextData.system

	SYSTEM_BOSS_RUSH = var_13_1

	if var_13_2 ~= var_13_1 then
		local var_13_3 = arg_13_0.contextData.system

		SYSTEM_BOSS_RUSH_EX = var_13_1

		if var_13_3 ~= var_13_1 then
			local var_13_4 = arg_13_0.contextData.system

			SYSTEM_BOSS_RUSH_COLLABRATE = var_13_1

			if var_13_4 ~= var_13_1 then
				local var_13_5 = arg_13_0.contextData.system

				SYSTEM_ACT_BOSS = var_13_1

				if var_13_5 ~= var_13_1 then
					local var_13_6 = arg_13_0.contextData.system

					SYSTEM_BOSS_SINGLE = var_13_1

					if var_13_6 ~= var_13_1 then
						local var_13_7 = arg_13_0.contextData.system

						SYSTEM_BOSS_SINGLE_VARIABLE = var_13_1

						if var_13_7 ~= var_13_1 then
							ys = var_13_7

							var_13_7.Battle.BattleCameraUtil.GetInstance().ActiveMainCamera(false)
						end
					end
				end
			end
		end
	end

	local var_13_8 = arg_13_0._grade.transform

	Vector3 = var_13_1
	var_13_8.localScale = var_13_1(1.5, 1.5, 0)
	LeanTween = var_13_8

	local var_13_9 = var_13_8.scale
	local var_13_10 = arg_13_0._grade

	Vector3 = var_4

	local var_13_11 = var_13_9(var_13_10, var_4(0.88, 0.88, 1), var_0_1.DURATION_WIN_SCALE)
	local var_13_12 = var_2.setOnComplete

	System = var_4

	var_13_12(var_13_11, var_4.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_13_0._levelText, true)

		local var_14_0 = arg_13_0

		var_0.rankAnimaFinish(var_14_0)

		return
	end))

	local var_13_13 = arg_13_0._tf
	local var_13_14 = var_2.GetComponent

	typeof = var_4
	Image = var_5

	local var_13_15 = var_13_14(var_13_13, var_4(var_5))

	Color = var_13_13
	var_13_15.color = var_13_13.New(0, 0, 0, 0.5)
	SetActive = var_13_15

	var_13_15(arg_13_0._atkBG, false)

	onToggle = var_13_15

	local var_13_16 = arg_13_0
	local var_13_17 = arg_13_0._subToggle

	local function var_13_18(arg_15_0)
		SetActive = var_2_10001

		var_2_10001(arg_13_0._subExpResult, not arg_15_0)

		SetActive = var_2_10001

		var_2_10001(arg_13_0._expResult, arg_15_0)

		setActive = var_2_10001

		local var_15_0 = arg_13_0._subToggle

		var_2_10001(var_2.Find(var_15_0, "off"), not arg_15_0)

		local var_15_1 = arg_13_0

		var_1.displayerCommanders(var_15_1, not arg_15_0)

		return
	end

	SFX_PANEL = var_6

	var_13_15(var_13_16, var_13_17, var_13_18, var_6)

	arg_13_0._stateFlag = var_0_1.STATE_RANK_ANIMA
	onButton = var_2

	local var_13_19 = arg_13_0
	local var_13_20 = arg_13_0._skipBtn

	local function var_13_21()
		local var_16_0 = arg_13_0

		var_0.skip(var_16_0)

		return
	end

	SFX_CONFIRM = var_6

	var_2(var_13_19, var_13_20, var_13_21, var_6)

	return
end

function var_0_1.setStageName(arg_17_0)
	if arg_17_0.contextData.system then
		local var_17_0 = arg_17_0.contextData.system

		SYSTEM_DUEL = var_1_10002

		if var_17_0 == var_1_10002 then
			if arg_17_0.rivalVO then
				setText = var_1

				var_1(arg_17_0._levelText, arg_17_0.rivalVO.name)
			else
				setText = var_1

				var_1(arg_17_0._levelText, "")
			end

			goto label_17_0
		end
	end

	do
		local var_17_1 = arg_17_0.contextData.stageId

		pg = var_1_10002

		local var_17_2 = var_1_10002.expedition_data_template[var_17_1]

		setText = var_1_10003

		var_1_10003(arg_17_0._levelText, var_17_2.name)
	end

	::label_17_0::

	return
end

function var_0_1.rankAnimaFinish(arg_18_0)
	local var_18_0 = arg_18_0._tf
	local var_18_1 = var_1.Find(var_18_0, "main/conditions")

	SetActive = var_18_0

	var_18_0(var_18_1, true)

	local var_18_2 = arg_18_0.contextData.stageId

	pg = var_3

	local var_18_3 = var_3.expedition_data_template[var_18_2]

	;(function(arg_19_0)
		type = var_2_10001

		if var_2_10001(arg_19_0) == "table" then
			i18n = var_1

			local var_19_0 = var_1(var_0_1.ObjectiveList[arg_19_0[1]], arg_19_0[2])
			local var_19_1 = arg_18_0

			var_2.setCondition(var_19_1, var_19_0, var_0_1.objectiveCheck(arg_19_0[1], arg_18_0.contextData))
		end

		return
	end)(var_18_3.objective_1)
	var_4(var_18_3.objective_2)
	var_4(var_18_3.objective_3)

	LeanTween = var_5

	local var_18_4 = var_5.delayedCall
	local var_18_5 = 1

	System = var_1_10007

	local var_18_6 = var_18_4(var_18_5, var_1_10007.Action(function()
		local var_20_0 = arg_18_0

		var_20_0._stateFlag = var_0_1.STATE_REPORTED
		SetActive = var_20_0

		local var_20_1 = arg_18_0._bg

		var_20_0(var_1.Find(var_20_1, "jieuan01/tips"), true)

		if arg_18_0.skipFlag then
			local var_20_2 = arg_18_0

			var_0.skip(var_20_2)
		end

		return
	end))

	table = var_18_5

	var_18_5.insert(arg_18_0._delayLeanList, var_18_6.id)

	arg_18_0._stateFlag = var_0_1.STATE_REPORT

	return
end

function var_0_1.objectiveCheck(arg_21_0, arg_21_1)
	if arg_21_0 == 1 or arg_21_0 == 4 or arg_21_0 == 8 then
		return arg_21_1.score > 1
	elseif arg_21_0 == 2 or arg_21_0 == 3 then
		return not arg_21_1.statistics._deadUnit
	elseif arg_21_0 == 6 then
		return arg_21_1.statistics._boss_destruct < 1
	elseif arg_21_0 == 5 then
		return not arg_21_1.statistics._badTime
	elseif arg_21_0 == 7 then
		return true
	end

	return
end

function var_0_1.setCondition(arg_22_0, arg_22_1, arg_22_2)
	cloneTplTo = var_1_10003

	local var_22_0 = var_1_10003(arg_22_0._conditionTpl, arg_22_0._conditionContainer)

	setActive = var_4

	var_4(var_22_0, false)

	local var_22_1
	local var_22_2 = var_22_0:Find("text")
	local var_22_3 = var_5.GetComponent

	typeof = var_7
	Text = var_1_10008

	local var_22_4 = var_22_3(var_22_2, var_7(var_1_10008))

	if arg_22_2 == nil then
		var_22_1 = "resources/condition_check"
		setColorStr = var_22_2
		var_22_4.text = var_22_2(arg_22_1, "#FFFFFFFF")
	elseif arg_22_2 == true then
		var_22_1 = "resources/condition_done"
		setColorStr = var_22_2
		var_22_4.text = var_22_2(arg_22_1, "#FFFFFFFF")
	else
		var_22_1 = "resources/condition_fail"
		setColorStr = var_22_2
		var_22_4.text = var_22_2(arg_22_1, "#FFFFFF80")
	end

	arg_22_0:setSpriteTo(var_22_1, var_22_0:Find("checkBox"), true)

	local var_22_5 = arg_22_0._conditionContainer.childCount - 1
	local var_22_6

	if 0 < var_22_5 then
		LeanTween = var_22_6
		var_22_6 = var_22_6.delayedCall

		local var_22_7 = var_0_1.CONDITIONS_FREQUENCE * var_22_5

		System = var_9
		var_22_6 = var_22_6(var_22_7, var_9.Action(function()
			setActive = var_2_10000

			var_2_10000(var_22_0, true)

			return
		end))
		table = var_22_7

		var_22_7.insert(arg_22_0._delayLeanList, var_22_6.id)
	else
		setActive = var_22_6

		var_22_6(var_22_0, true)
	end

	return
end

function var_0_1.showRewardInfo(arg_24_0)
	arg_24_0._stateFlag = var_0_1.STATE_REWARD

	local var_24_0 = arg_24_0.contextData.system

	SYSTEM_BOSS_RUSH = var_1_10002

	if var_24_0 ~= var_1_10002 then
		var_24_0 = arg_24_0.contextData.system
		SYSTEM_BOSS_RUSH_EX = var_1_10002

		if var_24_0 ~= var_1_10002 then
			var_24_0 = arg_24_0.contextData.system
			SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10002

			if var_24_0 == var_1_10002 then
				local var_24_1 = arg_24_0

				var_24_0 = arg_24_0.emit
				BattleResultMediator = var_1_10003

				var_24_0(var_24_1, var_1_10003.ON_BACK_TO_LEVEL_SCENE)

				return
			end

			SetActive = var_24_0

			local var_24_2 = arg_24_0._bg

			var_24_0(var_2.Find(var_24_2, "jieuan01/tips"), false)

			setParent = var_24_0

			var_24_0(arg_24_0._tf, arg_24_0.UIMain)

			local var_24_3

			local function var_24_4()
				if var_24_3 then
					coroutine = var_0

					if var_0.status(var_24_3) == "suspended" then
						coroutine = var_0

						local var_25_0, var_25_1 = var_0.resume(var_24_3)

						assert = var_2_10002

						var_2_10002(var_25_0, var_25_1)
					end
				end

				return
			end

			coroutine = var_3
			var_24_3 = var_3.create(function()
				local var_26_0 = arg_24_0.contextData.drops

				getProxy = var_2_10001
				ActivityProxy = var_2_10002

				local var_26_1 = var_2_10001(var_2_10002)
				local var_26_2 = var_1.getActivityById

				ActivityConst = var_2_10004

				local var_26_3

				if var_26_2(var_26_1, var_2_10004.UTAWARERU_ACTIVITY_PT_ID) then
					var_26_3 = var_2

					if not var_2.isEnd(var_26_3) then
						var_26_3 = var_2

						local var_26_4 = var_2.getConfig(var_26_3, "config_client").pt_id

						_ = var_26_3
						var_26_3 = var_26_3.detect

						local var_26_5 = var_1
						local var_26_6 = var_1.getActivitiesByType

						ActivityConst = var_2_10007

						local var_26_7 = var_26_3(var_26_6(var_26_5, var_2_10007.ACTIVITY_TYPE_PT_RANK), function(arg_27_0)
							return arg_27_0:getConfig("config_id") == var_26_4
						end)

						var_26_3 = var_26_3.getData1(var_26_7)

						if 1500 <= var_26_3 then
							var_26_3 = var_26_3 - 1500
							_ = var_5

							local var_26_8 = var_5.detect(var_26_0, function(arg_28_0)
								local var_28_0 = arg_28_0.type

								DROP_TYPE_RESOURCE = var_3_10002

								return var_28_0 == var_3_10002 and arg_28_0.id == var_26_4
							end)

							_ = var_6
							var_26_0 = var_6.filter(var_26_0, function(arg_29_0)
								local var_29_0 = arg_29_0.type

								DROP_TYPE_RESOURCE = var_3_10002

								return var_29_0 ~= var_3_10002 or arg_29_0.id ~= var_26_4
							end)

							if var_26_8 and var_26_3 < var_26_8.count then
								var_26_8.count = var_26_8.count - var_26_3
								table = var_6

								var_6.insert(var_26_0, var_26_8)
							end
						end
					end
				end

				local var_26_9 = {}

				ipairs = var_26_3

				for iter_26_0, iter_26_1 in var_26_3(arg_24_0.contextData.drops) do
					table = var_2_10009

					var_2_10009.insert(var_26_9, iter_26_1)
				end

				ipairs = var_4

				for iter_26_2, iter_26_3 in var_4(arg_24_0.contextData.extraDrops) do
					iter_26_3.riraty = true
					table = var_9

					var_9.insert(var_26_9, iter_26_3)
				end

				local var_26_10 = false
				local var_26_11 = arg_24_0.contextData.extraBuffList

				ipairs = var_6

				for iter_26_4, iter_26_5 in var_6(var_26_11) do
					pg = var_2_10011

					local var_26_12 = var_2_10011.benefit_buff_template[iter_26_5].benefit_type

					Chapter = var_2_10013

					if var_26_12 == var_2_10013.OPERATION_BUFF_TYPE_REWARD then
						var_26_10 = true

						break
					end
				end

				table = var_6

				local var_26_13

				if var_6.getCount(var_26_0) > 0 then
					var_26_13 = arg_24_0.skipFlag

					local var_26_14 = false
					local var_26_15 = arg_24_0.contextData.system

					SYSTEM_SCENARIO = iter_26_4

					if var_26_15 == iter_26_4 then
						getProxy = var_26_15
						ChapterProxy = iter_26_4
						iter_26_4 = var_26_15(iter_26_4)

						if var_8.getActiveChapter(iter_26_4, true) then
							iter_26_5 = var_8

							if var_8.isLoop(iter_26_5) then
								getProxy = iter_26_4
								ChapterProxy = iter_26_5
								iter_26_5 = iter_26_4(iter_26_5)

								iter_26_4.AddExtendChapterDataArray(iter_26_5, var_8.id, "TotalDrops", var_26_9)

								getProxy = iter_26_4
								ChapterProxy = iter_26_5
								iter_26_5 = iter_26_4(iter_26_5)
								var_26_14 = iter_26_4.GetChapterAutoFlag(iter_26_5, var_8.id) == 1
							end

							iter_26_5 = var_8

							var_8.writeDrops(iter_26_5, var_26_9)
						end
					else
						local var_26_16 = arg_24_0.contextData.system

						SYSTEM_ACT_BOSS = iter_26_4

						if var_26_16 == iter_26_4 then
							getProxy = var_26_16
							ContextProxy = iter_26_4
							iter_26_4 = var_26_16(iter_26_4)
							iter_26_4 = var_8.getCurrentContext(iter_26_4)

							local var_26_17 = var_8.getContextByMediator

							ContinuousOperationMediator = iter_26_5

							if var_26_17(iter_26_4, iter_26_5) then
								getProxy = var_8
								ChapterProxy = iter_26_4
								iter_26_4 = var_8(iter_26_4)

								var_8.AddActBossRewards(iter_26_4, var_26_9)
							end
						else
							local var_26_18 = arg_24_0.contextData.system

							SYSTEM_BOSS_SINGLE = iter_26_4

							if var_26_18 == iter_26_4 then
								getProxy = var_26_18
								ContextProxy = iter_26_4
								iter_26_4 = var_26_18(iter_26_4)
								iter_26_4 = var_8.getCurrentContext(iter_26_4)

								local var_26_19 = var_8.getContextByMediator

								BossSingleContinuousOperationMediator = iter_26_5

								if var_26_19(iter_26_4, iter_26_5) then
									getProxy = var_8
									ChapterProxy = iter_26_4
									iter_26_4 = var_8(iter_26_4)

									var_8.AddBossSingleRewards(iter_26_4, var_26_9)
								end
							else
								local var_26_20 = arg_24_0.contextData.system

								SYSTEM_BOSS_SINGLE_VARIABLE = iter_26_4

								if var_26_20 == iter_26_4 then
									-- block empty
								end
							end
						end
					end

					local var_26_21 = arg_24_0
					local var_26_22 = var_8.emit

					BaseUI = iter_26_5

					var_26_22(var_26_21, iter_26_5.ON_AWARD, {
						items = var_26_9,
						extraBonus = var_26_10,
						removeFunc = var_24_4,
						closeOnCompleted = var_26_13
					})

					coroutine = var_26_22

					var_26_22.yield()

					_ = var_8

					local var_26_23 = #var_8.filter(var_26_9, function(arg_30_0)
						local var_30_0 = arg_30_0.type

						DROP_TYPE_SHIP = var_3_10002

						return var_30_0 == var_3_10002
					end)

					getProxy = var_9
					BayProxy = var_10

					local var_26_24 = var_9(var_10)
					local var_26_25 = var_9.getNewShip(var_26_24, true)

					math = var_26_24

					for iter_26_6 = var_26_24.max(1, #var_26_25 - var_26_23 + 1), #var_26_25 do
						local var_26_26 = var_26_25[iter_26_6]

						PlayerPrefs = var_2_10016
						var_2_10016 = var_2_10016.GetInt
						DISPLAY_SHIP_GET_EFFECT = var_2_10017

						if var_2_10016(var_2_10017) ~= 1 then
							if not var_26_26.virgin then
								var_2_10017 = var_26_26
								var_2_10016 = var_26_26.getRarity(var_2_10017)
								ShipRarity = var_2_10017

								if not (var_2_10017.Purple <= var_2_10016) then
									var_2_10016 = false

									goto label_26_0
								end

								var_2_10016 = true
							end

							::label_26_0::

							if var_2_10016 then
								var_2_10017 = var_26_14 and not var_26_26.virgin and 3 or nil

								local var_26_27 = arg_24_0
								local var_26_28 = var_18.emit

								BattleResultMediator = var_2_10020

								var_26_28(var_26_27, var_2_10020.GET_NEW_SHIP, var_26_26, var_24_4, var_2_10017)

								coroutine = var_26_28

								var_26_28.yield()
							end
						end
					end
				end

				setParent = var_26_13

				var_26_13(arg_24_0._tf, arg_24_0.overlay)

				local var_26_29 = arg_24_0

				var_6.displayBG(var_26_29)

				return
			end)

			var_24_4()

			return
		end
	end
end

function var_0_1.displayBG(arg_31_0)
	local function var_31_0()
		local var_32_0 = arg_31_0

		var_0.displayShips(var_32_0)

		local var_32_1 = arg_31_0

		var_0.displayPlayerInfo(var_32_1)

		local var_32_2 = arg_31_0

		var_0.displayerCommanders(var_32_2)

		local var_32_3 = arg_31_0

		var_0.initMetaBtn(var_32_3)

		arg_31_0._stateFlag = var_0_1.STATE_DISPLAY

		if arg_31_0.skipFlag then
			local var_32_4 = arg_31_0

			var_0.skip(var_32_4)
		end

		return
	end

	rtf = var_1_10002

	local var_31_1 = var_1_10002(arg_31_0._grade)

	LeanTween = var_3

	local var_31_2 = var_3.moveX

	rtf = var_1_10004

	var_31_2(var_1_10004(arg_31_0._conditions), 1300, var_0_1.DURATION_MOVE)

	LeanTween = var_31_2

	local var_31_3 = var_31_2.scale
	local var_31_4 = arg_31_0._grade

	Vector3 = var_5

	var_31_3(var_31_4, var_5(0.6, 0.6, 0), var_0_1.DURATION_MOVE)

	LeanTween = var_31_3

	local var_31_5 = var_31_3.moveLocal

	go = var_31_4

	var_31_5(var_31_4(var_31_1), arg_31_0._gradeUpperLeftPos, var_0_1.DURATION_MOVE)

	setActive = var_31_5

	local var_31_6 = arg_31_0._bg

	var_31_5(var_4.Find(var_31_6, "jieuan01/Bomb"), false)

	onDelayTick = var_31_5

	var_31_5(function()
		setLocalScale = var_2_10000

		local var_33_0 = arg_31_0._grade

		Vector3 = var_2_10002

		var_2_10000(var_33_0, var_2_10002(0.6, 0.6, 0))

		setAnchoredPosition = var_2_10000

		var_2_10000(arg_31_0._grade, arg_31_0._gradeUpperLeftPos)
		var_31_0()

		return
	end, var_0_1.DURATION_MOVE)

	return
end

function var_0_1.displayPlayerInfo(arg_34_0)
	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.calcPlayerProgress(var_34_0)

	SetActive = var_34_0

	var_34_0(arg_34_0._leftPanel, true)

	SetActive = var_34_0

	var_34_0(arg_34_0._playerExp, true)

	local var_34_2 = arg_34_0._main
	local var_34_3 = var_2.GetComponent(var_34_2, "Animator")

	var_34_3.enabled = true
	LeanTween = var_34_3

	local var_34_4 = var_34_3.moveX

	rtf = var_3

	local var_34_5 = var_34_4(var_3(arg_34_0._leftPanel), 0, 0.5)
	local var_34_6 = var_2.setOnComplete

	System = var_4

	local var_34_7 = var_34_6(var_34_5, var_4.Action(function()
		LeanTween = var_2_10000

		local var_35_0 = var_2_10000.value

		go = var_2_10001

		local var_35_1 = var_35_0(var_2_10001(arg_34_0._tf), 0, var_34_1, 1)
		local var_35_2 = var_0.setOnUpdate

		System = var_2

		local var_35_3 = var_35_2(var_35_1, var_2.Action_float(function(arg_36_0)
			setText = var_3_10001

			local var_36_0 = arg_34_0._playerBonusExp
			local var_36_1 = "+"

			math = var_3_10004

			var_3_10001(var_36_0, var_36_1 .. var_3_10004.floor(arg_36_0))

			return
		end))

		table = var_35_1

		var_35_1.insert(arg_34_0._delayLeanList, var_35_3.id)

		return
	end))

	table = var_34_5

	var_34_5.insert(arg_34_0._delayLeanList, var_34_7.id)

	return
end

function var_0_1.calcPlayerExp(arg_37_0)
	local var_37_0 = arg_37_0.contextData.oldPlayer.level
	local var_37_1 = arg_37_0.player.level
	local var_37_2 = arg_37_0.player.exp - var_1.exp

	while var_37_0 < var_37_1 do
		pg = var_5
		var_37_2 = var_37_2 + var_5.user_level[var_37_0].exp
		var_37_0 = var_37_0 + 1
	end

	pg = var_5

	local var_37_3 = var_5.user_level

	pg = var_1_10006

	if var_37_0 == var_37_3[#var_1_10006.user_level].level then
		var_37_2 = 0
	end

	return var_37_2
end

function var_0_1.calcPlayerRank(arg_38_0)
	local var_38_0 = arg_38_0.contextData.oldRank.score

	return arg_38_0.season.score - var_1.score
end

function var_0_1.displayShips(arg_39_0)
	local var_39_0 = {}
	local var_39_1 = arg_39_0.shipVOs

	ipairs = var_1_10003

	for iter_39_0, iter_39_1 in var_1_10003(var_39_1) do
		var_39_0[iter_39_1.id] = iter_39_1
	end

	local var_39_2 = arg_39_0.contextData.statistics

	ipairs = var_4

	for iter_39_2, iter_39_3 in var_4(var_39_1) do
		if var_39_2[iter_39_3.id] then
			iter_39_4 = var_39_2[iter_39_3.id]
			iter_39_4.vo = iter_39_3
		end
	end

	local var_39_3
	local var_39_4

	if var_39_2.mvpShipID == -1 then
		var_39_4 = 0
		ipairs = var_6

		for iter_39_4, iter_39_5 in var_6(arg_39_0.contextData.oldMainShips) do
			math = var_1_10011
			var_39_4 = var_1_10011.max(var_39_2[iter_39_5.id].output, var_39_4)
		end
	elseif var_39_2.mvpShipID and var_39_2.mvpShipID ~= 0 then
		var_39_4 = var_39_2[var_39_2.mvpShipID].output
	else
		var_39_4 = 0
	end

	local var_39_5 = arg_39_0.contextData.oldMainShips

	arg_39_0._atkFuncs = {}

	local var_39_6
	local var_39_7

	SetActive = iter_39_4

	iter_39_4(arg_39_0._atkToggle, #var_39_5 > 6)

	local var_39_9

	if #var_39_5 > 6 then
		onToggle = var_9

		local var_39_8 = arg_39_0

		var_39_9 = arg_39_0._atkToggle

		local function var_39_10(arg_40_0)
			SetActive = var_2_10001

			var_2_10001(arg_39_0._atkContainer, arg_40_0)

			SetActive = var_2_10001

			var_2_10001(arg_39_0._atkContainerNext, not arg_40_0)

			if arg_40_0 then
				local var_40_0 = arg_39_0

				var_1.skipAtkAnima(var_40_0, arg_39_0._atkContainerNext)
			else
				local var_40_1 = arg_39_0

				var_1.skipAtkAnima(var_40_1, arg_39_0._atkContainer)
			end

			return
		end

		SFX_PANEL = var_1_10013

		var_9(var_39_8, var_39_9, var_39_10, var_1_10013)
	end

	local var_39_11 = {}
	local var_39_12 = {}

	ipairs = var_39_9

	for iter_39_6, iter_39_7 in var_39_9(var_39_5) do
		local var_39_13 = var_39_0[iter_39_7.id]

		if var_39_2[iter_39_7.id] then
			ys = var_17

			local var_39_14 = var_17.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_39_7.configId).type

			table = var_18

			local var_39_15 = var_18.contains

			ShipType = var_1_10019

			local var_39_16 = var_39_15(var_1_10019.SubShipType, var_39_14)

			var_1_10019 = nil

			local var_39_17
			local var_39_18 = 0
			local var_39_19

			if 6 < iter_39_6 then
				var_39_17 = arg_39_0._atkContainerNext
				var_39_19 = 7
			else
				var_39_17 = arg_39_0._atkContainer
				var_39_19 = 1
			end

			cloneTplTo = var_22
			var_22.x = var_22(arg_39_0._atkTpl, var_39_17).localPosition.x + (iter_39_6 - var_39_19) * 74
			var_22.y = var_22.y + (iter_39_6 - var_39_19) * 4
			var_1_10019.localPosition = var_22
			findTF = var_23

			local var_39_20 = var_23(var_1_10019, "result/stars")

			findTF = var_24

			local var_39_21 = var_24(var_1_10019, "result/stars/star_tpl")
			local var_39_22 = iter_39_7:getStar()
			local var_39_23 = iter_39_7:getMaxStar()

			while 0 < var_39_23 do
				cloneTplTo = var_39_24

				local var_39_24 = var_39_24(var_39_21, var_39_20)

				SetActive = var_28

				var_28(var_39_24:Find("empty"), var_39_22 < var_39_23)

				SetActive = var_28

				var_28(var_39_24:Find("star"), var_39_23 <= var_39_22)

				var_39_23 = var_39_23 - 1
			end

			local var_39_25 = var_1_10019:Find("result/mask/icon")
			local var_39_26 = var_1_10019:Find("result/type")
			local var_39_27 = var_39_25
			local var_39_28 = var_39_25.GetComponent

			typeof = var_1_10031
			Image = var_1_10032

			local var_39_29 = var_39_28(var_39_27, var_1_10031(var_1_10032))

			LoadSprite = var_39_27
			var_39_29.sprite = var_39_27("herohrzicon/" .. iter_39_7:getPainting())

			local var_39_30 = var_39_2[iter_39_7.id].output / var_39_4

			GetSpriteFromAtlas = var_30
			var_1_10031 = "shiptype"
			shipType2print = var_1_10032

			local var_39_31 = var_30(var_1_10031, var_1_10032(iter_39_7:getShipType()))

			setImageSprite = var_1_10031

			var_1_10031(var_39_26, var_39_31, true)

			var_1_10032 = arg_39_0

			arg_39_0.setAtkAnima(var_1_10032, var_1_10019, var_39_17, var_39_30, var_39_4, var_39_3 and iter_39_7.id == var_39_3.id, var_39_2[iter_39_7.id].output, var_39_2[iter_39_7.id].kill_count)

			var_1_10031 = nil
			var_1_10032 = false

			local var_39_36

			if var_39_3 and iter_39_7.id == var_39_3.id then
				var_1_10032 = true
				arg_39_0.mvpShipVO = iter_39_7

				local var_39_32
				local var_39_33
				local var_39_34
				local var_39_35 = arg_39_0.contextData.score
				local var_39_37

				if 1 < var_39_35 then
					ShipWordHelper = var_39_35
					var_39_35 = var_39_35.GetWordAndCV
					var_39_36 = arg_39_0.mvpShipVO.skinId
					ShipWordHelper = var_39_37
					var_39_37 = var_39_37.WORD_TYPE_MVP

					local var_39_38
					local var_39_39
					local var_39_40 = arg_39_0.mvpShipVO

					var_39_35, var_39_36, var_39_37 = var_39_35(var_39_36, var_39_37, var_39_38, var_39_39, var_41.getCVIntimacy(var_39_40))

					local var_39_41 = var_39_37

					var_39_34 = var_39_36

					local var_39_42 = var_39_35
				else
					ShipWordHelper = var_39_35

					local var_39_43 = var_39_35.GetWordAndCV

					var_39_36 = arg_39_0.mvpShipVO.skinId
					ShipWordHelper = var_39_37

					local var_39_44, var_39_45

					var_39_44, var_39_36, var_39_45 = var_39_43(var_39_36, var_39_37.WORD_TYPE_LOSE)

					local var_39_46 = var_39_45

					var_39_34 = var_39_36

					local var_39_47 = var_39_44
				end

				if var_39_34 then
					var_39_36 = arg_39_0

					arg_39_0.stopVoice(var_39_36)

					pg = var_36
					var_39_36 = var_36.CriMgr.GetInstance()

					var_36.PlaySoundEffect_V3(var_39_36, var_39_34, function(arg_41_0)
						arg_39_0._currentVoice = arg_41_0

						return
					end)
				end
			end

			if iter_39_7.id == var_39_2._flagShipID then
				arg_39_0.flagShipVO = iter_39_7
			end

			local var_39_48
			local var_39_49

			if arg_39_0.shipBuff then
				var_39_49 = arg_39_0.shipBuff[iter_39_7:getGroupId()]
			end

			local var_39_50

			if not arg_39_0.expBuff then
				var_39_50 = var_39_49
			end

			if var_39_50 then
				if arg_39_0.expBuff then
					var_39_36 = arg_39_0.expBuff

					if not var_36.getConfig(var_39_36, "name") then
						::label_39_0::

						if var_39_49 then
							::label_39_1::

							i18n = var_36
							var_39_48 = var_36("Word_Ship_Exp_Buff")
						end
					end

					local var_39_51

					if not var_39_16 then
						cloneTplTo = var_39_36
						var_39_36 = var_39_36(arg_39_0._extpl, arg_39_0._expContainer)
						BattleResultShipCard = var_38
						var_39_51 = var_38.New(var_39_36)
						table = var_38

						var_38.insert(arg_39_0._shipResultCardList, var_39_51)

						if var_39_7 then
							var_39_7:ConfigCallback(function()
								local var_42_0 = var_39_51

								var_0.Play(var_42_0)

								return
							end)
						else
							var_39_51:Play()
						end

						var_39_7 = var_39_51
					else
						cloneTplTo = var_39_36

						local var_39_52 = var_39_36(arg_39_0._extpl, arg_39_0._subExpContainer)

						BattleResultShipCard = var_38
						var_39_51 = var_38.New(var_39_52)
						table = var_38

						var_38.insert(arg_39_0._subShipResultCardList, var_39_51)

						if not var_39_6 then
							arg_39_0._subFirstExpCard = var_39_51
						else
							var_39_6:ConfigCallback(function()
								local var_43_0 = var_39_51

								var_0.Play(var_43_0)

								return
							end)
						end

						var_39_6 = var_39_51
					end

					var_39_51:SetShipVO(iter_39_7, var_39_13, var_1_10032, var_39_48)
				end
			end
		end
	end

	if var_39_7 then
		var_39_7:ConfigCallback(function()
			arg_39_0._stateFlag = var_0_1.STATE_DISPLAYED

			if not arg_39_0._subFirstExpCard then
				local var_44_0 = arg_39_0

				var_0.skip(var_44_0)
			end

			return
		end)
	end

	if var_39_6 then
		var_39_6:ConfigCallback(function()
			arg_39_0._stateFlag = var_0_1.STATE_SUB_DISPLAYED

			local var_45_0 = arg_39_0

			var_0.skip(var_45_0)

			return
		end)
	end

	return
end

function var_0_1.stopVoice(arg_46_0)
	if arg_46_0._currentVoice then
		local var_46_0 = arg_46_0._currentVoice

		var_1.PlaybackStop(var_46_0)

		arg_46_0._currentVoice = nil
	end

	return
end

function var_0_1.setAtkAnima(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4, arg_47_5, arg_47_6, arg_47_7)
	local var_47_0 = arg_47_1:Find("result")
	local var_47_1 = arg_47_1:Find("result/atk")
	local var_47_2 = arg_47_1:Find("result/dmg_progress/progress_bar")
	local var_47_3 = arg_47_1:Find("result/killCount")
	local var_47_4 = var_47_0
	local var_47_5 = var_47_0.GetComponent

	typeof = var_1_10014
	DftAniEvent = var_1_10015

	local var_47_6 = var_47_5(var_47_4, var_1_10014(var_1_10015))

	setText = var_47_4

	var_47_4(var_47_1, 0)

	setText = var_47_4

	var_47_4(var_47_3, 0)

	local var_47_7 = var_47_2
	local var_47_8 = var_47_2.GetComponent

	typeof = var_15
	Image = var_1_10016
	var_47_8(var_47_7, var_15(var_1_10016)).fillAmount = 0

	if arg_47_5 then
		local var_47_9 = arg_47_1
		local var_47_10 = arg_47_1.Find(var_47_9, "result/mvpBG")

		setParent = var_47_9

		var_47_9(arg_47_0._mvpFX, var_47_10)

		local var_47_11 = arg_47_0._mvpFX

		Vector3 = var_15
		var_47_11.localPosition = var_15(-368.5, 0, 0)
		setActive = var_47_11

		var_47_11(var_47_10, true)

		setActive = var_47_11
		var_1_10016 = arg_47_1

		var_47_11(arg_47_1.Find(var_1_10016, "result/bg"), false)
	end

	var_47_6:SetEndEvent(function(arg_48_0)
		if arg_47_5 then
			setActive = var_1

			var_1(arg_47_0._mvpFX, true)
		end

		LeanTween = var_1

		local var_48_0 = var_1.value

		go = var_2_10002

		local var_48_1 = var_48_0(var_2_10002(var_47_0), 0, arg_47_3, arg_47_3)
		local var_48_2 = var_1.setOnUpdate

		System = var_3

		var_48_2(var_48_1, var_3.Action_float(function(arg_49_0)
			local var_49_0 = var_47_2
			local var_49_1 = var_1.GetComponent

			typeof = var_3_10003
			Image = var_3_10004
			var_49_1(var_49_0, var_3_10003(var_3_10004)).fillAmount = arg_49_0

			return
		end))

		if arg_47_4 ~= 0 then
			LeanTween = var_1

			local var_48_3 = var_1.value

			go = var_48_1

			local var_48_4 = var_48_3(var_48_1(var_47_0), 0, arg_47_6, arg_47_3)
			local var_48_5 = var_1.setOnUpdate

			System = var_3

			var_48_5(var_48_4, var_3.Action_float(function(arg_50_0)
				setText = var_3_10001

				local var_50_0 = var_47_1

				math = var_3_10003

				var_3_10001(var_50_0, var_3_10003.floor(arg_50_0))

				return
			end))

			LeanTween = var_48_5

			local var_48_6 = var_48_5.value

			go = var_48_4

			local var_48_7 = var_48_6(var_48_4(var_47_0), 0, arg_47_7, arg_47_3)
			local var_48_8 = var_1.setOnUpdate

			System = var_3

			var_48_8(var_48_7, var_3.Action_float(function(arg_51_0)
				setText = var_3_10001

				local var_51_0 = var_47_3

				math = var_3_10003

				var_3_10001(var_51_0, var_3_10003.floor(arg_51_0))

				return
			end))
		end

		return
	end)

	if arg_47_2.childCount > 1 then
		local var_47_12 = arg_47_2:GetChild(arg_47_2.childCount - 2)
		local var_47_13 = var_13.Find(var_47_12, "result")
		local var_47_14 = var_13.GetComponent

		typeof = var_1_10016
		DftAniEvent = var_1_10017

		local var_47_15 = var_47_14(var_47_13, var_1_10016(var_1_10017))

		var_14.SetTriggerEvent(var_47_15, function(arg_52_0)
			setActive = var_2_10001

			var_2_10001(var_47_0, true)

			return
		end)
	else
		setActive = var_13

		var_13(var_47_0, true)
	end

	local function var_47_16()
		local var_53_0 = var_47_2
		local var_53_1 = var_0.GetComponent

		typeof = var_2_10002
		Image = var_2_10003

		local var_53_2 = var_53_1(var_53_0, var_2_10002(var_2_10003))

		var_53_2.fillAmount = arg_47_3
		setText = var_53_2

		var_53_2(var_47_1, arg_47_6)

		setText = var_53_2

		var_53_2(var_47_3, arg_47_7)

		local var_53_3 = var_47_0

		Vector3 = var_1
		var_53_3.localPosition = var_1(280, 46, 0)

		local var_53_4 = var_47_0
		local var_53_5 = var_0.GetComponent

		typeof = var_2
		Animator = var_3

		local var_53_6 = var_53_5(var_53_4, var_2(var_3))

		var_53_6.enabled = false
		setActive = var_53_6

		var_53_6(var_47_0, true)

		setActive = var_53_6

		var_53_6(arg_47_0._mvpFX, true)

		return
	end

	local var_47_17

	if arg_47_0._atkFuncs[arg_47_2] == nil then
		var_47_17 = arg_47_0._atkFuncs
		var_47_17[arg_47_2] = {}
	end

	table = var_47_17

	var_47_17.insert(arg_47_0._atkFuncs[arg_47_2], var_47_16)

	return
end

function var_0_1.skipAtkAnima(arg_54_0, arg_54_1)
	if arg_54_0._atkFuncs[arg_54_1] then
		ipairs = var_2

		for iter_54_0, iter_54_1 in var_2(arg_54_0._atkFuncs[arg_54_1]) do
			iter_54_1()
		end

		arg_54_0._atkFuncs[arg_54_1] = nil
	end

	return
end

function var_0_1.showPainting(arg_55_0)
	local var_55_0
	local var_55_1
	local var_55_2

	SetActive = var_1_10004

	var_1_10004(arg_55_0._painting, true)

	local var_55_3 = arg_55_0.contextData.score
	local var_55_5

	if 1 < var_55_3 then
		if not arg_55_0.mvpShipVO then
			var_55_3 = arg_55_0.flagShipVO
		end

		arg_55_0.paintingName = var_55_3:getPainting()

		local var_55_4 = var_55_3

		var_55_5 = var_55_3.getCVIntimacy(var_55_4)
		setPaintingPrefabAsync = var_55_4

		var_55_4(arg_55_0._painting, arg_55_0.paintingName, "jiesuan", function()
			findTF = var_2_10000

			local var_56_0 = var_2_10000(arg_55_0._painting, "fitter").childCount

			if 0 < var_56_0 then
				ShipExpressionHelper = var_56_0

				local var_56_1 = var_56_0.SetExpression

				findTF = var_1

				local var_56_2 = var_1(arg_55_0._painting, "fitter")

				var_56_1(var_1.GetChild(var_56_2, 0), arg_55_0.paintingName, "win_mvp", var_55_5)
			end

			return
		end)

		ShipWordHelper = var_55_4

		local var_55_6 = var_55_4.GetWordAndCV
		local var_55_7 = var_55_3.skinId

		ShipWordHelper = var_1_10008

		local var_55_8, var_55_9

		var_55_8, var_55_9, var_1_10008 = var_55_6(var_55_7, var_1_10008.WORD_TYPE_MVP, nil, nil, var_55_5)
		var_55_1 = var_1_10008

		local var_55_10 = var_55_9
		local var_55_11 = var_55_8

		SetActive = var_55_8

		var_55_8(arg_55_0._failPainting, false)
	else
		var_55_3 = arg_55_0.contextData.oldMainShips
		math = var_55_5

		local var_55_12 = var_55_3[var_55_5.random(#var_55_3)]

		ShipWordHelper = var_6

		local var_55_13 = var_6.GetWordAndCV
		local var_55_14 = var_55_12.skinId

		ShipWordHelper = var_1_10008

		local var_55_15, var_55_16

		var_55_15, var_55_16, var_55_1 = var_55_13(var_55_14, var_1_10008.WORD_TYPE_LOSE)
	end

	setText = var_55_3

	local var_55_17 = arg_55_0._chat

	var_55_3(var_5.Find(var_55_17, "Text"), var_55_1)

	local var_55_18 = arg_55_0._chat
	local var_55_19 = var_4.Find(var_55_18, "Text")
	local var_55_20 = var_4.GetComponent

	typeof = var_6
	Text = var_7

	local var_55_21 = #var_55_20(var_55_19, var_6(var_7)).text

	CHAT_POP_STR_LEN = var_6

	if var_6 < var_55_21 then
		TextAnchor = var_55_21
		var_4.alignment = var_55_21.MiddleLeft
	else
		TextAnchor = var_55_21
		var_4.alignment = var_55_21.MiddleCenter
	end

	SetActive = var_55_21

	var_55_21(arg_55_0._chat, true)

	local var_55_22 = arg_55_0._chat.transform

	Vector3 = var_6
	var_55_22.localScale = var_6.New(0, 0, 0)
	LeanTween = var_55_22

	local var_55_23 = var_55_22.cancel

	go = var_6

	var_55_23(var_6(arg_55_0._painting))

	LeanTween = var_55_23

	local var_55_24 = var_55_23.moveX

	rtf = var_6

	local var_55_25 = var_55_24(var_6(arg_55_0._painting), 50, 0.25)
	local var_55_26 = var_5.setOnComplete

	System = var_7

	var_55_26(var_55_25, var_7.Action(function()
		LeanTween = var_2_10000

		local var_57_0 = var_2_10000.scale

		rtf = var_2_10001

		local var_57_1 = var_2_10001(arg_55_0._chat.gameObject)

		Vector3 = var_2

		local var_57_2 = var_57_0(var_57_1, var_2.New(1, 1, 1), 0.3)
		local var_57_3 = var_0.setEase

		LeanTweenType = var_2

		local var_57_4 = var_57_3(var_57_2, var_2.easeOutBack)
		local var_57_5 = var_0.setOnComplete

		System = var_2

		var_57_5(var_57_4, var_2.Action(function()
			local var_58_0 = arg_55_0._statisticsBtn

			var_0.GetComponent(var_58_0, "Button").enabled = true

			local var_58_1 = arg_55_0._confirmBtn

			var_0.GetComponent(var_58_1, "Button").enabled = true

			local var_58_2 = arg_55_0._atkBG

			var_0.GetComponent(var_58_2, "Button").enabled = true

			return
		end))

		return
	end))

	return
end

function var_0_1.hidePainting(arg_59_0)
	SetActive = var_1_10001

	var_1_10001(arg_59_0._chat, false)

	local var_59_0 = arg_59_0._chat.transform

	Vector3 = var_2
	var_59_0.localScale = var_2.New(0, 0, 0)
	LeanTween = var_59_0

	local var_59_1 = var_59_0.cancel

	go = var_2

	var_59_1(var_2(arg_59_0._painting))

	LeanTween = var_59_1

	local var_59_2 = var_59_1.scale

	rtf = var_2

	local var_59_3 = var_2(arg_59_0._chat.gameObject)

	Vector3 = var_3

	local var_59_4 = var_59_2(var_59_3, var_3.New(0, 0, 0), 0.1)
	local var_59_5 = var_1.setEase

	LeanTweenType = var_3

	var_59_5(var_59_4, var_3.easeOutBack)

	LeanTween = var_59_5

	local var_59_6 = var_59_5.moveX

	rtf = var_59_4

	local var_59_7 = var_59_6(var_59_4(arg_59_0._painting), 720, 0.2)
	local var_59_8 = var_1.setOnComplete

	System = var_3

	var_59_8(var_59_7, var_3.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_59_0._painting, false)

		return
	end))

	return
end

function var_0_1.skip(arg_61_0)
	ipairs = var_1_10001

	for iter_61_0, iter_61_1 in var_1_10001(arg_61_0._delayLeanList) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_61_1)
	end

	if arg_61_0._stateFlag == var_0_1.STATE_RANK_ANIMA then
		-- block empty
	elseif arg_61_0._stateFlag == var_0_1.STATE_REPORT then
		local var_61_0 = arg_61_0._conditionContainer.childCount

		while 0 < var_61_0 do
			SetActive = var_2

			local var_61_1 = arg_61_0._conditionContainer

			var_2(var_3.GetChild(var_61_1, var_61_0 - 1), true)

			var_61_0 = var_61_0 - 1
		end

		SetActive = var_2

		local var_61_2 = arg_61_0._bg

		var_2(var_3.Find(var_61_2, "jieuan01/tips"), true)

		arg_61_0._stateFlag = var_0_1.STATE_REPORTED

		arg_61_0:skip()
	elseif arg_61_0._stateFlag == var_0_1.STATE_REPORTED then
		arg_61_0:showRewardInfo()
	elseif arg_61_0._stateFlag == var_0_1.STATE_REWARD then
		-- block empty
	elseif arg_61_0._stateFlag == var_0_1.STATE_DISPLAY then
		ipairs = var_1

		for iter_61_2, iter_61_3 in var_1(arg_61_0._shipResultCardList) do
			iter_61_3:SkipAnimation()
		end

		arg_61_0._stateFlag = var_0_1.STATE_DISPLAYED
		setText = var_1

		var_1(arg_61_0._playerBonusExp, "+" .. arg_61_0:calcPlayerProgress())

		if not arg_61_0._subFirstExpCard then
			arg_61_0:playSubExEnter()
		elseif arg_61_0.skipFlag then
			arg_61_0:skip()
		end
	elseif arg_61_0._stateFlag == var_0_1.STATE_DISPLAYED then
		setText = var_1

		var_1(arg_61_0._playerBonusExp, "+" .. arg_61_0:calcPlayerProgress())
		arg_61_0:playSubExEnter()
	elseif arg_61_0._stateFlag == var_0_1.STATE_SUB_DISPLAY then
		ipairs = var_1

		for iter_61_4, iter_61_5 in var_1(arg_61_0._subShipResultCardList) do
			iter_61_5:SkipAnimation()
		end

		arg_61_0._stateFlag = var_0_1.STATE_SUB_DISPLAYED

		if arg_61_0.skipFlag then
			arg_61_0:skip()
		end
	elseif arg_61_0._stateFlag == var_0_1.STATE_SUB_DISPLAYED then
		arg_61_0:showRightBottomPanel()
	end

	return
end

function var_0_1.playSubExEnter(arg_62_0)
	arg_62_0._stateFlag = var_0_1.STATE_SUB_DISPLAY

	if arg_62_0._subFirstExpCard then
		triggerToggle = var_1

		var_1(arg_62_0._subToggle, false)

		local var_62_0 = arg_62_0._subFirstExpCard

		var_1.Play(var_62_0)
	else
		arg_62_0:showRightBottomPanel()
	end

	if arg_62_0.skipFlag then
		arg_62_0:skip()
	end

	return
end

function var_0_1.showRightBottomPanel(arg_63_0)
	SetActive = var_1_10001

	var_1_10001(arg_63_0._skipBtn, false)

	SetActive = var_1_10001

	var_1_10001(arg_63_0._rightBottomPanel, true)

	SetActive = var_1_10001

	var_1_10001(arg_63_0._subToggle, arg_63_0._subFirstExpCard ~= nil)

	onButton = var_1_10001

	local var_63_0 = arg_63_0
	local var_63_1 = arg_63_0._statisticsBtn

	local function var_63_2()
		if arg_63_0._atkBG.gameObject.activeSelf then
			local var_64_0 = arg_63_0

			var_0.closeStatistics(var_64_0)
		else
			local var_64_1 = arg_63_0

			var_0.showStatistics(var_64_1)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_63_0, var_63_1, var_63_2, var_1_10005)

	onButton = var_1_10001

	local var_63_3 = arg_63_0
	local var_63_4 = arg_63_0._confirmBtn

	local function var_63_5()
		if arg_63_0.failTag == true then
			local var_65_0 = arg_63_0
			local var_65_1 = var_0.emit

			BattleResultMediator = var_2_10002

			var_65_1(var_65_0, var_2_10002.PRE_BATTLE_FAIL_EXIT)

			local var_65_2 = arg_63_0
			local var_65_3 = var_0.emit

			BattleResultMediator = var_2_10002

			var_65_3(var_65_2, var_2_10002.OPEN_FAIL_TIP_LAYER)
		else
			local var_65_4 = arg_63_0
			local var_65_5 = var_0.emit

			BattleResultMediator = var_2_10002

			var_65_5(var_65_4, var_2_10002.ON_BACK_TO_LEVEL_SCENE)
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_63_3, var_63_4, var_63_5, var_1_10005)

	onButton = var_1_10001

	local var_63_6 = arg_63_0
	local var_63_7 = arg_63_0._atkBG

	local function var_63_8()
		local var_66_0 = arg_63_0

		var_0.closeStatistics(var_66_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_63_6, var_63_7, var_63_8, var_1_10005)

	arg_63_0._stateFlag = nil
	arg_63_0._subFirstExpCard = nil

	if arg_63_0.skipFlag then
		triggerButton = var_1

		var_1(arg_63_0._confirmBtn)
	end

	return
end

function var_0_1.showStatistics(arg_67_0)
	setActive = var_1_10001

	var_1_10001(arg_67_0._leftPanel, false)
	arg_67_0:enabledStatisticsGizmos(false)

	SetActive = var_1

	var_1(arg_67_0._atkBG, true)

	local var_67_0 = arg_67_0._atkBG

	var_1.GetComponent(var_67_0, "Button").enabled = false

	local var_67_1 = arg_67_0._confirmBtn

	var_1.GetComponent(var_67_1, "Button").enabled = false

	local var_67_2 = arg_67_0._statisticsBtn

	var_1.GetComponent(var_67_2, "Button").enabled = false

	local var_67_3 = arg_67_0

	arg_67_0.showPainting(var_67_3)

	LeanTween = var_1

	local var_67_4 = var_1.moveX

	rtf = var_67_3

	local var_67_5 = var_67_4(var_67_3(arg_67_0._atkPanel), 0, 0.25)
	local var_67_6 = var_1.setOnComplete

	System = var_3

	var_67_6(var_67_5, var_3.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_67_0._atkContainer, true)

		return
	end))

	return
end

function var_0_1.closeStatistics(arg_69_0)
	setActive = var_1_10001

	var_1_10001(arg_69_0._leftPanel, true)
	arg_69_0:skipAtkAnima(arg_69_0._atkContainerNext)
	arg_69_0:skipAtkAnima(arg_69_0._atkContainer)
	arg_69_0:enabledStatisticsGizmos(true)
	arg_69_0:hidePainting()

	local var_69_0 = arg_69_0._atkBG
	local var_69_1 = var_1.GetComponent(var_69_0, "Button")

	var_69_1.enabled = false
	LeanTween = var_69_1

	var_69_1.cancel(arg_69_0._atkPanel.gameObject)

	LeanTween = var_1

	local var_69_2 = var_1.moveX

	rtf = var_2

	local var_69_3 = var_69_2(var_2(arg_69_0._atkPanel), -700, 0.2)
	local var_69_4 = var_1.setOnComplete

	System = var_3

	var_69_4(var_69_3, var_3.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_69_0._atkBG, false)

		return
	end))

	return
end

function var_0_1.enabledStatisticsGizmos(arg_71_0, arg_71_1)
	setActive = var_1_10002

	local var_71_0 = arg_71_0._main

	var_1_10002(var_3.Find(var_71_0, "gizmos/xuxian_down"), arg_71_1)

	setActive = var_1_10002

	local var_71_1 = arg_71_0._main

	var_1_10002(var_3.Find(var_71_1, "gizmos/xuxian_middle"), arg_71_1)

	return
end

function var_0_1.PlayAnimation(arg_72_0, arg_72_1, arg_72_2, arg_72_3, arg_72_4, arg_72_5, arg_72_6)
	LeanTween = var_1_10007

	local var_72_0 = var_1_10007.value(arg_72_1.gameObject, arg_72_2, arg_72_3, arg_72_4)
	local var_72_1 = var_7.setDelay(var_72_0, arg_72_5)
	local var_72_2 = var_7.setOnUpdate

	System = var_9

	var_72_2(var_72_1, var_9.Action_float(function(arg_73_0)
		arg_72_6(arg_73_0)

		return
	end))

	return
end

function var_0_1.SetSkipFlag(arg_74_0, arg_74_1)
	arg_74_0.skipFlag = arg_74_1

	return
end

function var_0_1.initMetaBtn(arg_75_0)
	local var_75_0 = arg_75_0._main

	arg_75_0.metaBtn = var_1.Find(var_75_0, "MetaBtn")
	getProxy = var_1
	MetaCharacterProxy = var_75_0

	local var_75_1 = var_1(var_75_0)
	local var_75_2 = var_1.getLastMetaSkillExpInfoList(var_75_1)

	setActive = var_75_1

	var_75_1(arg_75_0.metaBtn, var_75_2 and #var_75_2 > 0 or false)

	onButton = var_75_1

	local var_75_3 = arg_75_0
	local var_75_4 = arg_75_0.metaBtn

	local function var_75_5()
		setActive = var_2_10000

		var_2_10000(arg_75_0.metaBtn, false)

		if not arg_75_0.metaExpView then
			local var_76_0 = arg_75_0

			BattleResultMetaExpView = var_1
			var_76_0.metaExpView = var_1.New(arg_75_0._blurConatiner, arg_75_0.event, arg_75_0.contextData)

			local var_76_1 = arg_75_0.metaExpView

			var_0.setData(var_76_1, var_75_2, function()
				if arg_75_0.metaBtn then
					setActive = var_0

					var_0(arg_75_0.metaBtn, true)
				end

				arg_75_0.metaExpView = nil

				return
			end)

			local var_76_2 = arg_75_0.metaExpView

			var_0.Reset(var_76_2)

			local var_76_3 = arg_75_0.metaExpView

			var_0.Load(var_76_3)

			local var_76_4 = arg_75_0.metaExpView

			var_0.ActionInvoke(var_76_4, "Show")

			local var_76_5 = arg_75_0.metaExpView

			var_0.ActionInvoke(var_76_5, "openPanel")
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_75_1(var_75_3, var_75_4, var_75_5, var_1_10006)

	return
end

function var_0_1.onBackPressed(arg_78_0)
	if arg_78_0.metaExpView then
		local var_78_0 = arg_78_0.metaExpView

		var_1.closePanel(var_78_0)

		arg_78_0.metaExpView = nil

		return
	end

	if arg_78_0._stateFlag == var_0_1.STATE_RANK_ANIMA then
		-- block empty
	elseif arg_78_0._stateFlag == var_0_1.STATE_REPORT then
		triggerButton = var_1

		var_1(arg_78_0._bg)
	elseif arg_78_0._stateFlag == var_0_1.STATE_REPORTED then
		triggerButton = var_1

		var_1(arg_78_0._skipBtn)
	elseif arg_78_0._stateFlag == var_0_1.STATE_DISPLAY then
		triggerButton = var_1

		var_1(arg_78_0._skipBtn)
	else
		triggerButton = var_1

		var_1(arg_78_0._confirmBtn)
	end

	return
end

function var_0_1.willExit(arg_79_0)
	ipairs = var_1_10001

	for iter_79_0, iter_79_1 in var_1_10001(arg_79_0._shipResultCardList) do
		iter_79_1:Dispose()
	end

	ipairs = var_1

	for iter_79_2, iter_79_3 in var_1(arg_79_0._subShipResultCardList) do
		iter_79_3:Dispose()
	end

	arg_79_0._atkFuncs = nil
	LeanTween = var_1

	local var_79_0 = var_1.cancel

	go = var_2

	var_79_0(var_2(arg_79_0._tf))

	if arg_79_0.paintingName then
		retPaintingPrefab = var_1

		var_1(arg_79_0._painting, arg_79_0.paintingName)
	end

	if arg_79_0._rightTimer then
		local var_79_1 = arg_79_0._rightTimer

		var_1.Stop(var_79_1)
	end

	arg_79_0:UnOverlayPanel(arg_79_0._tf)

	local var_79_2 = arg_79_0

	arg_79_0.stopVoice(var_79_2)

	getProxy = var_1
	MetaCharacterProxy = var_79_2

	local var_79_3 = var_1(var_79_2)

	var_1.clearLastMetaSkillExpInfoList(var_79_3)

	if arg_79_0.metaExpView then
		local var_79_4 = arg_79_0.metaExpView

		var_1.Destroy(var_79_4)

		arg_79_0.metaExpView = nil
	end

	pg = var_1

	local var_79_5 = var_1.CameraFixMgr.GetInstance()

	var_1.disconnect(var_79_5, arg_79_0.camEventId)

	return
end

return var_0_1
