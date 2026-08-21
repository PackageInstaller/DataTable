local var_0_0 = class("BattleWorldBossResultLayer", import("..base.BaseUI"))

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

function var_0_0.setRivalVO(arg_2_0, arg_2_1)
	arg_2_0.rivalVO = arg_2_1

	return
end

function var_0_0.setRank(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.player = arg_3_1
	arg_3_0.season = arg_3_2

	setText(arg_3_0._playerName, "<color=#FFFFFF>" .. arg_3_0.player.name .. "</color><size=32> / C O M M A N D E R</size>")

	local var_3_0, var_3_1 = SeasonInfo.getNextMilitaryRank(arg_3_2.score, arg_3_2.rank)

	setText(arg_3_0._playerLv, SeasonInfo.getMilitaryRank(arg_3_2.score, arg_3_2.rank).name)
	setText(arg_3_0._playerExpLabel, i18n("word_rankScore"))

	arg_3_0._playerExpProgress:GetComponent(typeof(Image)).fillAmount = arg_3_2.score / var_3_1

	setText(arg_3_0._playerBonusExp, "+0")

	arg_3_0.calcPlayerProgress = arg_3_0.calcPlayerRank

	return
end

function var_0_0.setShips(arg_4_0, arg_4_1)
	arg_4_0.shipVOs = arg_4_1

	return
end

function var_0_0.setPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	setText(arg_5_0._playerName, "<color=#FFFFFF>" .. arg_5_0.player.name .. "</color><size=32> / C O M M A N D E R</size>")
	setText(arg_5_0._playerLv, "Lv." .. arg_5_0.player.level)

	arg_5_0._playerExpProgress:GetComponent(typeof(Image)).fillAmount = arg_5_0.player.exp / getConfigFromLevel1(pg.user_level, arg_5_0.player.level).exp_interval

	if arg_5_0.player.level == pg.user_level[#pg.user_level].level then
		arg_5_0._playerExpProgress:GetComponent(typeof(Image)).fillAmount = 1
	end

	setText(arg_5_0._playerBonusExp, "+0")

	arg_5_0.calcPlayerProgress = arg_5_0.calcPlayerExp

	return
end

function var_0_0.setExpBuff(arg_6_0, arg_6_1)
	arg_6_0.expBuff = arg_6_1

	return
end

function var_0_0.init(arg_7_0)
	arg_7_0._grade = arg_7_0._tf:Find("grade")
	arg_7_0._gradeLabel = arg_7_0._grade:Find("label")
	arg_7_0._gradeLabelImg = arg_7_0._gradeLabel:GetComponent(typeof(Image))
	arg_7_0.title = arg_7_0._tf:Find("main/title")
	arg_7_0.subTitleTxt = arg_7_0._tf:Find("main/title/Text"):GetComponent(typeof(Text))
	arg_7_0._levelText = arg_7_0._grade:Find("chapterName/Text22")
	arg_7_0.clearFX = arg_7_0._tf:Find("clear")

	setParent(arg_7_0.title, arg_7_0._tf)

	arg_7_0._main = arg_7_0._tf:Find("main")
	arg_7_0._blurConatiner = arg_7_0._tf:Find("blur_container")
	arg_7_0._bg = arg_7_0._tf:Find("main/jiesuanbeijing")
	arg_7_0._painting = arg_7_0._blurConatiner:Find("painting")
	arg_7_0._failPainting = arg_7_0._painting:Find("fail")
	arg_7_0._chat = arg_7_0._painting:Find("chat")
	arg_7_0._leftPanel = arg_7_0._main:Find("leftPanel")
	arg_7_0._expResult = arg_7_0._leftPanel:Find("expResult")
	arg_7_0._expContainer = arg_7_0._expResult:Find("expContainer")
	arg_7_0._extpl = arg_7_0:getTpl("ShipCardTpl", arg_7_0._expContainer)
	arg_7_0._playerExp = arg_7_0._leftPanel:Find("playerExp")
	arg_7_0._playerName = arg_7_0._playerExp:Find("name_text")
	arg_7_0._playerLv = arg_7_0._playerExp:Find("lv_text")
	arg_7_0._playerExpLabel = arg_7_0._playerExp:Find("exp_label")
	arg_7_0._playerExpProgress = arg_7_0._playerExp:Find("exp_progress")
	arg_7_0._playerBonusExp = arg_7_0._playerExp:Find("exp_text")
	arg_7_0._playerExpExtra = arg_7_0._playerExp:Find("operation_bonus")
	arg_7_0._atkBG = arg_7_0._blurConatiner:Find("atkPanel")
	arg_7_0._atkPanel = arg_7_0._atkBG:Find("atkResult")
	arg_7_0._atkResult = arg_7_0._atkBG:Find("atkResult/result")
	arg_7_0._atkContainer = arg_7_0._atkResult:Find("Grid")
	arg_7_0._atkContainerNext = arg_7_0._atkResult:Find("Grid_next")
	arg_7_0._atkToggle = arg_7_0._atkPanel:Find("switchAtk")
	arg_7_0._atkTpl = arg_7_0:getTpl("resulttpl", arg_7_0._atkResult)
	arg_7_0._mvpFX = arg_7_0._atkPanel:Find("mvpFX")
	arg_7_0._rightBottomPanel = arg_7_0._blurConatiner:Find("rightBottomPanel")
	arg_7_0._confirmBtn = arg_7_0._rightBottomPanel:Find("confirmBtn")

	setText(arg_7_0._confirmBtn:Find("Text"), i18n("text_confirm"))

	arg_7_0._statisticsBtn = arg_7_0._rightBottomPanel:Find("statisticsBtn")
	arg_7_0._subExpResult = arg_7_0._leftPanel:Find("subExpResult")
	arg_7_0._subExpContainer = arg_7_0._subExpResult:Find("expContainer")
	arg_7_0._subToggle = arg_7_0._leftPanel:Find("switchFleet")
	arg_7_0._skipBtn = arg_7_0._tf:Find("skipLayer")
	arg_7_0.UIMain = pg.UIMgr.GetInstance().UIMain
	arg_7_0.overlay = pg.UIMgr.GetInstance().OverlayMain
	arg_7_0._conditions = arg_7_0._tf:Find("main/conditions")
	arg_7_0._conditionContainer = arg_7_0._conditions:Find("bg16/list")
	arg_7_0._conditionTpl = arg_7_0._conditions:Find("bg16/conditionTpl")
	arg_7_0._conditionSubTpl = arg_7_0._conditions:Find("bg16/conditionSubTpl")
	arg_7_0._cmdExp = arg_7_0._leftPanel:Find("commanderExp")
	arg_7_0._cmdContainer = arg_7_0._cmdExp:Find("commander_container")
	arg_7_0._cmdTpl = arg_7_0._cmdExp:Find("commander_tpl")

	local var_7_0 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_7_1 = arg_7_0._tf:Find("grade/Xyz/bg13")
	local var_7_2 = arg_7_0._tf:Find("grade/Xyz/bg14")
	local var_7_5
	local var_7_6 = arg_7_0.contextData.score
	local var_7_7
	local var_7_8 = arg_7_0.contextData.score > 0

	setActive(arg_7_0._bg:Find("jieuan01/BG/bg_victory"), arg_7_0.contextData.score > 0)
	setActive(arg_7_0._bg:Find("jieuan01/BG/bg_fail"), not var_7_8)

	if var_7_8 then
		var_7_5 = var_7_0[var_7_6 + 1]
	elseif arg_7_0.contextData.statistics._scoreMark == ys.Battle.BattleConst.DEAD_FLAG then
		var_7_5 = var_7_0[2]
		var_7_7 = "flag_destroy"
	else
		var_7_5 = var_7_0[1]
	end

	SetActive(arg_7_0._levelText, false)
	LoadImageSpriteAsync("battlescore/grade_label_clear", arg_7_0._gradeLabel, true)
	setActive(arg_7_0._gradeLabel, true)
	setActive(arg_7_0._grade:Find("Xyz"), false)
	setActive(arg_7_0._grade:Find("chapterName"), false)

	arg_7_0._gradeLabel.localScale = Vector3(1.2, 1.2, 1)
	arg_7_0._delayLeanList = {}
	arg_7_0._ratioFitter = GetComponent(arg_7_0._tf, typeof(AspectRatioFitter))
	arg_7_0._ratioFitter.enabled = true
	arg_7_0._ratioFitter.aspectRatio = pg.CameraFixMgr.GetInstance().targetRatio
	arg_7_0.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_8_0, arg_8_1)
		arg_7_0._ratioFitter.aspectRatio = arg_8_1

		return
	end)

	return
end

function var_0_0.displayerCommanders(arg_9_0, arg_9_1)
	arg_9_0.commanderExps = arg_9_0.contextData.commanderExps or {}

	local var_9_0 = getProxy(CommanderProxy)

	removeAllChildren(arg_9_0._cmdContainer)

	local var_9_1 = arg_9_1 and (arg_9_0.commanderExps.submarineCMD or {}) or arg_9_0.commanderExps.surfaceCMD or {}

	setActive(arg_9_0._cmdExp, true)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = var_9_0:getCommanderById(iter_9_1.commander_id)
		local var_9_3 = cloneTplTo(arg_9_0._cmdTpl, arg_9_0._cmdContainer)

		GetImageSpriteFromAtlasAsync("commandericon/" .. var_9_2:getPainting(), "", var_9_3:Find("icon/mask/pic"))
		setText(var_9_3:Find("exp/name_text"), var_9_2:getName())
		setText(var_9_3:Find("exp/lv_text"), "Lv." .. var_9_2.level)
		setText(var_9_3:Find("exp/exp_text"), "+" .. iter_9_1.exp)

		local var_9_5 = var_9_3:Find("exp/exp_progress")

		var_9_5:GetComponent(typeof(Image)).fillAmount = var_9_2:isMaxLevel() and 1 or iter_9_1.curExp / var_9_2:getNextLevelExp()
	end

	return
end

function var_0_0.didEnter(arg_10_0)
	arg_10_0:setStageName()

	arg_10_0._gradeUpperLeftPos = rtf(arg_10_0._grade).localPosition
	arg_10_0._gradeLabelImg.color = Color.New(1, 1, 1, 1)

	pg.UIMgr.GetInstance():BlurPanel(arg_10_0._tf)

	arg_10_0._tf:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0.5)

	SetActive(arg_10_0._atkBG, false)

	arg_10_0._stateFlag = var_0_0.STATE_REPORTED

	setText(arg_10_0.title, "")
	arg_10_0:skip()

	return
end

function var_0_0.setTitle(arg_11_0, arg_11_1)
	arg_11_0.name = arg_11_1

	return
end

function var_0_0.setStageName(arg_12_0)
	if arg_12_0.contextData.system and arg_12_0.contextData.system == SYSTEM_DUEL then
		setText(arg_12_0._levelText, arg_12_0.rivalVO.name)
	else
		setText(arg_12_0._levelText, pg.expedition_data_template[arg_12_0.contextData.stageId].name)
	end

	return
end

function var_0_0.rankAnimaFinish(arg_13_0)
	SetActive(arg_13_0._tf:Find("main/conditions"), true)
	;(function(arg_14_0)
		if type(arg_14_0) == "table" then
			arg_13_0:setCondition(i18n(var_0_0.ObjectiveList[arg_14_0[1]], arg_14_0[2]), var_0_0.objectiveCheck(arg_14_0[1], arg_13_0.contextData))
		end

		return
	end)(pg.expedition_data_template[arg_13_0.contextData.stageId].objective_1)
	;(function(arg_14_0)
		if type(arg_14_0) == "table" then
			arg_13_0:setCondition(i18n(var_0_0.ObjectiveList[arg_14_0[1]], arg_14_0[2]), var_0_0.objectiveCheck(arg_14_0[1], arg_13_0.contextData))
		end

		return
	end)(pg.expedition_data_template[arg_13_0.contextData.stageId].objective_2)
	;(function(arg_14_0)
		if type(arg_14_0) == "table" then
			arg_13_0:setCondition(i18n(var_0_0.ObjectiveList[arg_14_0[1]], arg_14_0[2]), var_0_0.objectiveCheck(arg_14_0[1], arg_13_0.contextData))
		end

		return
	end)(pg.expedition_data_template[arg_13_0.contextData.stageId].objective_3)
	table.insert(arg_13_0._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		arg_13_0._stateFlag = var_0_0.STATE_REPORTED

		SetActive(arg_13_0._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	arg_13_0._stateFlag = var_0_0.STATE_REPORT

	return
end

function var_0_0.objectiveCheck(arg_16_0, arg_16_1)
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

function var_0_0.setCondition(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = cloneTplTo(arg_17_0._conditionTpl, arg_17_0._conditionContainer)

	setActive(var_17_0, false)

	local var_17_1
	local var_17_2 = var_17_0:Find("text"):GetComponent(typeof(Text))

	if arg_17_2 == nil then
		var_17_1 = "resources/condition_check"
		var_17_2.text = setColorStr(arg_17_1, "#FFFFFFFF")
	elseif arg_17_2 == true then
		var_17_1 = "resources/condition_done"
		var_17_2.text = setColorStr(arg_17_1, "#FFFFFFFF")
	else
		var_17_1 = "resources/condition_fail"
		var_17_2.text = setColorStr(arg_17_1, "#FFFFFF80")
	end

	arg_17_0:setSpriteTo(var_17_1, var_17_0:Find("checkBox"), true)

	if arg_17_0._conditionContainer.childCount - 1 > 0 then
		table.insert(arg_17_0._delayLeanList, LeanTween.delayedCall(var_0_0.CONDITIONS_FREQUENCE * (arg_17_0._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_17_0, true)

			return
		end)).id)
	else
		setActive(var_17_0, true)
	end

	return
end

function var_0_0.showRewardInfo(arg_19_0, arg_19_1)
	arg_19_0._stateFlag = var_0_0.STATE_REWARD

	SetActive(arg_19_0._bg:Find("jieuan01/tips"), false)
	setParent(arg_19_0._tf, arg_19_0.UIMain)

	local var_19_0 = coroutine.create(function()
		for iter_21_0, iter_21_1 in ipairs(arg_19_0.contextData.drops) do
			table.insert({}, iter_21_1)
		end

		for iter_21_2, iter_21_3 in ipairs(arg_19_0.contextData.extraDrops) do
			iter_21_3.riraty = true

			table.insert({}, iter_21_3)
		end

		if table.getCount(arg_19_0.contextData.drops) > 0 then
			arg_19_0:emit(BaseUI.ON_AWARD, {
				items = arg_19_0.contextData.drops,
				removeFunc = var_0
			})
			coroutine.yield()

			local var_21_2 = getProxy(BayProxy):getNewShip(true)

			for iter_21_4 = math.max(1, #var_21_2 - #_.filter({}, function(arg_22_0)
				return arg_22_0.type == DROP_TYPE_SHIP
			end) + 1), #var_21_2 do
				local var_21_3 = var_21_2[iter_21_4]

				if PlayerPrefs.GetInt(DISPLAY_SHIP_GET_EFFECT) ~= 1 then
					local var_21_4 = var_21_3.virgin

					if not var_21_3.virgin then
						if var_21_3:getRarity() < ShipRarity.Purple then
							var_21_4 = false

							goto label_21_0
						end

						var_21_4 = true
					end

					::label_21_0::

					if var_21_4 then
						arg_19_0:emit(BattleResultMediator.GET_NEW_SHIP, var_21_3, var_0)
						coroutine.yield()
					end
				end
			end
		end

		setParent(arg_19_0._tf, arg_19_0.overlay)
		arg_19_1()
		setActive(arg_19_0._tf:Find("main/jiesuanbeijing"), false)
		setActive(arg_19_0._conditions, false)

		return
	end)

	;(function()
		if var_19_0 and coroutine.status(var_19_0) == "suspended" then
			local var_20_0, var_20_1 = coroutine.resume(var_19_0)

			assert(var_20_0, var_20_1)
		end

		return
	end)()

	return
end

function var_0_0.displayPlayerInfo(arg_23_0)
	local var_23_0 = arg_23_0:calcPlayerProgress()

	SetActive(arg_23_0._leftPanel, true)
	SetActive(arg_23_0._playerExp, true)

	arg_23_0._main:GetComponent("Animator").enabled = true

	table.insert(arg_23_0._delayLeanList, LeanTween.moveX(rtf(arg_23_0._leftPanel), 0, 0.5):setOnComplete(System.Action(function()
		table.insert(arg_23_0._delayLeanList, LeanTween.value(go(arg_23_0._tf), 0, var_23_0, 1):setOnUpdate(System.Action_float(function(arg_25_0)
			setText(arg_23_0._playerBonusExp, "+" .. math.floor(arg_25_0))

			return
		end)).id)

		return
	end)).id)

	return
end

function var_0_0.calcPlayerExp(arg_26_0)
	local var_26_0 = arg_26_0.contextData.oldPlayer.level
	local var_26_1 = arg_26_0.player.exp - arg_26_0.contextData.oldPlayer.exp

	while var_26_0 < arg_26_0.player.level do
		var_26_1 = var_26_1 + pg.user_level[var_26_0].exp
		var_26_0 = var_26_0 + 1
	end

	if var_26_0 == pg.user_level[#pg.user_level].level then
		var_26_1 = 0
	end

	return var_26_1
end

function var_0_0.calcPlayerRank(arg_27_0)
	return arg_27_0.season.score - arg_27_0.contextData.oldRank.score
end

function var_0_0.displayShips(arg_28_0)
	setActive(arg_28_0.title, true)

	arg_28_0._expTFs = {}
	arg_28_0._initExp = {}
	arg_28_0._skipExp = {}
	arg_28_0._subSkipExp = {}
	arg_28_0._subCardAnimaFuncList = {}

	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.shipVOs) do
		var_28_0[iter_28_1.id] = iter_28_1
	end

	local var_28_1 = arg_28_0.contextData.statistics

	for iter_28_2, iter_28_3 in ipairs(arg_28_0.shipVOs) do
		if var_28_1[iter_28_3.id] then
			var_28_1[iter_28_3.id].vo = iter_28_3
		end
	end

	local var_28_2
	local var_28_3

	if var_28_1.mvpShipID and var_28_1.mvpShipID ~= 0 then
		var_28_2 = var_28_1[var_28_1.mvpShipID]
		var_28_3 = var_28_1[var_28_1.mvpShipID].output
	else
		var_28_3 = 0
	end

	local var_28_4 = arg_28_0.contextData.oldMainShips

	arg_28_0._atkFuncs = {}
	arg_28_0._commonAtkTplList = {}
	arg_28_0._subAtkTplList = {}

	local var_28_5
	local var_28_6

	SetActive(arg_28_0._atkToggle, #var_28_4 > 6)

	if #var_28_4 > 6 then
		onToggle(arg_28_0, arg_28_0._atkToggle, function(arg_29_0)
			SetActive(arg_28_0._atkContainer, arg_29_0)
			SetActive(arg_28_0._atkContainerNext, not arg_29_0)

			if arg_29_0 then
				arg_28_0:skipAtkAnima(arg_28_0._atkContainerNext)
			else
				arg_28_0:skipAtkAnima(arg_28_0._atkContainer)
			end

			return
		end, SFX_PANEL)
	end

	local var_28_7 = {}
	local var_28_8 = {}
	local var_28_9 = 0

	for iter_28_4, iter_28_5 in ipairs(var_28_4) do
		local var_28_10 = var_28_0[iter_28_5.id]

		if var_28_1[iter_28_5.id] then
			local var_28_11 = table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_28_5.configId).type)
			local var_28_13
			local var_28_15

			if iter_28_4 > 6 then
				var_28_13 = arg_28_0._atkContainerNext
				var_28_15 = 7
			else
				var_28_13 = arg_28_0._atkContainer
				var_28_15 = 1
			end

			local var_28_16 = cloneTplTo(arg_28_0._atkTpl, var_28_13)

			var_28_16.localPosition.x = var_28_16.localPosition.x + (iter_28_4 - var_28_15) * 74
			var_28_16.localPosition.y = var_28_16.localPosition.y + (iter_28_4 - var_28_15) * 4
			var_28_16.localPosition = var_28_16.localPosition

			local var_28_17 = var_28_16:Find("result/mask/icon")
			local var_28_18 = var_28_16:Find("result/type")

			var_28_17:GetComponent(typeof(Image)).sprite = LoadSprite("herohrzicon/" .. iter_28_5:getPainting())

			setImageSprite(var_28_18, GetSpriteFromAtlas("shiptype", shipType2print(iter_28_5:getShipType())), true)
			arg_28_0:setAtkAnima(var_28_16, var_28_13, var_28_1[iter_28_5.id].output / var_28_3, var_28_3, var_28_2 and iter_28_5.id == var_28_2.id, var_28_1[iter_28_5.id].output, var_28_1[iter_28_5.id].kill_count)

			var_28_9 = var_28_9 + var_28_1[iter_28_5.id].output

			local var_28_19
			local var_28_20

			if not var_28_11 then
				var_28_19 = cloneTplTo(arg_28_0._extpl, arg_28_0._expContainer)
				var_28_20 = arg_28_0._skipExp

				table.insert(var_28_7, var_28_19)
			else
				var_28_19 = cloneTplTo(arg_28_0._extpl, arg_28_0._subExpContainer)
				var_28_20 = arg_28_0._subSkipExp

				table.insert(var_28_8, var_28_19)
			end

			flushShipCard(var_28_19, iter_28_5)

			local var_28_21 = findTF(var_28_19, "content")
			local var_28_22 = findTF(var_28_21, "exp")

			arg_28_0._expTFs[#arg_28_0._expTFs + 1] = var_28_19

			local var_28_23 = findTF(var_28_16, "result/stars")
			local var_28_24 = findTF(var_28_16, "result/stars/star_tpl")
			local var_28_25 = iter_28_5:getStar()
			local var_28_26 = iter_28_5:getMaxStar()
			local var_28_28 = findTF(var_28_21, "heartsfly")
			local var_28_29 = findTF(var_28_21, "heartsbroken")

			while var_28_26 > 0 do
				local var_28_30 = cloneTplTo(var_28_24, var_28_23)

				SetActive(var_28_30:Find("empty"), var_28_25 < var_28_26)
				SetActive(var_28_30:Find("star"), var_28_26 <= var_28_25)

				var_28_26 = var_28_26 - 1
			end

			setScrollText(findTF(var_28_21, "info/name_mask/name"), iter_28_5:GetColorName())

			if var_28_2 and iter_28_5.id == var_28_2.id then
				arg_28_0.mvpShipVO = iter_28_5

				SetActive(findTF(var_28_21, "mvp"), true)

				local var_28_33, var_28_34, var_28_35 = ShipWordHelper.GetWordAndCV(arg_28_0.mvpShipVO.skinId, ShipWordHelper.WORD_TYPE_MVP)

				if var_28_34 then
					arg_28_0._currentVoice = nil

					pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_28_0._currentVoice)
				end
			end

			if iter_28_5.id == var_28_1._flagShipID then
				arg_28_0.flagShipVO = iter_28_5
			end

			local var_28_36 = iter_28_5:getConfig("rarity")
			local var_28_37 = findTF(var_28_21, "dockyard/lv/Text")
			local var_28_38 = findTF(var_28_21, "dockyard/lv_bg/levelUpLabel")
			local var_28_39 = findTF(var_28_21, "dockyard/lv_bg/levelup")
			local var_28_40 = findTF(var_28_22, "exp_text")
			local var_28_41 = findTF(var_28_22, "exp_progress"):GetComponent(typeof(Image))
			local var_28_42 = findTF(var_28_22, "exp_buff_mask/exp_buff")

			setActive(var_28_42, arg_28_0.expBuff)

			if arg_28_0.expBuff then
				setText(var_28_42, arg_28_0.expBuff:getConfig("name"))
			end

			local function var_28_43()
				SetActive(var_28_22, true)
				SetActive(var_28_28, iter_28_5:getIntimacy() < var_28_10:getIntimacy())
				SetActive(var_28_29, iter_28_5:getIntimacy() > var_28_10:getIntimacy())

				local var_30_0 = getExpByRarityFromLv1(var_28_36, iter_28_5.level)
				local var_30_1 = getExpByRarityFromLv1(var_28_36, var_28_10.level)

				var_28_41.fillAmount = iter_28_5:getExp() / var_30_0

				if iter_28_5.level < var_28_10.level then
					local var_30_2 = 0

					for iter_30_0 = iter_28_5.level, var_28_10.level - 1 do
						var_30_2 = var_30_2 + getExpByRarityFromLv1(var_28_36, iter_30_0)
					end

					arg_28_0:PlayAnimation(var_28_19, 0, var_30_2 + var_28_10:getExp() - iter_28_5:getExp(), 1, 0, function(arg_31_0)
						setText(var_28_40, "+" .. math.ceil(arg_31_0))

						return
					end)

					local function var_30_3(arg_32_0)
						SetActive(var_28_38, true)
						SetActive(var_28_39, true)
						LeanTween.moveY(rtf(var_28_38), var_28_38.localPosition.y + 30, 0.5):setOnComplete(System.Action(function()
							SetActive(var_28_38, false)

							var_28_38.localPosition = var_0

							pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BOAT_LEVEL_UP)

							return
						end))

						if arg_32_0 <= var_28_10.level then
							setText(var_28_37, arg_32_0)
						end

						return
					end

					local var_30_4 = iter_28_5.level

					;(function(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
						LeanTween.value(go(var_28_19), arg_34_0, arg_34_1, arg_34_2):setOnUpdate(System.Action_float(function(arg_35_0)
							var_28_41.fillAmount = arg_35_0

							return
						end)):setOnComplete(System.Action(function()
							var_30_4 = var_30_4 + 1

							if arg_34_3 then
								var_30_3(var_30_4)
							end

							if var_28_10.level == var_30_4 then
								if var_30_4 == var_28_10:getMaxLevel() then
									var_28_41.fillAmount = 1
								else
									var_0(0, var_28_10:getExp() / var_30_1, 1, false)
								end
							elseif var_28_10.level > var_30_4 then
								var_0(0, 1, 0.7, true)
							end

							return
						end))

						return
					end)(iter_28_5:getExp() / var_30_0, 1, 0.7, true)
				else
					setText(var_28_40, "+" .. math.ceil(var_28_10:getExp() - iter_28_5:getExp()))

					if iter_28_5.level == iter_28_5:getMaxLevel() then
						var_28_41.fillAmount = 1

						return
					end

					arg_28_0:PlayAnimation(var_28_19, iter_28_5:getExp() / var_30_0, var_28_10:getExp() / var_30_0, 1, 0, function(arg_37_0)
						var_28_41.fillAmount = arg_37_0

						return
					end)
				end

				return
			end

			var_28_19:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function(arg_38_0)
				var_28_43()

				return
			end)
			setActive(var_28_19, false)

			if var_28_11 then
				if not var_28_6 then
					arg_28_0._subFirstExpTF = var_28_19
				else
					var_28_6:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_39_0)
						setActive(var_28_19, true)

						return
					end)
				end

				var_28_6 = var_28_19
			else
				if var_28_5 then
					var_28_5:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_40_0)
						setActive(var_28_19, true)

						return
					end)
				else
					setActive(var_28_19, true)
				end

				var_28_5 = var_28_19
			end

			var_28_20[#var_28_20 + 1] = function()
				var_28_19:GetComponent(typeof(Animator)).enabled = false

				SetActive(var_28_19, true)
				SetActive(var_28_21, true)
				SetActive(var_28_22, true)

				var_28_19:GetComponent(typeof(CanvasGroup)).alpha = 1

				LeanTween.cancel(go(var_28_38))
				LeanTween.cancel(go(var_28_19))
				SetActive(var_28_28, iter_28_5:getIntimacy() < var_28_10:getIntimacy())
				SetActive(var_28_29, iter_28_5:getIntimacy() > var_28_10:getIntimacy())

				var_28_21.localPosition = Vector3(0, 0, 0)

				setText(var_28_37, var_28_10.level)

				if iter_28_5.level == iter_28_5:getMaxLevel() then
					setText(var_28_40, "+" .. math.ceil(var_28_10:getExp() - iter_28_5:getExp()))

					var_28_41.fillAmount = 1
				else
					if iter_28_5.level < var_28_10.level then
						local var_41_0 = 0

						for iter_41_0 = iter_28_5.level, var_28_10.level - 1 do
							var_41_0 = var_41_0 + getExpByRarityFromLv1(var_28_36, iter_41_0)
						end

						setText(var_28_40, "+" .. var_41_0 + var_28_10:getExp() - iter_28_5:getExp())
					else
						setText(var_28_40, "+" .. math.ceil(var_28_10:getExp() - iter_28_5:getExp()))
					end

					var_28_41.fillAmount = var_28_10:getExp() / getExpByRarityFromLv1(var_28_36, var_28_10.level)
				end

				SetActive(var_28_38, false)

				return
			end
		end
	end

	if var_28_7[#var_28_7] then
		var_28_7[#var_28_7]:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_42_0)
			arg_28_0._stateFlag = var_0_0.STATE_DISPLAYED

			if not arg_28_0._subFirstExpTF then
				arg_28_0:skip()
			end

			return
		end)
	end

	if #var_28_8 > 0 then
		var_28_8[#var_28_8]:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_43_0)
			arg_28_0._stateFlag = var_0_0.STATE_SUB_DISPLAYED

			arg_28_0:skip()

			return
		end)
	end

	arg_28_0.subTitleTxt.text = arg_28_0.contextData.statistics.specificDamage

	return
end

function var_0_0.setAtkAnima(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5, arg_44_6, arg_44_7)
	local var_44_0 = arg_44_1:Find("result")
	local var_44_1 = arg_44_1:Find("result/dmg_progress/progress_bar")
	local var_44_2 = arg_44_1:Find("result/killCount")

	setText(arg_44_1:Find("result/atk"), 0)
	setText(arg_44_1:Find("result/killCount"), 0)

	arg_44_1:Find("result/dmg_progress/progress_bar"):GetComponent(typeof(Image)).fillAmount = 0

	if arg_44_5 then
		local var_44_3 = arg_44_1:Find("result/mvpBG")

		setParent(arg_44_0._mvpFX, var_44_3)

		arg_44_0._mvpFX.localPosition = Vector3(-368.5, 0, 0)

		setActive(var_44_3, true)
		setActive(arg_44_1:Find("result/bg"), false)
	end

	var_44_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_45_0)
		if arg_44_5 then
			setActive(arg_44_0._mvpFX, true)
		end

		LeanTween.value(go(var_44_0), 0, arg_44_3, arg_44_3):setOnUpdate(System.Action_float(function(arg_46_0)
			var_44_1:GetComponent(typeof(Image)).fillAmount = arg_46_0

			return
		end))

		if arg_44_4 ~= 0 then
			LeanTween.value(go(var_44_0), 0, arg_44_6, arg_44_3):setOnUpdate(System.Action_float(function(arg_47_0)
				setText(var_0, math.floor(arg_47_0))

				return
			end))
			LeanTween.value(go(var_44_0), 0, arg_44_7, arg_44_3):setOnUpdate(System.Action_float(function(arg_48_0)
				setText(var_44_2, math.floor(arg_48_0))

				return
			end))
		end

		return
	end)

	if arg_44_2.childCount > 1 then
		arg_44_2:GetChild(arg_44_2.childCount - 2):Find("result"):GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function(arg_49_0)
			setActive(var_44_0, true)

			return
		end)
	else
		setActive(var_44_0, true)
	end

	local function var_44_4()
		var_44_1:GetComponent(typeof(Image)).fillAmount = arg_44_3

		setText(var_0, arg_44_6)
		setText(var_44_2, arg_44_7)

		var_44_0.localPosition = Vector3(280, 46, 0)
		var_44_0:GetComponent(typeof(Animator)).enabled = false

		setActive(var_44_0, true)
		setActive(arg_44_0._mvpFX, true)

		return
	end

	if arg_44_0._atkFuncs[arg_44_2] == nil then
		arg_44_0._atkFuncs[arg_44_2] = {}
	end

	table.insert(arg_44_0._atkFuncs[arg_44_2], var_44_4)

	return
end

function var_0_0.skipAtkAnima(arg_51_0, arg_51_1)
	if arg_51_0._atkFuncs[arg_51_1] then
		for iter_51_0, iter_51_1 in ipairs(arg_51_0._atkFuncs[arg_51_1]) do
			iter_51_1()
		end

		arg_51_0._atkFuncs[arg_51_1] = nil
	end

	return
end

function var_0_0.showPainting(arg_52_0)
	SetActive(arg_52_0._painting, true)

	local var_52_3 = arg_52_0.mvpShipVO or arg_52_0.flagShipVO

	arg_52_0.paintingName = var_52_3:getPainting()

	setPaintingPrefabAsync(arg_52_0._painting, arg_52_0.paintingName, "jiesuan", function()
		if findTF(arg_52_0._painting, "fitter").childCount > 0 then
			ShipExpressionHelper.SetExpression(findTF(arg_52_0._painting, "fitter"):GetChild(0), arg_52_0.paintingName, "win_mvp")
		end

		return
	end)

	local var_52_4, var_52_5, var_52_6 = ShipWordHelper.GetWordAndCV(var_52_3.skinId, ShipWordHelper.WORD_TYPE_MVP)

	SetActive(arg_52_0._failPainting, false)
	setText(arg_52_0._chat:Find("Text"), var_52_6)

	local var_52_7 = arg_52_0._chat:Find("Text"):GetComponent(typeof(Text))

	var_52_7.alignment = #var_52_7.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	SetActive(arg_52_0._chat, true)

	arg_52_0._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.cancel(go(arg_52_0._painting))
	LeanTween.moveX(rtf(arg_52_0._painting), 50, 0):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(arg_52_0._chat.gameObject), Vector3.New(1, 1, 1), 0):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
			arg_52_0._statisticsBtn:GetComponent("Button").enabled = true
			arg_52_0._confirmBtn:GetComponent("Button").enabled = true
			arg_52_0._atkBG:GetComponent("Button").enabled = true

			return
		end))

		return
	end))

	return
end

function var_0_0.hidePainting(arg_56_0)
	SetActive(arg_56_0._chat, false)

	arg_56_0._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.cancel(go(arg_56_0._painting))
	LeanTween.scale(rtf(arg_56_0._chat.gameObject), Vector3.New(0, 0, 0), 0.1):setEase(LeanTweenType.easeOutBack)
	LeanTween.moveX(rtf(arg_56_0._painting), 720, 0.2):setOnComplete(System.Action(function()
		SetActive(arg_56_0._painting, false)

		return
	end))

	return
end

function var_0_0.skip(arg_58_0)
	seriesAsync({
		function(arg_59_0)
			arg_58_0:showRewardInfo(arg_59_0)

			return
		end,
		function(arg_60_0)
			arg_58_0:displayShips()
			arg_58_0:showRightBottomPanel()

			return
		end
	})

	return
end

function var_0_0.playSubExEnter(arg_61_0)
	arg_61_0._stateFlag = var_0_0.STATE_SUB_DISPLAY

	if arg_61_0._subFirstExpTF then
		triggerToggle(arg_61_0._subToggle, false)
		setActive(arg_61_0._subFirstExpTF, true)
	else
		arg_61_0:showRightBottomPanel()
	end

	return
end

function var_0_0.showRightBottomPanel(arg_62_0)
	SetActive(arg_62_0._skipBtn, false)
	SetActive(arg_62_0._rightBottomPanel, true)
	SetActive(arg_62_0._subToggle, arg_62_0._subFirstExpTF ~= nil)
	setActive(arg_62_0._statisticsBtn, false)
	onButton(arg_62_0, arg_62_0._confirmBtn, function()
		arg_62_0:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)

		return
	end, SFX_CONFIRM)

	arg_62_0._stateFlag = nil
	arg_62_0._subFirstExpTF = nil

	arg_62_0:showStatistics()

	return
end

function var_0_0.showStatistics(arg_64_0)
	setActive(arg_64_0._leftPanel, false)
	arg_64_0:enabledStatisticsGizmos(false)
	SetActive(arg_64_0._atkBG, true)

	arg_64_0._atkBG:GetComponent("Button").enabled = false
	arg_64_0._confirmBtn:GetComponent("Button").enabled = false
	arg_64_0._statisticsBtn:GetComponent("Button").enabled = false

	arg_64_0:showPainting()
	LeanTween.moveX(rtf(arg_64_0._atkPanel), 0, 0.25):setOnComplete(System.Action(function()
		SetActive(arg_64_0._atkContainer, true)

		return
	end))

	return
end

function var_0_0.closeStatistics(arg_66_0)
	setActive(arg_66_0._leftPanel, true)
	arg_66_0:skipAtkAnima(arg_66_0._atkContainerNext)
	arg_66_0:skipAtkAnima(arg_66_0._atkContainer)
	arg_66_0:enabledStatisticsGizmos(true)
	arg_66_0:hidePainting()

	arg_66_0._atkBG:GetComponent("Button").enabled = false

	LeanTween.cancel(arg_66_0._atkPanel.gameObject)
	LeanTween.moveX(rtf(arg_66_0._atkPanel), -700, 0.2):setOnComplete(System.Action(function()
		SetActive(arg_66_0._atkBG, false)

		return
	end))

	return
end

function var_0_0.enabledStatisticsGizmos(arg_68_0, arg_68_1)
	setActive(arg_68_0._main:Find("gizmos/xuxian_down"), arg_68_1)
	setActive(arg_68_0._main:Find("gizmos/xuxian_middle"), arg_68_1)

	return
end

function var_0_0.PlayAnimation(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4, arg_69_5, arg_69_6)
	LeanTween.value(arg_69_1.gameObject, arg_69_2, arg_69_3, arg_69_4):setDelay(arg_69_5):setOnUpdate(System.Action_float(function(arg_70_0)
		arg_69_6(arg_70_0)

		return
	end))

	return
end

function var_0_0.onBackPressed(arg_71_0)
	if arg_71_0._stateFlag == var_0_0.STATE_RANK_ANIMA then
		-- block empty
	elseif arg_71_0._stateFlag == var_0_0.STATE_REPORT then
		triggerButton(arg_71_0._bg)
	elseif arg_71_0._stateFlag == var_0_0.STATE_DISPLAY then
		triggerButton(arg_71_0._skipBtn)
	else
		triggerButton(arg_71_0._confirmBtn)
	end

	return
end

function var_0_0.willExit(arg_72_0)
	setActive(arg_72_0.title, false)

	arg_72_0._atkFuncs = nil

	LeanTween.cancel(go(arg_72_0._tf))

	if arg_72_0._atkBG.gameObject.activeSelf then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_72_0._blurConatiner, arg_72_0._tf)
	end

	if arg_72_0.paintingName then
		retPaintingPrefab(arg_72_0._painting, arg_72_0.paintingName)
	end

	if arg_72_0._rightTimer then
		arg_72_0._rightTimer:Stop()
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_72_0._tf)

	if arg_72_0._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(arg_72_0._currentVoice)
	end

	arg_72_0._currentVoice = nil

	pg.CameraFixMgr.GetInstance():disconnect(arg_72_0.camEventId)

	return
end

return var_0_0
