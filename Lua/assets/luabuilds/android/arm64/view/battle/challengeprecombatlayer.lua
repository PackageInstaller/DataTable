local var_0_0 = class("ChallengePreCombatLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ChapterPreCombatUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.init(arg_3_0)
	arg_3_0._startBtn = arg_3_0.rtAdapt:Find("right/start")
	arg_3_0._popup = arg_3_0.rtAdapt:Find("right/popup")

	setActive(arg_3_0._popup, false)

	arg_3_0._backBtn = arg_3_0.rtAdapt:Find("top/back_btn")

	local var_3_0 = arg_3_0.rtAdapt:Find("middle")

	arg_3_0._mainGS = var_3_0:Find("gear_score/main/Text")
	arg_3_0._vanguardGS = var_3_0:Find("gear_score/vanguard/Text")

	setText(arg_3_0._mainGS, 0)
	setText(arg_3_0._vanguardGS, 0)

	arg_3_0._gridTFs = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {}
	}
	arg_3_0._gridFrame = var_3_0:Find("mask/GridFrame")

	for iter_3_0 = 1, 3 do
		arg_3_0._gridTFs[TeamType.Vanguard][iter_3_0] = arg_3_0._gridFrame:Find("vanguard_" .. iter_3_0)
		arg_3_0._gridTFs[TeamType.Main][iter_3_0] = arg_3_0._gridFrame:Find("main_" .. iter_3_0)
	end

	arg_3_0._heroContainer = var_3_0:Find("HeroContainer")
	arg_3_0._strategy = var_3_0:Find("strategy")

	setActive(arg_3_0._strategy, false)

	arg_3_0._formationList = var_3_0:Find("formation_list")

	setActive(arg_3_0._formationList, false)

	arg_3_0._goals = arg_3_0.rtAdapt:Find("right/infomation/goal")
	arg_3_0._heroInfo = arg_3_0:getTpl("heroInfo")
	arg_3_0._starTpl = arg_3_0:getTpl("star_tpl")
	arg_3_0._formationLogic = BaseFormation.New(arg_3_0._tf, arg_3_0._heroContainer, arg_3_0._heroInfo, arg_3_0._gridTFs)
	arg_3_0._middle = arg_3_0.rtAdapt:Find("middle")
	arg_3_0._right = arg_3_0.rtAdapt:Find("right")
	arg_3_0._fleet = arg_3_0.rtAdapt:Find("middle/fleet")

	setText(arg_3_0.rtAdapt:Find("middle/gear_score/vanguard/line/Image/Text1"), i18n("pre_combat_vanguard"))
	setText(arg_3_0.rtAdapt:Find("middle/gear_score/main/line/Image/Text1"), i18n("pre_combat_main"))
	setText(arg_3_0._fleet:Find("title_bg/Text"), i18n("pre_combat_team"))

	arg_3_0._ship_tpl = arg_3_0._fleet:Find("shiptpl")
	arg_3_0._empty_tpl = arg_3_0._fleet:Find("emptytpl")

	setActive(arg_3_0._ship_tpl, false)
	setActive(arg_3_0._empty_tpl, false)

	arg_3_0._autoToggle = arg_3_0.rtAdapt:Find("middle/auto_toggle")
	arg_3_0._autoSubToggle = arg_3_0.rtAdapt:Find("middle/sub_toggle_container/sub_toggle")
	arg_3_0.topPanel = arg_3_0.rtAdapt:Find("top")
	arg_3_0.strategyInfo = arg_3_0._tf:Find("strategy_info")

	setActive(arg_3_0.strategyInfo, false)
	setAnchoredPosition(arg_3_0._middle, {
		x = -840
	})
	setAnchoredPosition(arg_3_0._right, {
		x = 470
	})
	arg_3_0:Register()

	return
end

function var_0_0.uiStartAnimating(arg_4_0)
	setAnchoredPosition(arg_4_0.topPanel, {
		y = 100
	})
	shiftPanel(arg_4_0._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(arg_4_0._right, 0, nil, 0.3, 0, true, true, nil)
	shiftPanel(arg_4_0.topPanel, nil, 0, 0.3, 0, true, true, nil, nil)

	return
end

function var_0_0.uiExitAnimating(arg_5_0)
	shiftPanel(arg_5_0._middle, -840, nil, 0.3, 0, true, true)
	shiftPanel(arg_5_0._right, 470, nil, 0.3, 0, true, true)
	shiftPanel(arg_5_0.topPanel, nil, arg_5_0.topPanel.rect.height, 0.3, 0, true, true, nil, nil)

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0._backBtn, function()
		GetOrAddComponent(arg_6_0._tf, typeof(CanvasGroup)).interactable = false

		arg_6_0:uiExitAnimating()
		LeanTween.delayedCall(0.3, System.Action(function()
			arg_6_0:emit(var_0_0.ON_CLOSE)

			return
		end))

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0._startBtn, function()
		for iter_9_0, iter_9_1 in pairs(arg_6_0.fleet.ships) do
			local var_9_0, var_9_1 = ShipStatus.ShipStatusConflict("inActivity", iter_9_1, {
				inActivity = false
			})

			if var_9_0 == ShipStatus.STATE_CHANGE_FAIL then
				pg.TipsMgr.GetInstance():ShowTips(i18n(var_9_1))

				return
			end
		end

		arg_6_0:emit(ChallengePreCombatMediator.ON_START)

		return
	end, SFX_UI_WEIGHANCHOR)
	onToggle(arg_6_0, arg_6_0._autoToggle, function(arg_10_0)
		arg_6_0:emit(ChallengePreCombatMediator.ON_AUTO, {
			isOn = not arg_10_0,
			toggle = arg_6_0._autoToggle
		})

		if arg_10_0 and arg_6_0.subUseable == true then
			setActive(arg_6_0._autoSubToggle, true)
			onToggle(arg_6_0, arg_6_0._autoSubToggle, function(arg_11_0)
				arg_6_0:emit(ChallengePreCombatMediator.ON_SUB_AUTO, {
					isOn = not arg_11_0,
					toggle = arg_6_0._autoSubToggle
				})

				return
			end, SFX_PANEL, SFX_PANEL)
			triggerToggle(arg_6_0._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
		else
			setActive(arg_6_0._autoSubToggle, false)
		end

		return
	end, SFX_PANEL, SFX_PANEL)
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)
	setParent(arg_6_0.strategyInfo, arg_6_0._tf.parent)
	triggerToggle(arg_6_0._autoToggle, ys.Battle.BattleState.IsAutoBotActive())
	setAnchoredPosition(arg_6_0.topPanel, {
		y = arg_6_0.topPanel.rect.height
	})
	onNextTick(function()
		arg_6_0:uiStartAnimating()

		return
	end)

	return
end

function var_0_0.Register(arg_13_0)
	arg_13_0._formationLogic:AddHeroInfoModify(function(arg_14_0, arg_14_1)
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
			cloneTplTo(arg_13_0._starTpl, var_14_1)
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
	arg_13_0._formationLogic:AddShiftOnly(function(arg_15_0)
		arg_13_0:updateView(false)

		return
	end)
	arg_13_0._formationLogic:AddCheckRemove(function(arg_16_0, arg_16_1)
		arg_16_0()

		return
	end)

	return
end

function var_0_0.onBackPressed(arg_17_0)
	if arg_17_0.strategyPanel and arg_17_0.strategyPanel._go and isActive(arg_17_0.strategyPanel._go) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(arg_17_0._backBtn)
	end

	return
end

function var_0_0.setPlayerInfo(arg_18_0, arg_18_1)
	return
end

function var_0_0.updateChallenge(arg_19_0, arg_19_1)
	arg_19_0.challenge = arg_19_1
	arg_19_0.fleet = arg_19_1:getRegularFleet()

	arg_19_0._formationLogic:SetFleetVO(arg_19_0.fleet)
	arg_19_0._formationLogic:SetShipVOs(arg_19_0.fleet.ships)
	arg_19_0:updateView(true)

	return
end

function var_0_0.setSubFlag(arg_20_0, arg_20_1)
	arg_20_0.subUseable = arg_20_1 or false

	return
end

function var_0_0.updateView(arg_21_0, arg_21_1)
	arg_21_0._formationLogic:ResetGrid(TeamType.Vanguard)
	arg_21_0._formationLogic:ResetGrid(TeamType.Main)
	SetActive(arg_21_0._gridTFs[TeamType.Main][1]:Find("flag"), true)

	if arg_21_1 then
		arg_21_0:updateStageView()
		arg_21_0._formationLogic:LoadAllCharacter()
	else
		arg_21_0._formationLogic:SetAllCharacterPos()
	end

	arg_21_0:updateBattleFleetView()
	arg_21_0:displayFleetInfo()

	return
end

function var_0_0.updateStageView(arg_22_0)
	local var_22_0 = {
		arg_22_0._goals:Find("goal_tpl"),
		arg_22_0._goals:Find("goal_sink"),
		arg_22_0._goals:Find("goal_time")
	}

	for iter_22_0, iter_22_1 in ipairs({
		{
			1
		},
		false,
		false
	}) do
		local var_22_1

		if type(iter_22_1) ~= "string" then
			(function(arg_23_0, arg_23_1)
				if type(arg_23_0) == "table" then
					setActive(arg_23_1, true)
					setWidgetText(arg_23_1, (i18n(PreCombatLayer.ObjectiveList[arg_23_0[1]], arg_23_0[2])))
				else
					setActive(arg_23_1, false)
				end

				return
			end)(iter_22_1, var_22_0[1])

			var_22_1 = 1 + 1
		end
	end

	return
end

function var_0_0.updateBattleFleetView(arg_24_0)
	local var_24_0 = arg_24_0.challenge:getRegularFleet()

	;(function(arg_25_0, arg_25_1)
		removeAllChildren(arg_25_0)

		for iter_25_0 = 1, 3 do
			if arg_25_1[iter_25_0] then
				local var_25_0 = cloneTplTo(arg_24_0._ship_tpl, arg_25_0)

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
	end)(arg_24_0._fleet:Find("main"), var_24_0:getShipsByTeam(TeamType.Main, true))
	;(function(arg_25_0, arg_25_1)
		removeAllChildren(arg_25_0)

		for iter_25_0 = 1, 3 do
			if arg_25_1[iter_25_0] then
				local var_25_0 = cloneTplTo(arg_24_0._ship_tpl, arg_25_0)

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
	end)(arg_24_0._fleet:Find("vanguard"), var_24_0:getShipsByTeam(TeamType.Vanguard, true))

	return
end

function var_0_0.displayFleetInfo(arg_26_0)
	local var_26_0 = arg_26_0.challenge:getRegularFleet()
	local var_26_1 = var_26_0:getCommanders()

	FormationUI.tweenNumText(arg_26_0._vanguardGS, (_.reduce(var_26_0:getShipsByTeam(TeamType.Vanguard, false), 0, function(arg_27_0, arg_27_1)
		return arg_27_0 + arg_27_1:getShipCombatPower(var_26_1)
	end)))
	FormationUI.tweenNumText(arg_26_0._mainGS, (_.reduce(var_26_0:getShipsByTeam(TeamType.Main, false), 0, function(arg_28_0, arg_28_1)
		return arg_28_0 + arg_28_1:getShipCombatPower(var_26_1)
	end)))

	return
end

function var_0_0.willExit(arg_29_0)
	setParent(arg_29_0.strategyInfo, arg_29_0._tf)
	arg_29_0._formationLogic:Destroy()

	arg_29_0._formationLogic = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_29_0._tf)

	return
end

return var_0_0
