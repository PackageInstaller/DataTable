local var_0_0 = class("ExercisePreCombatLayer", import("view.battle.PreCombatLayer"))
local var_0_1 = import("..ship.FormationUI")

function var_0_0.getUIName(arg_1_0)
	return "PreCombatUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return {
		anim = true,
		order = 5,
		showType = PlayerResUI.TYPE_ALL
	}
end

function var_0_0.CommonInit(arg_3_0)
	var_0_0.super.CommonInit(arg_3_0)

	arg_3_0._ticket = arg_3_0._costContainer:Find("ticket")

	return
end

function var_0_0.Register(arg_4_0)
	arg_4_0._formationLogic:AddLoadComplete(function()
		if arg_4_0._currentForm ~= var_0_0.FORM_EDIT then
			arg_4_0._formationLogic:SwitchToPreviewMode()
		end

		return
	end)
	arg_4_0._formationLogic:AddHeroInfoModify(function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_2:SetLocalScale(Vector3(0.65, 0.65, 1))
		SetActive(arg_6_0, true)

		local var_6_0 = findTF(arg_6_0, "info")
		local var_6_1 = findTF(var_6_0, "stars")
		local var_6_2 = arg_6_1.energy <= Ship.ENERGY_MID
		local var_6_3 = findTF(var_6_0, "energy")

		if arg_6_1.energy <= Ship.ENERGY_MID then
			local var_6_4, var_6_5 = arg_6_1:getEnergyPrint()
			local var_6_6 = GetSpriteFromAtlas("energy", var_6_4)

			if not var_6_6 then
				warning("找不到疲劳")
			end

			setImageSprite(var_6_3, var_6_6)
		end

		setActive(var_6_3, var_6_2 and arg_4_0.contextData.system ~= SYSTEM_DUEL)

		for iter_6_0 = 1, arg_6_1:getStar() do
			cloneTplTo(arg_4_0._starTpl, var_6_1)
		end

		local var_6_7 = GetSpriteFromAtlas("shiptype", shipType2print(arg_6_1:getShipType()))

		if not var_6_7 then
			warning("找不到船形, shipConfigId: " .. arg_6_1.configId)
		end

		setImageSprite(findTF(var_6_0, "type"), var_6_7, true)
		setText(findTF(var_6_0, "frame/lv_contain/lv"), arg_6_1.level)
		setActive(var_6_0:Find("expbuff"), false)

		return
	end)
	arg_4_0._formationLogic:AddLongPress(function(arg_7_0, arg_7_1, arg_7_2)
		arg_4_0:emit(ExercisePreCombatMediator.OPEN_SHIP_INFO, arg_7_1.id, arg_7_2)

		return
	end)
	arg_4_0._formationLogic:AddClick(function(arg_8_0, arg_8_1, arg_8_2)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_CLICK)
		arg_4_0:emit(ExercisePreCombatMediator.CHANGE_FLEET_SHIP, arg_8_0, arg_8_2, arg_8_1)

		return
	end)
	arg_4_0._formationLogic:AddBeginDrag(function(arg_9_0)
		SetActive(findTF(arg_9_0, "info"), false)

		return
	end)
	arg_4_0._formationLogic:AddEndDrag(function(arg_10_0)
		SetActive(findTF(arg_10_0, "info"), true)

		return
	end)
	arg_4_0._formationLogic:AddShiftOnly(function(arg_11_0)
		arg_4_0:emit(ExercisePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, arg_11_0)

		return
	end)
	arg_4_0._formationLogic:AddRemoveShip(function(arg_12_0, arg_12_1)
		arg_4_0:emit(ExercisePreCombatMediator.REMOVE_SHIP, arg_12_0, arg_12_1)

		return
	end)
	arg_4_0._formationLogic:AddCheckRemove(function(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = false,
			zIndex = -100,
			content = i18n("battle_preCombatLayer_quest_leaveFleet", arg_13_2:getConfigTable().name),
			onYes = arg_13_1,
			onNo = arg_13_0
		})

		return
	end)
	arg_4_0._formationLogic:AddSwitchToDisplayMode(function()
		arg_4_0._currentForm = var_0_0.FORM_EDIT
		arg_4_0._checkBtn:GetComponent("Button").interactable = true

		setActive(arg_4_0._checkBtn:Find("save"), true)
		setActive(arg_4_0._checkBtn:Find("edit"), false)

		return
	end)
	arg_4_0._formationLogic:AddSwitchToShiftMode(function()
		arg_4_0._checkBtn:GetComponent("Button").interactable = false

		return
	end)
	arg_4_0._formationLogic:AddSwitchToPreviewMode(function()
		arg_4_0._currentForm = var_0_0.FORM_PREVIEW
		arg_4_0._checkBtn:GetComponent("Button").interactable = true

		setActive(arg_4_0._checkBtn:Find("save"), false)
		setActive(arg_4_0._checkBtn:Find("edit"), true)

		return
	end)
	arg_4_0._formationLogic:AddGridTipClick(function(arg_17_0, arg_17_1)
		arg_4_0:emit(ExercisePreCombatMediator.CHANGE_FLEET_SHIP, nil, arg_17_1, arg_17_0)

		return
	end)

	return
end

function var_0_0.didEnter(arg_18_0)
	arg_18_0:disableAllStepper()
	onButton(arg_18_0, arg_18_0._backBtn, function()
		if arg_18_0._currentForm == var_0_0.FORM_EDIT then
			table.insert({}, function(arg_20_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_confirm"),
					onYes = function()
						arg_18_0:emit(ExercisePreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_20_0()

							return
						end)

						return
					end,
					onNo = arg_20_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			GetOrAddComponent(arg_18_0._tf, typeof(CanvasGroup)).interactable = false

			arg_18_0:uiExitAnimating()
			LeanTween.delayedCall(0.3, System.Action(function()
				arg_18_0:emit(var_0_0.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(arg_18_0, arg_18_0._startBtn, function()
		if arg_18_0._currentForm == var_0_0.FORM_EDIT then
			table.insert({}, function(arg_26_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_march"),
					onYes = function()
						arg_18_0:emit(ExercisePreCombatMediator.ON_COMMIT_EDIT, function()
							arg_18_0._formationLogic:SwitchToPreviewMode()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_26_0()

							return
						end)

						return
					end
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_18_0:emit(ExercisePreCombatMediator.ON_START, arg_18_0._currentFleetVO.id)

			return
		end)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(arg_18_0, arg_18_0._nextPage, function()
		arg_18_0:emit(ExercisePreCombatMediator.ON_CHANGE_FLEET, arg_18_0._legalFleetIdList[arg_18_0._curFleetIndex + 1])

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0._prevPage, function()
		arg_18_0:emit(ExercisePreCombatMediator.ON_CHANGE_FLEET, arg_18_0._legalFleetIdList[arg_18_0._curFleetIndex - 1])

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0._checkBtn, function()
		if arg_18_0._currentForm == var_0_0.FORM_EDIT then
			arg_18_0:emit(ExercisePreCombatMediator.ON_COMMIT_EDIT, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
				arg_18_0._formationLogic:SwitchToPreviewMode()

				return
			end)
		elseif arg_18_0._currentForm == var_0_0.FORM_PREVIEW then
			arg_18_0._formationLogic:SwitchToDisplayMode()
		else
			assert("currentForm error")
		end

		return
	end, SFX_PANEL)

	arg_18_0._currentForm = arg_18_0.contextData.form
	arg_18_0.contextData.form = nil

	arg_18_0:UpdateFleetView(true)

	if arg_18_0._currentForm == var_0_0.FORM_EDIT then
		arg_18_0._formationLogic:SwitchToDisplayMode()
	else
		arg_18_0._formationLogic:SwitchToPreviewMode()
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_18_0._tf)

	if arg_18_0.contextData.system == SYSTEM_DUEL then
		setActive(arg_18_0._autoToggle, false)
		setActive(arg_18_0._autoSubToggle, false)
	else
		setActive(arg_18_0._autoToggle, true)
		onToggle(arg_18_0, arg_18_0._autoToggle, function(arg_34_0)
			arg_18_0:emit(ExercisePreCombatMediator.ON_AUTO, {
				isOn = not arg_34_0,
				toggle = arg_18_0._autoToggle
			})

			if arg_34_0 and arg_18_0._subUseable == true then
				setActive(arg_18_0._autoSubToggle, true)
				onToggle(arg_18_0, arg_18_0._autoSubToggle, function(arg_35_0)
					arg_18_0:emit(ExercisePreCombatMediator.ON_SUB_AUTO, {
						isOn = not arg_35_0,
						toggle = arg_18_0._autoSubToggle
					})

					return
				end, SFX_PANEL, SFX_PANEL)
				triggerToggle(arg_18_0._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
			else
				setActive(arg_18_0._autoSubToggle, false)
			end

			return
		end, SFX_PANEL, SFX_PANEL)
		triggerToggle(arg_18_0._autoToggle, ys.Battle.BattleState.IsAutoBotActive())
	end

	onNextTick(function()
		arg_18_0:uiStartAnimating()

		return
	end)

	if arg_18_0._currentForm == var_0_0.FORM_PREVIEW and arg_18_0.contextData.system == SYSTEM_DUEL and #arg_18_0._currentFleetVO.mainShips <= 0 then
		triggerButton(arg_18_0._checkBtn)
	end

	return
end

function var_0_0.disableAllStepper(arg_37_0)
	SetActive(arg_37_0._nextPage, false)
	SetActive(arg_37_0._prevPage, false)

	return
end

function var_0_0.willExit(arg_38_0)
	if arg_38_0._currentForm == var_0_0.FORM_EDIT then
		local var_38_0 = getProxy(FleetProxy)

		arg_38_0.contextData.EdittingFleet = var_38_0.EdittingFleet

		var_38_0:abortEditting()
	end

	var_0_0.super.willExit(arg_38_0)

	if arg_38_0.tweens then
		cancelTweens(arg_38_0.tweens)
	end

	return
end

return var_0_0
