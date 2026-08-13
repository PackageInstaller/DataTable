class = var_0_10000

local var_0_0 = "PreCombatLayerSubmarine"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PreCombatLayer"))

import = var_0_10001

local var_0_2 = var_0_10001("..ship.FormationUI")

function var_0_1.init(arg_1_0)
	arg_1_0:CommonInit()

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_1.Find(var_1_0, "adapt/middle")

	SetActive = var_1_10002

	var_1_10002(var_1_1:Find("gear_score/main"), false)

	SetActive = var_1_10002

	var_1_10002(var_1_1:Find("gear_score/vanguard"), false)

	SetActive = var_1_10002

	var_1_10002(var_1_1:Find("gear_score/submarine"), true)

	setActive = var_1_10002

	var_1_10002(arg_1_0._bgFleet, false)

	setActive = var_1_10002

	var_1_10002(arg_1_0._bgSub, true)

	BaseFormation = var_1_10002
	arg_1_0._formationLogic = var_1_10002.New(arg_1_0._tf, arg_1_0._heroContainer, arg_1_0._heroInfo, arg_1_0._gridTFs)

	arg_1_0:Register()

	return
end

function var_0_1.SetFleets(arg_2_0, arg_2_1)
	_ = var_1_10002

	local var_2_0 = var_1_10002.filter

	_ = var_1_10004

	local var_2_1 = var_2_0(var_1_10004.values(arg_2_1), function(arg_3_0)
		local var_3_0 = arg_3_0:getFleetType()

		FleetType = var_2_10002

		return var_3_0 == var_2_10002.Submarine
	end)

	arg_2_0._fleetVOs = {}
	arg_2_0._fleetIDList = {}

	local var_2_2 = 0

	_ = var_4

	var_4.each(var_2_1, function(arg_4_0)
		arg_2_0._fleetVOs[arg_4_0.id] = arg_4_0

		if #arg_4_0.ships > 0 then
			table = var_1

			var_1.insert(arg_2_0._fleetIDList, arg_4_0.id)

			var_2_2 = var_2_2 + 1
		end

		return
	end)

	if var_2_2 == 0 then
		table = var_4

		var_4.insert(arg_2_0._fleetIDList, var_2_1[1].id)
	end

	table = var_4

	var_4.sort(arg_2_0._fleetIDList, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	return
end

function var_0_1.SetCurrentFleet(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or arg_6_0._fleetIDList[1]
	arg_6_0._currentFleetVO = arg_6_0._fleetVOs[arg_6_1]

	local var_6_0 = arg_6_0._formationLogic

	var_2.SetFleetVO(var_6_0, arg_6_0._currentFleetVO)

	return
end

function var_0_1.UpdateFleetView(arg_7_0, arg_7_1)
	arg_7_0:displayFleetInfo()

	local var_7_0 = arg_7_0._formationLogic

	var_2.UpdateGridVisibility(var_7_0)

	local var_7_1 = arg_7_0._formationLogic
	local var_7_2 = var_2.ResetGrid

	TeamType = var_1_10005

	var_7_2(var_7_1, var_1_10005.Submarine, arg_7_0._currentForm ~= var_0_1.FORM_EDIT)

	if arg_7_1 then
		local var_7_3 = arg_7_0._formationLogic

		var_2.LoadAllCharacter(var_7_3)
	else
		local var_7_4 = arg_7_0._formationLogic

		var_2.SetAllCharacterPos(var_7_4)
	end

	return
end

function var_0_1.didEnter(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0._backBtn

	local function var_8_2()
		local var_9_0 = {}

		if arg_8_0._currentForm == var_0_1.FORM_EDIT then
			table = var_1

			var_1.insert(var_9_0, function(arg_10_0)
				pg = var_3_10001

				local var_10_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_10_1 = var_1.ShowMsgBox
				local var_10_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10005
				var_10_2.content = var_3_10005("battle_preCombatLayer_save_confirm")

				function var_10_2.onYes()
					local var_11_0 = arg_8_0
					local var_11_1 = var_0.emit

					PreCombatMediator = var_4_10003

					var_11_1(var_11_0, var_4_10003.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_12_0 = var_5_10000.TipsMgr.GetInstance()
						local var_12_1 = var_0.ShowTips

						i18n = var_5_10003

						var_12_1(var_12_0, var_5_10003("battle_preCombatLayer_save_success"))
						arg_10_0()

						return
					end)

					return
				end

				function var_10_2.onNo()
					local var_13_0 = arg_8_0
					local var_13_1 = var_0.emit

					PreCombatMediator = var_4_10003

					var_13_1(var_13_0, var_4_10003.ON_ABORT_EDIT)
					arg_10_0()

					return
				end

				var_10_1(var_10_0, var_10_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_9_0, function()
			GetOrAddComponent = var_3_10000

			local var_14_0 = arg_8_0._tf

			typeof = var_3_10003
			CanvasGroup = var_3_10005
			var_3_10000(var_14_0, var_3_10003(var_3_10005)).interactable = false

			local var_14_1 = arg_8_0

			var_1.uiExitAnimating(var_14_1)

			LeanTween = var_1

			local var_14_2 = var_1.delayedCall
			local var_14_3 = 0.3

			System = var_3_10004

			var_14_2(var_14_3, var_3_10004.Action(function()
				local var_15_0 = arg_8_0

				var_0.emit(var_15_0, var_0_1.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0._startBtn

	local function var_8_5()
		local var_16_0 = {}

		if arg_8_0._currentForm == var_0_1.FORM_EDIT then
			table = var_1

			var_1.insert(var_16_0, function(arg_17_0)
				pg = var_3_10001

				local var_17_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_17_1 = var_1.ShowMsgBox
				local var_17_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10005
				var_17_2.content = var_3_10005("battle_preCombatLayer_save_march")

				function var_17_2.onYes()
					local var_18_0 = arg_8_0
					local var_18_1 = var_0.emit

					PreCombatMediator = var_4_10003

					var_18_1(var_18_0, var_4_10003.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_19_0 = var_5_10000.TipsMgr.GetInstance()
						local var_19_1 = var_0.ShowTips

						i18n = var_5_10003

						var_19_1(var_19_0, var_5_10003("battle_preCombatLayer_save_success"))
						arg_17_0()

						return
					end)

					return
				end

				var_17_1(var_17_0, var_17_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_16_0, function()
			local var_20_0 = arg_8_0
			local var_20_1 = var_0.emit

			PreCombatMediator = var_3_10003

			var_20_1(var_20_0, var_3_10003.ON_START, arg_8_0._currentFleetVO.id)

			return
		end)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0._nextPage

	local function var_8_8()
		local var_21_0 = arg_8_0

		if var_0.getNextFleetID(var_21_0) then
			local var_21_1 = arg_8_0
			local var_21_2 = var_1.emit

			PreCombatMediator = var_2_10004

			var_21_2(var_21_1, var_2_10004.ON_CHANGE_FLEET, var_0, true)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10006)

	onButton = var_1_10001

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0._prevPage

	local function var_8_11()
		local var_22_0 = arg_8_0

		if var_0.getPrevFleetID(var_22_0) then
			local var_22_1 = arg_8_0
			local var_22_2 = var_1.emit

			PreCombatMediator = var_2_10004

			var_22_2(var_22_1, var_2_10004.ON_CHANGE_FLEET, var_0, true)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_9, var_8_10, var_8_11, var_1_10006)

	onButton = var_1_10001

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0._checkBtn

	local function var_8_14()
		if arg_8_0._currentForm == var_0_1.FORM_EDIT then
			local var_23_0 = arg_8_0
			local var_23_1 = var_0.emit

			PreCombatMediator = var_2_10003

			var_23_1(var_23_0, var_2_10003.ON_COMMIT_EDIT, function()
				pg = var_3_10000

				local var_24_0 = var_3_10000.TipsMgr.GetInstance()
				local var_24_1 = var_0.ShowTips

				i18n = var_3_10003

				var_24_1(var_24_0, var_3_10003("battle_preCombatLayer_save_success"))

				local var_24_2 = arg_8_0._formationLogic

				var_0.SwitchToPreviewMode(var_24_2)

				return
			end)
		elseif arg_8_0._currentForm == var_0_1.FORM_PREVIEW then
			local var_23_2 = arg_8_0._formationLogic

			var_0.SwitchToDisplayMode(var_23_2)
		else
			assert = var_0

			var_0("currentForm error")
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_12, var_8_13, var_8_14, var_1_10006)

	arg_8_0._currentForm = arg_8_0.contextData.form
	arg_8_0.contextData.form = nil

	arg_8_0:UpdateFleetView(true)

	if arg_8_0._currentForm == var_0_1.FORM_EDIT then
		local var_8_15 = arg_8_0._formationLogic

		var_1.SwitchToDisplayMode(var_8_15)
	else
		local var_8_16 = arg_8_0._formationLogic

		var_1.SwitchToPreviewMode(var_8_16)
	end

	pg = var_1

	local var_8_17 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_8_17, arg_8_0._tf)

	setActive = var_1

	var_1(arg_8_0._autoToggle, false)

	setActive = var_1

	var_1(arg_8_0._autoSubToggle, false)

	onNextTick = var_1

	var_1(function()
		local var_25_0 = arg_8_0

		var_0.uiStartAnimating(var_25_0)

		return
	end)

	return
end

function var_0_1.getNextFleetID(arg_26_0)
	local var_26_0

	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0._fleetIDList) do
		if iter_26_1 == arg_26_0._currentFleetVO.id then
			var_26_0 = iter_26_0

			break
		end
	end

	return arg_26_0._fleetIDList[var_26_0 + 1]
end

function var_0_1.getPrevFleetID(arg_27_0)
	local var_27_0

	ipairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0._fleetIDList) do
		if iter_27_1 == arg_27_0._currentFleetVO.id then
			var_27_0 = iter_27_0

			break
		end
	end

	return arg_27_0._fleetIDList[var_27_0 - 1]
end

function var_0_1.displayFleetInfo(arg_28_0)
	math = var_1_10001

	local var_28_0 = var_1_10001.floor
	local var_28_1 = arg_28_0._currentFleetVO
	local var_28_2 = var_3.GetGearScoreSum

	TeamType = var_1_10006

	local var_28_3 = var_28_0(var_28_2(var_28_1, var_1_10006.Submarine))
	local var_28_4 = arg_28_0._currentFleetVO
	local var_28_5 = var_2.GetCostSum(var_28_4)

	setActive = var_3

	var_3(arg_28_0._popup, true)
	var_0_2.tweenNumText(arg_28_0._costText, var_28_5.oil)
	var_0_2.tweenNumText(arg_28_0._subGS, var_28_3)

	setText = var_3

	var_3(arg_28_0._fleetNameText, var_0_2.defaultFleetName(arg_28_0._currentFleetVO))

	setText = var_3

	var_3(arg_28_0._fleetNumText, arg_28_0._currentFleetVO.id - 10)

	return
end

function var_0_1.SetFleetStepper(arg_29_0)
	if arg_29_0._currentForm == var_0_1.FORM_EDIT then
		SetActive = var_1

		var_1(arg_29_0._nextPage, false)

		SetActive = var_1

		var_1(arg_29_0._prevPage, false)
	else
		setActive = var_1

		var_1(arg_29_0._nextPage, arg_29_0:getNextFleetID() ~= nil)

		setActive = var_1

		var_1(arg_29_0._prevPage, arg_29_0:getPrevFleetID() ~= nil)
	end

	return
end

return var_0_1
