local var_0_0 = class("BattleScene", import("..base.BaseUI"))

var_0_0.IN_VIEW_FRIEND_SKILL_OFFSET = Vector3(-5, 0, 6)
var_0_0.IN_VIEW_FOE_SKILL_OFFSET = Vector3(-15, 0, 6)
var_0_0.FOE_SIDE_X_OFFSET = 250
var_0_0.SKILL_FLOAT_SCALE = Vector3(1.5, 1.5, 0)
var_0_0.SIDE_ALIGNMENT = {
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

function var_0_0.getUIName(arg_1_0)
	return "CombatUI" .. ys.Battle.BattleState.GetCombatSkinKey()
end

function var_0_0.forceRatio(arg_2_0)
	return math.max(pg.CameraFixMgr.GetInstance().targetRatio, 1.7777777777777777)
end

function var_0_0.getBGM(arg_3_0)
	local var_3_0 = arg_3_0.contextData.system == SYSTEM_WORLD and checkExist(pg.world_expedition_data[arg_3_0.contextData.stageId], {
		"bgm"
	}) or ""

	table.insert({}, var_3_0)
	table.insert({}, pg.expedition_data_template[arg_3_0.contextData.stageId].bgm)

	for iter_3_0, iter_3_1 in ipairs({}) do
		if iter_3_1 ~= "" then
			return iter_3_1
		end
	end

	return var_0_0.super.getBGM(arg_3_0)
end

function var_0_0.init(arg_4_0)
	var_0_1 = ys.Battle.BattleVariable

	local var_4_0 = pg.UIMgr.GetInstance():GetMainCamera()

	arg_4_0.uiCanvas = findTF(GameObject.Find("UICamera"), "Canvas/UIMain")
	arg_4_0.skillTips = arg_4_0._tf:Find("Skill_Activation")
	arg_4_0.skillRoot = arg_4_0._tf:Find("Skill_Activation/Root")
	arg_4_0.skillTpl = arg_4_0._tf:Find("Skill_Activation/mask").gameObject
	arg_4_0._skillFloatPool = pg.Pool.New(arg_4_0.skillRoot, arg_4_0.skillTpl, 15, 10, true, false):InitSize()

	arg_4_0._skillFloatPool:SetRecycleFuncs(function(arg_5_0)
		arg_5_0.transform:GetComponent(typeof(DftAniEvent)):OnDestroy()

		return
	end)

	arg_4_0.skillCMDRoot = arg_4_0._tf:Find("Skill_Activation/Root_cmd")
	arg_4_0.skillCMDTpl = arg_4_0._tf:Find("Skill_Activation/mask_cmd").gameObject
	arg_4_0._skillFloatCMDPool = pg.Pool.New(arg_4_0.skillCMDRoot, arg_4_0.skillCMDTpl, 2, 4, true, false):InitSize()

	arg_4_0._skillFloatCMDPool:SetRecycleFuncs(function(arg_6_0)
		arg_6_0.transform:GetComponent(typeof(DftAniEvent)):OnDestroy()

		return
	end)

	arg_4_0.popupTpl = arg_4_0:getTpl("popup")

	SetActive(arg_4_0._go, false)

	arg_4_0._skillPaintings = {}
	arg_4_0._skillFloat = true
	arg_4_0._cacheSkill = {}
	arg_4_0._commanderSkillList = {}
	arg_4_0._sideSkillFloatStateList = {}
	arg_4_0._sideSkillFloatStateList[ys.Battle.BattleConfig.FRIENDLY_CODE] = {
		{},
		{},
		{}
	}
	arg_4_0._sideSkillFloatStateList[ys.Battle.BattleConfig.FOE_CODE] = {
		{},
		{},
		{}
	}

	arg_4_0:initPainting()

	arg_4_0._fxContainerUpper = arg_4_0._tf:Find("FXContainerUpper")
	arg_4_0._fxContainerBottom = arg_4_0._tf:Find("FXContainerBottom")

	local var_4_1 = arg_4_0._tf:GetComponentInParent(typeof(UnityEngine.Canvas))

	if var_4_1 then
		arg_4_0._canvasOrder = var_4_1.sortingOrder or 0
		arg_4_0._ratioFitter = GetComponent(arg_4_0._tf, typeof(AspectRatioFitter))

		if not BATTLE_DEFAULT_UNIT_DETAIL then
			arg_4_0._go:AddComponent(typeof(RectMask2D))
		end

		return
	end
end

function var_0_0.initPainting(arg_7_0)
	local var_7_0 = ys.Battle.BattleResourceManager.GetInstance():InstSkillPaintingUI()

	setParent(var_7_0, arg_7_0.uiCanvas, false)

	arg_7_0._paintingUI = var_7_0
	arg_7_0._paintingAnimator = var_7_0:GetComponent(typeof(Animator))
	arg_7_0._paintingAnimator.enabled = false
	arg_7_0._paintingParticleContainer = findTF(var_7_0, "particleContainer")
	arg_7_0._paintingParticles = findTF(arg_7_0._paintingParticleContainer, "effect")
	arg_7_0._paintingParticleSystem = arg_7_0._paintingParticles:GetComponent(typeof(ParticleSystem))

	arg_7_0._paintingParticleSystem:Stop(true)

	arg_7_0._paintingFitter = findTF(var_7_0, "hero/fitter")

	removeAllChildren(arg_7_0._paintingFitter)

	local var_7_1 = GetOrAddComponent(arg_7_0._paintingFitter, "PaintingScaler")

	var_7_1.FrameName = "lihuisha"
	var_7_1.Tween = 1

	var_7_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_8_0)
		if arg_7_0._currentPainting then
			setActive(arg_7_0._currentPainting, false)

			arg_7_0._currentPainting = nil
		end

		return
	end)

	return
end

function var_0_0.EnableSkillFloat(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0._skillFloat then
		return
	end

	arg_9_0._skillFloat = arg_9_1

	if arg_9_0._skillFloat then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._cacheSkill) do
			arg_9_0:SkillHrzPop(iter_9_1.skillName, iter_9_1.caster, iter_9_1.commander, iter_9_1.hrzIcon)
		end

		arg_9_0._cacheSkill = {}
	else
		arg_9_0._skillFloatPool:AllRecycle()
		arg_9_0._skillFloatCMDPool:AllRecycle()

		arg_9_0._preCommanderSkillTF = nil
		arg_9_0._preSkillTF = nil
	end

	SetActive(arg_9_0.skillTips, arg_9_1)

	return
end

function var_0_0.SkillHrzPop(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not arg_10_0._skillFloat then
		table.insert(arg_10_0._cacheSkill, {
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
		if arg_10_0._commanderSkillList[arg_10_3] and arg_10_0._commanderSkillList[arg_10_3][arg_10_1] then
			return
		end

		var_10_1 = arg_10_0._skillFloatCMDPool
		var_10_2 = ys.Battle.BattleState.GetCombatSkinKey() == "Standard" and var_10_0:GetCommanderHrzIcon(arg_10_3) or var_10_0:GetCommanderIcon(arg_10_3)
	else
		var_10_1 = arg_10_0._skillFloatPool

		if arg_10_2:GetUnitType() == ys.Battle.BattleConst.UnitType.PLAYER_UNIT then
			local var_10_3 = arg_10_4 or arg_10_2:GetTemplate().painting

			var_10_2 = ys.Battle.BattleState.GetCombatSkinKey() == "Standard" and var_10_0:GetCharacterIcon(var_10_3) or var_10_0:GetCharacterSquareIcon(var_10_3)
		else
			var_10_2 = ys.Battle.BattleState.GetCombatSkinKey() == "Standard" and var_10_0:GetCharacterIcon(pg.enemy_data_statistics[arg_10_2:GetTemplateID()].icon) or var_10_0:GetCharacterSquareIcon(pg.enemy_data_statistics[arg_10_2:GetTemplateID()].icon)
		end
	end

	local var_10_4 = var_10_1:GetObject()
	local var_10_5 = var_10_4.transform

	var_10_5.localScale = var_0_0.SKILL_FLOAT_SCALE

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
		arg_10_0:commanderSkillFloat(arg_10_3, arg_10_1, var_10_4)
	else
		local var_10_11 = var_0_1.CameraPosToUICamera(arg_10_2:GetPosition():Clone())
		local var_10_12 = ys.Battle.BattleCameraUtil.GetInstance():GetCharacterArrowBarPosition(var_10_11)
		local var_10_13 = arg_10_2:GetMainUnitIndex()

		if var_10_12 == nil or var_10_12 == nil and table.contains(ShipType.SubShipType, arg_10_2:GetTemplate().type) and not arg_10_2:IsMainFleetUnit() then
			var_10_11 = var_10_9 == ys.Battle.BattleConfig.FRIENDLY_CODE and var_0_1.CameraPosToUICamera(arg_10_2:GetPosition():Clone():Add(var_0_0.IN_VIEW_FRIEND_SKILL_OFFSET)) or var_0_1.CameraPosToUICamera(arg_10_2:GetPosition():Clone():Add(var_0_0.IN_VIEW_FOE_SKILL_OFFSET))
			var_10_5.position = Vector3(var_10_11.x, var_10_11.y, -2)

			if Screen.width * 0.5 < rtf(var_10_5).rect.width * 0.5 + var_10_5.anchoredPosition.x then
				var_10_5.anchoredPosition.x = var_10_5.anchoredPosition.x - rtf(var_10_5).rect.width
				var_10_5.anchoredPosition = var_10_5.anchoredPosition
			end

			if arg_10_0._preSkillTF then
				arg_10_0.handleSkillFloatCld(arg_10_0._preSkillTF, var_10_5)
			end

			arg_10_0._preSkillTF = var_10_5

			var_10_5:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_11_0)
				arg_10_0._preSkillTF = nil

				var_10_1:Recycle(var_10_4)

				return
			end)
		else
			local var_10_14
			local var_10_15 = arg_10_0._sideSkillFloatStateList[var_10_9][var_10_13]

			for iter_10_0 = 1, #arg_10_0._sideSkillFloatStateList[var_10_9][var_10_13] do
				if arg_10_0._sideSkillFloatStateList[var_10_9][var_10_13][iter_10_0] then
					var_10_14 = iter_10_0

					break
				end
			end

			if var_10_14 == nil then
				var_10_14 = #arg_10_0._sideSkillFloatStateList[var_10_9][var_10_13] + 1
			end

			arg_10_0._sideSkillFloatStateList[var_10_9][var_10_13][var_10_14] = false
			var_10_5.position = Vector3(var_10_12.x, var_10_12.y, -2)
			var_10_5.anchoredPosition.y = var_0_0.SIDE_ALIGNMENT[var_10_13][var_10_14]

			if var_10_9 == ys.Battle.BattleConfig.FOE_CODE then
				var_10_5.anchoredPosition.x = var_0_0.FOE_SIDE_X_OFFSET
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

function var_0_0.SkillHrzPopCover(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:SkillHrzPop(arg_13_1, arg_13_2, nil, arg_13_3)

	return
end

function var_0_0.handleSkillFloatCld(arg_14_0, arg_14_1)
	if math.floor(math.abs(arg_14_1.anchoredPosition.y - arg_14_0.anchoredPosition.y)) <= 112.5 then
		arg_14_1.anchoredPosition.y = arg_14_0.anchoredPosition.y + 112.5
		arg_14_1.anchoredPosition = arg_14_1.anchoredPosition
	end

	return
end

function var_0_0.handleSkillSinkCld(arg_15_0, arg_15_1)
	return
end

function var_0_0.commanderSkillFloat(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0._commanderSkillList[arg_16_1] = arg_16_0._commanderSkillList[arg_16_1] or {}
	arg_16_0._commanderSkillList[arg_16_1][arg_16_2] = true
	arg_16_3.transform.anchoredPosition.x = 0
	arg_16_3.transform.anchoredPosition.y = 0
	arg_16_3.transform.anchoredPosition = arg_16_3.transform.anchoredPosition

	if arg_16_0._preCommanderSkillTF then
		if math.floor(math.abs(arg_16_3.transform.anchoredPosition.y - arg_16_0._preCommanderSkillTF.anchoredPosition.y)) <= 97.5 then
			arg_16_3.transform.anchoredPosition.y = arg_16_0._preCommanderSkillTF.anchoredPosition.y - 97.5
		end
	end

	arg_16_3.transform.anchoredPosition = arg_16_3.transform.anchoredPosition
	arg_16_0._preCommanderSkillTF = arg_16_3.transform

	arg_16_3.transform:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_17_0)
		arg_16_0._commanderSkillList[arg_16_1][arg_16_2] = nil
		arg_16_0._preCommanderSkillTF = nil

		arg_16_0._skillFloatCMDPool:Recycle(arg_16_3)

		return
	end)

	return
end

function var_0_0.CutInPainting(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_0._currentPainting then
		arg_18_0._paintingAnimator.enabled = false

		setActive(arg_18_0._currentPainting, false)
	end

	local var_18_0

	if not arg_18_4 then
		::label_18_0::

		var_18_0 = arg_18_1.painting or arg_18_1.prefab
	end

	if arg_18_0._skillPaintings[var_18_0] == nil then
		local var_18_1 = ys.Battle.BattleResourceManager.GetInstance():InstPainting(var_18_0)

		arg_18_0._skillPaintings[var_18_0] = var_18_1

		setParent(var_18_1, arg_18_0._paintingFitter, false)
	end

	arg_18_0._currentPainting = arg_18_0._skillPaintings[var_18_0]

	setActive(arg_18_0._currentPainting, true)
	LuaHelper.SetParticleSpeed(arg_18_0._paintingUI, arg_18_2)

	local var_18_2 = Vector3(arg_18_3, 1, 1)

	arg_18_0._paintingUI.transform.localScale = var_18_2
	arg_18_0._paintingParticleContainer.transform.localScale = var_18_2
	arg_18_0._paintingParticles.transform.localEulerAngles = Vector3(0, 90 * arg_18_3, 0)

	arg_18_0._paintingParticleSystem:Play(true)

	arg_18_0._paintingAnimator.speed = arg_18_2
	arg_18_0._paintingAnimator.enabled = true

	arg_18_0._paintingAnimator:Play("skill_painting", -1, 0)

	return
end

function var_0_0.CutInPaintingDAL(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = ys.Battle.BattleResourceManager.GetInstance():InstSkillPaintingDALUI()

	setParent(var_19_0, arg_19_0.uiCanvas, false)

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

function var_0_0.didEnter(arg_21_0)
	setActive(arg_21_0._tf, false)

	arg_21_0._ratioFitter.enabled = true
	arg_21_0._ratioFitter.aspectRatio = pg.CameraFixMgr.GetInstance():GetBattleUIRatio()
	arg_21_0.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_22_0, arg_22_1)
		arg_21_0._ratioFitter.aspectRatio = pg.CameraFixMgr.GetInstance():GetBattleUIRatio()

		return
	end)

	local var_21_0 = ys.Battle.BattleState.GetInstance()

	var_21_0:SetBattleUI(arg_21_0)
	onButton(arg_21_0, arg_21_0._tf:Find("PauseBtn"), function()
		arg_21_0:emit(BattleMediator.ON_PAUSE)

		return
	end, SFX_CONFIRM)

	arg_21_0._chatBtn = arg_21_0._tf:Find("chatBtnContainer/chatBtn")

	local var_21_1 = arg_21_0._chatBtn:GetComponent(typeof(Animation))

	onButton(arg_21_0, arg_21_0._chatBtn, function()
		arg_21_0:emit(BattleMediator.ON_CHAT, arg_21_0._tf:Find("chatContainer"))

		if not var_21_1 then
			setActive(arg_21_0._chatBtn, false)
		else
			var_21_1:Play("chatbtn_out")
		end

		return
	end)
	onToggle(arg_21_0, arg_21_0._tf:Find("AutoBtn"), function(arg_25_0)
		local var_25_0 = var_21_0:GetBattleType()

		arg_21_0:emit(BattleMediator.ON_AUTO, {
			isOn = not arg_25_0,
			toggle = arg_21_0._tf:Find("AutoBtn"),
			system = var_25_0
		})
		var_21_0:ActiveBot(ys.Battle.BattleState.IsAutoBotActive(var_25_0))

		if var_21_0:ChatUseable() then
			setActive(arg_21_0._chatBtn, true)

			if var_21_1 then
				var_21_1:Play("chatbtn_in")
			end
		elseif var_21_1 then
			var_21_1:Play("chatbtn_out")
		else
			setActive(arg_21_0._chatBtn, false)
		end

		return
	end, SFX_PANEL, SFX_PANEL)
	onButton(arg_21_0, arg_21_0._tf:Find("CardPuzzleConsole/relic/bg"), function()
		arg_21_0:emit(BattleMediator.ON_PUZZLE_RELIC, {
			relicList = var_21_0:GetProxyByName(ys.Battle.BattleDataProxy.__name):GetFleetByIFF(ys.Battle.BattleConfig.FRIENDLY_CODE):GetCardPuzzleComponent():GetRelicList()
		})

		return
	end, SFX_CONFIRM)
	onButton(arg_21_0, arg_21_0._tf:Find("CardPuzzleConsole/deck/bg"), function()
		local var_27_0 = var_21_0:GetProxyByName(ys.Battle.BattleDataProxy.__name):GetFleetByIFF(ys.Battle.BattleConfig.FRIENDLY_CODE):GetCardPuzzleComponent()

		arg_21_0:emit(BattleMediator.ON_PUZZLE_CARD, {
			card = var_27_0:GetDeck():GetCardList(),
			hand = var_27_0:GetHand():GetCardList()
		})

		return
	end, SFX_CONFIRM)
	var_21_0:ConfigBattleEndFunc(function(arg_28_0)
		arg_21_0:clear()
		arg_21_0:emit(BattleMediator.ON_BATTLE_RESULT, arg_28_0)

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

	arg_21_0._skillFloatPool = pg.Pool.New(arg_21_0.skillRoot, arg_21_0.skillTpl, 0 + (function(arg_29_0)
		local var_29_0 = 0

		for iter_29_0, iter_29_1 in ipairs(arg_29_0) do
			var_29_0 = var_29_0 + ys.Battle.BattleDataFunction.GetShipSkillTriggerCount(iter_29_1, var_21_2)
		end

		return var_29_0
	end)(arg_21_0.contextData.battleData.MainUnitList) + (function(arg_29_0)
		local var_29_0 = 0

		for iter_29_0, iter_29_1 in ipairs(arg_29_0) do
			var_29_0 = var_29_0 + ys.Battle.BattleDataFunction.GetShipSkillTriggerCount(iter_29_1, var_21_2)
		end

		return var_29_0
	end)(arg_21_0.contextData.battleData.VanguardUnitList) + (function(arg_29_0)
		local var_29_0 = 0

		for iter_29_0, iter_29_1 in ipairs(arg_29_0) do
			var_29_0 = var_29_0 + ys.Battle.BattleDataFunction.GetShipSkillTriggerCount(iter_29_1, var_21_2)
		end

		return var_29_0
	end)(arg_21_0.contextData.battleData.SubUnitList) + 4, 10, true, false):InitSize()

	arg_21_0._skillFloatPool:SetRecycleFuncs(function(arg_30_0)
		arg_30_0.transform:GetComponent(typeof(DftAniEvent)):OnDestroy()

		return
	end)
	arg_21_0:emit(BattleMediator.ENTER)
	arg_21_0:initPauseWindow()

	if arg_21_0.contextData.prePause then
		triggerButton(arg_21_0._tf:Find("PauseBtn"))
	end

	setActive(arg_21_0._chatBtn, var_21_0:ChatUseable())

	return
end

function var_0_0.onBackPressed(arg_31_0)
	if isActive(arg_31_0.pauseWindow) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(arg_31_0.continueBtn)
	end

	return
end

function var_0_0.activeBotHelp(arg_32_0, arg_32_1)
	local var_32_0 = getProxy(PlayerProxy)

	if not arg_32_1 then
		if arg_32_0.autoBotHelp then
			pg.MsgboxMgr.GetInstance():hide()
		end

		return
	end

	if var_32_0.botHelp then
		return
	end

	arg_32_0.autoBotHelp = true

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
			arg_32_0.autoBotHelp = false

			return
		end
	})

	var_32_0.botHelp = true

	return
end

function var_0_0.exitBattle(arg_34_0, arg_34_1)
	if not arg_34_1 then
		arg_34_0:emit(BattleMediator.ON_QUIT_BATTLE_MANUALLY)
		arg_34_0:emit(BattleMediator.ON_BACK_PRE_SCENE)
	elseif arg_34_1 == "kick" then
		-- block empty
	end

	return
end

function var_0_0.setChapter(arg_35_0, arg_35_1)
	arg_35_0._chapter = arg_35_1

	return
end

function var_0_0.setFleet(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	arg_36_0._mainShipVOs = arg_36_1
	arg_36_0._vanShipVOs = arg_36_2
	arg_36_0._subShipVOs = arg_36_3

	return
end

function var_0_0.initPauseWindow(arg_37_0)
	arg_37_0.pauseWindow = arg_37_0._tf:Find("Msgbox")
	arg_37_0.LeftTimeContainer = arg_37_0.pauseWindow:Find("window/LeftTime")
	arg_37_0.LeftTime = arg_37_0.pauseWindow:Find("window/LeftTime/Text")
	arg_37_0.mainTFs = {}
	arg_37_0.vanTFs = {}

	setText(arg_37_0.LeftTimeContainer:Find("label"), i18n("battle_battleMediator_remainTime"))
	setText(arg_37_0.pauseWindow:Find("window/van/power/title"), i18n("word_vanguard_fleet"))
	setText(arg_37_0.pauseWindow:Find("window/main/power/title"), i18n("word_main_fleet"))

	local var_37_0 = ys.Battle.BattleState.GetInstance()
	local var_37_1 = var_37_0:GetBattleType()

	if arg_37_0._mainShipVOs then
		(function(arg_38_0, arg_38_1, arg_38_2)
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
		end)(arg_37_0.mainTFs, arg_37_0.pauseWindow:Find("window/main"), arg_37_0._mainShipVOs)
		;(function(arg_38_0, arg_38_1, arg_38_2)
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
		end)(arg_37_0.vanTFs, arg_37_0.pauseWindow:Find("window/van"), arg_37_0._vanShipVOs)
	elseif var_37_1 == SYSTEM_SCENARIO_SUB_STRIKE then
		arg_37_0.subTFs = {}

		local var_37_2 = arg_37_0.pauseWindow:Find("window/main")

		setActive(arg_37_0.pauseWindow:Find("window/van"), false)
		setActive(arg_37_0.pauseWindow:Find("window/bg_fleet/Image (1)"), false)
		;(function(arg_38_0, arg_38_1, arg_38_2)
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
		end)(arg_37_0.subTFs, var_37_2, arg_37_0._subShipVOs)
		setText(var_37_2:Find("power/title"), i18n("index_shipType_qianTing"))

		var_37_2.localPosition = Vector3(0, var_37_2.localPosition.y, 0)
	end

	local var_37_3 = findTF(arg_37_0.pauseWindow, "window/Chapter")
	local var_37_4 = findTF(arg_37_0.pauseWindow, "window/Chapter/Text")

	arg_37_0.continueBtn = arg_37_0.pauseWindow:Find("window/button_container/continue")
	arg_37_0.leaveBtn = arg_37_0.pauseWindow:Find("window/button_container/leave")

	setText(arg_37_0.continueBtn:Find("pic"), i18n("battle_battleMediator_goOnFight"))
	setText(arg_37_0.leaveBtn:Find("pic"), i18n("battle_battleMediator_existFight"))

	if var_37_1 == SYSTEM_SCENARIO or var_37_1 == SYSTEM_SCENARIO_SUB_STRIKE then
		local var_37_5 = arg_37_0._chapter:getConfigTable()

		setText(var_37_3, var_37_5.chapter_name)
		setText(var_37_4, string.split(var_37_5.name, "|")[1])

		goto label_37_0
	end

	if var_37_1 == SYSTEM_ROUTINE or var_37_1 == SYSTEM_DUEL or var_37_1 == SYSTEM_HP_SHARE_ACT_BOSS or var_37_1 == SYSTEM_BOSS_EXPERIMENT or var_37_1 == SYSTEM_ACT_BOSS or var_37_1 == SYSTEM_ACT_BOSS_SP or var_37_1 == SYSTEM_BOSS_RUSH or var_37_1 == SYSTEM_BOSS_RUSH_EX or var_37_1 == SYSTEM_BOSS_RUSH_COLLABRATE or var_37_1 == SYSTEM_LIMIT_CHALLENGE or var_37_1 == SYSTEM_BOSS_SINGLE or var_37_1 == SYSTEM_BOSS_SINGLE_VARIABLE then
		setText(var_37_3, "SP")
		setText(var_37_4, pg.expedition_data_template[var_37_0:GetProxyByName(ys.Battle.BattleDataProxy.__name):GetInitData().StageTmpId].name)

		goto label_37_0
	end

	if var_37_1 == SYSTEM_DEBUG then
		setText(var_37_3, "??")
		setText(var_37_4, "碧蓝梦境")

		goto label_37_0
	end

	if var_37_1 == SYSTEM_CHALLENGE then
		setText(var_37_3, "SP")
		setText(var_37_4, arg_37_0._chapter:getNextExpedition().chapter_name[2])
		setActive(arg_37_0.LeftTimeContainer, true)

		goto label_37_0
	end

	if var_37_1 == SYSTEM_WORLD_BOSS or var_37_1 == SYSTEM_WORLD then
		setText(var_37_3, i18n("world_battle_pause"))
		setText(var_37_4, i18n("world_battle_pause2"))

		if var_37_1 == SYSTEM_WORLD_BOSS then
			setActive(arg_37_0.leaveBtn, false)
		end

		goto label_37_0
	end

	::label_37_0::

	if var_37_1 == SYSTEM_GUILD then
		local var_37_6 = pg.guild_boss_event[var_37_0:GetProxyByName(ys.Battle.BattleDataProxy.__name):GetInitData().ActID]

		setText(var_37_3, "BOSS")

		local var_37_8 = var_37_4

		if var_37_6 then
			do
				local var_37_9 = var_37_6.name or ""

				var_37_7(var_37_8, var_37_9)

				if false then
					if var_37_1 == SYSTEM_TEST or var_37_1 == SYSTEM_SUB_ROUTINE or var_37_1 == SYSTEM_SCENARIO_SUB_STRIKE or var_37_1 == SYSTEM_PERFORM or var_37_1 == SYSTEM_PROLOGUE or var_37_1 == SYSTEM_DODGEM or var_37_1 == SYSTEM_SIMULATION or var_37_1 == SYSTEM_SUBMARINE_RUN or var_37_1 == SYSTEM_BOSS_EXPERIMENT or var_37_1 == SYSTEM_REWARD_PERFORM or var_37_1 == SYSTEM_AIRFIGHT then
						-- block empty
					elseif var_37_1 == SYSTEM_CARDPUZZLE then
						-- block empty
					else
						assert(false, "System not defined " .. (var_37_1 or "NIL"))
					end
				end
			end

			onButton(arg_37_0, arg_37_0.leaveBtn, function()
				arg_37_0:emit(BattleMediator.ON_LEAVE)

				local var_39_0 = arg_37_0.leaveBtn:GetComponent(typeof(Animation))

				if var_39_0 and var_39_0:GetClip("msgbox_btn_blink") then
					var_39_0:Play("msgbox_btn_blink")
				end

				return
			end)
			onButton(arg_37_0, arg_37_0.continueBtn, function()
				local var_40_0 = arg_37_0.continueBtn:GetComponent(typeof(Animation))

				if var_40_0 and var_40_0:GetClip("msgbox_btn_blink") then
					var_40_0:Play("msgbox_btn_blink")
				end

				local var_40_1 = arg_37_0.pauseWindow:GetComponent(typeof(Animation))

				if var_40_1 then
					if var_40_1:IsPlaying("msgbox_out") then
						var_40_1:Stop("msgbox_out")
						var_40_1:Play("msgbox_in")
					else
						var_40_1:Play("msgbox_out")
						arg_37_0.pauseWindow:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_41_0)
							arg_37_0:ClosePauseWindow()
							var_37_0:Resume()

							return
						end)
					end
				else
					arg_37_0:ClosePauseWindow()
					var_37_0:Resume()
				end

				return
			end)
			onButton(arg_37_0, arg_37_0.pauseWindow:Find("help"), function()
				if BATTLE_DEBUG and PLATFORM == 7 then
					arg_37_0:ClosePauseWindow()
					var_37_0:Resume()
					var_37_0:OpenConsole()
				else
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_HELP,
						helps = i18n("help_battle_rule")
					})
				end

				return
			end)
			onButton(arg_37_0, arg_37_0.pauseWindow:Find("window/top/btnBack"), function()
				triggerButton(arg_37_0.continueBtn)

				return
			end)
			onButton(arg_37_0, arg_37_0.pauseWindow, function()
				triggerButton(arg_37_0.continueBtn)

				return
			end)
			onButton(arg_37_0, arg_37_0.pauseWindow, function()
				local var_45_0 = arg_37_0.pauseWindow:GetComponent(typeof(Animation))

				if var_45_0 and var_45_0:IsPlaying("msgbox_out") then
					-- block empty
				else
					triggerButton(arg_37_0.continueBtn)
				end

				return
			end)
			setActive(arg_37_0.pauseWindow, false)

			return
		end
	end
end

function var_0_0.updatePauseWindow(arg_46_0)
	if not arg_46_0.pauseWindow then
		return
	end

	setActive(arg_46_0.pauseWindow, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_46_0.pauseWindow)

	local var_46_0 = ys.Battle.BattleState.GetInstance():GetProxyByName(ys.Battle.BattleDataProxy.__name)
	local var_46_1 = var_46_0:GetFleetByIFF(ys.Battle.BattleConfig.FRIENDLY_CODE)

	;(function(arg_47_0, arg_47_1)
		if not arg_47_0 then
			return
		end

		for iter_47_0 = 1, #arg_47_0 do
			if var_46_1:GetFreezeShipByID(arg_47_0[iter_47_0].id) then
				local var_47_0 = var_46_1:GetFreezeShipByID(arg_47_0[iter_47_0].id)

				setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, var_47_0:GetHPRate())
				SetActive(arg_47_1[iter_47_0]:Find("mask"), false)
			elseif var_46_1:GetShipByID(arg_47_0[iter_47_0].id) then
				local var_47_1 = var_46_1:GetShipByID(arg_47_0[iter_47_0].id)

				setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, var_47_1:GetHPRate())
				SetActive(arg_47_1[iter_47_0]:Find("mask"), false)
			else
				setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, 0)
				SetActive(arg_47_1[iter_47_0]:Find("mask"), true)
			end
		end

		return
	end)(arg_46_0._mainShipVOs, arg_46_0.mainTFs)
	;(function(arg_47_0, arg_47_1)
		if not arg_47_0 then
			return
		end

		for iter_47_0 = 1, #arg_47_0 do
			if var_46_1:GetFreezeShipByID(arg_47_0[iter_47_0].id) then
				local var_47_0 = var_46_1:GetFreezeShipByID(arg_47_0[iter_47_0].id)

				setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, var_47_0:GetHPRate())
				SetActive(arg_47_1[iter_47_0]:Find("mask"), false)
			elseif var_46_1:GetShipByID(arg_47_0[iter_47_0].id) then
				local var_47_1 = var_46_1:GetShipByID(arg_47_0[iter_47_0].id)

				setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, var_47_1:GetHPRate())
				SetActive(arg_47_1[iter_47_0]:Find("mask"), false)
			else
				setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, 0)
				SetActive(arg_47_1[iter_47_0]:Find("mask"), true)
			end
		end

		return
	end)(arg_46_0._vanShipVOs, arg_46_0.vanTFs)

	if arg_46_0.subTFs then
		(function(arg_47_0, arg_47_1)
			if not arg_47_0 then
				return
			end

			for iter_47_0 = 1, #arg_47_0 do
				if var_46_1:GetFreezeShipByID(arg_47_0[iter_47_0].id) then
					local var_47_0 = var_46_1:GetFreezeShipByID(arg_47_0[iter_47_0].id)

					setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, var_47_0:GetHPRate())
					SetActive(arg_47_1[iter_47_0]:Find("mask"), false)
				elseif var_46_1:GetShipByID(arg_47_0[iter_47_0].id) then
					local var_47_1 = var_46_1:GetShipByID(arg_47_0[iter_47_0].id)

					setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, var_47_1:GetHPRate())
					SetActive(arg_47_1[iter_47_0]:Find("mask"), false)
				else
					setSlider(arg_47_1[iter_47_0]:Find("blood"), 0, 1, 0)
					SetActive(arg_47_1[iter_47_0]:Find("mask"), true)
				end
			end

			return
		end)(arg_46_0._subShipVOs, arg_46_0.subTFs)
	end

	setText(arg_46_0.LeftTime, ys.Battle.BattleTimerView.formatTime(math.floor(var_46_0:GetCountDown())))

	return
end

function var_0_0.ClosePauseWindow(arg_48_0)
	setActive(arg_48_0.pauseWindow, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_48_0.pauseWindow, arg_48_0._tf)

	return
end

function var_0_0.AddUIFX(arg_49_0, arg_49_1, arg_49_2)
	if not arg_49_2 then
		arg_49_2 = 1
		arg_49_1 = tf(arg_49_1)
	end

	if arg_49_2 > 0 then
		local var_49_0 = arg_49_0._fxContainerUpper or arg_49_0._fxContainerBottom

		arg_49_1:SetParent(var_49_0)
		pg.ViewUtils.SetSortingOrder(arg_49_1, arg_49_0._canvasOrder + arg_49_2)
		pg.ViewUtils.SetLayer(arg_49_1, Layer.UI)

		return var_49_0.localScale
	end
end

function var_0_0.OnCloseChat(arg_50_0)
	local var_50_0 = arg_50_0._chatBtn:GetComponent(typeof(Animation))

	if ys.Battle.BattleState.GetInstance():IsBotActive() then
		setActive(arg_50_0._chatBtn, true)

		if var_50_0 then
			var_50_0:Play("chatbtn_in")
		end
	elseif var_50_0 then
		var_50_0:Play("chatbtn_out")
	else
		setActive(arg_50_0._chatBtn, false)
	end

	return
end

function var_0_0.clear(arg_51_0)
	arg_51_0._preSkillTF = nil

	arg_51_0._skillFloatPool:AllRecycle()
	arg_51_0._skillFloatCMDPool:AllRecycle()

	arg_51_0._preCommanderSkillTF = nil
	arg_51_0._commanderSkillList = nil
	arg_51_0._skillPaintings = nil
	arg_51_0._currentPainting = nil

	Destroy(arg_51_0._paintingUI)

	return
end

function var_0_0.willExit(arg_52_0)
	arg_52_0._skillFloatPool:Dispose()
	arg_52_0._skillFloatCMDPool:Dispose()
	ys.Battle.BattleState.GetInstance():ExitBattle()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_52_0.pauseWindow, arg_52_0._tf)
	ys.Battle.BattleCameraUtil.GetInstance().ActiveMainCamera(false)
	pg.CameraFixMgr.GetInstance():disconnect(arg_52_0.camEventId)

	return
end

return var_0_0
