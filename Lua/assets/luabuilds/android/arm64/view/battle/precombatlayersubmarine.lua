local var_0_0 = class("PreCombatLayerSubmarine", import(".PreCombatLayer"))
local var_0_1 = import("..ship.FormationUI")

function var_0_0.init(arg_1_0)
	arg_1_0:CommonInit()

	local var_1_0 = arg_1_0._tf:Find("adapt/middle")

	SetActive(var_1_0:Find("gear_score/main"), false)
	SetActive(var_1_0:Find("gear_score/vanguard"), false)
	SetActive(var_1_0:Find("gear_score/submarine"), true)
	setActive(arg_1_0._bgFleet, false)
	setActive(arg_1_0._bgSub, true)

	arg_1_0._formationLogic = BaseFormation.New(arg_1_0._tf, arg_1_0._heroContainer, arg_1_0._heroInfo, arg_1_0._gridTFs)

	arg_1_0:Register()

	return
end

function var_0_0.SetFleets(arg_2_0, arg_2_1)
	local var_2_0 = _.filter(_.values(arg_2_1), function(arg_3_0)
		return arg_3_0:getFleetType() == FleetType.Submarine
	end)

	arg_2_0._fleetVOs = {}
	arg_2_0._fleetIDList = {}

	local var_2_1 = 0

	_.each(var_2_0, function(arg_4_0)
		arg_2_0._fleetVOs[arg_4_0.id] = arg_4_0

		if #arg_4_0.ships > 0 then
			table.insert(arg_2_0._fleetIDList, arg_4_0.id)

			var_2_1 = var_2_1 + 1
		end

		return
	end)

	if 0 == 0 then
		table.insert(arg_2_0._fleetIDList, var_2_0[1].id)
	end

	table.sort(arg_2_0._fleetIDList, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	return
end

function var_0_0.SetCurrentFleet(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or arg_6_0._fleetIDList[1]
	arg_6_0._currentFleetVO = arg_6_0._fleetVOs[arg_6_1]

	arg_6_0._formationLogic:SetFleetVO(arg_6_0._currentFleetVO)

	return
end

function var_0_0.UpdateFleetView(arg_7_0, arg_7_1)
	arg_7_0:displayFleetInfo()
	arg_7_0._formationLogic:UpdateGridVisibility()
	arg_7_0._formationLogic:ResetGrid(TeamType.Submarine, arg_7_0._currentForm ~= var_0_0.FORM_EDIT)

	if arg_7_1 then
		arg_7_0._formationLogic:LoadAllCharacter()
	else
		arg_7_0._formationLogic:SetAllCharacterPos()
	end

	return
end

function var_0_0.didEnter(arg_8_0)
	onButton(arg_8_0, arg_8_0._backBtn, function()
		if arg_8_0._currentForm == var_0_0.FORM_EDIT then
			table.insert({}, function(arg_10_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_confirm"),
					onYes = function()
						arg_8_0:emit(PreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_10_0()

							return
						end)

						return
					end,
					onNo = function()
						arg_8_0:emit(PreCombatMediator.ON_ABORT_EDIT)
						arg_10_0()

						return
					end
				})

				return
			end)
		end

		seriesAsync({}, function()
			GetOrAddComponent(arg_8_0._tf, typeof(CanvasGroup)).interactable = false

			arg_8_0:uiExitAnimating()
			LeanTween.delayedCall(0.3, System.Action(function()
				arg_8_0:emit(var_0_0.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0._startBtn, function()
		if arg_8_0._currentForm == var_0_0.FORM_EDIT then
			table.insert({}, function(arg_17_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_march"),
					onYes = function()
						arg_8_0:emit(PreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_17_0()

							return
						end)

						return
					end
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_8_0:emit(PreCombatMediator.ON_START, arg_8_0._currentFleetVO.id)

			return
		end)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(arg_8_0, arg_8_0._nextPage, function()
		local var_21_0 = arg_8_0:getNextFleetID()

		if var_21_0 then
			arg_8_0:emit(PreCombatMediator.ON_CHANGE_FLEET, var_21_0, true)
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._prevPage, function()
		local var_22_0 = arg_8_0:getPrevFleetID()

		if var_22_0 then
			arg_8_0:emit(PreCombatMediator.ON_CHANGE_FLEET, var_22_0, true)
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._checkBtn, function()
		if arg_8_0._currentForm == var_0_0.FORM_EDIT then
			arg_8_0:emit(PreCombatMediator.ON_COMMIT_EDIT, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
				arg_8_0._formationLogic:SwitchToPreviewMode()

				return
			end)
		elseif arg_8_0._currentForm == var_0_0.FORM_PREVIEW then
			arg_8_0._formationLogic:SwitchToDisplayMode()
		else
			assert("currentForm error")
		end

		return
	end, SFX_PANEL)

	arg_8_0._currentForm = arg_8_0.contextData.form
	arg_8_0.contextData.form = nil

	arg_8_0:UpdateFleetView(true)

	if arg_8_0._currentForm == var_0_0.FORM_EDIT then
		arg_8_0._formationLogic:SwitchToDisplayMode()
	else
		arg_8_0._formationLogic:SwitchToPreviewMode()
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf)
	setActive(arg_8_0._autoToggle, false)
	setActive(arg_8_0._autoSubToggle, false)
	onNextTick(function()
		arg_8_0:uiStartAnimating()

		return
	end)

	return
end

function var_0_0.getNextFleetID(arg_26_0)
	local var_26_0

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._fleetIDList) do
		if iter_26_1 == arg_26_0._currentFleetVO.id then
			var_26_0 = iter_26_0

			break
		end
	end

	return arg_26_0._fleetIDList[var_26_0 + 1]
end

function var_0_0.getPrevFleetID(arg_27_0)
	local var_27_0

	for iter_27_0, iter_27_1 in ipairs(arg_27_0._fleetIDList) do
		if iter_27_1 == arg_27_0._currentFleetVO.id then
			var_27_0 = iter_27_0

			break
		end
	end

	return arg_27_0._fleetIDList[var_27_0 - 1]
end

function var_0_0.displayFleetInfo(arg_28_0)
	setActive(arg_28_0._popup, true)
	var_0_1.tweenNumText(arg_28_0._costText, arg_28_0._currentFleetVO:GetCostSum().oil)
	var_0_1.tweenNumText(arg_28_0._subGS, (math.floor(arg_28_0._currentFleetVO:GetGearScoreSum(TeamType.Submarine))))
	setText(arg_28_0._fleetNameText, var_0_1.defaultFleetName(arg_28_0._currentFleetVO))
	setText(arg_28_0._fleetNumText, arg_28_0._currentFleetVO.id - 10)

	return
end

function var_0_0.SetFleetStepper(arg_29_0)
	if arg_29_0._currentForm == var_0_0.FORM_EDIT then
		SetActive(arg_29_0._nextPage, false)
		SetActive(arg_29_0._prevPage, false)
	else
		setActive(arg_29_0._nextPage, arg_29_0:getNextFleetID() ~= nil)
		setActive(arg_29_0._prevPage, arg_29_0:getPrevFleetID() ~= nil)
	end

	return
end

return var_0_0
