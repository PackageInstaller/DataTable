class = var_0_10000

local var_0_0 = "ActivityBossPreCombatLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.battle.PreCombatLayer"))

import = var_0_0

local var_0_2 = var_0_0("view.ship.FormationUI")
local var_0_3 = {
	[99] = true
}

function var_0_1.getUIName(arg_1_0)
	return "ActivityBossPrecombatUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:CommonInit()

	setActive = var_1

	var_1(arg_2_0._fleetInfo, true)

	local var_2_0 = arg_2_0._startBtn

	arg_2_0._ticket = var_1.Find(var_2_0, "ticket")

	local var_2_1 = arg_2_0._startBtn

	arg_2_0._bonus = var_1.Find(var_2_1, "bonus")

	local var_2_2 = arg_2_0._startBtn

	arg_2_0._costTip = var_1.Find(var_2_2, "cost_container/popup/tip")

	local var_2_3 = arg_2_0.rtAdapt

	arg_2_0._continuousBtn = var_1.Find(var_2_3, "right/multiple")
	setText = var_1

	local var_2_4 = arg_2_0._continuousBtn
	local var_2_5 = var_2.Find(var_2_4, "text")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("multiple_sorties_title"))

	setText = var_1

	local var_2_6 = arg_2_0._continuousBtn
	local var_2_7 = var_2.Find(var_2_6, "text_en")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("multiple_sorties_title_eng"))

	setText = var_1

	local var_2_8 = arg_2_0._ticket
	local var_2_9 = var_2.Find(var_2_8, "title")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("ex_pass_use"))

	setText = var_1

	local var_2_10 = arg_2_0._bonus
	local var_2_11 = var_2.Find(var_2_10, "title")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("expedition_extra_drop_tip"))

	BaseFormation = var_1
	arg_2_0._formationLogic = var_1.New(arg_2_0._tf, arg_2_0._heroContainer, arg_2_0._heroInfo, arg_2_0._gridTFs)

	arg_2_0:Register()

	return
end

function var_0_1.Register(arg_3_0)
	local var_3_0 = arg_3_0._formationLogic

	var_1.AddLoadComplete(var_3_0, function()
		local var_4_0 = arg_3_0._currentForm

		PreCombatLayer = var_2_10001

		if var_4_0 ~= var_2_10001.FORM_EDIT then
			local var_4_1 = arg_3_0._formationLogic

			var_0.SwitchToPreviewMode(var_4_1)
		end

		return
	end)

	local var_3_1 = arg_3_0._formationLogic

	var_1.AddHeroInfoModify(var_3_1, function(arg_5_0, arg_5_1)
		setAnchoredPosition = var_2_10002

		var_2_10002(arg_5_0, {
			x = 0,
			y = 0
		})

		SetActive = var_2_10002

		var_2_10002(arg_5_0, true)

		arg_5_0.name = "info"
		findTF = var_2

		local var_5_0 = var_2(arg_5_0, "info")

		findTF = var_3

		local var_5_1 = var_3(var_5_0, "stars")
		local var_5_2 = arg_5_1.energy

		Ship = var_5

		local var_5_3 = var_5_2 <= var_5.ENERGY_MID

		findTF = var_5

		local var_5_4 = var_5(var_5_0, "energy")
		local var_5_5

		if var_5_3 then
			var_5_5 = arg_5_1

			local var_5_6

			var_5_6, var_5_5 = arg_5_1.getEnergyPrint(var_5_5)
			GetSpriteFromAtlas = var_2_10008

			if not var_2_10008("energy", var_5_6) then
				warning = var_9

				var_9("找不到疲劳")
			end

			setImageSprite = var_9

			var_9(var_5_4, var_2_10008)
		end

		local var_5_7 = arg_3_0.contextData.system

		pg = var_5_5

		local var_5_8 = var_5_5.battle_cost_template[var_5_7]

		setActive = var_2_10008

		var_2_10008(var_5_4, var_5_3 and var_5_8.enter_energy_cost > 0)

		local var_5_9 = arg_5_1:getStar()

		for iter_5_0 = 1, var_5_9 do
			cloneTplTo = var_2_10013

			var_2_10013(arg_3_0._starTpl, var_5_1)
		end

		GetSpriteFromAtlas = var_9

		local var_5_10 = "shiptype"

		shipType2print = var_11

		if not var_9(var_5_10, var_11(arg_5_1:getShipType())) then
			warning = var_5_10

			var_5_10("找不到船形, shipConfigId: " .. arg_5_1.configId)
		end

		setImageSprite = var_5_10
		findTF = var_11

		var_5_10(var_11(var_5_0, "type"), var_9, true)

		setText = var_5_10
		findTF = var_11

		var_5_10(var_11(var_5_0, "frame/lv_contain/lv"), arg_5_1.level)

		local var_5_11 = var_5_8.ship_exp_award

		if 0 < var_5_11 then
			getProxy = var_5_11
			ActivityProxy = var_11

			local var_5_12 = var_5_11(var_11)
			local var_5_13 = var_10.getBuffShipList(var_5_12)[arg_5_1:getGroupId()]
			local var_5_14 = var_5_0
			local var_5_15 = var_5_0.Find(var_5_14, "expbuff")

			setActive = var_5_14

			var_5_14(var_5_15, var_5_13 ~= nil)

			if var_5_13 then
				local var_5_16 = var_5_13 / 100
				local var_5_17 = var_5_13 % 100

				tostring = var_16

				local var_5_18 = var_16(var_5_16)
				local var_5_19

				if 0 < var_5_17 then
					var_5_19 = var_5_18

					local var_5_20 = "."

					tostring = var_2_10019
					var_5_18 = var_5_19 .. var_5_20 .. var_2_10019(var_5_17)
				end

				setText = var_5_19

				local var_5_21 = var_5_15
				local var_5_22 = var_5_15.Find(var_5_21, "text")

				string = var_5_21

				var_5_19(var_5_22, var_5_21.format("EXP +%s%%", var_5_18))
			end
		else
			local var_5_23 = var_5_0
			local var_5_24 = var_5_0.Find(var_5_23, "expbuff")

			setActive = var_5_23

			var_5_23(var_5_24, false)
		end

		return
	end)

	local var_3_2 = arg_3_0._formationLogic

	var_1.AddLongPress(var_3_2, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = arg_3_0
		local var_6_1 = var_4.emit

		ActivityBossPreCombatMediator = var_2_10006

		var_6_1(var_6_0, var_2_10006.OPEN_SHIP_INFO, arg_6_1.id, arg_6_2)

		return
	end)

	local var_3_3 = arg_3_0._formationLogic

	var_1.AddBeginDrag(var_3_3, function(arg_7_0)
		findTF = var_2_10001

		local var_7_0 = var_2_10001(arg_7_0, "info")

		SetActive = var_2

		var_2(var_7_0, false)

		return
	end)

	local var_3_4 = arg_3_0._formationLogic

	var_1.AddEndDrag(var_3_4, function(arg_8_0)
		findTF = var_2_10001

		local var_8_0 = var_2_10001(arg_8_0, "info")

		SetActive = var_2

		var_2(var_8_0, true)

		return
	end)

	local var_3_5 = arg_3_0._formationLogic

	var_1.AddClick(var_3_5, function(arg_9_0, arg_9_1, arg_9_2)
		return
	end)

	local var_3_6 = arg_3_0._formationLogic

	var_1.AddShiftOnly(var_3_6, function(arg_10_0)
		local var_10_0 = arg_3_0
		local var_10_1 = var_1.emit

		ActivityBossPreCombatMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.CHANGE_FLEET_SHIPS_ORDER, arg_10_0)

		return
	end)

	local var_3_7 = arg_3_0._formationLogic

	var_1.AddRemoveShip(var_3_7, function(arg_11_0, arg_11_1)
		return
	end)

	local var_3_8 = arg_3_0._formationLogic

	var_1.AddCheckRemove(var_3_8, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		arg_12_0()

		return
	end)

	local var_3_9 = arg_3_0._formationLogic

	var_1.AddSwitchToDisplayMode(var_3_9, function()
		local var_13_0 = arg_3_0

		PreCombatLayer = var_2_10001
		var_13_0._currentForm = var_2_10001.FORM_EDIT

		local var_13_1 = arg_3_0._checkBtn

		var_0.GetComponent(var_13_1, "Button").interactable = true

		local var_13_2 = arg_3_0

		var_0.SetFleetStepper(var_13_2)

		setActive = var_0

		local var_13_3 = arg_3_0._checkBtn

		var_0(var_1.Find(var_13_3, "save"), true)

		setActive = var_0

		local var_13_4 = arg_3_0._checkBtn

		var_0(var_1.Find(var_13_4, "edit"), false)

		return
	end)

	local var_3_10 = arg_3_0._formationLogic

	var_1.AddSwitchToShiftMode(var_3_10, function()
		local var_14_0 = arg_3_0

		var_0.SetFleetStepper(var_14_0)

		local var_14_1 = arg_3_0._checkBtn

		var_0.GetComponent(var_14_1, "Button").interactable = false

		return
	end)

	local var_3_11 = arg_3_0._formationLogic

	var_1.AddSwitchToPreviewMode(var_3_11, function()
		local var_15_0 = arg_3_0

		PreCombatLayer = var_2_10001
		var_15_0._currentForm = var_2_10001.FORM_PREVIEW

		local var_15_1 = arg_3_0._checkBtn

		var_0.GetComponent(var_15_1, "Button").interactable = true

		local var_15_2 = arg_3_0

		var_0.SetFleetStepper(var_15_2)

		setActive = var_0

		local var_15_3 = arg_3_0._checkBtn

		var_0(var_1.Find(var_15_3, "save"), false)

		setActive = var_0

		local var_15_4 = arg_3_0._checkBtn

		var_0(var_1.Find(var_15_4, "edit"), true)

		return
	end)

	local var_3_12 = arg_3_0._formationLogic

	var_1.AddGridTipClick(var_3_12, function(arg_16_0, arg_16_1)
		return
	end)

	local var_3_13 = arg_3_0.contextData.system

	SYSTEM_ACT_BOSS = var_3_12

	if var_3_13 == var_3_12 then
		local var_3_14 = arg_3_0._formationLogic

		var_1.DisableTip(var_3_14)
	end

	return
end

function var_0_1.SetPlayerInfo(arg_17_0, arg_17_1)
	return
end

function var_0_1.SetSubFlag(arg_18_0, arg_18_1)
	arg_18_0._subUseable = arg_18_1 or false

	return
end

function var_0_1.SetShips(arg_19_0, arg_19_1)
	arg_19_0._shipVOs = arg_19_1

	local var_19_0 = arg_19_0._formationLogic

	var_2.SetShipVOs(var_19_0, arg_19_0._shipVOs)

	return
end

function var_0_1.SetStageID(arg_20_0, arg_20_1)
	removeAllChildren = var_1_10002

	var_1_10002(arg_20_0._spoilsContainer)

	arg_20_0._stageID = arg_20_1
	pg = var_1_10002

	local var_20_0 = var_1_10002.expedition_data_template[arg_20_1]

	Clone = var_3

	local var_20_1 = var_3(var_20_0.award_display)

	checkExist = var_4
	pg = var_1_10005

	if var_4(var_1_10005.expedition_activity_template[arg_20_1], {
		"pt_drop_display"
	}) then
		type = var_5

		if var_5(var_4) == "table" then
			getProxy = var_5
			ActivityProxy = var_6

			local var_20_2 = var_5(var_6)

			for iter_20_0 = #var_4, 1, -1 do
				if var_20_2:getActivityById(var_4[iter_20_0][1]) and not var_1_10010:isEnd() then
					table = var_11

					local var_20_3 = var_11.insert
					local var_20_4 = var_20_1
					local var_20_5 = 1

					var_1_10014 = {
						2
					}
					id2ItemId = var_1_10015
					var_1_10014[2] = var_1_10015(var_4[iter_20_0][2])

					var_20_3(var_20_4, var_20_5, var_1_10014)
				end
			end
		end
	end

	local var_20_6 = arg_20_0.contextData.system

	SYSTEM_BOSS_EXPERIMENT = var_6

	if var_20_6 ~= var_6 then
		ipairs = var_20_6

		for iter_20_1, iter_20_2 in var_20_6(var_20_1) do
			cloneTplTo = var_1_10010
			var_1_10010 = var_1_10010(arg_20_0._item, arg_20_0._spoilsContainer)

			local var_20_7 = {
				id = iter_20_2[2],
				type = iter_20_2[1]
			}

			updateDrop = var_12

			var_12(var_1_10010, var_20_7)

			onButton = var_12

			local var_20_8 = arg_20_0

			var_1_10014 = var_1_10010

			local function var_20_9()
				Item = var_2_10000

				if var_2_10000.getConfigData(iter_20_2[2]) and var_0_3[var_0.type] then
					local var_21_0 = var_0.display_icon
					local var_21_1 = {}

					ipairs = var_2_10003

					for iter_21_0, iter_21_1 in var_2_10003(var_21_0) do
						local var_21_2 = iter_21_1[1]
						local var_21_3 = iter_21_1[2]

						var_21_1[#var_21_1 + 1] = {
							hideName = true,
							type = var_21_2,
							id = var_21_3
						}
					end

					local var_21_4 = arg_20_0

					var_3.emit(var_21_4, var_0_1.ON_DROP_LIST, {
						item2Row = true,
						itemList = var_21_1,
						content = var_0.display
					})
				else
					local var_21_5 = arg_20_0

					var_1.emit(var_21_5, var_0_1.ON_DROP, var_20_7)
				end

				return
			end

			SFX_PANEL = var_1_10016

			var_12(var_20_8, var_1_10014, var_20_9, var_1_10016)
		end
	end

	local function var_20_10(arg_22_0, arg_22_1)
		type = var_2_10002

		local var_22_0

		if var_2_10002(arg_22_0) == "table" then
			setActive = var_22_0

			var_22_0(arg_22_1, true)

			i18n = var_22_0
			PreCombatLayer = var_3
			var_22_0 = var_22_0(var_3.ObjectiveList[arg_22_0[1]], arg_22_0[2])
			setWidgetText = var_3

			var_3(arg_22_1, var_22_0)
		else
			setActive = var_22_0

			var_22_0(arg_22_1, false)
		end

		return
	end

	local var_20_11 = {}

	findTF = var_1_10007
	var_20_11[1] = var_1_10007(arg_20_0._goals, "goal_tpl")
	findTF = var_7
	var_20_11[2] = var_7(arg_20_0._goals, "goal_sink")
	findTF = var_7
	var_20_11[3] = var_7(arg_20_0._goals, "goal_time")

	local var_20_12 = {
		var_20_0.objective_1,
		var_20_0.objective_2,
		var_20_0.objective_3
	}
	local var_20_13 = 1

	ipairs = var_9

	for iter_20_3, iter_20_4 in var_9(var_20_12) do
		type = var_1_10014

		if var_1_10014(iter_20_4) ~= "string" then
			var_20_10(iter_20_4, var_20_11[var_20_13])

			var_20_13 = var_20_13 + 1
		end
	end

	for iter_20_5 = var_20_13, #var_20_11 do
		var_20_10("", var_20_11[iter_20_5])
	end

	local var_20_15

	if var_20_0.guide_desc then
		local var_20_14 = #var_20_0.guide_desc

		var_20_15 = 0 < var_20_14
	end

	setActive = var_10

	var_10(arg_20_0.guideDesc, var_20_15)

	if var_20_15 then
		setText = var_10

		var_10(arg_20_0.guideDesc, var_20_0.guide_desc)
	end

	return
end

function var_0_1.SetFleets(arg_23_0, arg_23_1)
	_ = var_1_10002

	local var_23_0 = var_1_10002.filter

	_ = var_1_10003

	local var_23_1 = var_23_0(var_1_10003.values(arg_23_1), function(arg_24_0)
		local var_24_0 = arg_24_0
		local var_24_1 = arg_24_0.getFleetType(var_24_0)

		FleetType = var_24_0

		return var_24_1 == var_24_0.Normal
	end)

	arg_23_0._fleetVOs = {}
	_ = var_3

	var_3.each(var_23_1, function(arg_25_0)
		arg_23_0._fleetVOs[arg_25_0.id] = arg_25_0

		return
	end)
	arg_23_0:CheckLegalFleet()

	return
end

function var_0_1.SetCurrentFleet(arg_26_0, arg_26_1)
	arg_26_0._currentFleetVO = arg_26_0._fleetVOs[arg_26_1]

	local var_26_0 = arg_26_0._formationLogic

	var_2.SetFleetVO(var_26_0, arg_26_0._currentFleetVO)
	arg_26_0:CheckLegalFleet()

	ipairs = var_2

	for iter_26_0, iter_26_1 in var_2(arg_26_0._legalFleetIdList) do
		if arg_26_0._currentFleetVO.id == iter_26_1 then
			arg_26_0._curFleetIndex = iter_26_0

			break
		end
	end

	return
end

function var_0_1.SetTicketItemID(arg_27_0, arg_27_1)
	arg_27_0._ticketItemID = arg_27_1

	return
end

function var_0_1.CheckLegalFleet(arg_28_0)
	arg_28_0._legalFleetIdList = {}
	pairs = var_1

	for iter_28_0, iter_28_1 in var_1(arg_28_0._fleetVOs) do
		local var_28_0 = #iter_28_1.ships

		if 0 < var_28_0 then
			local var_28_1 = iter_28_1.id

			FleetProxy = var_7

			if var_28_1 ~= var_7.PVP_FLEET_ID then
				table = var_28_1

				var_28_1.insert(arg_28_0._legalFleetIdList, iter_28_1.id)
			end
		end
	end

	table = var_1

	var_1.sort(arg_28_0._legalFleetIdList)

	return
end

function var_0_1.UpdateFleetView(arg_29_0, arg_29_1)
	arg_29_0:displayFleetInfo()
	arg_29_0:updateFleetBg()

	local var_29_0 = arg_29_0._formationLogic

	var_2.UpdateGridVisibility(var_29_0)

	local var_29_1 = arg_29_0._formationLogic
	local var_29_2 = var_2.ResetGrid

	TeamType = var_1_10004

	local var_29_3 = var_1_10004.Vanguard
	local var_29_4 = arg_29_0._currentForm

	PreCombatLayer = var_1_10006

	var_29_2(var_29_1, var_29_3, var_29_4 ~= var_1_10006.FORM_EDIT)

	local var_29_5 = arg_29_0._formationLogic
	local var_29_6 = var_2.ResetGrid

	TeamType = var_29_3

	local var_29_7 = var_29_3.Main
	local var_29_8 = arg_29_0._currentForm

	PreCombatLayer = var_6

	var_29_6(var_29_5, var_29_7, var_29_8 ~= var_6.FORM_EDIT)

	local var_29_9 = arg_29_0._formationLogic
	local var_29_10 = var_2.ResetGrid

	TeamType = var_29_7

	local var_29_11 = var_29_7.Submarine
	local var_29_12 = arg_29_0._currentForm

	PreCombatLayer = var_6

	var_29_10(var_29_9, var_29_11, var_29_12 ~= var_6.FORM_EDIT)
	arg_29_0:resetFormationComponent()

	if arg_29_1 then
		local var_29_13 = arg_29_0._formationLogic

		var_2.LoadAllCharacter(var_29_13)
	else
		local var_29_14 = arg_29_0._formationLogic

		var_2.SetAllCharacterPos(var_29_14)
	end

	return
end

function var_0_1.updateFleetBg(arg_30_0)
	local var_30_0 = arg_30_0._currentFleetVO
	local var_30_1 = var_1.getFleetType(var_30_0)

	setActive = var_30_0

	local var_30_2 = arg_30_0._bgFleet

	FleetType = var_1_10004

	var_30_0(var_30_2, var_30_1 == var_1_10004.Normal)

	setActive = var_30_0

	local var_30_3 = arg_30_0._bgSub

	FleetType = var_4

	var_30_0(var_30_3, var_30_1 == var_4.Submarine)

	return
end

function var_0_1.resetFormationComponent(arg_31_0)
	SetActive = var_1_10001

	local var_31_0 = arg_31_0._gridTFs.main[1]
	local var_31_1 = var_2.Find(var_31_0, "flag")
	local var_31_2 = arg_31_0._currentFleetVO
	local var_31_3 = var_3.getTeamByName

	TeamType = var_1_10005

	var_1_10001(var_31_1, #var_31_3(var_31_2, var_1_10005.Main) ~= 0)

	SetActive = var_1_10001

	local var_31_4 = arg_31_0._gridTFs.submarine[1]
	local var_31_5 = var_2.Find(var_31_4, "flag")
	local var_31_6 = arg_31_0._currentFleetVO
	local var_31_7 = var_3.getTeamByName

	TeamType = var_5

	var_1_10001(var_31_5, #var_31_7(var_31_6, var_5.Submarine) ~= 0)

	return
end

function var_0_1.uiStartAnimating(arg_32_0)
	local var_32_0 = 0
	local var_32_1 = 0.3

	shiftPanel = var_1_10003

	var_1_10003(arg_32_0._middle, 0, nil, var_32_1, var_32_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_32_0._right, 0, nil, var_32_1, var_32_0, true, true)

	return
end

function var_0_1.uiExitAnimating(arg_33_0)
	shiftPanel = var_1_10001

	var_1_10001(arg_33_0._middle, -840, nil, nil, nil, true, true)

	shiftPanel = var_1_10001

	var_1_10001(arg_33_0._right, 470, nil, nil, nil, true, true)

	return
end

function var_0_1.quickExitFunc(arg_34_0)
	local var_34_0 = arg_34_0._currentForm

	PreCombatLayer = var_1_10002

	if var_34_0 == var_1_10002.FORM_EDIT then
		local var_34_1 = arg_34_0
		local var_34_2 = arg_34_0.emit

		ActivityBossPreCombatMediator = var_1_10003

		var_34_2(var_34_1, var_1_10003.ON_ABORT_EDIT)
	end

	var_0_1.super.quickExitFunc(arg_34_0)

	return
end

function var_0_1.didEnter(arg_35_0)
	onButton = var_1_10001

	local var_35_0 = arg_35_0
	local var_35_1 = arg_35_0._backBtn

	local function var_35_2()
		local var_36_0 = {}
		local var_36_1 = arg_35_0._currentForm

		PreCombatLayer = var_2_10002

		if var_36_1 == var_2_10002.FORM_EDIT then
			table = var_36_1

			var_36_1.insert(var_36_0, function(arg_37_0)
				pg = var_3_10001

				local var_37_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_37_1 = var_1.ShowMsgBox
				local var_37_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10004
				var_37_2.content = var_3_10004("battle_preCombatLayer_save_confirm")

				function var_37_2.onYes()
					local var_38_0 = arg_35_0
					local var_38_1 = var_0.emit

					ActivityBossPreCombatMediator = var_4_10002

					var_38_1(var_38_0, var_4_10002.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_39_0 = var_5_10000.TipsMgr.GetInstance()
						local var_39_1 = var_0.ShowTips

						i18n = var_5_10002

						var_39_1(var_39_0, var_5_10002("battle_preCombatLayer_save_success"))
						arg_37_0()

						return
					end)

					return
				end

				function var_37_2.onNo()
					local var_40_0 = arg_35_0
					local var_40_1 = var_0.emit

					ActivityBossPreCombatMediator = var_4_10002

					var_40_1(var_40_0, var_4_10002.ON_ABORT_EDIT)
					arg_37_0()

					return
				end

				var_37_1(var_37_0, var_37_2)

				return
			end)
		end

		seriesAsync = var_36_1

		var_36_1(var_36_0, function()
			GetOrAddComponent = var_3_10000

			local var_41_0 = arg_35_0._tf

			typeof = var_3_10002
			CanvasGroup = var_3_10003
			var_3_10000(var_41_0, var_3_10002(var_3_10003)).interactable = false

			local var_41_1 = arg_35_0

			var_1.uiExitAnimating(var_41_1)

			LeanTween = var_1

			local var_41_2 = var_1.delayedCall
			local var_41_3 = 0.3

			System = var_3_10003

			var_41_2(var_41_3, var_3_10003.Action(function()
				local var_42_0 = arg_35_0

				var_0.emit(var_42_0, var_0_1.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_35_0, var_35_1, var_35_2, var_1_10005)

	onButton = var_1_10001

	local var_35_3 = arg_35_0
	local var_35_4 = arg_35_0._startBtn

	local function var_35_5()
		local var_43_0 = {}
		local var_43_1 = arg_35_0._currentForm

		PreCombatLayer = var_2_10002

		if var_43_1 == var_2_10002.FORM_EDIT then
			table = var_43_1

			var_43_1.insert(var_43_0, function(arg_44_0)
				pg = var_3_10001

				local var_44_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_44_1 = var_1.ShowMsgBox
				local var_44_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10004
				var_44_2.content = var_3_10004("battle_preCombatLayer_save_march")

				function var_44_2.onYes()
					local var_45_0 = arg_35_0
					local var_45_1 = var_0.emit

					ActivityBossPreCombatMediator = var_4_10002

					var_45_1(var_45_0, var_4_10002.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_46_0 = var_5_10000.TipsMgr.GetInstance()
						local var_46_1 = var_0.ShowTips

						i18n = var_5_10002

						var_46_1(var_46_0, var_5_10002("battle_preCombatLayer_save_success"))
						arg_44_0()

						return
					end)

					return
				end

				var_44_1(var_44_0, var_44_2)

				return
			end)
		end

		seriesAsync = var_43_1

		var_43_1(var_43_0, function()
			local var_47_0 = arg_35_0
			local var_47_1 = var_0.emit

			ActivityBossPreCombatMediator = var_3_10002

			var_47_1(var_47_0, var_3_10002.ON_START, arg_35_0._currentFleetVO.id)

			return
		end)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10005

	var_1_10001(var_35_3, var_35_4, var_35_5, var_1_10005)

	onButton = var_1_10001

	local var_35_6 = arg_35_0
	local var_35_7 = arg_35_0._checkBtn

	local function var_35_8()
		local var_48_0 = arg_35_0._currentForm

		PreCombatLayer = var_2_10001

		local var_48_1

		if var_48_0 == var_2_10001.FORM_EDIT then
			var_48_1 = arg_35_0

			local var_48_2 = var_0.emit

			ActivityBossPreCombatMediator = var_2_10002

			var_48_2(var_48_1, var_2_10002.ON_COMMIT_EDIT, function()
				pg = var_3_10000

				local var_49_0 = var_3_10000.TipsMgr.GetInstance()
				local var_49_1 = var_0.ShowTips

				i18n = var_3_10002

				var_49_1(var_49_0, var_3_10002("battle_preCombatLayer_save_success"))

				local var_49_2 = arg_35_0._formationLogic

				var_0.SwitchToPreviewMode(var_49_2)

				return
			end)
		else
			local var_48_3 = arg_35_0._currentForm

			PreCombatLayer = var_48_1

			if var_48_3 == var_48_1.FORM_PREVIEW then
				local var_48_4 = arg_35_0._formationLogic

				var_48_3.SwitchToDisplayMode(var_48_4)
			else
				assert = var_48_3

				var_48_3("currentForm error")
			end
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_35_6, var_35_7, var_35_8, var_1_10005)

	arg_35_0._currentForm = arg_35_0.contextData.form
	arg_35_0.contextData.form = nil

	local var_35_9 = arg_35_0

	arg_35_0.UpdateFleetView(var_35_9, true)

	local var_35_10 = arg_35_0._currentForm

	PreCombatLayer = var_35_9

	if var_35_10 == var_35_9.FORM_EDIT then
		local var_35_11 = arg_35_0._formationLogic

		var_35_10.SwitchToDisplayMode(var_35_11)
	else
		local var_35_12 = arg_35_0._formationLogic

		var_35_10.SwitchToPreviewMode(var_35_12)
	end

	pg = var_35_10

	local var_35_13 = var_35_10.UIMgr.GetInstance()

	var_1.BlurPanel(var_35_13, arg_35_0._tf)

	setActive = var_1

	var_1(arg_35_0._autoToggle, true)

	onToggle = var_1

	local var_35_14 = arg_35_0
	local var_35_15 = arg_35_0._autoToggle

	local function var_35_16(arg_50_0)
		local var_50_0 = arg_35_0
		local var_50_1 = var_1.emit

		ActivityBossPreCombatMediator = var_2_10003

		var_50_1(var_50_0, var_2_10003.ON_AUTO, {
			isOn = not arg_50_0,
			toggle = arg_35_0._autoToggle
		})

		if arg_50_0 and arg_35_0._subUseable == true then
			setActive = var_50_1

			var_50_1(arg_35_0._autoSubToggle, true)

			onToggle = var_50_1

			local var_50_2 = arg_35_0
			local var_50_3 = arg_35_0._autoSubToggle

			local function var_50_4(arg_51_0)
				local var_51_0 = arg_35_0
				local var_51_1 = var_1.emit

				ActivityBossPreCombatMediator = var_3_10003

				var_51_1(var_51_0, var_3_10003.ON_SUB_AUTO, {
					isOn = not arg_51_0,
					toggle = arg_35_0._autoSubToggle
				})

				return
			end

			SFX_PANEL = var_5
			SFX_PANEL = var_2_10006

			var_50_1(var_50_2, var_50_3, var_50_4, var_5, var_2_10006)

			triggerToggle = var_50_1

			local var_50_5 = arg_35_0._autoSubToggle

			ys = var_50_3

			var_50_1(var_50_5, var_50_3.Battle.BattleState.IsAutoSubActive())
		else
			setActive = var_50_1

			var_50_1(arg_35_0._autoSubToggle, false)
		end

		return
	end

	SFX_PANEL = var_1_10005
	SFX_PANEL = var_1_10006

	var_1(var_35_14, var_35_15, var_35_16, var_1_10005, var_1_10006)

	triggerToggle = var_1

	local var_35_17 = arg_35_0._autoToggle

	ys = var_35_15

	var_1(var_35_17, var_35_15.Battle.BattleState.IsAutoBotActive())

	onNextTick = var_1

	var_1(function()
		local var_52_0 = arg_35_0

		var_0.uiStartAnimating(var_52_0)

		return
	end)

	local var_35_18 = arg_35_0.contextData.stageId

	getProxy = var_2
	ActivityProxy = var_3

	local var_35_19 = var_2(var_3)
	local var_35_20 = var_2.getActivityById(var_35_19, arg_35_0.contextData.actId)

	setActive = var_35_19

	local var_35_21 = arg_35_0._continuousBtn
	local var_35_22 = arg_35_0.contextData.system

	SYSTEM_ACT_BOSS = var_1_10006

	var_35_19(var_35_21, var_35_22 == var_1_10006)

	local var_35_23

	if var_35_20 then
		::label_35_0::

		var_35_21 = var_35_20
		var_35_23 = var_35_20.IsOilLimit(var_35_21, var_35_18)
	end

	setActive = var_35_21

	local var_35_24 = arg_35_0._continuousBtn

	var_35_21(var_5.Find(var_35_24, "lock"), not var_35_23)

	if var_35_23 then
		Color = var_35_21

		if not var_35_21.white then
			Color = var_35_21
			var_35_21 = var_35_21.New(0.2980392156862745, 0.2980392156862745, 0.2980392156862745)
		end

		setImageColor = var_5

		var_5(arg_35_0._continuousBtn, var_35_21)

		setTextColor = var_5

		local var_35_25 = arg_35_0._continuousBtn

		var_5(var_6.Find(var_35_25, "text"), var_35_21)

		setTextColor = var_5

		local var_35_26 = arg_35_0._continuousBtn

		var_5(var_6.Find(var_35_26, "text_en"), var_35_21)

		onButton = var_5

		local var_35_27 = arg_35_0
		local var_35_28 = arg_35_0._continuousBtn

		local function var_35_29()
			local var_53_1

			if var_35_23 then
				local var_53_0 = arg_35_0

				var_53_1 = var_53_1.emit
				ActivityBossPreCombatMediator = var_2_10002

				var_53_1(var_53_0, var_2_10002.SHOW_CONTINUOUS_OPERATION_WINDOW, arg_35_0._currentFleetVO.id)
			else
				pg = var_53_1

				local var_53_2 = var_53_1.TipsMgr.GetInstance()
				local var_53_3 = var_0.ShowTips

				i18n = var_2_10002

				var_53_3(var_53_2, var_2_10002("multiple_sorties_locked_tip"))
			end

			return
		end

		SFX_PANEL = var_1_10009

		var_5(var_35_27, var_35_28, var_35_29, var_1_10009)

		return
	end
end

function var_0_1.displayFleetInfo(arg_54_0)
	var_0_1.super.displayFleetInfo(arg_54_0)

	local var_54_0 = arg_54_0.contextData.system

	setActive = var_2

	var_2(arg_54_0._costContainer, true)

	local var_54_1 = arg_54_0.contextData.stageId

	getProxy = var_3
	ActivityProxy = var_4

	local var_54_2 = var_3(var_4)
	local var_54_3 = var_3.getActivityById(var_54_2, arg_54_0.contextData.actId)
	local var_54_4 = var_3.GetStageBonus(var_54_3, var_54_1)

	setActive = var_54_3

	var_54_3(arg_54_0._bonus, var_54_4 > 0)

	setActive = var_54_3

	var_54_3(arg_54_0._ticket, var_54_4 <= 0)

	setText = var_54_3

	local var_54_5 = arg_54_0._bonus

	var_54_3(var_6.Find(var_54_5, "Text"), var_54_4)

	local var_54_6

	if var_54_4 <= 0 then
		Drop = var_54_6
		var_54_6 = var_54_6.New

		local var_54_7 = {}

		DROP_TYPE_RESOURCE = var_7
		var_54_7.type = var_7
		var_54_7.id = arg_54_0._ticketItemID

		local var_54_8 = var_54_6(var_54_7)

		var_54_6 = var_54_6.getIcon(var_54_8)
		LoadSprite = var_54_8

		local var_54_9 = var_54_8(var_54_6, "")

		setImageSprite = var_7

		local var_54_10 = arg_54_0._ticket

		var_7(var_8.Find(var_54_10, "icon"), var_54_9)

		getProxy = var_7
		PlayerProxy = var_8

		local var_54_11 = var_7(var_8)
		local var_54_12 = var_7.getRawData(var_54_11)
		local var_54_13 = var_7.getResource(var_54_12, arg_54_0._ticketItemID)
		local var_54_14 = 1

		var_1_10010 = arg_54_0._ticket

		local var_54_15 = var_9.Find(var_1_10010, "checkbox")

		SYSTEM_BOSS_EXPERIMENT = var_1_10010

		if var_54_0 == var_1_10010 then
			var_54_14 = 0
			triggerToggle = var_1_10010

			var_1_10010(var_54_15, false)

			setToggleEnabled = var_1_10010

			var_1_10010(var_54_15, false)
		else
			SYSTEM_HP_SHARE_ACT_BOSS = var_1_10010

			if var_54_0 == var_1_10010 then
				triggerToggle = var_1_10010

				var_1_10010(var_54_15, true)

				setToggleEnabled = var_1_10010

				var_1_10010(var_54_15, false)
			else
				SYSTEM_ACT_BOSS_SP = var_1_10010

				if var_54_0 == var_1_10010 then
					setActive = var_1_10010

					var_1_10010(arg_54_0._ticket, false)
				else
					SYSTEM_ACT_BOSS = var_1_10010

					if var_54_0 == var_1_10010 then
						var_1_10010 = 0 < var_54_13
						getProxy = var_11
						SettingsProxy = var_1_10012
						var_1_10012 = var_11(var_1_10012)

						local var_54_16 = var_11.isTipActBossExchangeTicket(var_1_10012) == 1

						setToggleEnabled = var_1_10012

						var_1_10012(var_54_15, var_1_10010)

						triggerToggle = var_1_10012

						var_1_10012(var_54_15, var_1_10010 and var_54_16)
					end
				end
			end
		end

		if var_54_13 < var_54_14 then
			setColorStr = var_1_10010

			local var_54_17 = var_54_13

			COLOR_RED = var_1_10012
			var_54_13 = var_1_10010(var_54_17, var_1_10012) or var_54_13
		end

		setText = var_1_10010

		local var_54_18 = arg_54_0._ticket

		var_1_10010(var_11.Find(var_54_18, "Text"), var_54_14 .. "/" .. var_54_13)

		onToggle = var_1_10010

		local var_54_19 = arg_54_0
		local var_54_20 = var_54_15

		local function var_54_21(arg_55_0)
			getProxy = var_2_10001
			SettingsProxy = var_2_10002

			local var_55_0 = var_2_10001(var_2_10002)

			var_1.setActBossExchangeTicketTip(var_55_0, arg_55_0 and 1 or 0)

			return
		end

		SFX_PANEL = var_14
		SFX_CANCEL = var_1_10015

		var_1_10010(var_54_19, var_54_20, var_54_21, var_14, var_1_10015)
	end

	pg = var_54_6

	local var_54_22 = var_54_6.battle_cost_template[var_54_0].oil_cost > 0
	local var_54_23 = 0
	local var_54_24 = 0
	local var_54_25 = false

	ipairs = var_1_10010

	for iter_54_0, iter_54_1 in var_1_10010({
		arg_54_0.contextData.fleets[1]
	}) do
		local var_54_26 = iter_54_1:GetCostSum().oil

		if not var_54_22 then
			var_54_26 = 0
		end

		var_54_24 = var_54_24 + var_54_26

		local var_54_27 = iter_54_0 == 1
		local var_54_28 = arg_54_0.contextData.costLimit[var_54_27 and 1 or 2]

		if 0 < var_54_28 then
			var_54_25 = var_54_25 or var_54_28 < var_54_26
			math = var_18
			var_54_26 = var_18.min(var_54_26, var_54_28)
		end

		var_54_23 = var_54_23 + var_54_26
	end

	setTextColor = var_10

	local var_54_29 = arg_54_0._costText

	if var_54_25 then
		Color = var_54_30

		local var_54_30

		if not var_54_30(0.9803921568627451, 0.39215686274509803, 0.39215686274509803) then
			Color = var_54_30
			var_54_30 = var_54_30.white
		end

		var_10(var_54_29, var_54_30)
		var_0_2.tweenNumText(arg_54_0._costText, var_54_23)

		setActive = var_10

		var_10(arg_54_0._costTip, var_54_25)

		if var_54_25 then
			onButton = var_10

			var_10(arg_54_0, arg_54_0._costTip, function()
				pg = var_2_10000

				local var_56_0 = var_2_10000.MsgboxMgr.GetInstance()
				local var_56_1 = var_0.ShowMsgBox
				local var_56_2 = {
					hideNo = true
				}

				i18n = var_2_10003
				var_56_2.content = var_2_10003("use_oil_limit_help", var_54_24, var_54_23)

				var_56_1(var_56_0, var_56_2)

				return
			end)
		end

		setText = var_10

		local var_54_31 = arg_54_0._fleetNameText

		Fleet = var_12

		var_10(var_54_31, var_12.DEFAULT_NAME_BOSS_ACT[arg_54_0._currentFleetVO.id])

		return
	end
end

function var_0_1.SetFleetStepper(arg_57_0)
	SetActive = var_1_10001

	var_1_10001(arg_57_0._nextPage, false)

	SetActive = var_1_10001

	var_1_10001(arg_57_0._prevPage, false)

	return
end

function var_0_1.onBackPressed(arg_58_0)
	pg = var_1_10001

	local var_58_0 = var_1_10001.CriMgr.GetInstance()
	local var_58_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_58_1(var_58_0, var_1_10003)

	triggerButton = var_58_1

	var_58_1(arg_58_0._backBtn)

	return
end

function var_0_1.willExit(arg_59_0)
	pg = var_1_10001

	local var_59_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_59_0, arg_59_0._tf)

	local var_59_1 = arg_59_0._formationLogic

	var_1.Destroy(var_59_1)

	arg_59_0._formationLogic = nil

	return
end

return var_0_1
