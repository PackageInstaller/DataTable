local ChallengePreCombatLayer = class("ChallengePreCombatLayer", import("..base.BaseUI"))

function ChallengePreCombatLayer:getUIName()
	return "ChapterPreCombatUI"
end

function ChallengePreCombatLayer:ResUISettings()
	return true
end

function ChallengePreCombatLayer:init()
	self._startBtn = self.rtAdapt:Find("right/start")
	self._popup = self.rtAdapt:Find("right/popup")

	setActive(self._popup, false)

	self._backBtn = self.rtAdapt:Find("top/back_btn")

	local var_3_0 = self.rtAdapt:Find("middle")

	self._mainGS = var_3_0:Find("gear_score/main/Text")
	self._vanguardGS = var_3_0:Find("gear_score/vanguard/Text")

	setText(self._mainGS, 0)
	setText(self._vanguardGS, 0)

	self._gridTFs = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {}
	}
	self._gridFrame = var_3_0:Find("mask/GridFrame")

	for iter_3_0 = 1, 3 do
		self._gridTFs[TeamType.Vanguard][iter_3_0] = self._gridFrame:Find("vanguard_" .. iter_3_0)
		self._gridTFs[TeamType.Main][iter_3_0] = self._gridFrame:Find("main_" .. iter_3_0)
	end

	self._heroContainer = var_3_0:Find("HeroContainer")
	self._strategy = var_3_0:Find("strategy")

	setActive(self._strategy, false)

	self._formationList = var_3_0:Find("formation_list")

	setActive(self._formationList, false)

	self._goals = self.rtAdapt:Find("right/infomation/goal")
	self._heroInfo = self:getTpl("heroInfo")
	self._starTpl = self:getTpl("star_tpl")
	self._formationLogic = BaseFormation.New(self._tf, self._heroContainer, self._heroInfo, self._gridTFs)
	self._middle = self.rtAdapt:Find("middle")
	self._right = self.rtAdapt:Find("right")
	self._fleet = self.rtAdapt:Find("middle/fleet")

	setText(self.rtAdapt:Find("middle/gear_score/vanguard/line/Image/Text1"), i18n("pre_combat_vanguard"))
	setText(self.rtAdapt:Find("middle/gear_score/main/line/Image/Text1"), i18n("pre_combat_main"))
	setText(self._fleet:Find("title_bg/Text"), i18n("pre_combat_team"))

	self._ship_tpl = self._fleet:Find("shiptpl")
	self._empty_tpl = self._fleet:Find("emptytpl")

	setActive(self._ship_tpl, false)
	setActive(self._empty_tpl, false)

	self._autoToggle = self.rtAdapt:Find("middle/auto_toggle")
	self._autoSubToggle = self.rtAdapt:Find("middle/sub_toggle_container/sub_toggle")
	self.topPanel = self.rtAdapt:Find("top")
	self.strategyInfo = self._tf:Find("strategy_info")

	setActive(self.strategyInfo, false)
	setAnchoredPosition(self._middle, {
		x = -840
	})
	setAnchoredPosition(self._right, {
		x = 470
	})
	self:Register()

	return
end

function ChallengePreCombatLayer:uiStartAnimating()
	setAnchoredPosition(self.topPanel, {
		y = 100
	})
	shiftPanel(self._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(self._right, 0, nil, 0.3, 0, true, true, nil)
	shiftPanel(self.topPanel, nil, 0, 0.3, 0, true, true, nil, nil)

	return
end

function ChallengePreCombatLayer:uiExitAnimating()
	shiftPanel(self._middle, -840, nil, 0.3, 0, true, true)
	shiftPanel(self._right, 470, nil, 0.3, 0, true, true)
	shiftPanel(self.topPanel, nil, self.topPanel.rect.height, 0.3, 0, true, true, nil, nil)

	return
end

function ChallengePreCombatLayer:didEnter()
	onButton(self, self._backBtn, function()
		GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

		self:uiExitAnimating()
		LeanTween.delayedCall(0.3, System.Action(function()
			self:emit(ChallengePreCombatLayer.ON_CLOSE)

			return
		end))

		return
	end, SFX_CANCEL)
	onButton(self, self._startBtn, function()
		for iter_9_0, iter_9_1 in pairs(self.fleet.ships) do
			local var_9_0, var_9_1 = ShipStatus.ShipStatusConflict("inActivity", iter_9_1, {
				inActivity = false
			})

			if var_9_0 == ShipStatus.STATE_CHANGE_FAIL then
				pg.TipsMgr.GetInstance():ShowTips(i18n(var_9_1))

				return
			end
		end

		self:emit(ChallengePreCombatMediator.ON_START)

		return
	end, SFX_UI_WEIGHANCHOR)
	onToggle(self, self._autoToggle, function(arg_10_0)
		self:emit(ChallengePreCombatMediator.ON_AUTO, {
			isOn = not arg_10_0,
			toggle = self._autoToggle
		})

		if arg_10_0 and self.subUseable == true then
			setActive(self._autoSubToggle, true)
			onToggle(self, self._autoSubToggle, function(arg_11_0)
				self:emit(ChallengePreCombatMediator.ON_SUB_AUTO, {
					isOn = not arg_11_0,
					toggle = self._autoSubToggle
				})

				return
			end, SFX_PANEL, SFX_PANEL)
			triggerToggle(self._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
		else
			setActive(self._autoSubToggle, false)
		end

		return
	end, SFX_PANEL, SFX_PANEL)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setParent(self.strategyInfo, self._tf.parent)
	triggerToggle(self._autoToggle, ys.Battle.BattleState.IsAutoBotActive())
	setAnchoredPosition(self.topPanel, {
		y = self.topPanel.rect.height
	})
	onNextTick(function()
		self:uiStartAnimating()

		return
	end)

	return
end

function ChallengePreCombatLayer:Register()
	self._formationLogic:AddHeroInfoModify(function(arg_14_0, arg_14_1)
		setAnchoredPosition(arg_14_0, {
			x = 0,
			y = 0
		})
		SetActive(arg_14_0, true)

		arg_14_0.name = "info"

		local var_14_0 = arg_14_0:Find("info")
		local var_14_1 = var_14_0:Find("stars")
		local var_14_2 = arg_14_1:getEnergy() <= Ship.ENERGY_MID
		local var_14_3 = var_14_0:Find("energy")

		if var_14_2 then
			local var_14_4, var_14_5 = arg_14_1:getEnergyPrint()
			local var_14_6 = GetSpriteFromAtlas("energy", var_14_4)

			if not var_14_6 then
				warning("找不到疲劳")
			end

			setImageSprite(var_14_3, var_14_6)
		end

		setActive(var_14_3, var_14_2)

		for iter_14_0 = 1, arg_14_1:getStar() do
			cloneTplTo(self._starTpl, var_14_1)
		end

		local var_14_7 = GetSpriteFromAtlas("shiptype", shipType2print(arg_14_1:getShipType()))

		if not var_14_7 then
			warning("找不到船形, shipConfigId: " .. arg_14_1.configId)
		end

		setImageSprite(var_14_0:Find("type"), var_14_7, true)
		setText(var_14_0:Find("frame/lv_contain/lv"), arg_14_1.level)

		local var_14_8 = var_14_0:Find("blood")
		local var_14_9 = var_14_8:Find("fillarea/green")
		local var_14_10 = var_14_8:Find("fillarea/red")

		setActive(var_14_9, arg_14_1.hpRant >= ChapterConst.HpGreen)
		setActive(var_14_10, arg_14_1.hpRant < ChapterConst.HpGreen)

		;(arg_14_1.hpRant >= ChapterConst.HpGreen and var_14_9 or var_14_10):GetComponent("Image").fillAmount = arg_14_1.hpRant * 0.0001

		setActive(var_14_0:Find("expbuff"), false)

		return
	end)
	self._formationLogic:AddShiftOnly(function(arg_15_0)
		self:updateView(false)

		return
	end)
	self._formationLogic:AddCheckRemove(function(arg_16_0, arg_16_1)
		arg_16_0()

		return
	end)

	return
end

function ChallengePreCombatLayer:onBackPressed()
	if self.strategyPanel and self.strategyPanel._go and isActive(self.strategyPanel._go) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(self._backBtn)
	end

	return
end

function ChallengePreCombatLayer:setPlayerInfo(arg_18_1)
	return
end

function ChallengePreCombatLayer:updateChallenge(arg_19_1)
	self.challenge = arg_19_1
	self.fleet = arg_19_1:getRegularFleet()

	self._formationLogic:SetFleetVO(self.fleet)
	self._formationLogic:SetShipVOs(self.fleet.ships)
	self:updateView(true)

	return
end

function ChallengePreCombatLayer:setSubFlag(arg_20_1)
	self.subUseable = arg_20_1 or false

	return
end

function ChallengePreCombatLayer:updateView(arg_21_1)
	self._formationLogic:ResetGrid(TeamType.Vanguard)
	self._formationLogic:ResetGrid(TeamType.Main)
	SetActive(self._gridTFs[TeamType.Main][1]:Find("flag"), true)

	if arg_21_1 then
		self:updateStageView()
		self._formationLogic:LoadAllCharacter()
	else
		self._formationLogic:SetAllCharacterPos()
	end

	self:updateBattleFleetView()
	self:displayFleetInfo()

	return
end

function ChallengePreCombatLayer:updateStageView()
	local function var_22_0(arg_23_0, arg_23_1)
		if type(arg_23_0) == "table" then
			setActive(arg_23_1, true)
			setWidgetText(arg_23_1, (i18n(PreCombatLayer.ObjectiveList[arg_23_0[1]], arg_23_0[2])))
		else
			setActive(arg_23_1, false)
		end

		return
	end

	local var_22_1 = {
		self._goals:Find("goal_tpl"),
		self._goals:Find("goal_sink"),
		self._goals:Find("goal_time")
	}

	for iter_22_0, iter_22_1 in ipairs({
		{
			1
		},
		false,
		false
	}) do
		if type(iter_22_1) ~= "string" then
			var_22_0(iter_22_1, var_22_1[1])
		end
	end

	return
end

function ChallengePreCombatLayer:updateBattleFleetView()
	local function var_24_0(arg_25_0, arg_25_1)
		removeAllChildren(arg_25_0)

		for iter_25_0 = 1, 3 do
			if arg_25_1[iter_25_0] then
				local var_25_0 = cloneTplTo(self._ship_tpl, arg_25_0)

				updateShip(var_25_0, arg_25_1[iter_25_0])

				local var_25_1 = arg_25_1[iter_25_0].hpRant
				local var_25_2 = var_25_0:Find("blood")
				local var_25_3 = var_25_0:Find("blood/fillarea/green")
				local var_25_4 = var_25_0:Find("blood/fillarea/red")

				setActive(var_25_3, arg_25_1[iter_25_0].hpRant >= ChapterConst.HpGreen)
				setActive(var_25_4, var_25_1 < ChapterConst.HpGreen)

				;(var_25_1 >= ChapterConst.HpGreen and var_25_3 or var_25_4):GetComponent("Image").fillAmount = var_25_1 * 0.0001
			end
		end

		return
	end

	local var_24_1 = self.challenge:getRegularFleet()

	var_24_0(self._fleet:Find("main"), var_24_1:getShipsByTeam(TeamType.Main, true))
	var_24_0(self._fleet:Find("vanguard"), var_24_1:getShipsByTeam(TeamType.Vanguard, true))

	return
end

function ChallengePreCombatLayer:displayFleetInfo()
	local var_26_0 = self.challenge:getRegularFleet()
	local var_26_1 = var_26_0:getCommanders()

	FormationUI.tweenNumText(self._vanguardGS, (_.reduce(var_26_0:getShipsByTeam(TeamType.Vanguard, false), 0, function(arg_27_0, arg_27_1)
		return arg_27_0 + arg_27_1:getShipCombatPower(var_26_1)
	end)))
	FormationUI.tweenNumText(self._mainGS, (_.reduce(var_26_0:getShipsByTeam(TeamType.Main, false), 0, function(arg_28_0, arg_28_1)
		return arg_28_0 + arg_28_1:getShipCombatPower(var_26_1)
	end)))

	return
end

function ChallengePreCombatLayer:willExit()
	setParent(self.strategyInfo, self._tf)
	self._formationLogic:Destroy()

	self._formationLogic = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ChallengePreCombatLayer
