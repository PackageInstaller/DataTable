local BattleResultLayer = class("BattleResultLayer", import("..base.BaseUI"))

BattleResultLayer.DURATION_MOVE = 0.35
BattleResultLayer.DURATION_WIN_SCALE = 0.4
BattleResultLayer.CONDITIONS_FREQUENCE = 0.15
BattleResultLayer.STATE_RANK_ANIMA = "rankAnima"
BattleResultLayer.STATE_REPORT = "report"
BattleResultLayer.STATE_REPORTED = "reported"
BattleResultLayer.STATE_REWARD = "reward"
BattleResultLayer.STATE_DISPLAY = "display"
BattleResultLayer.STATE_DISPLAYED = "displayed"
BattleResultLayer.STATE_SUB_DISPLAY = "subDisplay"
BattleResultLayer.STATE_SUB_DISPLAYED = "subDisplayed"
BattleResultLayer.ObjectiveList = {
	"battle_result_victory",
	"battle_result_undefeated",
	"battle_result_sink_limit",
	"battle_preCombatLayer_time_hold",
	"battle_result_time_limit",
	"battle_result_boss_destruct",
	"battle_preCombatLayer_damage_before_end",
	"battle_result_defeat_all_enemys"
}

function BattleResultLayer:getUIName()
	return "BattleResultUI"
end

function BattleResultLayer:getGroupName()
	return "BattleScene"
end

function BattleResultLayer:setRivalVO(arg_3_1)
	self.rivalVO = arg_3_1

	return
end

function BattleResultLayer:setRank(arg_4_1, arg_4_2)
	self.player = arg_4_1
	self.season = arg_4_2

	setText(self._playerName, "<color=#FFFFFF>" .. self.player.name .. "</color><size=32> / C O M M A N D E R</size>")

	local var_4_0, var_4_1 = SeasonInfo.getNextMilitaryRank(arg_4_2.score, arg_4_2.rank)

	setText(self._playerLv, SeasonInfo.getMilitaryRank(arg_4_2.score, arg_4_2.rank).name)
	setText(self._playerExpLabel, i18n("word_rankScore"))

	self._playerExpProgress:GetComponent(typeof(Image)).fillAmount = arg_4_2.score / var_4_1

	setText(self._playerBonusExp, "+0")

	self.calcPlayerProgress = self.calcPlayerRank

	return
end

function BattleResultLayer:setShips(arg_5_1)
	self.shipVOs = arg_5_1

	return
end

function BattleResultLayer:setPlayer(arg_6_1)
	self.player = arg_6_1

	setText(self._playerName, "<color=#FFFFFF>" .. self.player.name .. "</color><size=32> / C O M M A N D E R</size>")
	setText(self._playerLv, "Lv." .. self.player.level)

	self._playerExpProgress:GetComponent(typeof(Image)).fillAmount = self.player.exp / getConfigFromLevel1(pg.user_level, self.player.level).exp_interval

	if self.player.level == pg.user_level[#pg.user_level].level then
		self._playerExpProgress:GetComponent(typeof(Image)).fillAmount = 1
	end

	setText(self._playerBonusExp, "+0")

	self.calcPlayerProgress = self.calcPlayerExp

	for iter_6_0, iter_6_1 in ipairs(self.contextData.extraBuffList) do
		if pg.benefit_buff_template[iter_6_1].benefit_type == Chapter.OPERATION_BUFF_TYPE_EXP then
			setActive(self._playerExpExtra, true)
		end
	end

	return
end

function BattleResultLayer:setExpBuff(arg_7_1, arg_7_2)
	self.expBuff = arg_7_1
	self.shipBuff = arg_7_2

	return
end

function BattleResultLayer:init()
	self._grade = self._tf:Find("grade")
	self._levelText = self._grade:Find("chapterName/Text22")
	self.clearFX = self._tf:Find("clear")
	self._main = self._tf:Find("main")
	self._blurConatiner = self._tf:Find("blur_container")
	self._bg = self._tf:Find("main/jiesuanbeijing")
	self._painting = self._blurConatiner:Find("painting")
	self._failPainting = self._painting:Find("fail")
	self._chat = self._painting:Find("chat")
	self._leftPanel = self._main:Find("leftPanel")
	self._expResult = self._leftPanel:Find("expResult")
	self._expContainer = self._expResult:Find("expContainer")
	self._extpl = self:getTpl("ShipCardTpl", self._expContainer)
	self._playerExp = self._leftPanel:Find("playerExp")
	self._playerName = self._playerExp:Find("name_text")
	self._playerLv = self._playerExp:Find("lv_text")
	self._playerExpLabel = self._playerExp:Find("exp_label")
	self._playerExpProgress = self._playerExp:Find("exp_progress")
	self._playerBonusExp = self._playerExp:Find("exp_text")
	self._playerExpExtra = self._playerExp:Find("operation_bonus")
	self._atkBG = self._blurConatiner:Find("atkPanel")
	self._atkPanel = self._atkBG:Find("atkResult")
	self._atkResult = self._atkBG:Find("atkResult/result")
	self._atkContainer = self._atkResult:Find("Grid")
	self._atkContainerNext = self._atkResult:Find("Grid_next")
	self._atkToggle = self._atkPanel:Find("switchAtk")
	self._atkTpl = self:getTpl("resulttpl", self._atkResult)
	self._mvpFX = self._atkPanel:Find("mvpFX")
	self._rightBottomPanel = self._blurConatiner:Find("rightBottomPanel")
	self._confirmBtn = self._rightBottomPanel:Find("confirmBtn")

	setText(self._confirmBtn:Find("Text"), i18n("text_confirm"))

	self._statisticsBtn = self._rightBottomPanel:Find("statisticsBtn")
	self._subExpResult = self._leftPanel:Find("subExpResult")
	self._subExpContainer = self._subExpResult:Find("expContainer")
	self._subToggle = self._leftPanel:Find("switchFleet")

	setActive(self._subToggle, false)

	self._skipBtn = self._tf:Find("skipLayer")
	self.UIMain = pg.UIMgr.GetInstance().UIMain
	self.overlay = pg.UIMgr.GetInstance().OverlayMain
	self._conditions = self._tf:Find("main/conditions")
	self._conditionContainer = self._conditions:Find("bg16/list")
	self._conditionTpl = self._conditions:Find("bg16/conditionTpl")
	self._conditionSubTpl = self._conditions:Find("bg16/conditionSubTpl")
	self._conditionContributeTpl = self._conditions:Find("bg16/conditionContributeTpl")
	self._conditionBGNormal = self._conditions:Find("bg16/bg_normal")
	self._conditionBGContribute = self._conditions:Find("bg16/bg_contribute")
	self._cmdExp = self._leftPanel:Find("commanderExp")
	self._cmdContainer = self._cmdExp:Find("commander_container")
	self._cmdTpl = self._cmdExp:Find("commander_tpl")

	self:setGradeLabel()
	SetActive(self._levelText, false)

	self._delayLeanList = {}
	self._ratioFitter = GetComponent(self._tf, typeof(AspectRatioFitter))
	self._ratioFitter.enabled = true
	self._ratioFitter.aspectRatio = pg.CameraFixMgr.GetInstance().targetRatio
	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_9_0, arg_9_1)
		self._ratioFitter.aspectRatio = arg_9_1

		return
	end)

	return
end

function BattleResultLayer:customsLang()
	setText(findTF(self._confirmBtn, "Text"), i18n("battle_result_confirm"))
	setText(findTF(self._bg, "jieuan01/tips/dianjijixu/bg20"), i18n("battle_result_continue"))
	setText(findTF(self._atkTpl, "result/dmg_count_label"), i18n("battle_result_dmg"))
	setText(findTF(self._atkTpl, "result/kill_count_label"), i18n("battle_result_kill_count"))
	setText(findTF(self._subToggle, "on"), i18n("battle_result_toggle_on"))
	setText(findTF(self._subToggle, "off"), i18n("battle_result_toggle_off"))
	setText(findTF(self._conditions, "bg17"), i18n("battle_result_targets"))

	return
end

function BattleResultLayer:setGradeLabel()
	local var_11_0 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_11_1 = self._tf:Find("grade/Xyz/bg13")
	local var_11_2 = self._tf:Find("grade/Xyz/bg14")
	local var_11_3
	local var_11_4
	local var_11_5
	local var_11_6 = self.contextData.score
	local var_11_7
	local var_11_8 = self.contextData.score > 0

	setActive(self._bg:Find("jieuan01/BG/bg_victory"), self.contextData.score > 0)
	setActive(self._bg:Find("jieuan01/BG/bg_fail"), not var_11_8)

	if var_11_8 then
		var_11_5 = var_11_0[var_11_6 + 1]
		var_11_3 = "battlescore/battle_score_" .. var_11_0[var_11_6 + 1] .. "/letter_" .. var_11_0[var_11_6 + 1]
		var_11_4 = "battlescore/battle_score_" .. var_11_0[var_11_6 + 1] .. "/label_" .. var_11_0[var_11_6 + 1]
	else
		if self.contextData.statistics._scoreMark == ys.Battle.BattleConst.DEAD_FLAG then
			var_11_5 = var_11_0[2]
			var_11_7 = "flag_destroy"
		else
			var_11_5 = var_11_0[1]
		end

		var_11_3 = "battlescore/battle_score_" .. var_11_5 .. "/letter_" .. var_11_5
		var_11_4 = "battlescore/battle_score_" .. var_11_5 .. "/label_" .. (var_11_7 or var_11_5)
	end

	LoadImageSpriteAsync(var_11_3, var_11_1, false)
	LoadImageSpriteAsync(var_11_4, var_11_2, false)

	if (self.contextData.system == SYSTEM_SCENARIO or self.contextData.system == SYSTEM_ROUTINE or self.contextData.system == SYSTEM_SUB_ROUTINE or self.contextData.system == SYSTEM_DUEL) and (var_11_5 == var_11_0[1] or var_11_5 == var_11_0[2]) then
		self.failTag = true
	end

	return
end

function BattleResultLayer:displayerCommanders(arg_12_1)
	self.commanderExps = self.contextData.commanderExps or {}

	local var_12_0 = getProxy(CommanderProxy)

	removeAllChildren(self._cmdContainer)

	local var_12_1 = arg_12_1 and (self.commanderExps.submarineCMD or {}) or self.commanderExps.surfaceCMD or {}

	setActive(self._cmdExp, true)

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = var_12_0:getCommanderById(iter_12_1.commander_id)
		local var_12_3 = cloneTplTo(self._cmdTpl, self._cmdContainer)

		GetImageSpriteFromAtlasAsync("commandericon/" .. var_12_2:getPainting(), "", var_12_3:Find("icon/mask/pic"))
		setText(var_12_3:Find("exp/name_text"), var_12_2:getName())
		setText(var_12_3:Find("exp/lv_text"), "Lv." .. var_12_2.level)
		setText(var_12_3:Find("exp/exp_text"), "+" .. iter_12_1.exp)

		var_12_3:Find("exp/exp_progress"):GetComponent(typeof(Image)).fillAmount = var_12_2:isMaxLevel() and 1 or iter_12_1.curExp / var_12_2:getNextLevelExp()
	end

	return
end

function BattleResultLayer:didEnter()
	self:setStageName()
	self:customsLang()

	self._shipResultCardList, self._subShipResultCardList = {}, {}

	local var_13_0 = rtf(self._grade)

	self._gradeUpperLeftPos = var_13_0.localPosition
	var_13_0.localPosition = Vector3(0, 25, 0)

	self:BlurPanel(self._tf, {
		staticBlur = true,
		lockGlobalBlur = true
	})

	if self.contextData.system ~= SYSTEM_BOSS_RUSH and self.contextData.system ~= SYSTEM_BOSS_RUSH_EX and self.contextData.system ~= SYSTEM_BOSS_RUSH_COLLABRATE and self.contextData.system ~= SYSTEM_ACT_BOSS and self.contextData.system ~= SYSTEM_BOSS_SINGLE and self.contextData.system ~= SYSTEM_BOSS_SINGLE_VARIABLE then
		ys.Battle.BattleCameraUtil.GetInstance().ActiveMainCamera(false)
	end

	self._grade.transform.localScale = Vector3(1.5, 1.5, 0)

	LeanTween.scale(self._grade, Vector3(0.88, 0.88, 1), BattleResultLayer.DURATION_WIN_SCALE):setOnComplete(System.Action(function()
		SetActive(self._levelText, true)
		self:rankAnimaFinish()

		return
	end))

	self._tf:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0.5)

	SetActive(self._atkBG, false)
	onToggle(self, self._subToggle, function(arg_15_0)
		SetActive(self._subExpResult, not arg_15_0)
		SetActive(self._expResult, arg_15_0)
		setActive(self._subToggle:Find("off"), not arg_15_0)
		self:displayerCommanders(not arg_15_0)

		return
	end, SFX_PANEL)

	self._stateFlag = BattleResultLayer.STATE_RANK_ANIMA

	onButton(self, self._skipBtn, function()
		self:skip()

		return
	end, SFX_CONFIRM)

	return
end

function BattleResultLayer:setStageName()
	if self.contextData.system and self.contextData.system == SYSTEM_DUEL then
		if self.rivalVO then
			setText(self._levelText, self.rivalVO.name)
		else
			setText(self._levelText, "")
		end
	else
		setText(self._levelText, pg.expedition_data_template[self.contextData.stageId].name)
	end

	return
end

function BattleResultLayer:rankAnimaFinish()
	SetActive(self._tf:Find("main/conditions"), true)

	local function var_18_0(arg_19_0)
		if type(arg_19_0) == "table" then
			self:setCondition(i18n(BattleResultLayer.ObjectiveList[arg_19_0[1]], arg_19_0[2]), BattleResultLayer.objectiveCheck(arg_19_0[1], self.contextData))
		end

		return
	end

	var_18_0(pg.expedition_data_template[self.contextData.stageId].objective_1)
	var_18_0(pg.expedition_data_template[self.contextData.stageId].objective_2)
	var_18_0(pg.expedition_data_template[self.contextData.stageId].objective_3)
	table.insert(self._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		self._stateFlag = BattleResultLayer.STATE_REPORTED

		SetActive(self._bg:Find("jieuan01/tips"), true)

		if self.skipFlag then
			self:skip()
		end

		return
	end)).id)

	self._stateFlag = BattleResultLayer.STATE_REPORT

	return
end

function BattleResultLayer:objectiveCheck(arg_21_1)
	if self == 1 or self == 4 or self == 8 then
		return arg_21_1.score > 1
	elseif self == 2 or self == 3 then
		return not arg_21_1.statistics._deadUnit
	elseif self == 6 then
		return arg_21_1.statistics._boss_destruct < 1
	elseif self == 5 then
		return not arg_21_1.statistics._badTime
	elseif self == 7 then
		return true
	end

	return
end

function BattleResultLayer:setCondition(arg_22_1, arg_22_2)
	local var_22_0 = cloneTplTo(self._conditionTpl, self._conditionContainer)

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

	self:setSpriteTo(var_22_1, var_22_0:Find("checkBox"), true)

	if self._conditionContainer.childCount - 1 > 0 then
		table.insert(self._delayLeanList, LeanTween.delayedCall(BattleResultLayer.CONDITIONS_FREQUENCE * (self._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_22_0, true)

			return
		end)).id)
	else
		setActive(var_22_0, true)
	end

	return
end

function BattleResultLayer:showRewardInfo()
	self._stateFlag = BattleResultLayer.STATE_REWARD

	if self.contextData.system == SYSTEM_BOSS_RUSH or self.contextData.system == SYSTEM_BOSS_RUSH_EX or self.contextData.system == SYSTEM_BOSS_RUSH_COLLABRATE then
		self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)

		return
	end

	SetActive(self._bg:Find("jieuan01/tips"), false)
	setParent(self._tf, self.UIMain)

	local var_24_0

	local function var_24_1()
		if var_24_0 and coroutine.status(var_24_0) == "suspended" then
			local var_25_0, var_25_1 = coroutine.resume(var_24_0)

			assert(var_25_0, var_25_1)
		end

		return
	end

	var_24_0 = coroutine.create(function()
		local var_26_0 = self.contextData.drops
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

		for iter_26_0, iter_26_1 in ipairs(self.contextData.drops) do
			table.insert(var_26_6, iter_26_1)
		end

		for iter_26_2, iter_26_3 in ipairs(self.contextData.extraDrops) do
			iter_26_3.riraty = true

			table.insert(var_26_6, iter_26_3)
		end

		local var_26_7 = false

		for iter_26_4, iter_26_5 in ipairs(self.contextData.extraBuffList) do
			if pg.benefit_buff_template[iter_26_5].benefit_type == Chapter.OPERATION_BUFF_TYPE_REWARD then
				var_26_7 = true

				break
			end
		end

		if table.getCount(var_26_0) > 0 then
			local var_26_8 = self.skipFlag
			local var_26_9 = false

			if self.contextData.system == SYSTEM_SCENARIO then
				local var_26_10 = getProxy(ChapterProxy):getActiveChapter(true)

				if var_26_10 then
					if var_26_10:isLoop() then
						getProxy(ChapterProxy):AddExtendChapterDataArray(var_26_10.id, "TotalDrops", var_26_6)

						var_26_9 = getProxy(ChapterProxy):GetChapterAutoFlag(var_26_10.id) == 1
					end

					var_26_10:writeDrops(var_26_6)
				end
			elseif self.contextData.system == SYSTEM_ACT_BOSS then
				if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
					getProxy(ChapterProxy):AddActBossRewards(var_26_6)
				end
			elseif self.contextData.system == SYSTEM_BOSS_SINGLE then
				if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator) then
					getProxy(ChapterProxy):AddBossSingleRewards(var_26_6)
				end
			elseif self.contextData.system == SYSTEM_BOSS_SINGLE_VARIABLE then
				-- block empty
			end

			self:emit(BaseUI.ON_AWARD, {
				items = var_26_6,
				extraBonus = var_26_7,
				removeFunc = var_24_1,
				closeOnCompleted = var_26_8
			})
			coroutine.yield()

			local var_26_11 = getProxy(BayProxy):getNewShip(true)

			for iter_26_6 = math.max(1, #var_26_11 - #_.filter(var_26_6, function(arg_30_0)
				return arg_30_0.type == DROP_TYPE_SHIP
			end) + 1), #var_26_11 do
				local var_26_12 = var_26_11[iter_26_6]

				if PlayerPrefs.GetInt(DISPLAY_SHIP_GET_EFFECT) ~= 1 then
					if var_26_12.virgin or var_26_12:getRarity() >= ShipRarity.Purple then
						self:emit(BattleResultMediator.GET_NEW_SHIP, var_26_12, var_24_1, var_26_9 and not var_26_12.virgin and 3 or nil)
						coroutine.yield()
					end
				end
			end
		end

		setParent(self._tf, self.overlay)
		self:displayBG()

		return
	end)

	var_24_1()

	return
end

function BattleResultLayer:displayBG()
	local function var_31_0()
		self:displayShips()
		self:displayPlayerInfo()
		self:displayerCommanders()
		self:initMetaBtn()

		self._stateFlag = BattleResultLayer.STATE_DISPLAY

		if self.skipFlag then
			self:skip()
		end

		return
	end

	LeanTween.moveX(rtf(self._conditions), 1300, BattleResultLayer.DURATION_MOVE)
	LeanTween.scale(self._grade, Vector3(0.6, 0.6, 0), BattleResultLayer.DURATION_MOVE)
	LeanTween.moveLocal(go((rtf(self._grade))), self._gradeUpperLeftPos, BattleResultLayer.DURATION_MOVE)
	setActive(self._bg:Find("jieuan01/Bomb"), false)
	onDelayTick(function()
		setLocalScale(self._grade, Vector3(0.6, 0.6, 0))
		setAnchoredPosition(self._grade, self._gradeUpperLeftPos)
		var_31_0()

		return
	end, BattleResultLayer.DURATION_MOVE)

	return
end

function BattleResultLayer:displayPlayerInfo()
	local var_34_0 = self:calcPlayerProgress()

	SetActive(self._leftPanel, true)
	SetActive(self._playerExp, true)

	self._main:GetComponent("Animator").enabled = true

	table.insert(self._delayLeanList, LeanTween.moveX(rtf(self._leftPanel), 0, 0.5):setOnComplete(System.Action(function()
		table.insert(self._delayLeanList, LeanTween.value(go(self._tf), 0, var_34_0, 1):setOnUpdate(System.Action_float(function(arg_36_0)
			setText(self._playerBonusExp, "+" .. math.floor(arg_36_0))

			return
		end)).id)

		return
	end)).id)

	return
end

function BattleResultLayer:calcPlayerExp()
	local var_37_0 = self.contextData.oldPlayer.level
	local var_37_1 = self.player.exp - self.contextData.oldPlayer.exp

	while var_37_0 < self.player.level do
		var_37_1 = var_37_1 + pg.user_level[var_37_0].exp
		var_37_0 = var_37_0 + 1
	end

	if var_37_0 == pg.user_level[#pg.user_level].level then
		var_37_1 = 0
	end

	return var_37_1
end

function BattleResultLayer:calcPlayerRank()
	return self.season.score - self.contextData.oldRank.score
end

function BattleResultLayer:displayShips()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(self.shipVOs) do
		var_39_0[iter_39_1.id] = iter_39_1
	end

	local var_39_1 = self.contextData.statistics

	for iter_39_2, iter_39_3 in ipairs(self.shipVOs) do
		if var_39_1[iter_39_3.id] then
			var_39_1[iter_39_3.id].vo = iter_39_3
		end
	end

	local var_39_2
	local var_39_3

	if var_39_1.mvpShipID == -1 then
		var_39_3 = 0

		for iter_39_4, iter_39_5 in ipairs(self.contextData.oldMainShips) do
			var_39_3 = math.max(var_39_1[iter_39_5.id].output, var_39_3)
		end
	elseif var_39_1.mvpShipID and var_39_1.mvpShipID ~= 0 then
		var_39_2 = var_39_1[var_39_1.mvpShipID]
		var_39_3 = var_39_1[var_39_1.mvpShipID].output
	else
		var_39_3 = 0
	end

	local var_39_4 = self.contextData.oldMainShips

	self._atkFuncs = {}

	local var_39_5
	local var_39_6

	SetActive(self._atkToggle, #var_39_4 > 6)

	if #var_39_4 > 6 then
		onToggle(self, self._atkToggle, function(arg_40_0)
			SetActive(self._atkContainer, arg_40_0)
			SetActive(self._atkContainerNext, not arg_40_0)

			if arg_40_0 then
				self:skipAtkAnima(self._atkContainerNext)
			else
				self:skipAtkAnima(self._atkContainer)
			end

			return
		end, SFX_PANEL)
	end

	for iter_39_6, iter_39_7 in ipairs(var_39_4) do
		if var_39_1[iter_39_7.id] then
			local var_39_9 = table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_39_7.configId).type)
			local var_39_11
			local var_39_13

			if iter_39_6 > 6 then
				var_39_11 = self._atkContainerNext
				var_39_13 = 7
			else
				var_39_11 = self._atkContainer
				var_39_13 = 1
			end

			local var_39_14 = cloneTplTo(self._atkTpl, var_39_11)

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
			self:setAtkAnima(var_39_14, var_39_11, var_39_1[iter_39_7.id].output / var_39_3, var_39_3, var_39_2 and iter_39_7.id == var_39_2.id, var_39_1[iter_39_7.id].output, var_39_1[iter_39_7.id].kill_count)

			local var_39_23 = false

			if var_39_2 and iter_39_7.id == var_39_2.id then
				var_39_23 = true
				self.mvpShipVO = iter_39_7

				local var_39_26

				if self.contextData.score > 1 then
					local var_39_27, var_39_28

					var_39_27, var_39_26, var_39_28 = ShipWordHelper.GetWordAndCV(self.mvpShipVO.skinId, ShipWordHelper.WORD_TYPE_MVP, nil, nil, self.mvpShipVO:getCVIntimacy())
				else
					local var_39_29, var_39_30

					var_39_29, var_39_26, var_39_30 = ShipWordHelper.GetWordAndCV(self.mvpShipVO.skinId, ShipWordHelper.WORD_TYPE_LOSE)
				end

				if var_39_26 then
					self:stopVoice()
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_39_26, function(arg_41_0)
						self._currentVoice = arg_41_0

						return
					end)
				end
			end

			if iter_39_7.id == var_39_1._flagShipID then
				self.flagShipVO = iter_39_7
			end

			local var_39_31
			local var_39_32 = self.shipBuff and self.shipBuff[iter_39_7:getGroupId()]

			if self.expBuff or var_39_32 then
				var_39_31 = self.expBuff and self.expBuff:getConfig("name") or var_39_32 and i18n("Word_Ship_Exp_Buff")
			end

			local var_39_33

			if not var_39_9 then
				var_39_33 = BattleResultShipCard.New((cloneTplTo(self._extpl, self._expContainer)))

				table.insert(self._shipResultCardList, var_39_33)

				if var_39_6 then
					var_39_6:ConfigCallback(function()
						var_39_33:Play()

						return
					end)
				else
					var_39_33:Play()
				end

				var_39_6 = var_39_33
			else
				var_39_33 = BattleResultShipCard.New((cloneTplTo(self._extpl, self._subExpContainer)))

				table.insert(self._subShipResultCardList, var_39_33)

				if not var_39_5 then
					self._subFirstExpCard = var_39_33
				else
					var_39_5:ConfigCallback(function()
						var_39_33:Play()

						return
					end)
				end

				var_39_5 = var_39_33
			end

			var_39_33:SetShipVO(iter_39_7, var_39_0[iter_39_7.id], var_39_23, var_39_31)
		end
	end

	if var_39_6 then
		var_39_6:ConfigCallback(function()
			self._stateFlag = BattleResultLayer.STATE_DISPLAYED

			if not self._subFirstExpCard then
				self:skip()
			end

			return
		end)
	end

	if var_39_5 then
		var_39_5:ConfigCallback(function()
			self._stateFlag = BattleResultLayer.STATE_SUB_DISPLAYED

			self:skip()

			return
		end)
	end

	return
end

function BattleResultLayer:stopVoice()
	if self._currentVoice then
		self._currentVoice:PlaybackStop()

		self._currentVoice = nil
	end

	return
end

function BattleResultLayer:setAtkAnima(arg_47_1, arg_47_2, arg_47_3, arg_47_4, arg_47_5, arg_47_6, arg_47_7)
	local var_47_0 = arg_47_1:Find("result")
	local var_47_1 = arg_47_1:Find("result/atk")
	local var_47_2 = arg_47_1:Find("result/dmg_progress/progress_bar")
	local var_47_3 = arg_47_1:Find("result/killCount")

	setText(var_47_1, 0)
	setText(var_47_3, 0)

	var_47_2:GetComponent(typeof(Image)).fillAmount = 0

	if arg_47_5 then
		local var_47_4 = arg_47_1:Find("result/mvpBG")

		setParent(self._mvpFX, var_47_4)

		self._mvpFX.localPosition = Vector3(-368.5, 0, 0)

		setActive(var_47_4, true)
		setActive(arg_47_1:Find("result/bg"), false)
	end

	var_47_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_48_0)
		if arg_47_5 then
			setActive(self._mvpFX, true)
		end

		LeanTween.value(go(var_47_0), 0, arg_47_3, arg_47_3):setOnUpdate(System.Action_float(function(arg_49_0)
			var_47_2:GetComponent(typeof(Image)).fillAmount = arg_49_0

			return
		end))

		if arg_47_4 ~= 0 then
			LeanTween.value(go(var_47_0), 0, arg_47_6, arg_47_3):setOnUpdate(System.Action_float(function(arg_50_0)
				setText(var_47_1, math.floor(arg_50_0))

				return
			end))
			LeanTween.value(go(var_47_0), 0, arg_47_7, arg_47_3):setOnUpdate(System.Action_float(function(arg_51_0)
				setText(var_47_3, math.floor(arg_51_0))

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

	if self._atkFuncs[arg_47_2] == nil then
		self._atkFuncs[arg_47_2] = {}
	end

	table.insert(self._atkFuncs[arg_47_2], function()
		var_47_2:GetComponent(typeof(Image)).fillAmount = arg_47_3

		setText(var_47_1, arg_47_6)
		setText(var_47_3, arg_47_7)

		var_47_0.localPosition = Vector3(280, 46, 0)
		var_47_0:GetComponent(typeof(Animator)).enabled = false

		setActive(var_47_0, true)
		setActive(self._mvpFX, true)

		return
	end)

	return
end

function BattleResultLayer:skipAtkAnima(arg_54_1)
	if self._atkFuncs[arg_54_1] then
		for iter_54_0, iter_54_1 in ipairs(self._atkFuncs[arg_54_1]) do
			iter_54_1()
		end

		self._atkFuncs[arg_54_1] = nil
	end

	return
end

function BattleResultLayer:showPainting()
	local var_55_1

	SetActive(self._painting, true)

	if self.contextData.score > 1 then
		local var_55_3 = self.mvpShipVO or self.flagShipVO

		self.paintingName = var_55_3:getPainting()

		local var_55_4 = var_55_3:getCVIntimacy()

		setPaintingPrefabAsync(self._painting, self.paintingName, "jiesuan", function()
			if findTF(self._painting, "fitter").childCount > 0 then
				ShipExpressionHelper.SetExpression(findTF(self._painting, "fitter"):GetChild(0), self.paintingName, "win_mvp", var_55_4)
			end

			return
		end)

		local var_55_5, var_55_6

		var_55_5, var_55_6, var_55_1 = ShipWordHelper.GetWordAndCV(var_55_3.skinId, ShipWordHelper.WORD_TYPE_MVP, nil, nil, var_55_4)

		SetActive(self._failPainting, false)
	else
		local var_55_7, var_55_8

		var_55_7, var_55_8, var_55_1 = ShipWordHelper.GetWordAndCV(self.contextData.oldMainShips[math.random(#self.contextData.oldMainShips)].skinId, ShipWordHelper.WORD_TYPE_LOSE)
	end

	setText(self._chat:Find("Text"), var_55_1)

	local var_55_9 = self._chat:Find("Text"):GetComponent(typeof(Text))

	var_55_9.alignment = #var_55_9.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	SetActive(self._chat, true)

	self._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.cancel(go(self._painting))
	LeanTween.moveX(rtf(self._painting), 50, 0.25):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self._chat.gameObject), Vector3.New(1, 1, 1), 0.3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
			self._statisticsBtn:GetComponent("Button").enabled = true
			self._confirmBtn:GetComponent("Button").enabled = true
			self._atkBG:GetComponent("Button").enabled = true

			return
		end))

		return
	end))

	return
end

function BattleResultLayer:hidePainting()
	SetActive(self._chat, false)

	self._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.cancel(go(self._painting))
	LeanTween.scale(rtf(self._chat.gameObject), Vector3.New(0, 0, 0), 0.1):setEase(LeanTweenType.easeOutBack)
	LeanTween.moveX(rtf(self._painting), 720, 0.2):setOnComplete(System.Action(function()
		SetActive(self._painting, false)

		return
	end))

	return
end

function BattleResultLayer:skip()
	for iter_61_0, iter_61_1 in ipairs(self._delayLeanList) do
		LeanTween.cancel(iter_61_1)
	end

	if self._stateFlag == BattleResultLayer.STATE_RANK_ANIMA then
		-- block empty
	elseif self._stateFlag == BattleResultLayer.STATE_REPORT then
		while self._conditionContainer.childCount > 0 do
			SetActive(self._conditionContainer:GetChild(self._conditionContainer.childCount - 1), true)
		end

		SetActive(self._bg:Find("jieuan01/tips"), true)

		self._stateFlag = BattleResultLayer.STATE_REPORTED

		self:skip()
	elseif self._stateFlag == BattleResultLayer.STATE_REPORTED then
		self:showRewardInfo()
	elseif self._stateFlag == BattleResultLayer.STATE_REWARD then
		-- block empty
	elseif self._stateFlag == BattleResultLayer.STATE_DISPLAY then
		for iter_61_2, iter_61_3 in ipairs(self._shipResultCardList) do
			iter_61_3:SkipAnimation()
		end

		self._stateFlag = BattleResultLayer.STATE_DISPLAYED

		setText(self._playerBonusExp, "+" .. self:calcPlayerProgress())

		if not self._subFirstExpCard then
			self:playSubExEnter()
		elseif self.skipFlag then
			self:skip()
		end
	elseif self._stateFlag == BattleResultLayer.STATE_DISPLAYED then
		setText(self._playerBonusExp, "+" .. self:calcPlayerProgress())
		self:playSubExEnter()
	elseif self._stateFlag == BattleResultLayer.STATE_SUB_DISPLAY then
		for iter_61_4, iter_61_5 in ipairs(self._subShipResultCardList) do
			iter_61_5:SkipAnimation()
		end

		self._stateFlag = BattleResultLayer.STATE_SUB_DISPLAYED

		if self.skipFlag then
			self:skip()
		end
	elseif self._stateFlag == BattleResultLayer.STATE_SUB_DISPLAYED then
		self:showRightBottomPanel()
	end

	return
end

function BattleResultLayer:playSubExEnter()
	self._stateFlag = BattleResultLayer.STATE_SUB_DISPLAY

	if self._subFirstExpCard then
		triggerToggle(self._subToggle, false)
		self._subFirstExpCard:Play()
	else
		self:showRightBottomPanel()
	end

	if self.skipFlag then
		self:skip()
	end

	return
end

function BattleResultLayer:showRightBottomPanel()
	SetActive(self._skipBtn, false)
	SetActive(self._rightBottomPanel, true)
	SetActive(self._subToggle, self._subFirstExpCard ~= nil)
	onButton(self, self._statisticsBtn, function()
		if self._atkBG.gameObject.activeSelf then
			self:closeStatistics()
		else
			self:showStatistics()
		end

		return
	end, SFX_PANEL)
	onButton(self, self._confirmBtn, function()
		if self.failTag == true then
			self:emit(BattleResultMediator.PRE_BATTLE_FAIL_EXIT)
			self:emit(BattleResultMediator.OPEN_FAIL_TIP_LAYER)
		else
			self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self._atkBG, function()
		self:closeStatistics()

		return
	end, SFX_CANCEL)

	self._stateFlag = nil
	self._subFirstExpCard = nil

	if self.skipFlag then
		triggerButton(self._confirmBtn)
	end

	return
end

function BattleResultLayer:showStatistics()
	setActive(self._leftPanel, false)
	self:enabledStatisticsGizmos(false)
	SetActive(self._atkBG, true)

	self._atkBG:GetComponent("Button").enabled = false
	self._confirmBtn:GetComponent("Button").enabled = false
	self._statisticsBtn:GetComponent("Button").enabled = false

	self:showPainting()
	LeanTween.moveX(rtf(self._atkPanel), 0, 0.25):setOnComplete(System.Action(function()
		SetActive(self._atkContainer, true)

		return
	end))

	return
end

function BattleResultLayer:closeStatistics()
	setActive(self._leftPanel, true)
	self:skipAtkAnima(self._atkContainerNext)
	self:skipAtkAnima(self._atkContainer)
	self:enabledStatisticsGizmos(true)
	self:hidePainting()

	self._atkBG:GetComponent("Button").enabled = false

	LeanTween.cancel(self._atkPanel.gameObject)
	LeanTween.moveX(rtf(self._atkPanel), -700, 0.2):setOnComplete(System.Action(function()
		SetActive(self._atkBG, false)

		return
	end))

	return
end

function BattleResultLayer:enabledStatisticsGizmos(arg_71_1)
	setActive(self._main:Find("gizmos/xuxian_down"), arg_71_1)
	setActive(self._main:Find("gizmos/xuxian_middle"), arg_71_1)

	return
end

function BattleResultLayer:PlayAnimation(arg_72_1, arg_72_2, arg_72_3, arg_72_4, arg_72_5, arg_72_6)
	LeanTween.value(arg_72_1.gameObject, arg_72_2, arg_72_3, arg_72_4):setDelay(arg_72_5):setOnUpdate(System.Action_float(function(arg_73_0)
		arg_72_6(arg_73_0)

		return
	end))

	return
end

function BattleResultLayer:SetSkipFlag(arg_74_1)
	self.skipFlag = arg_74_1

	return
end

function BattleResultLayer:initMetaBtn()
	self.metaBtn = self._main:Find("MetaBtn")

	local var_75_0 = getProxy(MetaCharacterProxy):getLastMetaSkillExpInfoList()

	setActive(self.metaBtn, var_75_0 and #var_75_0 > 0 or false)
	onButton(self, self.metaBtn, function()
		setActive(self.metaBtn, false)

		if not self.metaExpView then
			self.metaExpView = BattleResultMetaExpView.New(self._blurConatiner, self.event, self.contextData)

			self.metaExpView:setData(var_75_0, function()
				if self.metaBtn then
					setActive(self.metaBtn, true)
				end

				self.metaExpView = nil

				return
			end)
			self.metaExpView:Reset()
			self.metaExpView:Load()
			self.metaExpView:ActionInvoke("Show")
			self.metaExpView:ActionInvoke("openPanel")
		end

		return
	end, SFX_PANEL)

	return
end

function BattleResultLayer:onBackPressed()
	if self.metaExpView then
		self.metaExpView:closePanel()

		self.metaExpView = nil

		return
	end

	if self._stateFlag == BattleResultLayer.STATE_RANK_ANIMA then
		-- block empty
	elseif self._stateFlag == BattleResultLayer.STATE_REPORT then
		triggerButton(self._bg)
	elseif self._stateFlag == BattleResultLayer.STATE_REPORTED then
		triggerButton(self._skipBtn)
	elseif self._stateFlag == BattleResultLayer.STATE_DISPLAY then
		triggerButton(self._skipBtn)
	else
		triggerButton(self._confirmBtn)
	end

	return
end

function BattleResultLayer:willExit()
	for iter_79_0, iter_79_1 in ipairs(self._shipResultCardList) do
		iter_79_1:Dispose()
	end

	for iter_79_2, iter_79_3 in ipairs(self._subShipResultCardList) do
		iter_79_3:Dispose()
	end

	self._atkFuncs = nil

	LeanTween.cancel(go(self._tf))

	if self.paintingName then
		retPaintingPrefab(self._painting, self.paintingName)
	end

	if self._rightTimer then
		self._rightTimer:Stop()
	end

	self:UnOverlayPanel(self._tf)
	self:stopVoice()
	getProxy(MetaCharacterProxy):clearLastMetaSkillExpInfoList()

	if self.metaExpView then
		self.metaExpView:Destroy()

		self.metaExpView = nil
	end

	pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

	return
end

return BattleResultLayer
