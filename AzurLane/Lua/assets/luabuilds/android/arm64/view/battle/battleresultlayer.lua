local var_0_0 = class("BattleResultLayer", import("..base.BaseUI"))

var_0_0.DURATION_MOVE = 0.35
var_0_0.DURATION_WIN_SCALE = 0.4
var_0_0.CONDITIONS_FREQUENCE = 0.15
var_0_0.STATE_RANK_ANIMA = "rankAnima"
var_0_0.STATE_REPORT = "report"
var_0_0.STATE_REPORTED = "reported"
var_0_0.STATE_REWARD = "reward"
var_0_0.STATE_DISPLAY = "display"
var_0_0.STATE_DISPLAYED = "displayed"
var_0_0.STATE_SUB_DISPLAY = "subDisplay"
var_0_0.STATE_SUB_DISPLAYED = "subDisplayed"
var_0_0.ObjectiveList = {
	"battle_result_victory",
	"battle_result_undefeated",
	"battle_result_sink_limit",
	"battle_preCombatLayer_time_hold",
	"battle_result_time_limit",
	"battle_result_boss_destruct",
	"battle_preCombatLayer_damage_before_end",
	"battle_result_defeat_all_enemys"
}

function var_0_0.getUIName(arg_1_0)
	return "BattleResultUI"
end

function var_0_0.getGroupName(arg_2_0)
	return "BattleScene"
end

function var_0_0.setRivalVO(arg_3_0, arg_3_1)
	arg_3_0.rivalVO = arg_3_1

	return
end

function var_0_0.setRank(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.player = arg_4_1
	arg_4_0.season = arg_4_2

	setText(arg_4_0._playerName, "<color=#FFFFFF>" .. arg_4_0.player.name .. "</color><size=32> / C O M M A N D E R</size>")

	local var_4_0, var_4_1 = SeasonInfo.getNextMilitaryRank(arg_4_2.score, arg_4_2.rank)

	setText(arg_4_0._playerLv, SeasonInfo.getMilitaryRank(arg_4_2.score, arg_4_2.rank).name)
	setText(arg_4_0._playerExpLabel, i18n("word_rankScore"))

	arg_4_0._playerExpProgress:GetComponent(typeof(Image)).fillAmount = arg_4_2.score / var_4_1

	setText(arg_4_0._playerBonusExp, "+0")

	arg_4_0.calcPlayerProgress = arg_4_0.calcPlayerRank

	return
end

function var_0_0.setShips(arg_5_0, arg_5_1)
	arg_5_0.shipVOs = arg_5_1

	return
end

function var_0_0.setPlayer(arg_6_0, arg_6_1)
	arg_6_0.player = arg_6_1

	setText(arg_6_0._playerName, "<color=#FFFFFF>" .. arg_6_0.player.name .. "</color><size=32> / C O M M A N D E R</size>")
	setText(arg_6_0._playerLv, "Lv." .. arg_6_0.player.level)

	arg_6_0._playerExpProgress:GetComponent(typeof(Image)).fillAmount = arg_6_0.player.exp / getConfigFromLevel1(pg.user_level, arg_6_0.player.level).exp_interval

	if arg_6_0.player.level == pg.user_level[#pg.user_level].level then
		arg_6_0._playerExpProgress:GetComponent(typeof(Image)).fillAmount = 1
	end

	setText(arg_6_0._playerBonusExp, "+0")

	arg_6_0.calcPlayerProgress = arg_6_0.calcPlayerExp

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.contextData.extraBuffList) do
		if pg.benefit_buff_template[iter_6_1].benefit_type == Chapter.OPERATION_BUFF_TYPE_EXP then
			setActive(arg_6_0._playerExpExtra, true)
		end
	end

	return
end

function var_0_0.setExpBuff(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.expBuff = arg_7_1
	arg_7_0.shipBuff = arg_7_2

	return
end

function var_0_0.init(arg_8_0)
	arg_8_0._grade = arg_8_0._tf:Find("grade")
	arg_8_0._levelText = arg_8_0._grade:Find("chapterName/Text22")
	arg_8_0.clearFX = arg_8_0._tf:Find("clear")
	arg_8_0._main = arg_8_0._tf:Find("main")
	arg_8_0._blurConatiner = arg_8_0._tf:Find("blur_container")
	arg_8_0._bg = arg_8_0._tf:Find("main/jiesuanbeijing")
	arg_8_0._painting = arg_8_0._blurConatiner:Find("painting")
	arg_8_0._failPainting = arg_8_0._painting:Find("fail")
	arg_8_0._chat = arg_8_0._painting:Find("chat")
	arg_8_0._leftPanel = arg_8_0._main:Find("leftPanel")
	arg_8_0._expResult = arg_8_0._leftPanel:Find("expResult")
	arg_8_0._expContainer = arg_8_0._expResult:Find("expContainer")
	arg_8_0._extpl = arg_8_0:getTpl("ShipCardTpl", arg_8_0._expContainer)
	arg_8_0._playerExp = arg_8_0._leftPanel:Find("playerExp")
	arg_8_0._playerName = arg_8_0._playerExp:Find("name_text")
	arg_8_0._playerLv = arg_8_0._playerExp:Find("lv_text")
	arg_8_0._playerExpLabel = arg_8_0._playerExp:Find("exp_label")
	arg_8_0._playerExpProgress = arg_8_0._playerExp:Find("exp_progress")
	arg_8_0._playerBonusExp = arg_8_0._playerExp:Find("exp_text")
	arg_8_0._playerExpExtra = arg_8_0._playerExp:Find("operation_bonus")
	arg_8_0._atkBG = arg_8_0._blurConatiner:Find("atkPanel")
	arg_8_0._atkPanel = arg_8_0._atkBG:Find("atkResult")
	arg_8_0._atkResult = arg_8_0._atkBG:Find("atkResult/result")
	arg_8_0._atkContainer = arg_8_0._atkResult:Find("Grid")
	arg_8_0._atkContainerNext = arg_8_0._atkResult:Find("Grid_next")
	arg_8_0._atkToggle = arg_8_0._atkPanel:Find("switchAtk")
	arg_8_0._atkTpl = arg_8_0:getTpl("resulttpl", arg_8_0._atkResult)
	arg_8_0._mvpFX = arg_8_0._atkPanel:Find("mvpFX")
	arg_8_0._rightBottomPanel = arg_8_0._blurConatiner:Find("rightBottomPanel")
	arg_8_0._confirmBtn = arg_8_0._rightBottomPanel:Find("confirmBtn")

	setText(arg_8_0._confirmBtn:Find("Text"), i18n("text_confirm"))

	arg_8_0._statisticsBtn = arg_8_0._rightBottomPanel:Find("statisticsBtn")
	arg_8_0._subExpResult = arg_8_0._leftPanel:Find("subExpResult")
	arg_8_0._subExpContainer = arg_8_0._subExpResult:Find("expContainer")
	arg_8_0._subToggle = arg_8_0._leftPanel:Find("switchFleet")

	setActive(arg_8_0._subToggle, false)

	arg_8_0._skipBtn = arg_8_0._tf:Find("skipLayer")
	arg_8_0.UIMain = pg.UIMgr.GetInstance().UIMain
	arg_8_0.overlay = pg.UIMgr.GetInstance().OverlayMain
	arg_8_0._conditions = arg_8_0._tf:Find("main/conditions")
	arg_8_0._conditionContainer = arg_8_0._conditions:Find("bg16/list")
	arg_8_0._conditionTpl = arg_8_0._conditions:Find("bg16/conditionTpl")
	arg_8_0._conditionSubTpl = arg_8_0._conditions:Find("bg16/conditionSubTpl")
	arg_8_0._conditionContributeTpl = arg_8_0._conditions:Find("bg16/conditionContributeTpl")
	arg_8_0._conditionBGNormal = arg_8_0._conditions:Find("bg16/bg_normal")
	arg_8_0._conditionBGContribute = arg_8_0._conditions:Find("bg16/bg_contribute")
	arg_8_0._cmdExp = arg_8_0._leftPanel:Find("commanderExp")
	arg_8_0._cmdContainer = arg_8_0._cmdExp:Find("commander_container")
	arg_8_0._cmdTpl = arg_8_0._cmdExp:Find("commander_tpl")

	arg_8_0:setGradeLabel()
	SetActive(arg_8_0._levelText, false)

	arg_8_0._delayLeanList = {}
	arg_8_0._ratioFitter = GetComponent(arg_8_0._tf, typeof(AspectRatioFitter))
	arg_8_0._ratioFitter.enabled = true
	arg_8_0._ratioFitter.aspectRatio = pg.CameraFixMgr.GetInstance().targetRatio
	arg_8_0.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_9_0, arg_9_1)
		arg_8_0._ratioFitter.aspectRatio = arg_9_1

		return
	end)

	return
end

function var_0_0.customsLang(arg_10_0)
	setText(findTF(arg_10_0._confirmBtn, "Text"), i18n("battle_result_confirm"))
	setText(findTF(arg_10_0._bg, "jieuan01/tips/dianjijixu/bg20"), i18n("battle_result_continue"))
	setText(findTF(arg_10_0._atkTpl, "result/dmg_count_label"), i18n("battle_result_dmg"))
	setText(findTF(arg_10_0._atkTpl, "result/kill_count_label"), i18n("battle_result_kill_count"))
	setText(findTF(arg_10_0._subToggle, "on"), i18n("battle_result_toggle_on"))
	setText(findTF(arg_10_0._subToggle, "off"), i18n("battle_result_toggle_off"))
	setText(findTF(arg_10_0._conditions, "bg17"), i18n("battle_result_targets"))

	return
end

function var_0_0.setGradeLabel(arg_11_0)
	local var_11_0 = arg_11_0._tf:Find("grade/Xyz/bg13")
	local var_11_1 = arg_11_0._tf:Find("grade/Xyz/bg14")
	local var_11_2
	local var_11_3
	local var_11_4
	local var_11_5 = arg_11_0.contextData.score
	local var_11_6
	local var_11_7 = arg_11_0.contextData.score > 0

	setActive(arg_11_0._bg:Find("jieuan01/BG/bg_victory"), arg_11_0.contextData.score > 0)
	setActive(arg_11_0._bg:Find("jieuan01/BG/bg_fail"), not var_11_7)

	if var_11_7 then
		var_11_4 = ({
			"d",
			"c",
			"b",
			"a",
			"s"
		})[var_11_5 + 1]
		var_11_2 = "battlescore/battle_score_" .. ({
			"d",
			"c",
			"b",
			"a",
			"s"
		})[var_11_5 + 1] .. "/letter_" .. ({
			"d",
			"c",
			"b",
			"a",
			"s"
		})[var_11_5 + 1]
		var_11_3 = "battlescore/battle_score_" .. ({
			"d",
			"c",
			"b",
			"a",
			"s"
		})[var_11_5 + 1] .. "/label_" .. ({
			"d",
			"c",
			"b",
			"a",
			"s"
		})[var_11_5 + 1]
	else
		if arg_11_0.contextData.statistics._scoreMark == ys.Battle.BattleConst.DEAD_FLAG then
			var_11_4 = ({
				"d",
				"c",
				"b",
				"a",
				"s"
			})[2]
			var_11_6 = "flag_destroy"
		else
			var_11_4 = ({
				"d",
				"c",
				"b",
				"a",
				"s"
			})[1]
		end

		var_11_2 = "battlescore/battle_score_" .. var_11_4 .. "/letter_" .. var_11_4
		var_11_3 = "battlescore/battle_score_" .. var_11_4 .. "/label_" .. (var_11_6 or var_11_4)
	end

	LoadImageSpriteAsync(var_11_2, var_11_0, false)
	LoadImageSpriteAsync(var_11_3, var_11_1, false)

	if (arg_11_0.contextData.system == SYSTEM_SCENARIO or arg_11_0.contextData.system == SYSTEM_ROUTINE or arg_11_0.contextData.system == SYSTEM_SUB_ROUTINE or arg_11_0.contextData.system == SYSTEM_DUEL) and (var_11_4 == ({
		"d",
		"c",
		"b",
		"a",
		"s"
	})[1] or var_11_4 == ({
		"d",
		"c",
		"b",
		"a",
		"s"
	})[2]) then
		arg_11_0.failTag = true
	end

	return
end

function var_0_0.displayerCommanders(arg_12_0, arg_12_1)
	arg_12_0.commanderExps = arg_12_0.contextData.commanderExps or {}

	local var_12_0 = getProxy(CommanderProxy)

	removeAllChildren(arg_12_0._cmdContainer)

	local var_12_1 = arg_12_1 and (arg_12_0.commanderExps.submarineCMD or {}) or arg_12_0.commanderExps.surfaceCMD or {}

	setActive(arg_12_0._cmdExp, true)

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = var_12_0:getCommanderById(iter_12_1.commander_id)
		local var_12_3 = cloneTplTo(arg_12_0._cmdTpl, arg_12_0._cmdContainer)

		GetImageSpriteFromAtlasAsync("commandericon/" .. var_12_2:getPainting(), "", var_12_3:Find("icon/mask/pic"))
		setText(var_12_3:Find("exp/name_text"), var_12_2:getName())
		setText(var_12_3:Find("exp/lv_text"), "Lv." .. var_12_2.level)
		setText(var_12_3:Find("exp/exp_text"), "+" .. iter_12_1.exp)

		local var_12_5 = var_12_3:Find("exp/exp_progress")

		var_12_5:GetComponent(typeof(Image)).fillAmount = var_12_2:isMaxLevel() and 1 or iter_12_1.curExp / var_12_2:getNextLevelExp()
	end

	return
end

function var_0_0.didEnter(arg_13_0)
	arg_13_0:setStageName()
	arg_13_0:customsLang()

	arg_13_0._shipResultCardList, arg_13_0._subShipResultCardList = {}, {}

	local var_13_0 = rtf(arg_13_0._grade)

	arg_13_0._gradeUpperLeftPos = var_13_0.localPosition
	var_13_0.localPosition = Vector3(0, 25, 0)

	arg_13_0:BlurPanel(arg_13_0._tf, {
		staticBlur = true,
		lockGlobalBlur = true
	})

	if arg_13_0.contextData.system ~= SYSTEM_BOSS_RUSH and arg_13_0.contextData.system ~= SYSTEM_BOSS_RUSH_EX and arg_13_0.contextData.system ~= SYSTEM_BOSS_RUSH_COLLABRATE and arg_13_0.contextData.system ~= SYSTEM_ACT_BOSS and arg_13_0.contextData.system ~= SYSTEM_BOSS_SINGLE and arg_13_0.contextData.system ~= SYSTEM_BOSS_SINGLE_VARIABLE then
		ys.Battle.BattleCameraUtil.GetInstance().ActiveMainCamera(false)
	end

	arg_13_0._grade.transform.localScale = Vector3(1.5, 1.5, 0)

	LeanTween.scale(arg_13_0._grade, Vector3(0.88, 0.88, 1), var_0_0.DURATION_WIN_SCALE):setOnComplete(System.Action(function()
		SetActive(arg_13_0._levelText, true)
		arg_13_0:rankAnimaFinish()

		return
	end))

	arg_13_0._tf:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0.5)

	SetActive(arg_13_0._atkBG, false)
	onToggle(arg_13_0, arg_13_0._subToggle, function(arg_15_0)
		SetActive(arg_13_0._subExpResult, not arg_15_0)
		SetActive(arg_13_0._expResult, arg_15_0)
		setActive(arg_13_0._subToggle:Find("off"), not arg_15_0)
		arg_13_0:displayerCommanders(not arg_15_0)

		return
	end, SFX_PANEL)

	arg_13_0._stateFlag = var_0_0.STATE_RANK_ANIMA

	onButton(arg_13_0, arg_13_0._skipBtn, function()
		arg_13_0:skip()

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.setStageName(arg_17_0)
	if arg_17_0.contextData.system and arg_17_0.contextData.system == SYSTEM_DUEL then
		if arg_17_0.rivalVO then
			setText(arg_17_0._levelText, arg_17_0.rivalVO.name)
		else
			setText(arg_17_0._levelText, "")
		end
	else
		setText(arg_17_0._levelText, pg.expedition_data_template[arg_17_0.contextData.stageId].name)
	end

	return
end

function var_0_0.rankAnimaFinish(arg_18_0)
	SetActive(arg_18_0._tf:Find("main/conditions"), true)
	;(function(arg_19_0)
		if type(arg_19_0) == "table" then
			arg_18_0:setCondition(i18n(var_0_0.ObjectiveList[arg_19_0[1]], arg_19_0[2]), var_0_0.objectiveCheck(arg_19_0[1], arg_18_0.contextData))
		end

		return
	end)(pg.expedition_data_template[arg_18_0.contextData.stageId].objective_1)
	;(function(arg_19_0)
		if type(arg_19_0) == "table" then
			arg_18_0:setCondition(i18n(var_0_0.ObjectiveList[arg_19_0[1]], arg_19_0[2]), var_0_0.objectiveCheck(arg_19_0[1], arg_18_0.contextData))
		end

		return
	end)(pg.expedition_data_template[arg_18_0.contextData.stageId].objective_2)
	;(function(arg_19_0)
		if type(arg_19_0) == "table" then
			arg_18_0:setCondition(i18n(var_0_0.ObjectiveList[arg_19_0[1]], arg_19_0[2]), var_0_0.objectiveCheck(arg_19_0[1], arg_18_0.contextData))
		end

		return
	end)(pg.expedition_data_template[arg_18_0.contextData.stageId].objective_3)
	table.insert(arg_18_0._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		arg_18_0._stateFlag = var_0_0.STATE_REPORTED

		SetActive(arg_18_0._bg:Find("jieuan01/tips"), true)

		if arg_18_0.skipFlag then
			arg_18_0:skip()
		end

		return
	end)).id)

	arg_18_0._stateFlag = var_0_0.STATE_REPORT

	return
end

function var_0_0.objectiveCheck(arg_21_0, arg_21_1)
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

function var_0_0.setCondition(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = cloneTplTo(arg_22_0._conditionTpl, arg_22_0._conditionContainer)

	setActive(var_22_0, false)

	local var_22_1
	local var_22_2 = var_22_0:Find("text"):GetComponent(typeof(Text))

	if arg_22_2 == nil then
		var_22_1 = "resources/condition_check"
		var_22_2.text = setColorStr(arg_22_1, "#FFFFFFFF")
	elseif arg_22_2 == true then
		var_22_1 = "resources/condition_done"
		var_22_2.text = setColorStr(arg_22_1, "#FFFFFFFF")
	else
		var_22_1 = "resources/condition_fail"
		var_22_2.text = setColorStr(arg_22_1, "#FFFFFF80")
	end

	arg_22_0:setSpriteTo(var_22_1, var_22_0:Find("checkBox"), true)

	if arg_22_0._conditionContainer.childCount - 1 > 0 then
		table.insert(arg_22_0._delayLeanList, LeanTween.delayedCall(var_0_0.CONDITIONS_FREQUENCE * (arg_22_0._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_22_0, true)

			return
		end)).id)
	else
		setActive(var_22_0, true)
	end

	return
end

function var_0_0.showRewardInfo(arg_24_0)
	arg_24_0._stateFlag = var_0_0.STATE_REWARD

	if arg_24_0.contextData.system == SYSTEM_BOSS_RUSH or arg_24_0.contextData.system == SYSTEM_BOSS_RUSH_EX or arg_24_0.contextData.system == SYSTEM_BOSS_RUSH_COLLABRATE then
		arg_24_0:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)

		return
	end

	SetActive(arg_24_0._bg:Find("jieuan01/tips"), false)
	setParent(arg_24_0._tf, arg_24_0.UIMain)

	local var_24_0 = coroutine.create(function()
		local var_26_0 = arg_24_0.contextData.drops
		local var_26_1 = getProxy(ActivityProxy)
		local var_26_2 = var_26_1:getActivityById(ActivityConst.UTAWARERU_ACTIVITY_PT_ID)

		if var_26_2 and not var_26_2:isEnd() then
			local var_26_3 = var_26_2:getConfig("config_client").pt_id
			local var_26_4 = _.detect(var_26_1:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_27_0)
				return arg_27_0:getConfig("config_id") == var_26_3
			end):getData1()

			if var_26_4 >= 1500 then
				local var_26_5 = _.detect(var_26_0, function(arg_28_0)
					return arg_28_0.type == DROP_TYPE_RESOURCE and arg_28_0.id == var_26_3
				end)

				var_26_0 = _.filter(var_26_0, function(arg_29_0)
					return arg_29_0.type ~= DROP_TYPE_RESOURCE or arg_29_0.id ~= var_26_3
				end)

				if var_26_5 and var_26_4 - 1500 < var_26_5.count then
					var_26_5.count = var_26_5.count - (var_26_4 - 1500)

					table.insert(var_26_0, var_26_5)
				end
			end
		end

		local var_26_6 = {}

		for iter_26_0, iter_26_1 in ipairs(arg_24_0.contextData.drops) do
			table.insert(var_26_6, iter_26_1)
		end

		for iter_26_2, iter_26_3 in ipairs(arg_24_0.contextData.extraDrops) do
			iter_26_3.riraty = true

			table.insert(var_26_6, iter_26_3)
		end

		local var_26_7 = false

		for iter_26_4, iter_26_5 in ipairs(arg_24_0.contextData.extraBuffList) do
			if pg.benefit_buff_template[iter_26_5].benefit_type == Chapter.OPERATION_BUFF_TYPE_REWARD then
				var_26_7 = true

				break
			end
		end

		if table.getCount(var_26_0) > 0 then
			local var_26_8 = arg_24_0.skipFlag
			local var_26_9 = false

			if arg_24_0.contextData.system == SYSTEM_SCENARIO then
				local var_26_10 = getProxy(ChapterProxy):getActiveChapter(true)

				if var_26_10 then
					if var_26_10:isLoop() then
						getProxy(ChapterProxy):AddExtendChapterDataArray(var_26_10.id, "TotalDrops", var_26_6)

						var_26_9 = getProxy(ChapterProxy):GetChapterAutoFlag(var_26_10.id) == 1
					end

					var_26_10:writeDrops(var_26_6)
				end
			elseif arg_24_0.contextData.system == SYSTEM_ACT_BOSS then
				if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
					getProxy(ChapterProxy):AddActBossRewards(var_26_6)
				end
			elseif arg_24_0.contextData.system == SYSTEM_BOSS_SINGLE then
				if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator) then
					getProxy(ChapterProxy):AddBossSingleRewards(var_26_6)
				end
			elseif arg_24_0.contextData.system == SYSTEM_BOSS_SINGLE_VARIABLE then
				-- block empty
			end

			arg_24_0:emit(BaseUI.ON_AWARD, {
				items = var_26_6,
				extraBonus = var_26_7,
				removeFunc = var_0,
				closeOnCompleted = var_26_8
			})
			coroutine.yield()

			local var_26_11 = getProxy(BayProxy):getNewShip(true)

			for iter_26_6 = math.max(1, #var_26_11 - #_.filter(var_26_6, function(arg_30_0)
				return arg_30_0.type == DROP_TYPE_SHIP
			end) + 1), #var_26_11 do
				local var_26_12 = var_26_11[iter_26_6]

				if PlayerPrefs.GetInt(DISPLAY_SHIP_GET_EFFECT) ~= 1 then
					local var_26_13 = var_26_12.virgin

					if not var_26_12.virgin then
						if var_26_12:getRarity() < ShipRarity.Purple then
							var_26_13 = false

							goto label_26_0
						end

						var_26_13 = true
					end

					::label_26_0::

					if var_26_13 then
						arg_24_0:emit(BattleResultMediator.GET_NEW_SHIP, var_26_12, var_0, var_26_9 and not var_26_12.virgin and 3 or nil)
						coroutine.yield()
					end
				end
			end
		end

		setParent(arg_24_0._tf, arg_24_0.overlay)
		arg_24_0:displayBG()

		return
	end)

	;(function()
		if var_24_0 and coroutine.status(var_24_0) == "suspended" then
			local var_25_0, var_25_1 = coroutine.resume(var_24_0)

			assert(var_25_0, var_25_1)
		end

		return
	end)()

	return
end

function var_0_0.displayBG(arg_31_0)
	local function var_31_0()
		arg_31_0:displayShips()
		arg_31_0:displayPlayerInfo()
		arg_31_0:displayerCommanders()
		arg_31_0:initMetaBtn()

		arg_31_0._stateFlag = var_0_0.STATE_DISPLAY

		if arg_31_0.skipFlag then
			arg_31_0:skip()
		end

		return
	end

	LeanTween.moveX(rtf(arg_31_0._conditions), 1300, var_0_0.DURATION_MOVE)
	LeanTween.scale(arg_31_0._grade, Vector3(0.6, 0.6, 0), var_0_0.DURATION_MOVE)
	LeanTween.moveLocal(go((rtf(arg_31_0._grade))), arg_31_0._gradeUpperLeftPos, var_0_0.DURATION_MOVE)
	setActive(arg_31_0._bg:Find("jieuan01/Bomb"), false)
	onDelayTick(function()
		setLocalScale(arg_31_0._grade, Vector3(0.6, 0.6, 0))
		setAnchoredPosition(arg_31_0._grade, arg_31_0._gradeUpperLeftPos)
		var_31_0()

		return
	end, var_0_0.DURATION_MOVE)

	return
end

function var_0_0.displayPlayerInfo(arg_34_0)
	local var_34_0 = arg_34_0:calcPlayerProgress()

	SetActive(arg_34_0._leftPanel, true)
	SetActive(arg_34_0._playerExp, true)

	arg_34_0._main:GetComponent("Animator").enabled = true

	table.insert(arg_34_0._delayLeanList, LeanTween.moveX(rtf(arg_34_0._leftPanel), 0, 0.5):setOnComplete(System.Action(function()
		table.insert(arg_34_0._delayLeanList, LeanTween.value(go(arg_34_0._tf), 0, var_34_0, 1):setOnUpdate(System.Action_float(function(arg_36_0)
			setText(arg_34_0._playerBonusExp, "+" .. math.floor(arg_36_0))

			return
		end)).id)

		return
	end)).id)

	return
end

function var_0_0.calcPlayerExp(arg_37_0)
	local var_37_0 = arg_37_0.contextData.oldPlayer.level
	local var_37_1 = arg_37_0.player.exp - arg_37_0.contextData.oldPlayer.exp

	while var_37_0 < arg_37_0.player.level do
		var_37_1 = var_37_1 + pg.user_level[var_37_0].exp
		var_37_0 = var_37_0 + 1
	end

	if var_37_0 == pg.user_level[#pg.user_level].level then
		var_37_1 = 0
	end

	return var_37_1
end

function var_0_0.calcPlayerRank(arg_38_0)
	return arg_38_0.season.score - arg_38_0.contextData.oldRank.score
end

function var_0_0.displayShips(arg_39_0)
	for iter_39_0, iter_39_1 in ipairs(arg_39_0.shipVOs) do
		({})[iter_39_1.id] = iter_39_1
	end

	local var_39_0 = arg_39_0.contextData.statistics

	for iter_39_2, iter_39_3 in ipairs(arg_39_0.shipVOs) do
		if var_39_0[iter_39_3.id] then
			var_39_0[iter_39_3.id].vo = iter_39_3
		end
	end

	local var_39_1
	local var_39_2

	if var_39_0.mvpShipID == -1 then
		var_39_2 = 0

		for iter_39_4, iter_39_5 in ipairs(arg_39_0.contextData.oldMainShips) do
			var_39_2 = math.max(var_39_0[iter_39_5.id].output, var_39_2)
		end
	elseif var_39_0.mvpShipID and var_39_0.mvpShipID ~= 0 then
		var_39_1 = var_39_0[var_39_0.mvpShipID]
		var_39_2 = var_39_0[var_39_0.mvpShipID].output
	else
		var_39_2 = 0
	end

	local var_39_3 = arg_39_0.contextData.oldMainShips

	arg_39_0._atkFuncs = {}

	local var_39_4
	local var_39_5

	SetActive(arg_39_0._atkToggle, #var_39_3 > 6)

	if #var_39_3 > 6 then
		onToggle(arg_39_0, arg_39_0._atkToggle, function(arg_40_0)
			SetActive(arg_39_0._atkContainer, arg_40_0)
			SetActive(arg_39_0._atkContainerNext, not arg_40_0)

			if arg_40_0 then
				arg_39_0:skipAtkAnima(arg_39_0._atkContainerNext)
			else
				arg_39_0:skipAtkAnima(arg_39_0._atkContainer)
			end

			return
		end, SFX_PANEL)
	end

	for iter_39_6, iter_39_7 in ipairs(var_39_3) do
		local var_39_8 = ({})[iter_39_7.id]

		if var_39_0[iter_39_7.id] then
			local var_39_9 = table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_39_7.configId).type)
			local var_39_11
			local var_39_13

			if iter_39_6 > 6 then
				var_39_11 = arg_39_0._atkContainerNext
				var_39_13 = 7
			else
				var_39_11 = arg_39_0._atkContainer
				var_39_13 = 1
			end

			local var_39_14 = cloneTplTo(arg_39_0._atkTpl, var_39_11)

			var_39_14.localPosition.x = var_39_14.localPosition.x + (iter_39_6 - var_39_13) * 74
			var_39_14.localPosition.y = var_39_14.localPosition.y + (iter_39_6 - var_39_13) * 4
			var_39_14.localPosition = var_39_14.localPosition

			local var_39_15 = findTF(var_39_14, "result/stars")
			local var_39_16 = findTF(var_39_14, "result/stars/star_tpl")
			local var_39_17 = iter_39_7:getStar()
			local var_39_18 = iter_39_7:getMaxStar()

			while var_39_18 > 0 do
				local var_39_19 = cloneTplTo(var_39_16, var_39_15)

				SetActive(var_39_19:Find("empty"), var_39_17 < var_39_18)
				SetActive(var_39_19:Find("star"), var_39_18 <= var_39_17)

				var_39_18 = var_39_18 - 1
			end

			local var_39_20 = var_39_14:Find("result/mask/icon")
			local var_39_21 = var_39_14:Find("result/type")

			var_39_20:GetComponent(typeof(Image)).sprite = LoadSprite("herohrzicon/" .. iter_39_7:getPainting())

			setImageSprite(var_39_21, GetSpriteFromAtlas("shiptype", shipType2print(iter_39_7:getShipType())), true)
			arg_39_0:setAtkAnima(var_39_14, var_39_11, var_39_0[iter_39_7.id].output / var_39_2, var_39_2, var_39_1 and iter_39_7.id == var_39_1.id, var_39_0[iter_39_7.id].output, var_39_0[iter_39_7.id].kill_count)

			local var_39_23 = false

			if var_39_1 and iter_39_7.id == var_39_1.id then
				var_39_23 = true
				arg_39_0.mvpShipVO = iter_39_7

				local var_39_26

				if arg_39_0.contextData.score > 1 then
					local var_39_27, var_39_28

					var_39_27, var_39_26, var_39_28 = ShipWordHelper.GetWordAndCV(arg_39_0.mvpShipVO.skinId, ShipWordHelper.WORD_TYPE_MVP, nil, nil, arg_39_0.mvpShipVO:getCVIntimacy())
				else
					local var_39_29, var_39_30

					var_39_29, var_39_26, var_39_30 = ShipWordHelper.GetWordAndCV(arg_39_0.mvpShipVO.skinId, ShipWordHelper.WORD_TYPE_LOSE)
				end

				if var_39_26 then
					arg_39_0:stopVoice()
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_39_26, function(arg_41_0)
						arg_39_0._currentVoice = arg_41_0

						return
					end)
				end
			end

			if iter_39_7.id == var_39_0._flagShipID then
				arg_39_0.flagShipVO = iter_39_7
			end

			local var_39_31
			local var_39_32 = arg_39_0.shipBuff and arg_39_0.shipBuff[iter_39_7:getGroupId()]
			local var_39_33 = arg_39_0.expBuff or var_39_32

			if var_39_33 then
				var_39_31 = arg_39_0.expBuff and arg_39_0.expBuff:getConfig("name") or var_39_32 and i18n("Word_Ship_Exp_Buff")
			end

			local var_39_34

			if not var_39_9 then
				var_39_34 = BattleResultShipCard.New((cloneTplTo(arg_39_0._extpl, arg_39_0._expContainer)))

				table.insert(arg_39_0._shipResultCardList, var_39_34)

				if var_39_5 then
					var_39_5:ConfigCallback(function()
						var_39_34:Play()

						return
					end)
				else
					var_39_34:Play()
				end

				var_39_5 = var_39_34
			else
				var_39_34 = BattleResultShipCard.New((cloneTplTo(arg_39_0._extpl, arg_39_0._subExpContainer)))

				table.insert(arg_39_0._subShipResultCardList, var_39_34)

				if not var_39_4 then
					arg_39_0._subFirstExpCard = var_39_34
				else
					var_39_4:ConfigCallback(function()
						var_39_34:Play()

						return
					end)
				end

				var_39_4 = var_39_34
			end

			var_39_34:SetShipVO(iter_39_7, var_39_8, var_39_23, var_39_31)
		end
	end

	if var_39_5 then
		var_39_5:ConfigCallback(function()
			arg_39_0._stateFlag = var_0_0.STATE_DISPLAYED

			if not arg_39_0._subFirstExpCard then
				arg_39_0:skip()
			end

			return
		end)
	end

	if var_39_4 then
		var_39_4:ConfigCallback(function()
			arg_39_0._stateFlag = var_0_0.STATE_SUB_DISPLAYED

			arg_39_0:skip()

			return
		end)
	end

	return
end

function var_0_0.stopVoice(arg_46_0)
	if arg_46_0._currentVoice then
		arg_46_0._currentVoice:PlaybackStop()

		arg_46_0._currentVoice = nil
	end

	return
end

function var_0_0.setAtkAnima(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4, arg_47_5, arg_47_6, arg_47_7)
	local var_47_0 = arg_47_1:Find("result")
	local var_47_1 = arg_47_1:Find("result/dmg_progress/progress_bar")
	local var_47_2 = arg_47_1:Find("result/killCount")

	setText(arg_47_1:Find("result/atk"), 0)
	setText(arg_47_1:Find("result/killCount"), 0)

	arg_47_1:Find("result/dmg_progress/progress_bar"):GetComponent(typeof(Image)).fillAmount = 0

	if arg_47_5 then
		local var_47_3 = arg_47_1:Find("result/mvpBG")

		setParent(arg_47_0._mvpFX, var_47_3)

		arg_47_0._mvpFX.localPosition = Vector3(-368.5, 0, 0)

		setActive(var_47_3, true)
		setActive(arg_47_1:Find("result/bg"), false)
	end

	var_47_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_48_0)
		if arg_47_5 then
			setActive(arg_47_0._mvpFX, true)
		end

		LeanTween.value(go(var_47_0), 0, arg_47_3, arg_47_3):setOnUpdate(System.Action_float(function(arg_49_0)
			var_47_1:GetComponent(typeof(Image)).fillAmount = arg_49_0

			return
		end))

		if arg_47_4 ~= 0 then
			LeanTween.value(go(var_47_0), 0, arg_47_6, arg_47_3):setOnUpdate(System.Action_float(function(arg_50_0)
				setText(var_0, math.floor(arg_50_0))

				return
			end))
			LeanTween.value(go(var_47_0), 0, arg_47_7, arg_47_3):setOnUpdate(System.Action_float(function(arg_51_0)
				setText(var_47_2, math.floor(arg_51_0))

				return
			end))
		end

		return
	end)

	if arg_47_2.childCount > 1 then
		arg_47_2:GetChild(arg_47_2.childCount - 2):Find("result"):GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function(arg_52_0)
			setActive(var_47_0, true)

			return
		end)
	else
		setActive(var_47_0, true)
	end

	local function var_47_4()
		var_47_1:GetComponent(typeof(Image)).fillAmount = arg_47_3

		setText(var_0, arg_47_6)
		setText(var_47_2, arg_47_7)

		var_47_0.localPosition = Vector3(280, 46, 0)
		var_47_0:GetComponent(typeof(Animator)).enabled = false

		setActive(var_47_0, true)
		setActive(arg_47_0._mvpFX, true)

		return
	end

	if arg_47_0._atkFuncs[arg_47_2] == nil then
		arg_47_0._atkFuncs[arg_47_2] = {}
	end

	table.insert(arg_47_0._atkFuncs[arg_47_2], var_47_4)

	return
end

function var_0_0.skipAtkAnima(arg_54_0, arg_54_1)
	if arg_54_0._atkFuncs[arg_54_1] then
		for iter_54_0, iter_54_1 in ipairs(arg_54_0._atkFuncs[arg_54_1]) do
			iter_54_1()
		end

		arg_54_0._atkFuncs[arg_54_1] = nil
	end

	return
end

function var_0_0.showPainting(arg_55_0)
	local var_55_1

	SetActive(arg_55_0._painting, true)

	if arg_55_0.contextData.score > 1 then
		local var_55_3 = arg_55_0.mvpShipVO or arg_55_0.flagShipVO

		arg_55_0.paintingName = var_55_3:getPainting()

		local var_55_4 = var_55_3:getCVIntimacy()

		setPaintingPrefabAsync(arg_55_0._painting, arg_55_0.paintingName, "jiesuan", function()
			if findTF(arg_55_0._painting, "fitter").childCount > 0 then
				ShipExpressionHelper.SetExpression(findTF(arg_55_0._painting, "fitter"):GetChild(0), arg_55_0.paintingName, "win_mvp", var_55_4)
			end

			return
		end)

		local var_55_5, var_55_6

		var_55_5, var_55_6, var_55_1 = ShipWordHelper.GetWordAndCV(var_55_3.skinId, ShipWordHelper.WORD_TYPE_MVP, nil, nil, (var_55_3:getCVIntimacy()))

		SetActive(arg_55_0._failPainting, false)
	else
		local var_55_7, var_55_8

		var_55_7, var_55_8, var_55_1 = ShipWordHelper.GetWordAndCV(arg_55_0.contextData.oldMainShips[math.random(#arg_55_0.contextData.oldMainShips)].skinId, ShipWordHelper.WORD_TYPE_LOSE)
	end

	setText(arg_55_0._chat:Find("Text"), var_55_1)

	local var_55_9 = arg_55_0._chat:Find("Text"):GetComponent(typeof(Text))

	var_55_9.alignment = #var_55_9.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	SetActive(arg_55_0._chat, true)

	arg_55_0._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.cancel(go(arg_55_0._painting))
	LeanTween.moveX(rtf(arg_55_0._painting), 50, 0.25):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(arg_55_0._chat.gameObject), Vector3.New(1, 1, 1), 0.3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
			arg_55_0._statisticsBtn:GetComponent("Button").enabled = true
			arg_55_0._confirmBtn:GetComponent("Button").enabled = true
			arg_55_0._atkBG:GetComponent("Button").enabled = true

			return
		end))

		return
	end))

	return
end

function var_0_0.hidePainting(arg_59_0)
	SetActive(arg_59_0._chat, false)

	arg_59_0._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.cancel(go(arg_59_0._painting))
	LeanTween.scale(rtf(arg_59_0._chat.gameObject), Vector3.New(0, 0, 0), 0.1):setEase(LeanTweenType.easeOutBack)
	LeanTween.moveX(rtf(arg_59_0._painting), 720, 0.2):setOnComplete(System.Action(function()
		SetActive(arg_59_0._painting, false)

		return
	end))

	return
end

function var_0_0.skip(arg_61_0)
	for iter_61_0, iter_61_1 in ipairs(arg_61_0._delayLeanList) do
		LeanTween.cancel(iter_61_1)
	end

	if arg_61_0._stateFlag == var_0_0.STATE_RANK_ANIMA then
		-- block empty
	elseif arg_61_0._stateFlag == var_0_0.STATE_REPORT then
		while arg_61_0._conditionContainer.childCount > 0 do
			SetActive(arg_61_0._conditionContainer:GetChild(arg_61_0._conditionContainer.childCount - 1), true)
		end

		SetActive(arg_61_0._bg:Find("jieuan01/tips"), true)

		arg_61_0._stateFlag = var_0_0.STATE_REPORTED

		arg_61_0:skip()
	elseif arg_61_0._stateFlag == var_0_0.STATE_REPORTED then
		arg_61_0:showRewardInfo()
	elseif arg_61_0._stateFlag == var_0_0.STATE_REWARD then
		-- block empty
	elseif arg_61_0._stateFlag == var_0_0.STATE_DISPLAY then
		for iter_61_2, iter_61_3 in ipairs(arg_61_0._shipResultCardList) do
			iter_61_3:SkipAnimation()
		end

		arg_61_0._stateFlag = var_0_0.STATE_DISPLAYED

		setText(arg_61_0._playerBonusExp, "+" .. arg_61_0:calcPlayerProgress())

		if not arg_61_0._subFirstExpCard then
			arg_61_0:playSubExEnter()
		elseif arg_61_0.skipFlag then
			arg_61_0:skip()
		end
	elseif arg_61_0._stateFlag == var_0_0.STATE_DISPLAYED then
		setText(arg_61_0._playerBonusExp, "+" .. arg_61_0:calcPlayerProgress())
		arg_61_0:playSubExEnter()
	elseif arg_61_0._stateFlag == var_0_0.STATE_SUB_DISPLAY then
		for iter_61_4, iter_61_5 in ipairs(arg_61_0._subShipResultCardList) do
			iter_61_5:SkipAnimation()
		end

		arg_61_0._stateFlag = var_0_0.STATE_SUB_DISPLAYED

		if arg_61_0.skipFlag then
			arg_61_0:skip()
		end
	elseif arg_61_0._stateFlag == var_0_0.STATE_SUB_DISPLAYED then
		arg_61_0:showRightBottomPanel()
	end

	return
end

function var_0_0.playSubExEnter(arg_62_0)
	arg_62_0._stateFlag = var_0_0.STATE_SUB_DISPLAY

	if arg_62_0._subFirstExpCard then
		triggerToggle(arg_62_0._subToggle, false)
		arg_62_0._subFirstExpCard:Play()
	else
		arg_62_0:showRightBottomPanel()
	end

	if arg_62_0.skipFlag then
		arg_62_0:skip()
	end

	return
end

function var_0_0.showRightBottomPanel(arg_63_0)
	SetActive(arg_63_0._skipBtn, false)
	SetActive(arg_63_0._rightBottomPanel, true)
	SetActive(arg_63_0._subToggle, arg_63_0._subFirstExpCard ~= nil)
	onButton(arg_63_0, arg_63_0._statisticsBtn, function()
		if arg_63_0._atkBG.gameObject.activeSelf then
			arg_63_0:closeStatistics()
		else
			arg_63_0:showStatistics()
		end

		return
	end, SFX_PANEL)
	onButton(arg_63_0, arg_63_0._confirmBtn, function()
		if arg_63_0.failTag == true then
			arg_63_0:emit(BattleResultMediator.PRE_BATTLE_FAIL_EXIT)
			arg_63_0:emit(BattleResultMediator.OPEN_FAIL_TIP_LAYER)
		else
			arg_63_0:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_63_0, arg_63_0._atkBG, function()
		arg_63_0:closeStatistics()

		return
	end, SFX_CANCEL)

	arg_63_0._stateFlag = nil
	arg_63_0._subFirstExpCard = nil

	if arg_63_0.skipFlag then
		triggerButton(arg_63_0._confirmBtn)
	end

	return
end

function var_0_0.showStatistics(arg_67_0)
	setActive(arg_67_0._leftPanel, false)
	arg_67_0:enabledStatisticsGizmos(false)
	SetActive(arg_67_0._atkBG, true)

	arg_67_0._atkBG:GetComponent("Button").enabled = false
	arg_67_0._confirmBtn:GetComponent("Button").enabled = false
	arg_67_0._statisticsBtn:GetComponent("Button").enabled = false

	arg_67_0:showPainting()
	LeanTween.moveX(rtf(arg_67_0._atkPanel), 0, 0.25):setOnComplete(System.Action(function()
		SetActive(arg_67_0._atkContainer, true)

		return
	end))

	return
end

function var_0_0.closeStatistics(arg_69_0)
	setActive(arg_69_0._leftPanel, true)
	arg_69_0:skipAtkAnima(arg_69_0._atkContainerNext)
	arg_69_0:skipAtkAnima(arg_69_0._atkContainer)
	arg_69_0:enabledStatisticsGizmos(true)
	arg_69_0:hidePainting()

	arg_69_0._atkBG:GetComponent("Button").enabled = false

	LeanTween.cancel(arg_69_0._atkPanel.gameObject)
	LeanTween.moveX(rtf(arg_69_0._atkPanel), -700, 0.2):setOnComplete(System.Action(function()
		SetActive(arg_69_0._atkBG, false)

		return
	end))

	return
end

function var_0_0.enabledStatisticsGizmos(arg_71_0, arg_71_1)
	setActive(arg_71_0._main:Find("gizmos/xuxian_down"), arg_71_1)
	setActive(arg_71_0._main:Find("gizmos/xuxian_middle"), arg_71_1)

	return
end

function var_0_0.PlayAnimation(arg_72_0, arg_72_1, arg_72_2, arg_72_3, arg_72_4, arg_72_5, arg_72_6)
	LeanTween.value(arg_72_1.gameObject, arg_72_2, arg_72_3, arg_72_4):setDelay(arg_72_5):setOnUpdate(System.Action_float(function(arg_73_0)
		arg_72_6(arg_73_0)

		return
	end))

	return
end

function var_0_0.SetSkipFlag(arg_74_0, arg_74_1)
	arg_74_0.skipFlag = arg_74_1

	return
end

function var_0_0.initMetaBtn(arg_75_0)
	arg_75_0.metaBtn = arg_75_0._main:Find("MetaBtn")

	local var_75_0 = getProxy(MetaCharacterProxy):getLastMetaSkillExpInfoList()

	setActive(arg_75_0.metaBtn, var_75_0 and #var_75_0 > 0 or false)
	onButton(arg_75_0, arg_75_0.metaBtn, function()
		setActive(arg_75_0.metaBtn, false)

		if not arg_75_0.metaExpView then
			arg_75_0.metaExpView = BattleResultMetaExpView.New(arg_75_0._blurConatiner, arg_75_0.event, arg_75_0.contextData)

			arg_75_0.metaExpView:setData(var_75_0, function()
				if arg_75_0.metaBtn then
					setActive(arg_75_0.metaBtn, true)
				end

				arg_75_0.metaExpView = nil

				return
			end)
			arg_75_0.metaExpView:Reset()
			arg_75_0.metaExpView:Load()
			arg_75_0.metaExpView:ActionInvoke("Show")
			arg_75_0.metaExpView:ActionInvoke("openPanel")
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.onBackPressed(arg_78_0)
	if arg_78_0.metaExpView then
		arg_78_0.metaExpView:closePanel()

		arg_78_0.metaExpView = nil

		return
	end

	if arg_78_0._stateFlag == var_0_0.STATE_RANK_ANIMA then
		-- block empty
	elseif arg_78_0._stateFlag == var_0_0.STATE_REPORT then
		triggerButton(arg_78_0._bg)
	elseif arg_78_0._stateFlag == var_0_0.STATE_REPORTED then
		triggerButton(arg_78_0._skipBtn)
	elseif arg_78_0._stateFlag == var_0_0.STATE_DISPLAY then
		triggerButton(arg_78_0._skipBtn)
	else
		triggerButton(arg_78_0._confirmBtn)
	end

	return
end

function var_0_0.willExit(arg_79_0)
	for iter_79_0, iter_79_1 in ipairs(arg_79_0._shipResultCardList) do
		iter_79_1:Dispose()
	end

	for iter_79_2, iter_79_3 in ipairs(arg_79_0._subShipResultCardList) do
		iter_79_3:Dispose()
	end

	arg_79_0._atkFuncs = nil

	LeanTween.cancel(go(arg_79_0._tf))

	if arg_79_0.paintingName then
		retPaintingPrefab(arg_79_0._painting, arg_79_0.paintingName)
	end

	if arg_79_0._rightTimer then
		arg_79_0._rightTimer:Stop()
	end

	arg_79_0:UnOverlayPanel(arg_79_0._tf)
	arg_79_0:stopVoice()
	getProxy(MetaCharacterProxy):clearLastMetaSkillExpInfoList()

	if arg_79_0.metaExpView then
		arg_79_0.metaExpView:Destroy()

		arg_79_0.metaExpView = nil
	end

	pg.CameraFixMgr.GetInstance():disconnect(arg_79_0.camEventId)

	return
end

return var_0_0
