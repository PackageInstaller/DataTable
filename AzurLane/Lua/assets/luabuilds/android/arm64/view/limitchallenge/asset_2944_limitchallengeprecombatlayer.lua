class = var_0_10000

local var_0_0 = "LimitChallengePreCombatLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

import = var_0_10001

local var_0_2 = var_0_10001("view.ship.FormationUI")
local var_0_3 = {
	[99] = true
}

function var_0_1.getUIName(arg_1_0)
	return "LimitChallengePreCombatUI"
end

function var_0_1.tempCache(arg_2_0)
	return true
end

function var_0_1.init(arg_3_0)
	arg_3_0:CommonInit()

	BaseFormation = var_1
	arg_3_0._formationLogic = var_1.New(arg_3_0._tf, arg_3_0._heroContainer, arg_3_0._heroInfo, arg_3_0._gridTFs)

	arg_3_0:Register()

	return
end

function var_0_1.CommonInit(arg_4_0)
	arg_4_0.eventTriggers = {}
	setActive = var_1

	var_1(arg_4_0._fleetInfo, true)

	local var_4_0 = {}

	TeamType = var_1_10002
	var_4_0[var_1_10002.Vanguard] = {}
	TeamType = var_2
	var_4_0[var_2.Main] = {}
	TeamType = var_2
	var_4_0[var_2.Submarine] = {}
	arg_4_0._gridTFs = var_4_0

	for iter_4_0 = 1, 3 do
		local var_4_1 = arg_4_0._gridTFs

		TeamType = var_1_10006

		local var_4_2 = var_4_1[var_1_10006.Main]
		local var_4_3 = arg_4_0._gridFrame

		var_4_2[iter_4_0] = var_1_10006.Find(var_4_3, "main_" .. iter_4_0)

		local var_4_4 = arg_4_0._gridTFs

		TeamType = var_1_10006

		local var_4_5 = var_4_4[var_1_10006.Vanguard]
		local var_4_6 = arg_4_0._gridFrame

		var_4_5[iter_4_0] = var_1_10006.Find(var_4_6, "vanguard_" .. iter_4_0)

		local var_4_7 = arg_4_0._gridTFs

		TeamType = var_1_10006

		local var_4_8 = var_4_7[var_1_10006.Submarine]
		local var_4_9 = arg_4_0._gridFrame

		var_4_8[iter_4_0] = var_1_10006.Find(var_4_9, "submarine_" .. iter_4_0)
	end

	SetActive = var_1

	var_1(arg_4_0._item, false)

	SetActive = var_1

	var_1(arg_4_0._heroInfo, false)

	SetActive = var_1

	var_1(arg_4_0._starTplsa, false)

	setText = var_1

	local var_4_10 = arg_4_0._gearScore
	local var_4_11 = var_3.Find(var_4_10, "vanguard/line/Image/Text1")

	i18n = var_4

	var_1(var_4_11, var_4("pre_combat_vanguard"))

	setText = var_1

	local var_4_12 = arg_4_0._gearScore
	local var_4_13 = var_3.Find(var_4_12, "main/line/Image/Text1")

	i18n = var_4

	var_1(var_4_13, var_4("pre_combat_main"))

	setText = var_1

	local var_4_14 = arg_4_0._gearScore
	local var_4_15 = var_3.Find(var_4_14, "submarine/line/Image/text1")

	i18n = var_4

	var_1(var_4_15, var_4("pre_combat_submarine"))

	setText = var_1

	local var_4_16 = arg_4_0._costContainer
	local var_4_17 = var_3.Find(var_4_16, "title")

	i18n = var_4

	var_1(var_4_17, var_4("pre_combat_consume"))

	setText = var_1

	local var_4_18 = arg_4_0._infomation
	local var_4_19 = var_3.Find(var_4_18, "target/title/GameObject")

	i18n = var_4

	var_1(var_4_19, var_4("pre_combat_targets"))

	setText = var_1

	local var_4_20 = arg_4_0._infomation
	local var_4_21 = var_3.Find(var_4_20, "atlasloot/atlasloot/title/GameObject")

	i18n = var_4

	var_1(var_4_21, var_4("pre_combat_atlasloot"))

	setText = var_1

	local var_4_22 = arg_4_0._startBtn
	local var_4_23 = var_3.Find(var_4_22, "text")

	i18n = var_4

	var_1(var_4_23, var_4("pre_combat_start"))

	setText = var_1

	local var_4_24 = arg_4_0._startBtn
	local var_4_25 = var_3.Find(var_4_24, "text_en")

	i18n = var_4

	var_1(var_4_25, var_4("pre_combat_start_en"))

	setText = var_1

	local var_4_26 = arg_4_0.btnRegular
	local var_4_27 = var_3.Find(var_4_26, "fleet/CnFleet")

	Fleet = var_4

	var_1(var_4_27, var_4.DEFAULT_NAME[1])

	setText = var_1

	local var_4_28 = arg_4_0.btnSub
	local var_4_29 = var_3.Find(var_4_28, "fleet/CnFleet")

	Fleet = var_4

	var_1(var_4_29, var_4.DEFAULT_NAME[1])

	setAnchoredPosition = var_1

	var_1(arg_4_0._middle, {
		x = -840
	})

	setAnchoredPosition = var_1

	var_1(arg_4_0._right, {
		x = 470
	})
	arg_4_0:SetStageID(arg_4_0.contextData.stageId)

	LimitChallengeCommanderFormationPage = var_1
	arg_4_0.commanderFormationPanel = var_1.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData)

	local var_4_30 = arg_4_0.commanderFormationPanel

	var_1.RegisterView(var_4_30, arg_4_0)

	return
end

function var_0_1.Register(arg_5_0)
	local var_5_0 = arg_5_0._formationLogic

	var_1.AddLoadComplete(var_5_0, function()
		return
	end)

	local var_5_1 = arg_5_0._formationLogic

	var_1.AddHeroInfoModify(var_5_1, function(arg_7_0, arg_7_1)
		setAnchoredPosition = var_2_10002

		var_2_10002(arg_7_0, {
			x = 0,
			y = 0
		})

		SetActive = var_2_10002

		var_2_10002(arg_7_0, true)

		arg_7_0.name = "info"
		findTF = var_2

		local var_7_0 = var_2(arg_7_0, "info")

		findTF = var_2_10003

		local var_7_1 = var_2_10003(var_7_0, "stars")
		local var_7_2 = arg_7_1.energy

		Ship = var_5

		local var_7_3 = var_7_2 <= var_5.ENERGY_MID

		findTF = var_5

		local var_7_4 = var_5(var_7_0, "energy")
		local var_7_6

		if var_7_3 then
			local var_7_5 = arg_7_1
			local var_7_7

			var_7_6, var_7_7 = arg_7_1.getEnergyPrint(var_7_5)
			GetSpriteFromAtlas = var_7_5

			if not var_7_5("energy", var_7_6) then
				warning = var_2_10009

				var_2_10009("找不到疲劳")
			end

			setImageSprite = var_2_10009

			var_2_10009(var_7_4, var_8)
		end

		setActive = var_7_6

		local var_7_8 = var_7_4

		if var_7_3 then
			::label_7_0::

			var_2_10009 = arg_5_0.contextData.system
			SYSTEM_DUEL = var_2_10010
			var_2_10009 = var_2_10009 ~= var_2_10010
		end

		var_7_6(var_7_8, var_2_10009)

		local var_7_9 = arg_7_1:getStar()

		for iter_7_0 = 1, var_7_9 do
			cloneTplTo = var_2_10011

			var_2_10011(arg_5_0._starTplsa, var_7_1)
		end

		GetSpriteFromAtlas = var_7

		local var_7_10 = "shiptype"

		shipType2print = iter_7_0

		if not var_7(var_7_10, iter_7_0(arg_7_1:getShipType())) then
			warning = var_8

			var_8("找不到船形, shipConfigId: " .. arg_7_1.configId)
		end

		setImageSprite = var_8
		findTF = var_10

		var_8(var_10(var_7_0, "type"), var_7, true)

		setText = var_8
		findTF = var_10

		var_8(var_10(var_7_0, "frame/lv_contain/lv"), arg_7_1.level)

		local var_7_11 = var_7_0:Find("expbuff")

		setActive = var_7_10

		var_7_10(var_7_11, false)

		return
	end)

	local var_5_2 = arg_5_0._formationLogic

	var_1.AddLongPress(var_5_2, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_5_0
		local var_8_1 = var_4.emit

		LimitChallengePreCombatMediator = var_2_10007

		var_8_1(var_8_0, var_2_10007.OPEN_SHIP_INFO, arg_8_1.id, arg_8_2)

		return
	end)

	local var_5_3 = arg_5_0._formationLogic

	var_1.AddBeginDrag(var_5_3, function(arg_9_0)
		findTF = var_2_10001

		local var_9_0 = var_2_10001(arg_9_0, "info")

		SetActive = var_2_10002

		var_2_10002(var_9_0, false)

		return
	end)

	local var_5_4 = arg_5_0._formationLogic

	var_1.AddEndDrag(var_5_4, function(arg_10_0)
		findTF = var_2_10001

		local var_10_0 = var_2_10001(arg_10_0, "info")

		SetActive = var_2_10002

		var_2_10002(var_10_0, true)

		return
	end)

	local var_5_5 = arg_5_0._formationLogic

	var_1.AddClick(var_5_5, function(arg_11_0, arg_11_1, arg_11_2)
		pg = var_2_10003

		local var_11_0 = var_2_10003.CriMgr.GetInstance()
		local var_11_1 = var_3.PlaySoundEffect_V3

		SFX_UI_CLICK = var_2_10006

		var_11_1(var_11_0, var_2_10006)

		local var_11_2 = arg_5_0
		local var_11_3 = var_3.emit

		LimitChallengePreCombatMediator = var_2_10006

		var_11_3(var_11_2, var_2_10006.CHANGE_FLEET_SHIP, arg_11_0, arg_11_2, arg_11_1)

		return
	end)

	local var_5_6 = arg_5_0._formationLogic

	var_1.AddShiftOnly(var_5_6, function(arg_12_0)
		local var_12_0 = arg_5_0
		local var_12_1 = var_1.emit

		LimitChallengePreCombatMediator = var_2_10004

		var_12_1(var_12_0, var_2_10004.CHANGE_FLEET_SHIPS_ORDER, arg_12_0)

		return
	end)

	local var_5_7 = arg_5_0._formationLogic

	var_1.AddRemoveShip(var_5_7, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_5_0
		local var_13_1 = var_2.emit

		LimitChallengePreCombatMediator = var_2_10005

		var_13_1(var_13_0, var_2_10005.REMOVE_SHIP, arg_13_0, arg_13_1)

		return
	end)

	local var_5_8 = arg_5_0._formationLogic

	var_1.AddCheckRemove(var_5_8, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		local var_14_1

		if not arg_14_3:canRemove(arg_14_2) then
			local var_14_0 = arg_14_3
			local var_14_2

			var_14_1, var_14_2 = arg_14_3.getShipPos(var_14_0, arg_14_2)
			pg = var_14_0
			var_2_10009 = var_14_0.TipsMgr.GetInstance()

			local var_14_3 = var_7.ShowTips

			i18n = var_2_10010

			local var_14_4 = "ship_formationUI_removeError_onlyShip"
			local var_14_5 = arg_14_2
			local var_14_6 = arg_14_2.getConfigTable(var_14_5).name
			local var_14_7 = arg_14_3.name

			Fleet = var_14_5

			var_14_3(var_2_10009, var_2_10010(var_14_4, var_14_6, var_14_7, var_14_5.C_TEAM_NAME[var_14_2]))
			arg_14_0()
		else
			pg = var_14_1

			local var_14_8 = var_14_1.MsgboxMgr.GetInstance()
			local var_14_9 = var_5.ShowMsgBox
			local var_14_10 = {
				hideNo = false,
				zIndex = -100
			}

			i18n = var_2_10009
			var_14_10.content = var_2_10009("battle_preCombatLayer_quest_leaveFleet", arg_14_2:getConfigTable().name)
			var_14_10.onYes = arg_14_1
			var_14_10.onNo = arg_14_0

			var_14_9(var_14_8, var_14_10)
		end

		return
	end)

	local var_5_9 = arg_5_0._formationLogic

	var_1.AddSwitchToDisplayMode(var_5_9, function()
		return
	end)

	local var_5_10 = arg_5_0._formationLogic

	var_1.AddSwitchToShiftMode(var_5_10, function()
		local var_16_0 = arg_5_0

		var_0.SetFleetStepper(var_16_0)

		return
	end)

	local var_5_11 = arg_5_0._formationLogic

	var_1.AddSwitchToPreviewMode(var_5_11, function()
		local var_17_0 = arg_5_0

		var_0.SetFleetStepper(var_17_0)

		return
	end)

	local var_5_12 = arg_5_0._formationLogic

	var_1.AddGridTipClick(var_5_12, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_5_0
		local var_18_1 = var_2.emit

		LimitChallengePreCombatMediator = var_2_10005

		var_18_1(var_18_0, var_2_10005.CHANGE_FLEET_SHIP, nil, arg_5_0._currentFleetVO, arg_18_0)

		return
	end)

	return
end

function var_0_1.SetPlayerInfo(arg_19_0, arg_19_1)
	return
end

function var_0_1.SetSubFlag(arg_20_0, arg_20_1)
	arg_20_0._subUseable = arg_20_1 or false

	arg_20_0:UpdateSubToggle()

	return
end

function var_0_1.SetShips(arg_21_0, arg_21_1)
	arg_21_0._shipVOs = arg_21_1

	local var_21_0 = arg_21_0._formationLogic

	var_2.SetShipVOs(var_21_0, arg_21_0._shipVOs)

	return
end

function var_0_1.SetStageID(arg_22_0, arg_22_1)
	removeAllChildren = var_1_10002

	var_1_10002(arg_22_0._spoilsContainer)

	arg_22_0._stageID = arg_22_1
	pg = var_1_10002

	local var_22_0 = var_1_10002.expedition_data_template[arg_22_1]

	Clone = var_1_10003

	local var_22_1 = var_1_10003(var_22_0.award_display)

	checkExist = var_4
	pg = var_1_10006

	local var_22_2

	if var_4(var_1_10006.expedition_activity_template[arg_22_1], {
		"pt_drop_display"
	}) then
		type = var_22_2

		if var_22_2(var_4) == "table" then
			getProxy = var_22_2
			ActivityProxy = var_7
			var_22_2 = var_22_2(var_7)

			for iter_22_0 = #var_4, 1, -1 do
				if var_22_2:getActivityById(var_4[iter_22_0][1]) and not var_1_10010:isEnd() then
					table = var_11

					local var_22_3 = var_11.insert
					local var_22_4 = var_22_1

					var_1_10014 = 1

					local var_22_5 = {
						2
					}

					id2ItemId = var_1_10016
					var_22_5[2] = var_1_10016(var_4[iter_22_0][2])

					var_22_3(var_22_4, var_1_10014, var_22_5)
				end
			end
		end
	end

	ipairs = var_22_2

	for iter_22_1, iter_22_2 in var_22_2(var_22_1) do
		cloneTplTo = var_1_10010
		var_1_10010 = var_1_10010(arg_22_0._item, arg_22_0._spoilsContainer)

		local var_22_6 = {
			id = iter_22_2[2],
			type = iter_22_2[1]
		}

		updateDrop = var_12

		var_12(var_1_10010, var_22_6)

		onButton = var_12
		var_1_10014 = arg_22_0

		local var_22_7 = var_1_10010

		local function var_22_8()
			Item = var_2_10000

			if var_2_10000.getConfigData(iter_22_2[2]) and var_0_3[var_0.type] then
				local var_23_0 = var_0.display_icon
				local var_23_1 = {}

				ipairs = var_2_10003

				for iter_23_0, iter_23_1 in var_2_10003(var_23_0) do
					local var_23_2 = iter_23_1[1]
					local var_23_3 = iter_23_1[2]

					var_23_1[#var_23_1 + 1] = {
						hideName = true,
						type = var_23_2,
						id = var_23_3
					}
				end

				local var_23_4 = arg_22_0

				var_3.emit(var_23_4, var_0_1.ON_DROP_LIST, {
					item2Row = true,
					itemList = var_23_1,
					content = var_0.display
				})
			else
				local var_23_5 = arg_22_0

				var_1.emit(var_23_5, var_0_1.ON_DROP, var_22_6)
			end

			return
		end

		SFX_PANEL = var_1_10017

		var_12(var_1_10014, var_22_7, var_22_8, var_1_10017)
	end

	local function var_22_9(arg_24_0, arg_24_1)
		type = var_2_10002

		local var_24_0

		if var_2_10002(arg_24_0) == "table" then
			setActive = var_24_0

			var_24_0(arg_24_1, true)

			i18n = var_24_0
			PreCombatLayer = var_4
			var_24_0 = var_24_0(var_4.ObjectiveList[arg_24_0[1]], arg_24_0[2])
			setWidgetText = var_2_10003

			var_2_10003(arg_24_1, var_24_0)
		else
			setActive = var_24_0

			var_24_0(arg_24_1, false)
		end

		return
	end

	local var_22_10 = {}

	findTF = var_7
	var_22_10[1] = var_7(arg_22_0._goals, "goal_tpl")
	findTF = var_7
	var_22_10[2] = var_7(arg_22_0._goals, "goal_sink")
	findTF = var_7
	var_22_10[3] = var_7(arg_22_0._goals, "goal_time")

	local var_22_11 = {
		var_22_0.objective_1,
		var_22_0.objective_2,
		var_22_0.objective_3
	}
	local var_22_12 = 1

	ipairs = var_9

	for iter_22_3, iter_22_4 in var_9(var_22_11) do
		type = var_1_10014

		if var_1_10014(iter_22_4) ~= "string" then
			var_22_9(iter_22_4, var_22_10[var_22_12])

			var_22_12 = var_22_12 + 1
		end
	end

	for iter_22_5 = var_22_12, #var_22_10 do
		var_22_9("", var_22_10[iter_22_5])
	end

	return
end

function var_0_1.SetFleets(arg_25_0, arg_25_1)
	arg_25_0._fleetVOs = {}
	arg_25_0._legalFleetIdList = {}
	_ = var_2

	var_2.each(arg_25_1, function(arg_26_0)
		local var_26_0 = arg_25_0._fleetVOs

		var_26_0[arg_26_0.id] = arg_26_0
		table = var_26_0

		var_26_0.insert(arg_25_0._legalFleetIdList, arg_26_0.id)

		return
	end)

	return
end

function var_0_1.SetCurrentFleet(arg_27_0, arg_27_1)
	arg_27_0._currentFleetVO = arg_27_0._fleetVOs[arg_27_1]

	local var_27_0 = arg_27_0._formationLogic

	var_2.SetFleetVO(var_27_0, arg_27_0._currentFleetVO)

	ipairs = var_2

	for iter_27_0, iter_27_1 in var_2(arg_27_0._legalFleetIdList) do
		if arg_27_0._currentFleetVO.id == iter_27_1 then
			arg_27_0._curFleetIndex = iter_27_0

			break
		end
	end

	arg_27_0:updateCommanderFormation()

	return
end

function var_0_1.SetOpenCommander(arg_28_0, arg_28_1)
	arg_28_0.isOpenCommander = arg_28_1

	return
end

function var_0_1.CheckLegalFleet(arg_29_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.UpdateFleetView(arg_30_0, arg_30_1)
	arg_30_0:displayFleetInfo()
	arg_30_0:updateFleetBg()

	local var_30_0 = arg_30_0._formationLogic

	var_2.UpdateGridVisibility(var_30_0)

	local var_30_1 = arg_30_0._formationLogic
	local var_30_2 = var_2.ResetGrid

	TeamType = var_1_10005

	var_30_2(var_30_1, var_1_10005.Vanguard)

	local var_30_3 = arg_30_0._formationLogic
	local var_30_4 = var_2.ResetGrid

	TeamType = var_5

	var_30_4(var_30_3, var_5.Main)

	local var_30_5 = arg_30_0._formationLogic
	local var_30_6 = var_2.ResetGrid

	TeamType = var_5

	var_30_6(var_30_5, var_5.Submarine)
	arg_30_0:resetFormationComponent()

	if arg_30_1 then
		local var_30_7 = arg_30_0._formationLogic

		var_2.LoadAllCharacter(var_30_7)
	else
		local var_30_8 = arg_30_0._formationLogic

		var_2.SetAllCharacterPos(var_30_8)
	end

	local var_30_9 = arg_30_0._currentFleetVO
	local var_30_10 = var_2.getFleetType(var_30_9)

	setActive = var_1_10003

	local var_30_11 = arg_30_0.btnRegular
	local var_30_12 = var_5.Find(var_30_11, "on")

	FleetType = var_1_10006

	var_1_10003(var_30_12, var_30_10 == var_1_10006.Normal)

	setActive = var_1_10003

	local var_30_13 = arg_30_0.btnRegular
	local var_30_14 = var_5.Find(var_30_13, "off")

	FleetType = var_6

	var_1_10003(var_30_14, var_30_10 ~= var_6.Normal)

	setActive = var_1_10003

	local var_30_15 = arg_30_0.btnSub
	local var_30_16 = var_5.Find(var_30_15, "on")

	FleetType = var_6

	var_1_10003(var_30_16, var_30_10 == var_6.Submarine)

	setActive = var_1_10003

	local var_30_17 = arg_30_0.btnSub
	local var_30_18 = var_5.Find(var_30_17, "off")

	FleetType = var_6

	var_1_10003(var_30_18, var_30_10 ~= var_6.Submarine)

	return
end

function var_0_1.updateFleetBg(arg_31_0)
	local var_31_0 = arg_31_0._currentFleetVO
	local var_31_1 = var_1.getFleetType(var_31_0)

	setActive = var_1_10002

	local var_31_2 = arg_31_0._bgFleet

	FleetType = var_1_10005

	var_1_10002(var_31_2, var_31_1 == var_1_10005.Normal)

	setActive = var_1_10002

	local var_31_3 = arg_31_0._bgSub

	FleetType = var_5

	var_1_10002(var_31_3, var_31_1 == var_5.Submarine)

	return
end

function var_0_1.resetFormationComponent(arg_32_0)
	SetActive = var_1_10001

	local var_32_0 = arg_32_0._gridTFs.main[1]
	local var_32_1 = var_3.Find(var_32_0, "flag")
	local var_32_2 = arg_32_0._currentFleetVO
	local var_32_3 = var_4.getTeamByName

	TeamType = var_1_10007

	var_1_10001(var_32_1, #var_32_3(var_32_2, var_1_10007.Main) ~= 0)

	SetActive = var_1_10001

	local var_32_4 = arg_32_0._gridTFs.submarine[1]
	local var_32_5 = var_3.Find(var_32_4, "flag")
	local var_32_6 = arg_32_0._currentFleetVO
	local var_32_7 = var_4.getTeamByName

	TeamType = var_7

	var_1_10001(var_32_5, #var_32_7(var_32_6, var_7.Submarine) ~= 0)

	return
end

function var_0_1.uiStartAnimating(arg_33_0)
	local var_33_0 = 0
	local var_33_1 = 0.3

	shiftPanel = var_1_10003

	var_1_10003(arg_33_0._middle, 0, nil, var_33_1, var_33_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_33_0._right, 0, nil, var_33_1, var_33_0, true, true)

	return
end

function var_0_1.uiExitAnimating(arg_34_0)
	shiftPanel = var_1_10001

	var_1_10001(arg_34_0._middle, -840, nil, nil, nil, true, true)

	shiftPanel = var_1_10001

	var_1_10001(arg_34_0._right, 470, nil, nil, nil, true, true)

	return
end

function var_0_1.didEnter(arg_35_0)
	GetOrAddComponent = var_1_10001

	local var_35_0 = arg_35_0._tf

	typeof = var_1_10004
	CanvasGroup = var_1_10006
	var_1_10001(var_35_0, var_1_10004(var_1_10006)).interactable = true
	onButton = var_2

	local var_35_1 = arg_35_0
	local var_35_2 = arg_35_0._backBtn

	local function var_35_3()
		local var_36_0 = arg_35_0
		local var_36_1 = var_0.emit

		LimitChallengePreCombatMediator = var_2_10003

		var_36_1(var_36_0, var_2_10003.ON_UPDATE_CUSTOM_FLEET)

		GetOrAddComponent = var_36_1

		local var_36_2 = arg_35_0._tf

		typeof = var_3
		CanvasGroup = var_2_10005
		var_36_1(var_36_2, var_3(var_2_10005)).interactable = false

		local var_36_3 = arg_35_0

		var_1.uiExitAnimating(var_36_3)

		LeanTween = var_1

		local var_36_4 = var_1.delayedCall
		local var_36_5 = 0.3

		System = var_2_10004

		var_36_4(var_36_5, var_2_10004.Action(function()
			local var_37_0 = arg_35_0

			var_0.closeView(var_37_0)

			return
		end))

		return
	end

	SFX_CANCEL = var_1_10007

	var_2(var_35_1, var_35_2, var_35_3, var_1_10007)

	onButton = var_2

	local var_35_4 = arg_35_0
	local var_35_5 = arg_35_0._option

	local function var_35_6()
		local var_38_0 = arg_35_0
		local var_38_1 = var_0.emit

		LimitChallengePreCombatMediator = var_2_10003

		var_38_1(var_38_0, var_2_10003.ON_UPDATE_CUSTOM_FLEET)

		local var_38_2 = arg_35_0

		var_0.quickExitFunc(var_38_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_35_4, var_35_5, var_35_6, var_1_10007)

	onButton = var_2

	local var_35_7 = arg_35_0
	local var_35_8 = arg_35_0._startBtn

	local function var_35_9()
		local var_39_0 = arg_35_0
		local var_39_1 = var_0.emit

		LimitChallengePreCombatMediator = var_2_10003

		var_39_1(var_39_0, var_2_10003.ON_START)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10007

	var_2(var_35_7, var_35_8, var_35_9, var_1_10007)

	onButton = var_2

	local var_35_10 = arg_35_0
	local var_35_11 = arg_35_0._nextPage

	local function var_35_12()
		local var_40_0 = arg_35_0
		local var_40_1 = var_0.emit

		LimitChallengePreCombatMediator = var_2_10003

		var_40_1(var_40_0, var_2_10003.ON_CHANGE_FLEET, arg_35_0._legalFleetIdList[arg_35_0._curFleetIndex + 1])

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_35_10, var_35_11, var_35_12, var_1_10007)

	onButton = var_2

	local var_35_13 = arg_35_0
	local var_35_14 = arg_35_0._prevPage

	local function var_35_15()
		local var_41_0 = arg_35_0
		local var_41_1 = var_0.emit

		LimitChallengePreCombatMediator = var_2_10003

		var_41_1(var_41_0, var_2_10003.ON_CHANGE_FLEET, arg_35_0._legalFleetIdList[arg_35_0._curFleetIndex - 1])

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_35_13, var_35_14, var_35_15, var_1_10007)
	arg_35_0:UpdateFleetView(true)

	setActive = var_2

	var_2(arg_35_0._autoToggle, true)

	onToggle = var_2

	local var_35_16 = arg_35_0
	local var_35_17 = arg_35_0._autoToggle

	local function var_35_18(arg_42_0)
		local var_42_0 = arg_35_0
		local var_42_1 = var_1.emit

		LimitChallengePreCombatMediator = var_2_10004

		var_42_1(var_42_0, var_2_10004.ON_AUTO, {
			isOn = not arg_42_0,
			toggle = arg_35_0._autoToggle
		})

		arg_35_0.autoFlag = arg_42_0

		local var_42_2 = arg_35_0

		var_1.UpdateSubToggle(var_42_2)

		return
	end

	SFX_PANEL = var_1_10007
	SFX_PANEL = var_1_10008

	var_2(var_35_16, var_35_17, var_35_18, var_1_10007, var_1_10008)

	onToggle = var_2

	local var_35_19 = arg_35_0
	local var_35_20 = arg_35_0._autoSubToggle

	local function var_35_21(arg_43_0)
		local var_43_0 = arg_35_0
		local var_43_1 = var_1.emit

		LimitChallengePreCombatMediator = var_2_10004

		var_43_1(var_43_0, var_2_10004.ON_SUB_AUTO, {
			isOn = not arg_43_0,
			toggle = arg_35_0._autoSubToggle
		})

		return
	end

	SFX_PANEL = var_1_10007
	SFX_PANEL = var_1_10008

	var_2(var_35_19, var_35_20, var_35_21, var_1_10007, var_1_10008)

	onButton = var_2

	local var_35_22 = arg_35_0
	local var_35_23 = arg_35_0.btnRegular

	local function var_35_24()
		local var_44_0 = arg_35_0
		local var_44_1 = var_0.emit

		LimitChallengePreCombatMediator = var_2_10003

		local var_44_2 = var_2_10003.ON_CHANGE_FLEET

		FleetProxy = var_2_10004

		var_44_1(var_44_0, var_44_2, var_2_10004.CHALLENGE_FLEET_ID)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_35_22, var_35_23, var_35_24, var_1_10007)

	onButton = var_2

	local var_35_25 = arg_35_0
	local var_35_26 = arg_35_0.btnSub

	local function var_35_27()
		local var_45_0 = arg_35_0
		local var_45_1 = var_0.emit

		LimitChallengePreCombatMediator = var_2_10003

		local var_45_2 = var_2_10003.ON_CHANGE_FLEET

		FleetProxy = var_2_10004

		var_45_1(var_45_0, var_45_2, var_2_10004.CHALLENGE_SUB_FLEET_ID)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_35_25, var_35_26, var_35_27, var_1_10007)

	if arg_35_0.isOpenCommander then
		local var_35_28 = arg_35_0.commanderFormationPanel

		var_2.ActionInvoke(var_35_28, "Show")
	end

	triggerToggle = var_2

	local var_35_29 = arg_35_0._autoToggle

	ys = var_35_26

	var_2(var_35_29, var_35_26.Battle.BattleState.IsAutoBotActive())

	onNextTick = var_2

	var_2(function()
		local var_46_0 = arg_35_0

		var_0.uiStartAnimating(var_46_0)

		return
	end)
	arg_35_0:SetFleetStepper()
	arg_35_0:OverlayPanel(arg_35_0._tf)

	return
end

function var_0_1.UpdateSubToggle(arg_47_0)
	if arg_47_0.autoFlag and arg_47_0._subUseable == true then
		setActive = var_1

		var_1(arg_47_0._autoSubToggle, true)

		triggerToggle = var_1

		local var_47_0 = arg_47_0._autoSubToggle

		ys = var_4

		var_1(var_47_0, var_4.Battle.BattleState.IsAutoSubActive())
	else
		setActive = var_1

		var_1(arg_47_0._autoSubToggle, false)
	end

	return
end

function var_0_1.displayFleetInfo(arg_48_0)
	local var_48_0 = arg_48_0._currentFleetVO
	local var_48_1 = var_1.getFleetType(var_48_0)

	setActive = var_1_10002

	local var_48_2 = arg_48_0._vanguardGS.parent

	FleetType = var_1_10005

	var_1_10002(var_48_2, var_48_1 == var_1_10005.Normal)

	setActive = var_1_10002

	local var_48_3 = arg_48_0._mainGS.parent

	FleetType = var_5

	var_1_10002(var_48_3, var_48_1 == var_5.Normal)

	math = var_1_10002

	local var_48_4 = var_1_10002.floor
	local var_48_5 = arg_48_0._currentFleetVO
	local var_48_6 = var_4.GetGearScoreSum

	TeamType = var_1_10007

	local var_48_7 = var_48_4(var_48_6(var_48_5, var_1_10007.Vanguard))

	math = var_48_0

	local var_48_8 = var_48_0.floor
	local var_48_9 = arg_48_0._currentFleetVO
	local var_48_10 = var_5.GetGearScoreSum

	TeamType = var_1_10008

	local var_48_11 = var_48_8(var_48_10(var_48_9, var_1_10008.Main))

	setActive = var_4

	local var_48_12 = arg_48_0._subGS.parent

	FleetType = var_48_9

	var_4(var_48_12, var_48_1 == var_48_9.Submarine)

	math = var_4

	local var_48_13 = var_4.floor
	local var_48_14 = arg_48_0._currentFleetVO
	local var_48_15 = var_6.GetGearScoreSum

	TeamType = var_1_10009

	local var_48_16 = var_48_13(var_48_15(var_48_14, var_1_10009.Submarine))
	local var_48_17 = arg_48_0.contextData.system

	setActive = var_6

	local var_48_18 = arg_48_0._costContainer

	SYSTEM_DUEL = var_9

	var_6(var_48_18, var_48_17 ~= var_9)
	var_0_2.tweenNumText(arg_48_0._vanguardGS, var_48_7)
	var_0_2.tweenNumText(arg_48_0._mainGS, var_48_11)
	var_0_2.tweenNumText(arg_48_0._subGS, var_48_16)

	setText = var_6

	local var_48_19 = arg_48_0._fleetNameText
	local var_48_20 = arg_48_0._currentFleetVO

	var_6(var_48_19, var_9.GetName(var_48_20))

	setText = var_6

	var_6(arg_48_0._fleetNumText, arg_48_0._curFleetIndex)

	local var_48_21 = var_6[#arg_48_0.contextData.fleets]

	_ = var_8

	local var_48_22 = var_8.slice(var_6, 1, #var_6 - 1)
	local var_48_23 = (function()
		local var_49_0 = 0

		pg = var_2_10001

		local var_49_1 = var_2_10001.battle_cost_template[var_48_17].oil_cost > 0

		return var_49_0 + (function(arg_50_0, arg_50_1)
			local var_50_0 = 0

			if var_49_1 then
				var_50_0 = arg_50_0:GetCostSum().oil

				if 0 < arg_50_1 then
					math = var_3
					var_50_0 = var_3.min(arg_50_1, var_50_0)
				end
			end

			return var_50_0
		end)(var_48_22[1], 0) + var_3(var_48_21, 0)
	end)()

	var_0_2.tweenNumText(arg_48_0._costText, var_48_23)

	return
end

function var_0_1.SetFleetStepper(arg_51_0)
	SetActive = var_1_10001

	var_1_10001(arg_51_0._nextPage, arg_51_0._curFleetIndex < #arg_51_0._legalFleetIdList)

	SetActive = var_1_10001

	var_1_10001(arg_51_0._prevPage, arg_51_0._curFleetIndex > 1)

	return
end

function var_0_1.updateCommanderFormation(arg_52_0)
	if arg_52_0.isOpenCommander then
		local var_52_0 = arg_52_0.commanderFormationPanel

		var_1.Load(var_52_0)

		local var_52_1 = arg_52_0.commanderFormationPanel

		var_1.ActionInvoke(var_52_1, "Update", arg_52_0._currentFleetVO)
	end

	return
end

function var_0_1.onBackPressed(arg_53_0)
	pg = var_1_10001

	local var_53_0 = var_1_10001.CriMgr.GetInstance()
	local var_53_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_53_1(var_53_0, var_1_10004)

	triggerButton = var_53_1

	var_53_1(arg_53_0._backBtn)

	return
end

function var_0_1.willExit(arg_54_0)
	local var_54_0 = arg_54_0.commanderFormationPanel

	var_1.Destroy(var_54_0)

	local var_54_1 = arg_54_0._formationLogic

	var_1.Destroy(var_54_1)

	arg_54_0._formationLogic = nil

	arg_54_0:UnOverlayPanel(arg_54_0._tf)

	return
end

return var_0_1
