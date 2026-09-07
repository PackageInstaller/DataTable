local BattleWorldBossResultLayer = class("BattleWorldBossResultLayer", import("..base.BaseUI"))

BattleWorldBossResultLayer.DURATION_MOVE = 0.35
BattleWorldBossResultLayer.DURATION_WIN_SCALE = 0.4
BattleWorldBossResultLayer.CONDITIONS_FREQUENCE = 0.15
BattleWorldBossResultLayer.STATE_RANK_ANIMA = "rankAnima"
BattleWorldBossResultLayer.STATE_REPORT = "report"
BattleWorldBossResultLayer.STATE_REPORTED = "reported"
BattleWorldBossResultLayer.STATE_REWARD = "reward"
BattleWorldBossResultLayer.STATE_DISPLAY = "display"
BattleWorldBossResultLayer.STATE_DISPLAYED = "displayed"
BattleWorldBossResultLayer.STATE_SUB_DISPLAY = "subDisplay"
BattleWorldBossResultLayer.STATE_SUB_DISPLAYED = "subDisplayed"
BattleWorldBossResultLayer.ObjectiveList = {
	"battle_result_victory",
	"battle_result_undefeated",
	"battle_result_sink_limit",
	"battle_preCombatLayer_time_hold",
	"battle_result_time_limit",
	"battle_result_boss_destruct",
	"battle_preCombatLayer_damage_before_end",
	"battle_result_defeat_all_enemys"
}

function BattleWorldBossResultLayer:getUIName()
	return "BattleResultUI"
end

function BattleWorldBossResultLayer:setRivalVO(arg_2_1)
	self.rivalVO = arg_2_1

	return
end

function BattleWorldBossResultLayer:setRank(arg_3_1, arg_3_2)
	self.player = arg_3_1
	self.season = arg_3_2

	setText(self._playerName, "<color=#FFFFFF>" .. self.player.name .. "</color><size=32> / C O M M A N D E R</size>")

	local var_3_0, var_3_1 = SeasonInfo.getNextMilitaryRank(arg_3_2.score, arg_3_2.rank)

	setText(self._playerLv, SeasonInfo.getMilitaryRank(arg_3_2.score, arg_3_2.rank).name)
	setText(self._playerExpLabel, i18n("word_rankScore"))

	self._playerExpProgress:GetComponent(typeof(Image)).fillAmount = arg_3_2.score / var_3_1

	setText(self._playerBonusExp, "+0")

	self.calcPlayerProgress = self.calcPlayerRank

	return
end

function BattleWorldBossResultLayer:setShips(arg_4_1)
	self.shipVOs = arg_4_1

	return
end

function BattleWorldBossResultLayer:setPlayer(arg_5_1)
	self.player = arg_5_1

	setText(self._playerName, "<color=#FFFFFF>" .. self.player.name .. "</color><size=32> / C O M M A N D E R</size>")
	setText(self._playerLv, "Lv." .. self.player.level)

	self._playerExpProgress:GetComponent(typeof(Image)).fillAmount = self.player.exp / getConfigFromLevel1(pg.user_level, self.player.level).exp_interval

	if self.player.level == pg.user_level[#pg.user_level].level then
		self._playerExpProgress:GetComponent(typeof(Image)).fillAmount = 1
	end

	setText(self._playerBonusExp, "+0")

	self.calcPlayerProgress = self.calcPlayerExp

	return
end

function BattleWorldBossResultLayer:setExpBuff(arg_6_1)
	self.expBuff = arg_6_1

	return
end

function BattleWorldBossResultLayer:init()
	self._grade = self._tf:Find("grade")
	self._gradeLabel = self._grade:Find("label")
	self._gradeLabelImg = self._gradeLabel:GetComponent(typeof(Image))
	self.title = self._tf:Find("main/title")
	self.subTitleTxt = self._tf:Find("main/title/Text"):GetComponent(typeof(Text))
	self._levelText = self._grade:Find("chapterName/Text22")
	self.clearFX = self._tf:Find("clear")

	setParent(self.title, self._tf)

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
	self._skipBtn = self._tf:Find("skipLayer")
	self.UIMain = pg.UIMgr.GetInstance().UIMain
	self.overlay = pg.UIMgr.GetInstance().OverlayMain
	self._conditions = self._tf:Find("main/conditions")
	self._conditionContainer = self._conditions:Find("bg16/list")
	self._conditionTpl = self._conditions:Find("bg16/conditionTpl")
	self._conditionSubTpl = self._conditions:Find("bg16/conditionSubTpl")
	self._cmdExp = self._leftPanel:Find("commanderExp")
	self._cmdContainer = self._cmdExp:Find("commander_container")
	self._cmdTpl = self._cmdExp:Find("commander_tpl")

	local var_7_0 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_7_1 = self._tf:Find("grade/Xyz/bg13")
	local var_7_2 = self._tf:Find("grade/Xyz/bg14")
	local var_7_5
	local var_7_6 = self.contextData.score
	local var_7_7
	local var_7_8 = self.contextData.score > 0

	setActive(self._bg:Find("jieuan01/BG/bg_victory"), self.contextData.score > 0)
	setActive(self._bg:Find("jieuan01/BG/bg_fail"), not var_7_8)

	if var_7_8 then
		var_7_5 = var_7_0[var_7_6 + 1]
	elseif self.contextData.statistics._scoreMark == ys.Battle.BattleConst.DEAD_FLAG then
		var_7_5 = var_7_0[2]
		var_7_7 = "flag_destroy"
	else
		var_7_5 = var_7_0[1]
	end

	SetActive(self._levelText, false)
	LoadImageSpriteAsync("battlescore/grade_label_clear", self._gradeLabel, true)
	setActive(self._gradeLabel, true)
	setActive(self._grade:Find("Xyz"), false)
	setActive(self._grade:Find("chapterName"), false)

	self._gradeLabel.localScale = Vector3(1.2, 1.2, 1)
	self._delayLeanList = {}
	self._ratioFitter = GetComponent(self._tf, typeof(AspectRatioFitter))
	self._ratioFitter.enabled = true
	self._ratioFitter.aspectRatio = pg.CameraFixMgr.GetInstance().targetRatio
	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_8_0, arg_8_1)
		self._ratioFitter.aspectRatio = arg_8_1

		return
	end)

	return
end

function BattleWorldBossResultLayer:displayerCommanders(arg_9_1)
	self.commanderExps = self.contextData.commanderExps or {}

	local var_9_0 = getProxy(CommanderProxy)

	removeAllChildren(self._cmdContainer)

	local var_9_1 = arg_9_1 and (self.commanderExps.submarineCMD or {}) or self.commanderExps.surfaceCMD or {}

	setActive(self._cmdExp, true)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = var_9_0:getCommanderById(iter_9_1.commander_id)
		local var_9_3 = cloneTplTo(self._cmdTpl, self._cmdContainer)

		GetImageSpriteFromAtlasAsync("commandericon/" .. var_9_2:getPainting(), "", var_9_3:Find("icon/mask/pic"))
		setText(var_9_3:Find("exp/name_text"), var_9_2:getName())
		setText(var_9_3:Find("exp/lv_text"), "Lv." .. var_9_2.level)
		setText(var_9_3:Find("exp/exp_text"), "+" .. iter_9_1.exp)

		var_9_3:Find("exp/exp_progress"):GetComponent(typeof(Image)).fillAmount = var_9_2:isMaxLevel() and 1 or iter_9_1.curExp / var_9_2:getNextLevelExp()
	end

	return
end

function BattleWorldBossResultLayer:didEnter()
	self:setStageName()

	self._gradeUpperLeftPos = rtf(self._grade).localPosition
	self._gradeLabelImg.color = Color.New(1, 1, 1, 1)

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self._tf:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0.5)

	SetActive(self._atkBG, false)

	self._stateFlag = BattleWorldBossResultLayer.STATE_REPORTED

	setText(self.title, "")
	self:skip()

	return
end

function BattleWorldBossResultLayer:setTitle(arg_11_1)
	self.name = arg_11_1

	return
end

function BattleWorldBossResultLayer:setStageName()
	if self.contextData.system and self.contextData.system == SYSTEM_DUEL then
		setText(self._levelText, self.rivalVO.name)
	else
		setText(self._levelText, pg.expedition_data_template[self.contextData.stageId].name)
	end

	return
end

function BattleWorldBossResultLayer:rankAnimaFinish()
	SetActive(self._tf:Find("main/conditions"), true)

	local function var_13_0(arg_14_0)
		if type(arg_14_0) == "table" then
			self:setCondition(i18n(BattleWorldBossResultLayer.ObjectiveList[arg_14_0[1]], arg_14_0[2]), BattleWorldBossResultLayer.objectiveCheck(arg_14_0[1], self.contextData))
		end

		return
	end

	var_13_0(pg.expedition_data_template[self.contextData.stageId].objective_1)
	var_13_0(pg.expedition_data_template[self.contextData.stageId].objective_2)
	var_13_0(pg.expedition_data_template[self.contextData.stageId].objective_3)
	table.insert(self._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		self._stateFlag = BattleWorldBossResultLayer.STATE_REPORTED

		SetActive(self._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	self._stateFlag = BattleWorldBossResultLayer.STATE_REPORT

	return
end

function BattleWorldBossResultLayer:objectiveCheck(arg_16_1)
	if self == 1 or self == 4 or self == 8 then
		return arg_16_1.score > 1
	elseif self == 2 or self == 3 then
		return not arg_16_1.statistics._deadUnit
	elseif self == 6 then
		return arg_16_1.statistics._boss_destruct < 1
	elseif self == 5 then
		return not arg_16_1.statistics._badTime
	elseif self == 7 then
		return true
	end

	return
end

function BattleWorldBossResultLayer:setCondition(arg_17_1, arg_17_2)
	local var_17_0 = cloneTplTo(self._conditionTpl, self._conditionContainer)

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

	self:setSpriteTo(var_17_1, var_17_0:Find("checkBox"), true)

	if self._conditionContainer.childCount - 1 > 0 then
		table.insert(self._delayLeanList, LeanTween.delayedCall(BattleWorldBossResultLayer.CONDITIONS_FREQUENCE * (self._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_17_0, true)

			return
		end)).id)
	else
		setActive(var_17_0, true)
	end

	return
end

function BattleWorldBossResultLayer:showRewardInfo(arg_19_1)
	self._stateFlag = BattleWorldBossResultLayer.STATE_REWARD

	SetActive(self._bg:Find("jieuan01/tips"), false)
	setParent(self._tf, self.UIMain)

	local var_19_0

	local function var_19_1()
		if var_19_0 and coroutine.status(var_19_0) == "suspended" then
			local var_20_0, var_20_1 = coroutine.resume(var_19_0)

			assert(var_20_0, var_20_1)
		end

		return
	end

	var_19_0 = coroutine.create(function()
		local var_21_0 = {}

		for iter_21_0, iter_21_1 in ipairs(self.contextData.drops) do
			table.insert(var_21_0, iter_21_1)
		end

		for iter_21_2, iter_21_3 in ipairs(self.contextData.extraDrops) do
			iter_21_3.riraty = true

			table.insert(var_21_0, iter_21_3)
		end

		if table.getCount(self.contextData.drops) > 0 then
			self:emit(BaseUI.ON_AWARD, {
				items = self.contextData.drops,
				removeFunc = var_19_1
			})
			coroutine.yield()

			local var_21_3 = getProxy(BayProxy):getNewShip(true)

			for iter_21_4 = math.max(1, #var_21_3 - #_.filter(var_21_0, function(arg_22_0)
				return arg_22_0.type == DROP_TYPE_SHIP
			end) + 1), #var_21_3 do
				local var_21_4 = var_21_3[iter_21_4]

				if PlayerPrefs.GetInt(DISPLAY_SHIP_GET_EFFECT) ~= 1 then
					if var_21_4.virgin or var_21_4:getRarity() >= ShipRarity.Purple then
						self:emit(BattleResultMediator.GET_NEW_SHIP, var_21_4, var_19_1)
						coroutine.yield()
					end
				end
			end
		end

		setParent(self._tf, self.overlay)
		arg_19_1()
		setActive(self._tf:Find("main/jiesuanbeijing"), false)
		setActive(self._conditions, false)

		return
	end)

	var_19_1()

	return
end

function BattleWorldBossResultLayer:displayPlayerInfo()
	local var_23_0 = self:calcPlayerProgress()

	SetActive(self._leftPanel, true)
	SetActive(self._playerExp, true)

	self._main:GetComponent("Animator").enabled = true

	table.insert(self._delayLeanList, LeanTween.moveX(rtf(self._leftPanel), 0, 0.5):setOnComplete(System.Action(function()
		table.insert(self._delayLeanList, LeanTween.value(go(self._tf), 0, var_23_0, 1):setOnUpdate(System.Action_float(function(arg_25_0)
			setText(self._playerBonusExp, "+" .. math.floor(arg_25_0))

			return
		end)).id)

		return
	end)).id)

	return
end

function BattleWorldBossResultLayer:calcPlayerExp()
	local var_26_0 = self.contextData.oldPlayer.level
	local var_26_1 = self.player.exp - self.contextData.oldPlayer.exp

	while var_26_0 < self.player.level do
		var_26_1 = var_26_1 + pg.user_level[var_26_0].exp
		var_26_0 = var_26_0 + 1
	end

	if var_26_0 == pg.user_level[#pg.user_level].level then
		var_26_1 = 0
	end

	return var_26_1
end

function BattleWorldBossResultLayer:calcPlayerRank()
	return self.season.score - self.contextData.oldRank.score
end

function BattleWorldBossResultLayer:displayShips()
	setActive(self.title, true)

	self._expTFs = {}
	self._initExp = {}
	self._skipExp = {}
	self._subSkipExp = {}
	self._subCardAnimaFuncList = {}

	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(self.shipVOs) do
		var_28_0[iter_28_1.id] = iter_28_1
	end

	local var_28_1 = self.contextData.statistics

	for iter_28_2, iter_28_3 in ipairs(self.shipVOs) do
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

	local var_28_4 = self.contextData.oldMainShips

	self._atkFuncs = {}
	self._commonAtkTplList = {}
	self._subAtkTplList = {}

	local var_28_5
	local var_28_6

	SetActive(self._atkToggle, #var_28_4 > 6)

	if #var_28_4 > 6 then
		onToggle(self, self._atkToggle, function(arg_29_0)
			SetActive(self._atkContainer, arg_29_0)
			SetActive(self._atkContainerNext, not arg_29_0)

			if arg_29_0 then
				self:skipAtkAnima(self._atkContainerNext)
			else
				self:skipAtkAnima(self._atkContainer)
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
				var_28_13 = self._atkContainerNext
				var_28_15 = 7
			else
				var_28_13 = self._atkContainer
				var_28_15 = 1
			end

			local var_28_16 = cloneTplTo(self._atkTpl, var_28_13)

			var_28_16.localPosition.x = var_28_16.localPosition.x + (iter_28_4 - var_28_15) * 74
			var_28_16.localPosition.y = var_28_16.localPosition.y + (iter_28_4 - var_28_15) * 4
			var_28_16.localPosition = var_28_16.localPosition

			local var_28_17 = var_28_16:Find("result/mask/icon")
			local var_28_18 = var_28_16:Find("result/type")

			var_28_17:GetComponent(typeof(Image)).sprite = LoadSprite("herohrzicon/" .. iter_28_5:getPainting())

			setImageSprite(var_28_18, GetSpriteFromAtlas("shiptype", shipType2print(iter_28_5:getShipType())), true)
			self:setAtkAnima(var_28_16, var_28_13, var_28_1[iter_28_5.id].output / var_28_3, var_28_3, var_28_2 and iter_28_5.id == var_28_2.id, var_28_1[iter_28_5.id].output, var_28_1[iter_28_5.id].kill_count)

			var_28_9 = var_28_9 + var_28_1[iter_28_5.id].output

			local var_28_19
			local var_28_20

			if not var_28_11 then
				var_28_19 = cloneTplTo(self._extpl, self._expContainer)
				var_28_20 = self._skipExp

				table.insert(var_28_7, var_28_19)
			else
				var_28_19 = cloneTplTo(self._extpl, self._subExpContainer)
				var_28_20 = self._subSkipExp

				table.insert(var_28_8, var_28_19)
			end

			flushShipCard(var_28_19, iter_28_5)

			local var_28_21 = findTF(var_28_19, "content")
			local var_28_22 = findTF(var_28_21, "exp")

			self._expTFs[#self._expTFs + 1] = var_28_19

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
				self.mvpShipVO = iter_28_5

				SetActive(findTF(var_28_21, "mvp"), true)

				local var_28_33, var_28_34, var_28_35 = ShipWordHelper.GetWordAndCV(self.mvpShipVO.skinId, ShipWordHelper.WORD_TYPE_MVP)

				if var_28_34 then
					self._currentVoice = nil

					pg.CriMgr.GetInstance():PlaySoundEffect_V3(self._currentVoice)
				end
			end

			if iter_28_5.id == var_28_1._flagShipID then
				self.flagShipVO = iter_28_5
			end

			local var_28_36 = iter_28_5:getConfig("rarity")
			local var_28_37 = findTF(var_28_21, "dockyard/lv/Text")
			local var_28_38 = findTF(var_28_21, "dockyard/lv_bg/levelUpLabel")
			local var_28_39 = findTF(var_28_21, "dockyard/lv_bg/levelup")
			local var_28_40 = findTF(var_28_22, "exp_text")
			local var_28_41 = findTF(var_28_22, "exp_progress"):GetComponent(typeof(Image))
			local var_28_42 = findTF(var_28_22, "exp_buff_mask/exp_buff")

			setActive(var_28_42, self.expBuff)

			if self.expBuff then
				setText(var_28_42, self.expBuff:getConfig("name"))
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

					self:PlayAnimation(var_28_19, 0, var_30_2 + var_28_10:getExp() - iter_28_5:getExp(), 1, 0, function(arg_31_0)
						setText(var_28_40, "+" .. math.ceil(arg_31_0))

						return
					end)

					local function var_30_3(arg_32_0)
						SetActive(var_28_38, true)
						SetActive(var_28_39, true)

						local var_32_0 = var_28_38.localPosition

						LeanTween.moveY(rtf(var_28_38), var_28_38.localPosition.y + 30, 0.5):setOnComplete(System.Action(function()
							SetActive(var_28_38, false)

							var_28_38.localPosition = var_32_0

							pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BOAT_LEVEL_UP)

							return
						end))

						if arg_32_0 <= var_28_10.level then
							setText(var_28_37, arg_32_0)
						end

						return
					end

					local var_30_4 = iter_28_5.level

					local function var_30_5(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
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
									var_30_5(0, var_28_10:getExp() / var_30_1, 1, false)
								end
							elseif var_28_10.level > var_30_4 then
								var_30_5(0, 1, 0.7, true)
							end

							return
						end))

						return
					end

					var_30_5(iter_28_5:getExp() / var_30_0, 1, 0.7, true)
				else
					setText(var_28_40, "+" .. math.ceil(var_28_10:getExp() - iter_28_5:getExp()))

					if iter_28_5.level == iter_28_5:getMaxLevel() then
						var_28_41.fillAmount = 1

						return
					end

					self:PlayAnimation(var_28_19, iter_28_5:getExp() / var_30_0, var_28_10:getExp() / var_30_0, 1, 0, function(arg_37_0)
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
					self._subFirstExpTF = var_28_19
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
			self._stateFlag = BattleWorldBossResultLayer.STATE_DISPLAYED

			if not self._subFirstExpTF then
				self:skip()
			end

			return
		end)
	end

	if #var_28_8 > 0 then
		var_28_8[#var_28_8]:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_43_0)
			self._stateFlag = BattleWorldBossResultLayer.STATE_SUB_DISPLAYED

			self:skip()

			return
		end)
	end

	self.subTitleTxt.text = self.contextData.statistics.specificDamage

	return
end

function BattleWorldBossResultLayer:setAtkAnima(arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5, arg_44_6, arg_44_7)
	local var_44_0 = arg_44_1:Find("result")
	local var_44_1 = arg_44_1:Find("result/atk")
	local var_44_2 = arg_44_1:Find("result/dmg_progress/progress_bar")
	local var_44_3 = arg_44_1:Find("result/killCount")

	setText(var_44_1, 0)
	setText(var_44_3, 0)

	var_44_2:GetComponent(typeof(Image)).fillAmount = 0

	if arg_44_5 then
		local var_44_4 = arg_44_1:Find("result/mvpBG")

		setParent(self._mvpFX, var_44_4)

		self._mvpFX.localPosition = Vector3(-368.5, 0, 0)

		setActive(var_44_4, true)
		setActive(arg_44_1:Find("result/bg"), false)
	end

	var_44_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_45_0)
		if arg_44_5 then
			setActive(self._mvpFX, true)
		end

		LeanTween.value(go(var_44_0), 0, arg_44_3, arg_44_3):setOnUpdate(System.Action_float(function(arg_46_0)
			var_44_2:GetComponent(typeof(Image)).fillAmount = arg_46_0

			return
		end))

		if arg_44_4 ~= 0 then
			LeanTween.value(go(var_44_0), 0, arg_44_6, arg_44_3):setOnUpdate(System.Action_float(function(arg_47_0)
				setText(var_44_1, math.floor(arg_47_0))

				return
			end))
			LeanTween.value(go(var_44_0), 0, arg_44_7, arg_44_3):setOnUpdate(System.Action_float(function(arg_48_0)
				setText(var_44_3, math.floor(arg_48_0))

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

	if self._atkFuncs[arg_44_2] == nil then
		self._atkFuncs[arg_44_2] = {}
	end

	table.insert(self._atkFuncs[arg_44_2], function()
		var_44_2:GetComponent(typeof(Image)).fillAmount = arg_44_3

		setText(var_44_1, arg_44_6)
		setText(var_44_3, arg_44_7)

		var_44_0.localPosition = Vector3(280, 46, 0)
		var_44_0:GetComponent(typeof(Animator)).enabled = false

		setActive(var_44_0, true)
		setActive(self._mvpFX, true)

		return
	end)

	return
end

function BattleWorldBossResultLayer:skipAtkAnima(arg_51_1)
	if self._atkFuncs[arg_51_1] then
		for iter_51_0, iter_51_1 in ipairs(self._atkFuncs[arg_51_1]) do
			iter_51_1()
		end

		self._atkFuncs[arg_51_1] = nil
	end

	return
end

function BattleWorldBossResultLayer:showPainting()
	SetActive(self._painting, true)

	local var_52_3 = self.mvpShipVO or self.flagShipVO

	self.paintingName = var_52_3:getPainting()

	setPaintingPrefabAsync(self._painting, self.paintingName, "jiesuan", function()
		if findTF(self._painting, "fitter").childCount > 0 then
			ShipExpressionHelper.SetExpression(findTF(self._painting, "fitter"):GetChild(0), self.paintingName, "win_mvp")
		end

		return
	end)

	local var_52_4, var_52_5, var_52_6 = ShipWordHelper.GetWordAndCV(var_52_3.skinId, ShipWordHelper.WORD_TYPE_MVP)

	SetActive(self._failPainting, false)
	setText(self._chat:Find("Text"), var_52_6)

	local var_52_7 = self._chat:Find("Text"):GetComponent(typeof(Text))

	var_52_7.alignment = #var_52_7.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	SetActive(self._chat, true)

	self._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.cancel(go(self._painting))
	LeanTween.moveX(rtf(self._painting), 50, 0):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self._chat.gameObject), Vector3.New(1, 1, 1), 0):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
			self._statisticsBtn:GetComponent("Button").enabled = true
			self._confirmBtn:GetComponent("Button").enabled = true
			self._atkBG:GetComponent("Button").enabled = true

			return
		end))

		return
	end))

	return
end

function BattleWorldBossResultLayer:hidePainting()
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

function BattleWorldBossResultLayer:skip()
	seriesAsync({
		function(arg_59_0)
			self:showRewardInfo(arg_59_0)

			return
		end,
		function(arg_60_0)
			self:displayShips()
			self:showRightBottomPanel()

			return
		end
	})

	return
end

function BattleWorldBossResultLayer:playSubExEnter()
	self._stateFlag = BattleWorldBossResultLayer.STATE_SUB_DISPLAY

	if self._subFirstExpTF then
		triggerToggle(self._subToggle, false)
		setActive(self._subFirstExpTF, true)
	else
		self:showRightBottomPanel()
	end

	return
end

function BattleWorldBossResultLayer:showRightBottomPanel()
	SetActive(self._skipBtn, false)
	SetActive(self._rightBottomPanel, true)
	SetActive(self._subToggle, self._subFirstExpTF ~= nil)
	setActive(self._statisticsBtn, false)
	onButton(self, self._confirmBtn, function()
		self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)

		return
	end, SFX_CONFIRM)

	self._stateFlag = nil
	self._subFirstExpTF = nil

	self:showStatistics()

	return
end

function BattleWorldBossResultLayer:showStatistics()
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

function BattleWorldBossResultLayer:closeStatistics()
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

function BattleWorldBossResultLayer:enabledStatisticsGizmos(arg_68_1)
	setActive(self._main:Find("gizmos/xuxian_down"), arg_68_1)
	setActive(self._main:Find("gizmos/xuxian_middle"), arg_68_1)

	return
end

function BattleWorldBossResultLayer:PlayAnimation(arg_69_1, arg_69_2, arg_69_3, arg_69_4, arg_69_5, arg_69_6)
	LeanTween.value(arg_69_1.gameObject, arg_69_2, arg_69_3, arg_69_4):setDelay(arg_69_5):setOnUpdate(System.Action_float(function(arg_70_0)
		arg_69_6(arg_70_0)

		return
	end))

	return
end

function BattleWorldBossResultLayer:onBackPressed()
	if self._stateFlag == BattleWorldBossResultLayer.STATE_RANK_ANIMA then
		-- block empty
	elseif self._stateFlag == BattleWorldBossResultLayer.STATE_REPORT then
		triggerButton(self._bg)
	elseif self._stateFlag == BattleWorldBossResultLayer.STATE_DISPLAY then
		triggerButton(self._skipBtn)
	else
		triggerButton(self._confirmBtn)
	end

	return
end

function BattleWorldBossResultLayer:willExit()
	setActive(self.title, false)

	self._atkFuncs = nil

	LeanTween.cancel(go(self._tf))

	if self._atkBG.gameObject.activeSelf then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._blurConatiner, self._tf)
	end

	if self.paintingName then
		retPaintingPrefab(self._painting, self.paintingName)
	end

	if self._rightTimer then
		self._rightTimer:Stop()
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(self._currentVoice)
	end

	self._currentVoice = nil

	pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

	return
end

return BattleWorldBossResultLayer
