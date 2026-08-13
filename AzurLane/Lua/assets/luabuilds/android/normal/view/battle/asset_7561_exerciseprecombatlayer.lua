class = var_0_10000

local var_0_0 = "ExercisePreCombatLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.battle.PreCombatLayer"))

import = var_0_0

local var_0_2 = var_0_0("..ship.FormationUI")

function var_0_1.getUIName(arg_1_0)
	return "PreCombatUI"
end

function var_0_1.ResUISettings(arg_2_0)
	local var_2_0 = {
		anim = true,
		order = 5
	}

	PlayerResUI = var_1_10002
	var_2_0.showType = var_1_10002.TYPE_ALL

	return var_2_0
end

function var_0_1.CommonInit(arg_3_0)
	var_0_1.super.CommonInit(arg_3_0)

	local var_3_0 = arg_3_0._costContainer

	arg_3_0._ticket = var_1.Find(var_3_0, "ticket")

	return
end

function var_0_1.Register(arg_4_0)
	local var_4_0 = arg_4_0._formationLogic

	var_1.AddLoadComplete(var_4_0, function()
		if arg_4_0._currentForm ~= var_0_1.FORM_EDIT then
			local var_5_0 = arg_4_0._formationLogic

			var_0.SwitchToPreviewMode(var_5_0)
		end

		return
	end)

	local var_4_1 = arg_4_0._formationLogic

	var_1.AddHeroInfoModify(var_4_1, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_6_2
		local var_6_1 = arg_6_2.SetLocalScale

		Vector3 = var_2_10005

		var_6_1(var_6_0, var_2_10005(0.65, 0.65, 1))

		SetActive = var_6_1

		var_6_1(arg_6_0, true)

		findTF = var_6_1

		local var_6_2 = var_6_1(arg_6_0, "info")

		findTF = var_4

		local var_6_3 = var_4(var_6_2, "stars")
		local var_6_4 = arg_6_1.energy

		Ship = var_6

		local var_6_5 = var_6_4 <= var_6.ENERGY_MID

		findTF = var_6

		local var_6_6 = var_6(var_6_2, "energy")
		local var_6_7

		if var_6_5 then
			local var_6_8

			var_6_7, var_6_8 = arg_6_1:getEnergyPrint()
			GetSpriteFromAtlas = var_2_10009

			if not var_2_10009("energy", var_6_7) then
				warning = var_2_10010

				var_2_10010("找不到疲劳")
			end

			setImageSprite = var_2_10010

			var_2_10010(var_6_6, var_2_10009)
		end

		setActive = var_6_7

		local var_6_9 = var_6_6

		if var_6_5 then
			::label_6_0::

			var_2_10009 = arg_4_0.contextData.system
			SYSTEM_DUEL = var_2_10010
			var_2_10009 = var_2_10009 ~= var_2_10010
		end

		var_6_7(var_6_9, var_2_10009)

		local var_6_10 = arg_6_1:getStar()

		for iter_6_0 = 1, var_6_10 do
			cloneTplTo = var_2_10012

			var_2_10012(arg_4_0._starTpl, var_6_3)
		end

		GetSpriteFromAtlas = var_8

		local var_6_11 = "shiptype"

		shipType2print = var_10

		if not var_8(var_6_11, var_10(arg_6_1:getShipType())) then
			warning = var_6_11

			var_6_11("找不到船形, shipConfigId: " .. arg_6_1.configId)
		end

		setImageSprite = var_6_11
		findTF = var_10

		var_6_11(var_10(var_6_2, "type"), var_8, true)

		setText = var_6_11
		findTF = var_10

		var_6_11(var_10(var_6_2, "frame/lv_contain/lv"), arg_6_1.level)

		local var_6_12 = var_6_2
		local var_6_13 = var_6_2.Find(var_6_12, "expbuff")

		setActive = var_6_12

		var_6_12(var_6_13, false)

		return
	end)

	local var_4_2 = arg_4_0._formationLogic

	var_1.AddLongPress(var_4_2, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_4_0
		local var_7_1 = var_3.emit

		ExercisePreCombatMediator = var_2_10005

		var_7_1(var_7_0, var_2_10005.OPEN_SHIP_INFO, arg_7_1.id, arg_7_2)

		return
	end)

	local var_4_3 = arg_4_0._formationLogic

	var_1.AddClick(var_4_3, function(arg_8_0, arg_8_1, arg_8_2)
		pg = var_2_10003

		local var_8_0 = var_2_10003.CriMgr.GetInstance()
		local var_8_1 = var_3.PlaySoundEffect_V3

		SFX_UI_CLICK = var_2_10005

		var_8_1(var_8_0, var_2_10005)

		local var_8_2 = arg_4_0
		local var_8_3 = var_3.emit

		ExercisePreCombatMediator = var_2_10005

		var_8_3(var_8_2, var_2_10005.CHANGE_FLEET_SHIP, arg_8_0, arg_8_2, arg_8_1)

		return
	end)

	local var_4_4 = arg_4_0._formationLogic

	var_1.AddBeginDrag(var_4_4, function(arg_9_0)
		findTF = var_2_10001

		local var_9_0 = var_2_10001(arg_9_0, "info")

		SetActive = var_2

		var_2(var_9_0, false)

		return
	end)

	local var_4_5 = arg_4_0._formationLogic

	var_1.AddEndDrag(var_4_5, function(arg_10_0)
		findTF = var_2_10001

		local var_10_0 = var_2_10001(arg_10_0, "info")

		SetActive = var_2

		var_2(var_10_0, true)

		return
	end)

	local var_4_6 = arg_4_0._formationLogic

	var_1.AddShiftOnly(var_4_6, function(arg_11_0)
		local var_11_0 = arg_4_0
		local var_11_1 = var_1.emit

		ExercisePreCombatMediator = var_2_10003

		var_11_1(var_11_0, var_2_10003.CHANGE_FLEET_SHIPS_ORDER, arg_11_0)

		return
	end)

	local var_4_7 = arg_4_0._formationLogic

	var_1.AddRemoveShip(var_4_7, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_4_0
		local var_12_1 = var_2.emit

		ExercisePreCombatMediator = var_2_10004

		var_12_1(var_12_0, var_2_10004.REMOVE_SHIP, arg_12_0, arg_12_1)

		return
	end)

	local var_4_8 = arg_4_0._formationLogic

	var_1.AddCheckRemove(var_4_8, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		pg = var_2_10005

		local var_13_0 = var_2_10005.MsgboxMgr.GetInstance()
		local var_13_1 = var_5.ShowMsgBox
		local var_13_2 = {
			hideNo = false,
			zIndex = -100
		}

		i18n = var_2_10008
		var_13_2.content = var_2_10008("battle_preCombatLayer_quest_leaveFleet", arg_13_2:getConfigTable().name)
		var_13_2.onYes = arg_13_1
		var_13_2.onNo = arg_13_0

		var_13_1(var_13_0, var_13_2)

		return
	end)

	local var_4_9 = arg_4_0._formationLogic

	var_1.AddSwitchToDisplayMode(var_4_9, function()
		arg_4_0._currentForm = var_0_1.FORM_EDIT

		local var_14_0 = arg_4_0._checkBtn
		local var_14_1 = var_0.GetComponent(var_14_0, "Button")

		var_14_1.interactable = true
		setActive = var_14_1

		local var_14_2 = arg_4_0._checkBtn

		var_14_1(var_1.Find(var_14_2, "save"), true)

		setActive = var_14_1

		local var_14_3 = arg_4_0._checkBtn

		var_14_1(var_1.Find(var_14_3, "edit"), false)

		return
	end)

	local var_4_10 = arg_4_0._formationLogic

	var_1.AddSwitchToShiftMode(var_4_10, function()
		local var_15_0 = arg_4_0._checkBtn

		var_0.GetComponent(var_15_0, "Button").interactable = false

		return
	end)

	local var_4_11 = arg_4_0._formationLogic

	var_1.AddSwitchToPreviewMode(var_4_11, function()
		arg_4_0._currentForm = var_0_1.FORM_PREVIEW

		local var_16_0 = arg_4_0._checkBtn
		local var_16_1 = var_0.GetComponent(var_16_0, "Button")

		var_16_1.interactable = true
		setActive = var_16_1

		local var_16_2 = arg_4_0._checkBtn

		var_16_1(var_1.Find(var_16_2, "save"), false)

		setActive = var_16_1

		local var_16_3 = arg_4_0._checkBtn

		var_16_1(var_1.Find(var_16_3, "edit"), true)

		return
	end)

	local var_4_12 = arg_4_0._formationLogic

	var_1.AddGridTipClick(var_4_12, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_4_0
		local var_17_1 = var_2.emit

		ExercisePreCombatMediator = var_2_10004

		var_17_1(var_17_0, var_2_10004.CHANGE_FLEET_SHIP, nil, arg_17_1, arg_17_0)

		return
	end)

	return
end

function var_0_1.didEnter(arg_18_0)
	arg_18_0:disableAllStepper()

	onButton = var_1

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0._backBtn

	local function var_18_2()
		local var_19_0 = {}

		if arg_18_0._currentForm == var_0_1.FORM_EDIT then
			table = var_1

			var_1.insert(var_19_0, function(arg_20_0)
				pg = var_3_10001

				local var_20_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_20_1 = var_1.ShowMsgBox
				local var_20_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10004
				var_20_2.content = var_3_10004("battle_preCombatLayer_save_confirm")

				function var_20_2.onYes()
					local var_21_0 = arg_18_0
					local var_21_1 = var_0.emit

					ExercisePreCombatMediator = var_4_10002

					var_21_1(var_21_0, var_4_10002.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_22_0 = var_5_10000.TipsMgr.GetInstance()
						local var_22_1 = var_0.ShowTips

						i18n = var_5_10002

						var_22_1(var_22_0, var_5_10002("battle_preCombatLayer_save_success"))
						arg_20_0()

						return
					end)

					return
				end

				var_20_2.onNo = arg_20_0

				var_20_1(var_20_0, var_20_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_19_0, function()
			GetOrAddComponent = var_3_10000

			local var_23_0 = arg_18_0._tf

			typeof = var_3_10002
			CanvasGroup = var_3_10003
			var_3_10000(var_23_0, var_3_10002(var_3_10003)).interactable = false

			local var_23_1 = arg_18_0

			var_1.uiExitAnimating(var_23_1)

			LeanTween = var_1

			local var_23_2 = var_1.delayedCall
			local var_23_3 = 0.3

			System = var_3_10003

			var_23_2(var_23_3, var_3_10003.Action(function()
				local var_24_0 = arg_18_0

				var_0.emit(var_24_0, var_0_1.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_18_0, var_18_1, var_18_2, var_1_10005)

	onButton = var_1

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0._startBtn

	local function var_18_5()
		local var_25_0 = {}

		if arg_18_0._currentForm == var_0_1.FORM_EDIT then
			table = var_1

			var_1.insert(var_25_0, function(arg_26_0)
				pg = var_3_10001

				local var_26_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_26_1 = var_1.ShowMsgBox
				local var_26_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10004
				var_26_2.content = var_3_10004("battle_preCombatLayer_save_march")

				function var_26_2.onYes()
					local var_27_0 = arg_18_0
					local var_27_1 = var_0.emit

					ExercisePreCombatMediator = var_4_10002

					var_27_1(var_27_0, var_4_10002.ON_COMMIT_EDIT, function()
						local var_28_0 = arg_18_0._formationLogic

						var_0.SwitchToPreviewMode(var_28_0)

						pg = var_0

						local var_28_1 = var_0.TipsMgr.GetInstance()
						local var_28_2 = var_0.ShowTips

						i18n = var_5_10002

						var_28_2(var_28_1, var_5_10002("battle_preCombatLayer_save_success"))
						arg_26_0()

						return
					end)

					return
				end

				var_26_1(var_26_0, var_26_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_25_0, function()
			local var_29_0 = arg_18_0
			local var_29_1 = var_0.emit

			ExercisePreCombatMediator = var_3_10002

			var_29_1(var_29_0, var_3_10002.ON_START, arg_18_0._currentFleetVO.id)

			return
		end)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10005

	var_1(var_18_3, var_18_4, var_18_5, var_1_10005)

	onButton = var_1

	local var_18_6 = arg_18_0
	local var_18_7 = arg_18_0._nextPage

	local function var_18_8()
		local var_30_0 = arg_18_0
		local var_30_1 = var_0.emit

		ExercisePreCombatMediator = var_2_10002

		var_30_1(var_30_0, var_2_10002.ON_CHANGE_FLEET, arg_18_0._legalFleetIdList[arg_18_0._curFleetIndex + 1])

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_18_6, var_18_7, var_18_8, var_1_10005)

	onButton = var_1

	local var_18_9 = arg_18_0
	local var_18_10 = arg_18_0._prevPage

	local function var_18_11()
		local var_31_0 = arg_18_0
		local var_31_1 = var_0.emit

		ExercisePreCombatMediator = var_2_10002

		var_31_1(var_31_0, var_2_10002.ON_CHANGE_FLEET, arg_18_0._legalFleetIdList[arg_18_0._curFleetIndex - 1])

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_18_9, var_18_10, var_18_11, var_1_10005)

	onButton = var_1

	local var_18_12 = arg_18_0
	local var_18_13 = arg_18_0._checkBtn

	local function var_18_14()
		if arg_18_0._currentForm == var_0_1.FORM_EDIT then
			local var_32_0 = arg_18_0
			local var_32_1 = var_0.emit

			ExercisePreCombatMediator = var_2_10002

			var_32_1(var_32_0, var_2_10002.ON_COMMIT_EDIT, function()
				pg = var_3_10000

				local var_33_0 = var_3_10000.TipsMgr.GetInstance()
				local var_33_1 = var_0.ShowTips

				i18n = var_3_10002

				var_33_1(var_33_0, var_3_10002("battle_preCombatLayer_save_success"))

				local var_33_2 = arg_18_0._formationLogic

				var_0.SwitchToPreviewMode(var_33_2)

				return
			end)
		elseif arg_18_0._currentForm == var_0_1.FORM_PREVIEW then
			local var_32_2 = arg_18_0._formationLogic

			var_0.SwitchToDisplayMode(var_32_2)
		else
			assert = var_0

			var_0("currentForm error")
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_18_12, var_18_13, var_18_14, var_1_10005)

	arg_18_0._currentForm = arg_18_0.contextData.form
	arg_18_0.contextData.form = nil

	arg_18_0:UpdateFleetView(true)

	if arg_18_0._currentForm == var_0_1.FORM_EDIT then
		local var_18_15 = arg_18_0._formationLogic

		var_1.SwitchToDisplayMode(var_18_15)
	else
		local var_18_16 = arg_18_0._formationLogic

		var_1.SwitchToPreviewMode(var_18_16)
	end

	pg = var_1

	local var_18_17 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_18_17, arg_18_0._tf)

	local var_18_18 = arg_18_0.contextData.system

	SYSTEM_DUEL = var_18_17

	if var_18_18 == var_18_17 then
		setActive = var_18_18

		var_18_18(arg_18_0._autoToggle, false)

		setActive = var_18_18

		var_18_18(arg_18_0._autoSubToggle, false)
	else
		setActive = var_18_18

		var_18_18(arg_18_0._autoToggle, true)

		onToggle = var_18_18

		local var_18_19 = arg_18_0
		local var_18_20 = arg_18_0._autoToggle

		local function var_18_21(arg_34_0)
			local var_34_0 = arg_18_0
			local var_34_1 = var_1.emit

			ExercisePreCombatMediator = var_2_10003

			var_34_1(var_34_0, var_2_10003.ON_AUTO, {
				isOn = not arg_34_0,
				toggle = arg_18_0._autoToggle
			})

			if arg_34_0 and arg_18_0._subUseable == true then
				setActive = var_34_1

				var_34_1(arg_18_0._autoSubToggle, true)

				onToggle = var_34_1

				local var_34_2 = arg_18_0
				local var_34_3 = arg_18_0._autoSubToggle

				local function var_34_4(arg_35_0)
					local var_35_0 = arg_18_0
					local var_35_1 = var_1.emit

					ExercisePreCombatMediator = var_3_10003

					var_35_1(var_35_0, var_3_10003.ON_SUB_AUTO, {
						isOn = not arg_35_0,
						toggle = arg_18_0._autoSubToggle
					})

					return
				end

				SFX_PANEL = var_5
				SFX_PANEL = var_2_10006

				var_34_1(var_34_2, var_34_3, var_34_4, var_5, var_2_10006)

				triggerToggle = var_34_1

				local var_34_5 = arg_18_0._autoSubToggle

				ys = var_34_3

				var_34_1(var_34_5, var_34_3.Battle.BattleState.IsAutoSubActive())
			else
				setActive = var_34_1

				var_34_1(arg_18_0._autoSubToggle, false)
			end

			return
		end

		SFX_PANEL = var_1_10005
		SFX_PANEL = var_1_10006

		var_18_18(var_18_19, var_18_20, var_18_21, var_1_10005, var_1_10006)

		triggerToggle = var_18_18

		local var_18_22 = arg_18_0._autoToggle

		ys = var_18_20

		var_18_18(var_18_22, var_18_20.Battle.BattleState.IsAutoBotActive())
	end

	onNextTick = var_18_18

	var_18_18(function()
		local var_36_0 = arg_18_0

		var_0.uiStartAnimating(var_36_0)

		return
	end)

	if arg_18_0._currentForm == var_0_1.FORM_PREVIEW then
		local var_18_23 = arg_18_0.contextData.system

		SYSTEM_DUEL = var_2

		if var_18_23 == var_2 and #arg_18_0._currentFleetVO.mainShips <= 0 then
			triggerButton = var_1

			var_1(arg_18_0._checkBtn)
		end
	end

	return
end

function var_0_1.disableAllStepper(arg_37_0)
	SetActive = var_1_10001

	var_1_10001(arg_37_0._nextPage, false)

	SetActive = var_1_10001

	var_1_10001(arg_37_0._prevPage, false)

	return
end

function var_0_1.willExit(arg_38_0)
	if arg_38_0._currentForm == var_0_1.FORM_EDIT then
		getProxy = var_1
		FleetProxy = var_2

		local var_38_0 = var_1(var_2)

		arg_38_0.contextData.EdittingFleet = var_38_0.EdittingFleet

		var_38_0:abortEditting()
	end

	var_0_1.super.willExit(arg_38_0)

	if arg_38_0.tweens then
		cancelTweens = var_1

		var_1(arg_38_0.tweens)
	end

	return
end

return var_0_1
