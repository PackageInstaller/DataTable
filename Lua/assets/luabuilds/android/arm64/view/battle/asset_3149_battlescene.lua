local BattleScene = class("BattleScene", import("..base.BaseUI"))

BattleScene.IN_VIEW_FRIEND_SKILL_OFFSET = Vector3(-5, 0, 6)
BattleScene.IN_VIEW_FOE_SKILL_OFFSET = Vector3(-15, 0, 6)
BattleScene.FOE_SIDE_X_OFFSET = 250
BattleScene.SKILL_FLOAT_SCALE = Vector3(1.5, 1.5, 0)
BattleScene.SIDE_ALIGNMENT = {
	{
		-120,
		-7.5,
		-232.5
	},
	{
		105,
		217.5,
		330
	},
	{
		-345,
		-457.5,
		-570
	}
}

local var_0_1

function BattleScene:getUIName()
	return "CombatUI" .. ys.Battle.BattleState.GetCombatSkinKey()
end

function BattleScene:forceRatio()
	return math.max(pg.CameraFixMgr.GetInstance().targetRatio, 1.7777777777777777)
end

function BattleScene:getBGM()
	local var_3_0 = {}

	table.insert(var_3_0, self.contextData.system == SYSTEM_WORLD and checkExist(pg.world_expedition_data[self.contextData.stageId], {
		"bgm"
	}) or "")
	table.insert(var_3_0, pg.expedition_data_template[self.contextData.stageId].bgm)

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if iter_3_1 ~= "" then
			return iter_3_1
		end
	end

	return BattleScene.super.getBGM(self)
end

function BattleScene:init()
	var_0_1 = ys.Battle.BattleVariable

	local var_4_0 = pg.UIMgr.GetInstance():GetMainCamera()

	self.uiCanvas = findTF(GameObject.Find("UICamera"), "Canvas/UIMain")
	self.skillTips = self._tf:Find("Skill_Activation")
	self.skillRoot = self._tf:Find("Skill_Activation/Root")
	self.skillTpl = self._tf:Find("Skill_Activation/mask").gameObject
	self._skillFloatPool = pg.Pool.New(self.skillRoot, self.skillTpl, 15, 10, true, false):InitSize()

	self._skillFloatPool:SetRecycleFuncs(function(arg_5_0)
		arg_5_0.transform:GetComponent(typeof(DftAniEvent)):OnDestroy()

		return
	end)

	self.skillCMDRoot = self._tf:Find("Skill_Activation/Root_cmd")
	self.skillCMDTpl = self._tf:Find("Skill_Activation/mask_cmd").gameObject
	self._skillFloatCMDPool = pg.Pool.New(self.skillCMDRoot, self.skillCMDTpl, 2, 4, true, false):InitSize()

	self._skillFloatCMDPool:SetRecycleFuncs(function(arg_6_0)
		arg_6_0.transform:GetComponent(typeof(DftAniEvent)):OnDestroy()

		return
	end)

	self.popupTpl = self:getTpl("popup")

	SetActive(self._go, false)

	self._skillPaintings = {}
	self._skillFloat = true
	self._cacheSkill = {}
	self._commanderSkillList = {}
	self._sideSkillFloatStateList = {}
	self._sideSkillFloatStateList[ys.Battle.BattleConfig.FRIENDLY_CODE] = {
		{},
		{},
		{}
	}
	self._sideSkillFloatStateList[ys.Battle.BattleConfig.FOE_CODE] = {
		{},
		{},
		{}
	}

	self:initPainting()

	self._fxContainerUpper = self._tf:Find("FXContainerUpper")
	self._fxContainerBottom = self._tf:Find("FXContainerBottom")

	local var_4_1 = self._tf:GetComponentInParent(typeof(UnityEngine.Canvas))

	if var_4_1 then
		self._canvasOrder = var_4_1.sortingOrder or 0
	end

	self._ratioFitter = GetComponent(self._tf, typeof(AspectRatioFitter))

	if not BATTLE_DEFAULT_UNIT_DETAIL then
		self._go:AddComponent(typeof(RectMask2D))
	end

	return
end

function BattleScene:initPainting()
	local var_7_0 = ys.Battle.BattleResourceManager.GetInstance():InstSkillPaintingUI()

	setParent(var_7_0, self.uiCanvas, false)

	self._paintingUI = var_7_0
	self._paintingAnimator = var_7_0:GetComponent(typeof(Animator))
	self._paintingAnimator.enabled = false
	self._paintingParticleContainer = findTF(var_7_0, "particleContainer")
	self._paintingParticles = findTF(self._paintingParticleContainer, "effect")
	self._paintingParticleSystem = self._paintingParticles:GetComponent(typeof(ParticleSystem))

	self._paintingParticleSystem:Stop(true)

	self._paintingFitter = findTF(var_7_0, "hero/fitter")

	removeAllChildren(self._paintingFitter)

	local var_7_1 = GetOrAddComponent(self._paintingFitter, "PaintingScaler")

	var_7_1.FrameName = "lihuisha"
	var_7_1.Tween = 1

	var_7_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_8_0)
		if self._currentPainting then
			setActive(self._currentPainting, false)

			self._currentPainting = nil
		end

		return
	end)

	return
end

function BattleScene:EnableSkillFloat(arg_9_1)
	if arg_9_1 == self._skillFloat then
		return
	end

	self._skillFloat = arg_9_1

	if self._skillFloat then
		for iter_9_0, iter_9_1 in ipairs(self._cacheSkill) do
			self:SkillHrzPop(iter_9_1.skillName, iter_9_1.caster, iter_9_1.commander, iter_9_1.hrzIcon)
		end

		self._cacheSkill = {}
	else
		self._skillFloatPool:AllRecycle()
		self._skillFloatCMDPool:AllRecycle()

		self._preCommanderSkillTF = nil
		self._preSkillTF = nil
	end

	SetActive(self.skillTips, arg_9_1)

	return
end

function BattleScene:SkillHrzPop(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not self._skillFloat then
		table.insert(self._cacheSkill, {
			skillName = arg_10_1,
			caster = arg_10_2,
			commander = arg_10_3,
			hrzIcon = arg_10_4
		})

		return
	end

	local var_10_0 = ys.Battle.BattleResourceManager.GetInstance()
	local var_10_1
	local var_10_2

	if arg_10_3 then
		if self._commanderSkillList[arg_10_3] and self._commanderSkillList[arg_10_3][arg_10_1] then
			return
		end

		var_10_1 = self._skillFloatCMDPool
		var_10_2 = ys.Battle.BattleState.GetCombatSkinKey() == "Standard" and var_10_0:GetCommanderHrzIcon(arg_10_3) or var_10_0:GetCommanderIcon(arg_10_3)
	else
		var_10_1 = self._skillFloatPool

		if arg_10_2:GetUnitType() == ys.Battle.BattleConst.UnitType.PLAYER_UNIT then
			local var_10_3 = arg_10_4 or arg_10_2:GetTemplate().painting

			var_10_2 = ys.Battle.BattleState.GetCombatSkinKey() == "Standard" and var_10_0:GetCharacterIcon(var_10_3) or var_10_0:GetCharacterSquareIcon(var_10_3)
		else
			var_10_2 = ys.Battle.BattleState.GetCombatSkinKey() == "Standard" and var_10_0:GetCharacterIcon(pg.enemy_data_statistics[arg_10_2:GetTemplateID()].icon) or var_10_0:GetCharacterSquareIcon(pg.enemy_data_statistics[arg_10_2:GetTemplateID()].icon)
		end
	end

	local var_10_4 = var_10_1:GetObject()
	local var_10_5 = var_10_4.transform

	var_10_5.localScale = BattleScene.SKILL_FLOAT_SCALE

	setText(findTF(var_10_5, "skill/skill_name/Text"), SwitchSpecialChar(HXSet.hxLan(arg_10_1)))

	local var_10_6 = findTF(var_10_5, "skill/skill_name")
	local var_10_7 = var_10_5:GetComponent(typeof(Animation))

	if var_10_7 then
		local var_10_8 = 1

		while var_10_7:GetClip("anim_skinui_skill_" .. var_10_8) do
			var_10_8 = var_10_8 + 1
		end

		if var_10_8 > 1 then
			var_10_7:Play("anim_skinui_skill_" .. math.random(var_10_8 - 1))
		end
	end

	findTF(var_10_5, "skill/icon_mask/icon"):GetComponent(typeof(Image)).sprite = var_10_2

	local var_10_9, var_10_10 = arg_10_2:GetIFF()

	var_10_10 = arg_10_2:GetIFF() == ys.Battle.BattleConfig.FRIENDLY_CODE and Color.New(1, 1, 1, 1) or Color.New(1, 0.33, 0.33, 1)
	var_10_6:GetComponent(typeof(Image)).color = var_10_10
	findTF(var_10_5, "skill"):GetComponent(typeof(Image)).color = var_10_10

	if arg_10_3 then
		self:commanderSkillFloat(arg_10_3, arg_10_1, var_10_4)
	else
		local var_10_11 = var_0_1.CameraPosToUICamera(arg_10_2:GetPosition():Clone())
		local var_10_12 = ys.Battle.BattleCameraUtil.GetInstance():GetCharacterArrowBarPosition(var_10_11)
		local var_10_13 = arg_10_2:GetMainUnitIndex()

		if var_10_12 == nil or var_10_12 == nil and table.contains(ShipType.SubShipType, arg_10_2:GetTemplate().type) and not arg_10_2:IsMainFleetUnit() then
			var_10_11 = var_10_9 == ys.Battle.BattleConfig.FRIENDLY_CODE and var_0_1.CameraPosToUICamera(arg_10_2:GetPosition():Clone():Add(BattleScene.IN_VIEW_FRIEND_SKILL_OFFSET)) or var_0_1.CameraPosToUICamera(arg_10_2:GetPosition():Clone():Add(BattleScene.IN_VIEW_FOE_SKILL_OFFSET))
			var_10_5.position = Vector3(var_10_11.x, var_10_11.y, -2)

			if Screen.width * 0.5 < rtf(var_10_5).rect.width * 0.5 + var_10_5.anchoredPosition.x then
				var_10_5.anchoredPosition.x = var_10_5.anchoredPosition.x - rtf(var_10_5).rect.width
				var_10_5.anchoredPosition = var_10_5.anchoredPosition
			end

			if self._preSkillTF then
				self.handleSkillFloatCld(self._preSkillTF, var_10_5)
			end

			self._preSkillTF = var_10_5

			var_10_5:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_11_0)
				self._preSkillTF = nil

				var_10_1:Recycle(var_10_4)

				return
			end)
		else
			local var_10_14
			local var_10_15 = self._sideSkillFloatStateList[var_10_9][var_10_13]

			for iter_10_0 = 1, #self._sideSkillFloatStateList[var_10_9][var_10_13] do
				if self._sideSkillFloatStateList[var_10_9][var_10_13][iter_10_0] then
					var_10_14 = iter_10_0

					break
				end
			end

			if var_10_14 == nil then
				var_10_14 = #self._sideSkillFloatStateList[var_10_9][var_10_13] + 1
			end

			self._sideSkillFloatStateList[var_10_9][var_10_13][var_10_14] = false
			var_10_5.position = Vector3(var_10_12.x, var_10_12.y, -2)
			var_10_5.anchoredPosition.y = BattleScene.SIDE_ALIGNMENT[var_10_13][var_10_14]

			if var_10_9 == ys.Battle.BattleConfig.FOE_CODE then
				var_10_5.anchoredPosition.x = BattleScene.FOE_SIDE_X_OFFSET
			end

			var_10_5.anchoredPosition = var_10_5.anchoredPosition

			var_10_5:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_12_0)
				var_10_15[var_10_14] = true

				var_10_1:Recycle(var_10_4)

				return
			end)
		end
	end

	return
end

function BattleScene:SkillHrzPopCover(arg_13_1, arg_13_2, arg_13_3)
	self:SkillHrzPop(arg_13_1, arg_13_2, nil, arg_13_3)

	return
end

function BattleScene:handleSkillFloatCld(arg_14_1)
	if math.floor(math.abs(arg_14_1.anchoredPosition.y - self.anchoredPosition.y)) <= 112.5 then
		arg_14_1.anchoredPosition.y = self.anchoredPosition.y + 112.5
		arg_14_1.anchoredPosition = arg_14_1.anchoredPosition
	end

	return
end

function BattleScene:handleSkillSinkCld(arg_15_1)
	return
end

function BattleScene:commanderSkillFloat(arg_16_1, arg_16_2, arg_16_3)
	self._commanderSkillList[arg_16_1] = self._commanderSkillList[arg_16_1] or {}
	self._commanderSkillList[arg_16_1][arg_16_2] = true
	arg_16_3.transform.anchoredPosition.x = 0
	arg_16_3.transform.anchoredPosition.y = 0
	arg_16_3.transform.anchoredPosition = arg_16_3.transform.anchoredPosition

	if self._preCommanderSkillTF then
		if math.floor(math.abs(arg_16_3.transform.anchoredPosition.y - self._preCommanderSkillTF.anchoredPosition.y)) <= 97.5 then
			arg_16_3.transform.anchoredPosition.y = self._preCommanderSkillTF.anchoredPosition.y - 97.5
		end
	end

	arg_16_3.transform.anchoredPosition = arg_16_3.transform.anchoredPosition
	self._preCommanderSkillTF = arg_16_3.transform

	arg_16_3.transform:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_17_0)
		self._commanderSkillList[arg_16_1][arg_16_2] = nil
		self._preCommanderSkillTF = nil

		self._skillFloatCMDPool:Recycle(arg_16_3)

		return
	end)

	return
end

function BattleScene:CutInPainting(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if self._currentPainting then
		self._paintingAnimator.enabled = false

		setActive(self._currentPainting, false)
	end

	local var_18_0

	if not arg_18_4 then
		::label_18_0::

		var_18_0 = arg_18_1.painting or arg_18_1.prefab
	end

	if self._skillPaintings[var_18_0] == nil then
		local var_18_1 = ys.Battle.BattleResourceManager.GetInstance():InstPainting(var_18_0)

		self._skillPaintings[var_18_0] = var_18_1

		setParent(var_18_1, self._paintingFitter, false)
	end

	self._currentPainting = self._skillPaintings[var_18_0]

	setActive(self._currentPainting, true)
	LuaHelper.SetParticleSpeed(self._paintingUI, arg_18_2)

	local var_18_2 = Vector3(arg_18_3, 1, 1)

	self._paintingUI.transform.localScale = var_18_2
	self._paintingParticleContainer.transform.localScale = var_18_2
	self._paintingParticles.transform.localEulerAngles = Vector3(0, 90 * arg_18_3, 0)

	self._paintingParticleSystem:Play(true)

	self._paintingAnimator.speed = arg_18_2
	self._paintingAnimator.enabled = true

	self._paintingAnimator:Play("skill_painting", -1, 0)

	return
end

function BattleScene:CutInPaintingDAL(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = ys.Battle.BattleResourceManager.GetInstance():InstSkillPaintingDALUI()

	setParent(var_19_0, self.uiCanvas, false)

	local var_19_1 = findTF(var_19_0, "hero/fitter")
	local var_19_2 = GetOrAddComponent(var_19_1, "PaintingScaler")

	var_19_2.FrameName = "lihuisha"
	var_19_2.Tween = 1

	setParent(ys.Battle.BattleResourceManager.GetInstance():InstPainting(arg_19_4.cutin_cover_DAL), var_19_1, false)
	var_19_0:GetComponent(typeof(Animator)):Play("skill_painting", -1, 0)
	setText(findTF(var_19_0, "pop/text"), arg_19_4.cutin_script)
	var_19_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_20_0)
		setActive(var_19_0, false)

		return
	end)

	return
end

function BattleScene:didEnter()
	setActive(self._tf, false)

	self._ratioFitter.enabled = true
	self._ratioFitter.aspectRatio = pg.CameraFixMgr.GetInstance():GetBattleUIRatio()
	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_22_0, arg_22_1)
		self._ratioFitter.aspectRatio = pg.CameraFixMgr.GetInstance():GetBattleUIRatio()

		return
	end)

	local var_21_0 = ys.Battle.BattleState.GetInstance()

	var_21_0:SetBattleUI(self)
	onButton(self, self._tf:Find("PauseBtn"), function()
		self:emit(BattleMediator.ON_PAUSE)

		return
	end, SFX_CONFIRM)

	self._chatBtn = self._tf:Find("chatBtnContainer/chatBtn")

	local var_21_1 = self._chatBtn:GetComponent(typeof(Animation))

	onButton(self, self._chatBtn, function()
		self:emit(BattleMediator.ON_CHAT, self._tf:Find("chatContainer"))

		if not var_21_1 then
			setActive(self._chatBtn, false)
		else
			var_21_1:Play("chatbtn_out")
		end

		return
	end)
	onToggle(self, self._tf:Find("AutoBtn"), function(arg_25_0)
		local var_25_0 = var_21_0:GetBattleType()

		self:emit(BattleMediator.ON_AUTO, {
			isOn = not arg_25_0,
			toggle = self._tf:Find("AutoBtn"),
			system = var_25_0
		})
		var_21_0:ActiveBot(ys.Battle.BattleState.IsAutoBotActive(var_25_0))

		if var_21_0:ChatUseable() then
			setActive(self._chatBtn, true)

			if var_21_1 then
				var_21_1:Play("chatbtn_in")
			end
		elseif var_21_1 then
			var_21_1:Play("chatbtn_out")
		else
			setActive(self._chatBtn, false)
		end

		return
	end, SFX_PANEL, SFX_PANEL)
	onButton(self, self._tf:Find("CardPuzzleConsole/relic/bg"), function()
		self:emit(BattleMediator.ON_PUZZLE_RELIC, {
			relicList = var_21_0:GetProxyByName(ys.Battle.BattleDataProxy.__name):GetFleetByIFF(ys.Battle.BattleConfig.FRIENDLY_CODE):GetCardPuzzleComponent():GetRelicList()
		})

		return
	end, SFX_CONFIRM)
	onButton(self, self._tf:Find("CardPuzzleConsole/deck/bg"), function()
		local var_27_0 = var_21_0:GetProxyByName(ys.Battle.BattleDataProxy.__name):GetFleetByIFF(ys.Battle.BattleConfig.FRIENDLY_CODE):GetCardPuzzleComponent()

		self:emit(BattleMediator.ON_PUZZLE_CARD, {
			card = var_27_0:GetDeck():GetCardList(),
			hand = var_27_0:GetHand():GetCardList()
		})

		return
	end, SFX_CONFIRM)
	var_21_0:ConfigBattleEndFunc(function(arg_28_0)
		self:clear()
		self:emit(BattleMediator.ON_BATTLE_RESULT, arg_28_0)

		return
	end)

	local var_21_2 = {
		ys.Battle.BattleConst.BuffEffectType.ON_START_GAME,
		ys.Battle.BattleConst.BuffEffectType.ON_FLAG_SHIP,
		ys.Battle.BattleConst.BuffEffectType.ON_CONSORT,
		ys.Battle.BattleConst.BuffEffectType.ON_LEADER,
		ys.Battle.BattleConst.BuffEffectType.ON_REAR,
		ys.Battle.BattleConst.BuffEffectType.ON_SUB_LEADER,
		ys.Battle.BattleConst.BuffEffectType.ON_SUB_CONSORT
	}

	local function var_21_3(arg_29_0)
		local var_29_0 = 0

		for iter_29_0, iter_29_1 in ipairs(arg_29_0) do
			var_29_0 = var_29_0 + ys.Battle.BattleDataFunction.GetShipSkillTriggerCount(iter_29_1, var_21_2)
		end

		return var_29_0
	end

	self._skillFloatPool = pg.Pool.New(self.skillRoot, self.skillTpl, 0 + var_21_3(self.contextData.battleData.MainUnitList) + var_21_3(self.contextData.battleData.VanguardUnitList) + var_21_3(self.contextData.battleData.SubUnitList) + 4, 10, true, false):InitSize()

	self._skillFloatPool:SetRecycleFuncs(function(arg_30_0)
		arg_30_0.transform:GetComponent(typeof(DftAniEvent)):OnDestroy()

		return
	end)
	self:emit(BattleMediator.ENTER)
	self:initPauseWindow()

	if self.contextData.prePause then
		triggerButton(self._tf:Find("PauseBtn"))
	end

	setActive(self._chatBtn, var_21_0:ChatUseable())

	return
end

function BattleScene:onBackPressed()
	if isActive(self.pauseWindow) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(self.continueBtn)
	end

	return
end

function BattleScene:activeBotHelp(arg_32_1)
	local var_32_0 = getProxy(PlayerProxy)

	if not arg_32_1 then
		if self.autoBotHelp then
			pg.MsgboxMgr.GetInstance():hide()
		end

		return
	end

	if var_32_0.botHelp then
		return
	end

	self.autoBotHelp = true

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		type = MSGBOX_TYPE_HELP,
		helps = i18n("help_battle_auto"),
		custom = {
			{
				text = "text_iknow",
				sound = SFX_CANCEL
			}
		},
		onClose = function()
			self.autoBotHelp = false

			return
		end
	})

	var_32_0.botHelp = true

	return
end

function BattleScene:exitBattle(arg_34_1)
	if not arg_34_1 then
		self:emit(BattleMediator.ON_QUIT_BATTLE_MANUALLY)
		self:emit(BattleMediator.ON_BACK_PRE_SCENE)
	elseif arg_34_1 == "kick" then
		-- block empty
	end

	return
end

function BattleScene:setChapter(arg_35_1)
	self._chapter = arg_35_1

	return
end

function BattleScene:setFleet(arg_36_1, arg_36_2, arg_36_3)
	self._mainShipVOs = arg_36_1
	self._vanShipVOs = arg_36_2
	self._subShipVOs = arg_36_3

	return
end

function BattleScene:initPauseWindow()
	self.pauseWindow = self._tf:Find("Msgbox")
	self.LeftTimeContainer = self.pauseWindow:Find("window/LeftTime")
	self.LeftTime = self.pauseWindow:Find("window/LeftTime/Text")
	self.mainTFs = {}
	self.vanTFs = {}

	setText(self.LeftTimeContainer:Find("label"), i18n("battle_battleMediator_remainTime"))
	setText(self.pauseWindow:Find("window/van/power/title"), i18n("word_vanguard_fleet"))
	setText(self.pauseWindow:Find("window/main/power/title"), i18n("word_main_fleet"))

	local function var_37_0(arg_38_0, arg_38_1, arg_38_2)
		for iter_38_0 = 1, 3 do
			local var_38_0 = arg_38_1:Find("ship_" .. iter_38_0)

			setActive(var_38_0, arg_38_2 and iter_38_0 <= #arg_38_2)

			if arg_38_2 and iter_38_0 <= #arg_38_2 then
				updateShip(var_38_0, arg_38_2[iter_38_0])
			end

			table.insert(arg_38_0, var_38_0)
		end

		if arg_38_2 then
			local var_38_1 = 0

			for iter_38_1, iter_38_2 in ipairs(arg_38_2) do
				var_38_1 = var_38_1 + iter_38_2:getShipCombatPower()
			end

			setText(arg_38_1:Find("power/value"), var_38_1)
		end

		return
	end

	local var_37_1 = ys.Battle.BattleState.GetInstance()
	local var_37_2 = var_37_1:GetBattleType()

	if self._mainShipVOs then
		var_37_0(self.mainTFs, self.pauseWindow:Find("window/main"), self._mainShipVOs)
		var_37_0(self.vanTFs, self.pauseWindow:Find("window/van"), self._vanShipVOs)
	elseif var_37_2 == SYSTEM_SCENARIO_SUB_STRIKE then
		self.subTFs = {}

		local var_37_3 = self.pauseWindow:Find("window/main")

		setActive(self.pauseWindow:Find("window/van"), false)
		setActive(self.pauseWindow:Find("window/bg_fleet/Image (1)"), false)
		var_37_0(self.subTFs, var_37_3, self._subShipVOs)
		setText(var_37_3:Find("power/title"), i18n("index_shipType_qianTing"))

		var_37_3.localPosition = Vector3(0, var_37_3.localPosition.y, 0)
	end

	local var_37_4 = findTF(self.pauseWindow, "window/Chapter")
	local var_37_5 = findTF(self.pauseWindow, "window/Chapter/Text")

	self.continueBtn = self.pauseWindow:Find("window/button_container/continue")
	self.leaveBtn = self.pauseWindow:Find("window/button_container/leave")

	setText(self.continueBtn:Find("pic"), i18n("battle_battleMediator_goOnFight"))
	setText(self.leaveBtn:Find("pic"), i18n("battle_battleMediator_existFight"))

	if var_37_2 == SYSTEM_SCENARIO or var_37_2 == SYSTEM_SCENARIO_SUB_STRIKE then
		local var_37_6 = self._chapter:getConfigTable()

		setText(var_37_4, var_37_6.chapter_name)
		setText(var_37_5, string.split(var_37_6.name, "|")[1])
	elseif var_37_2 == SYSTEM_ROUTINE or var_37_2 == SYSTEM_DUEL or var_37_2 == SYSTEM_HP_SHARE_ACT_BOSS or var_37_2 == SYSTEM_BOSS_EXPERIMENT or var_37_2 == SYSTEM_ACT_BOSS or var_37_2 == SYSTEM_ACT_BOSS_SP or var_37_2 == SYSTEM_BOSS_RUSH or var_37_2 == SYSTEM_BOSS_RUSH_EX or var_37_2 == SYSTEM_BOSS_RUSH_COLLABRATE or var_37_2 == SYSTEM_LIMIT_CHALLENGE or var_37_2 == SYSTEM_BOSS_SINGLE or var_37_2 == SYSTEM_BOSS_SINGLE_VARIABLE then
		setText(var_37_4, "SP")
		setText(var_37_5, pg.expedition_data_template[var_37_1:GetProxyByName(ys.Battle.BattleDataProxy.__name):GetInitData().StageTmpId].name)
	elseif var_37_2 == SYSTEM_DEBUG then
		setText(var_37_4, "??")
		setText(var_37_5, "碧蓝梦境")
	elseif var_37_2 == SYSTEM_CHALLENGE then
		setText(var_37_4, "SP")
		setText(var_37_5, self._chapter:getNextExpedition().chapter_name[2])
		setActive(self.LeftTimeContainer, true)
	elseif var_37_2 == SYSTEM_WORLD_BOSS or var_37_2 == SYSTEM_WORLD then
		setText(var_37_4, i18n("world_battle_pause"))
		setText(var_37_5, i18n("world_battle_pause2"))

		if var_37_2 == SYSTEM_WORLD_BOSS then
			setActive(self.leaveBtn, false)
		end
	elseif var_37_2 == SYSTEM_GUILD then
		local var_37_7 = pg.guild_boss_event[var_37_1:GetProxyByName(ys.Battle.BattleDataProxy.__name):GetInitData().ActID]

		setText(var_37_4, "BOSS")
		setText(var_37_5, (var_37_7 or nil) and (var_37_7.name or ""))
	elseif var_37_2 == SYSTEM_TEST or var_37_2 == SYSTEM_SUB_ROUTINE or var_37_2 == SYSTEM_SCENARIO_SUB_STRIKE or var_37_2 == SYSTEM_PERFORM or var_37_2 == SYSTEM_PROLOGUE or var_37_2 == SYSTEM_DODGEM or var_37_2 == SYSTEM_SIMULATION or var_37_2 == SYSTEM_SUBMARINE_RUN or var_37_2 == SYSTEM_BOSS_EXPERIMENT or var_37_2 == SYSTEM_REWARD_PERFORM or var_37_2 == SYSTEM_AIRFIGHT then
		-- block empty
	elseif var_37_2 == SYSTEM_CARDPUZZLE then
		-- block empty
	else
		assert(false, "System not defined " .. (var_37_2 or "NIL"))
	end

	onButton(self, self.leaveBtn, function()
		self:emit(BattleMediator.ON_LEAVE)

		local var_39_0 = self.leaveBtn:GetComponent(typeof(Animation))

		if var_39_0 and var_39_0:GetClip("msgbox_btn_blink") then
			var_39_0:Play("msgbox_btn_blink")
		end

		return
	end)
	onButton(self, self.continueBtn, function()
		local var_40_0 = self.continueBtn:GetComponent(typeof(Animation))

		if var_40_0 and var_40_0:GetClip("msgbox_btn_blink") then
			var_40_0:Play("msgbox_btn_blink")
		end

		local var_40_1 = self.pauseWindow:GetComponent(typeof(Animation))

		if var_40_1 then
			if var_40_1:IsPlaying("msgbox_out") then
				var_40_1:Stop("msgbox_out")
				var_40_1:Play("msgbox_in")
			else
				var_40_1:Play("msgbox_out")
				self.pauseWindow:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_41_0)
					self:ClosePauseWindow()
					var_37_1:Resume()

					return
				end)
			end
		else
			self:ClosePauseWindow()
			var_37_1:Resume()
		end

		return
	end)
	onButton(self, self.pauseWindow:Find("help"), function()
		if BATTLE_DEBUG and PLATFORM == 7 then
			self:ClosePauseWindow()
			var_37_1:Resume()
			var_37_1:OpenConsole()
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("help_battle_rule")
			})
		end

		return
	end)
	onButton(self, self.pauseWindow:Find("window/top/btnBack"), function()
		triggerButton(self.continueBtn)

		return
	end)
	onButton(self, self.pauseWindow, function()
		triggerButton(self.continueBtn)

		return
	end)
	onButton(self, self.pauseWindow, function()
		local var_45_0 = self.pauseWindow:GetComponent(typeof(Animation))

		if var_45_0 and var_45_0:IsPlaying("msgbox_out") then
			-- block empty
		else
			triggerButton(self.continueBtn)
		end

		return
	end)
	setActive(self.pauseWindow, false)

	return
end

function BattleScene:updatePauseWindow()
	if not self.pauseWindow then
		return
	end

	setActive(self.pauseWindow, true)
	pg.UIMgr.GetInstance():BlurPanel(self.pauseWindow)

	local var_46_0 = ys.Battle.BattleState.GetInstance():GetProxyByName(ys.Battle.BattleDataProxy.__name)
	local var_46_1 = var_46_0:GetFleetByIFF(ys.Battle.BattleConfig.FRIENDLY_CODE)

	local function var_46_2(arg_47_0, arg_47_1)
		if not arg_47_0 then
			return
		end

		for iter_47_0 = 1, #arg_47_0 do
			if var_46_1:GetFreezeShipByID(arg_47_0[iter_47_0].id) then
				setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, var_46_1:GetFreezeShipByID(arg_47_0[iter_47_0].id):GetHPRate())
				SetActive(arg_47_1[iter_47_0]:Find("mask"), false)
			elseif var_46_1:GetShipByID(arg_47_0[iter_47_0].id) then
				setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, var_46_1:GetShipByID(arg_47_0[iter_47_0].id):GetHPRate())
				SetActive(arg_47_1[iter_47_0]:Find("mask"), false)
			else
				setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, 0)
				SetActive(arg_47_1[iter_47_0]:Find("mask"), true)
			end
		end

		return
	end

	var_46_2(self._mainShipVOs, self.mainTFs)
	var_46_2(self._vanShipVOs, self.vanTFs)

	if self.subTFs then
		var_46_2(self._subShipVOs, self.subTFs)
	end

	setText(self.LeftTime, ys.Battle.BattleTimerView.formatTime(math.floor(var_46_0:GetCountDown())))

	return
end

function BattleScene:ClosePauseWindow()
	setActive(self.pauseWindow, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.pauseWindow, self._tf)

	return
end

function BattleScene:AddUIFX(arg_49_1, arg_49_2)
	if not arg_49_2 then
		arg_49_2 = 1
		arg_49_1 = tf(arg_49_1)
	end

	local var_49_0

	if arg_49_2 > 0 then
		var_49_0 = self._fxContainerUpper or self._fxContainerBottom
	end

	arg_49_1:SetParent(var_49_0)
	pg.ViewUtils.SetSortingOrder(arg_49_1, self._canvasOrder + arg_49_2)
	pg.ViewUtils.SetLayer(arg_49_1, Layer.UI)

	return var_49_0.localScale
end

function BattleScene:OnCloseChat()
	local var_50_0 = self._chatBtn:GetComponent(typeof(Animation))

	if ys.Battle.BattleState.GetInstance():IsBotActive() then
		setActive(self._chatBtn, true)

		if var_50_0 then
			var_50_0:Play("chatbtn_in")
		end
	elseif var_50_0 then
		var_50_0:Play("chatbtn_out")
	else
		setActive(self._chatBtn, false)
	end

	return
end

function BattleScene:clear()
	self._preSkillTF = nil

	self._skillFloatPool:AllRecycle()
	self._skillFloatCMDPool:AllRecycle()

	self._preCommanderSkillTF = nil
	self._commanderSkillList = nil
	self._skillPaintings = nil
	self._currentPainting = nil

	Destroy(self._paintingUI)

	return
end

function BattleScene:willExit()
	self._skillFloatPool:Dispose()
	self._skillFloatCMDPool:Dispose()
	ys.Battle.BattleState.GetInstance():ExitBattle()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.pauseWindow, self._tf)
	ys.Battle.BattleCameraUtil.GetInstance().ActiveMainCamera(false)
	pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

	return
end

return BattleScene
