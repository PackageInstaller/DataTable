class = var_0_10000

local var_0_0 = "BossSinglePreCombatLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

import = var_0_0

local var_0_2 = var_0_0("view.ship.FormationUI")
local var_0_3 = {
	[99] = true
}

function var_0_1.getUIName(arg_1_0)
	return "BossSinglePreCombatUI"
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

function var_0_1.init(arg_3_0)
	arg_3_0:CommonInit()

	BaseFormation = var_1
	arg_3_0._formationLogic = var_1.New(arg_3_0._tf, arg_3_0._heroContainer, arg_3_0._heroInfo, arg_3_0._gridTFs)

	arg_3_0:Register()

	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.CommonInit(arg_4_0)
	arg_4_0.eventTriggers = {}

	local var_4_0 = arg_4_0.rtAdapt

	arg_4_0._startBtn = var_1.Find(var_4_0, "right/start")

	local var_4_1 = arg_4_0.rtAdapt

	arg_4_0._costContainer = var_1.Find(var_4_1, "right/start/cost_container")

	local var_4_2 = arg_4_0._costContainer

	arg_4_0._popup = var_1.Find(var_4_2, "popup")

	local var_4_3 = arg_4_0._popup

	arg_4_0._costText = var_1.Find(var_4_3, "Text")

	local var_4_4 = arg_4_0._tf

	arg_4_0._moveLayer = var_1.Find(var_4_4, "moveLayer")

	local var_4_5 = arg_4_0.rtAdapt
	local var_4_6 = var_1.Find(var_4_5, "middle")
	local var_4_7 = arg_4_0.rtAdapt

	arg_4_0._autoToggle = var_2.Find(var_4_7, "auto_toggle")

	local var_4_8 = arg_4_0.rtAdapt

	arg_4_0._autoSubToggle = var_2.Find(var_4_8, "sub_toggle_container/sub_toggle")
	arg_4_0._fleetInfo = var_4_6:Find("fleet_info")
	arg_4_0._fleetNameText = var_4_6:Find("fleet_info/fleet_name/Text")
	arg_4_0._fleetNumText = var_4_6:Find("fleet_info/fleet_number")
	setActive = var_2

	var_2(arg_4_0._fleetInfo, true)

	arg_4_0._mainGS = var_4_6:Find("gear_score/main/Text")
	arg_4_0._vanguardGS = var_4_6:Find("gear_score/vanguard/Text")
	arg_4_0._subGS = var_4_6:Find("gear_score/submarine/Text")
	arg_4_0._bgFleet = var_4_6:Find("mask/grid_bg")

	local var_4_9 = var_4_6

	arg_4_0._bgSub = var_4_6.Find(var_4_9, "mask/bg_sub")

	local var_4_10 = {}

	TeamType = var_4_9
	var_4_10[var_4_9.Vanguard] = {}
	TeamType = var_3
	var_4_10[var_3.Main] = {}
	TeamType = var_3
	var_4_10[var_3.Submarine] = {}
	arg_4_0._gridTFs = var_4_10
	arg_4_0._gridFrame = var_4_6:Find("mask/GridFrame")

	for iter_4_0 = 1, 3 do
		local var_4_11 = arg_4_0._gridTFs

		TeamType = var_1_10007

		local var_4_12 = var_4_11[var_1_10007.Main]
		local var_4_13 = arg_4_0._gridFrame

		var_4_12[iter_4_0] = var_1_10007.Find(var_4_13, "main_" .. iter_4_0)

		local var_4_14 = arg_4_0._gridTFs

		TeamType = var_1_10007

		local var_4_15 = var_4_14[var_1_10007.Vanguard]
		local var_4_16 = arg_4_0._gridFrame

		var_4_15[iter_4_0] = var_1_10007.Find(var_4_16, "vanguard_" .. iter_4_0)

		local var_4_17 = arg_4_0._gridTFs

		TeamType = var_1_10007

		local var_4_18 = var_4_17[var_1_10007.Submarine]
		local var_4_19 = arg_4_0._gridFrame

		var_4_18[iter_4_0] = var_1_10007.Find(var_4_19, "submarine_" .. iter_4_0)
	end

	local var_4_20 = arg_4_0.rtAdapt

	arg_4_0._nextPage = var_2.Find(var_4_20, "middle/nextPage")

	local var_4_21 = arg_4_0.rtAdapt

	arg_4_0._prevPage = var_2.Find(var_4_21, "middle/prevPage")
	arg_4_0._heroContainer = var_4_6:Find("HeroContainer")
	arg_4_0._checkBtn = var_4_6:Find("checkBtn")

	local var_4_22 = arg_4_0._tf

	arg_4_0._blurPanel = var_2.Find(var_4_22, "blur_panel")

	local var_4_23 = arg_4_0._blurPanel

	arg_4_0.topPanel = var_2.Find(var_4_23, "top")

	local var_4_24 = arg_4_0._blurPanel

	arg_4_0.topPanelBg = var_2.Find(var_4_24, "top_bg")

	local var_4_25 = arg_4_0.topPanel

	arg_4_0._backBtn = var_2.Find(var_4_25, "back_btn")

	local var_4_26 = arg_4_0.rtAdapt

	arg_4_0._spoilsContainer = var_2.Find(var_4_26, "right/infomation/atlasloot/spoils/items/items_container")

	local var_4_27 = arg_4_0.rtAdapt

	arg_4_0._item = var_2.Find(var_4_27, "right/infomation/atlasloot/spoils/items/item_tpl")
	SetActive = var_2

	var_2(arg_4_0._item, false)

	local var_4_28 = arg_4_0.rtAdapt

	arg_4_0._goals = var_2.Find(var_4_28, "right/infomation/target/goal")
	arg_4_0._heroInfo = arg_4_0:getTpl("heroInfo")

	local var_4_29 = arg_4_0

	arg_4_0._starTpl = arg_4_0.getTpl(var_4_29, "star_tpl")
	setText = var_2
	findTF = var_4_29

	local var_4_30 = var_4_29(arg_4_0.rtAdapt, "middle/gear_score/vanguard/line/Image/Text1")

	i18n = var_4

	var_2(var_4_30, var_4("pre_combat_vanguard"))

	setText = var_2
	findTF = var_4_30

	local var_4_31 = var_4_30(arg_4_0.rtAdapt, "middle/gear_score/main/line/Image/Text1")

	i18n = var_4

	var_2(var_4_31, var_4("pre_combat_main"))

	setText = var_2
	findTF = var_4_31

	local var_4_32 = var_4_31(arg_4_0.rtAdapt, "middle/gear_score/submarine/line/Image/text1")

	i18n = var_4

	var_2(var_4_32, var_4("pre_combat_submarine"))

	setText = var_2

	local var_4_33 = arg_4_0._costContainer
	local var_4_34 = var_3.Find(var_4_33, "title")

	i18n = var_4_33

	var_2(var_4_34, var_4_33("pre_combat_consume"))

	setText = var_2
	findTF = var_4_34

	local var_4_35 = var_4_34(arg_4_0.rtAdapt, "right/infomation/target/title/GameObject")

	i18n = var_4

	var_2(var_4_35, var_4("pre_combat_targets"))

	setText = var_2
	findTF = var_4_35

	local var_4_36 = var_4_35(arg_4_0.rtAdapt, "right/infomation/atlasloot/atlasloot/title/GameObject")

	i18n = var_4

	var_2(var_4_36, var_4("pre_combat_atlasloot"))

	setText = var_2

	local var_4_37 = arg_4_0._startBtn
	local var_4_38 = var_3.Find(var_4_37, "text")

	i18n = var_4_37

	var_2(var_4_38, var_4_37("pre_combat_start"))

	setText = var_2

	local var_4_39 = arg_4_0._startBtn
	local var_4_40 = var_3.Find(var_4_39, "text_en")

	i18n = var_4_39

	var_2(var_4_40, var_4_39("pre_combat_start_en"))

	local var_4_41 = arg_4_0.rtAdapt

	arg_4_0._middle = var_2.Find(var_4_41, "middle")

	local var_4_42 = arg_4_0.rtAdapt

	arg_4_0._right = var_2.Find(var_4_42, "right")
	setAnchoredPosition = var_2

	var_2(arg_4_0._middle, {
		x = -840
	})

	setAnchoredPosition = var_2

	var_2(arg_4_0._right, {
		x = 470
	})

	local var_4_43 = arg_4_0._middle

	arg_4_0.guideDesc = var_2.Find(var_4_43, "guideDesc")

	if arg_4_0.contextData.stageId then
		arg_4_0:SetStageID(arg_4_0.contextData.stageId)
	end

	local var_4_44 = arg_4_0._startBtn

	arg_4_0._costTip = var_2.Find(var_4_44, "cost_container/popup/tip")

	local var_4_45 = arg_4_0.rtAdapt

	arg_4_0._continuousBtn = var_2.Find(var_4_45, "right/multiple")
	setText = var_2

	local var_4_46 = arg_4_0._continuousBtn
	local var_4_47 = var_3.Find(var_4_46, "text")

	i18n = var_4_46

	var_2(var_4_47, var_4_46("multiple_sorties_title"))

	setText = var_2

	local var_4_48 = arg_4_0._continuousBtn
	local var_4_49 = var_3.Find(var_4_48, "text_en")

	i18n = var_4_48

	var_2(var_4_49, var_4_48("multiple_sorties_title_eng"))

	return
end

function var_0_1.Register(arg_5_0)
	local var_5_0 = arg_5_0._formationLogic

	var_1.AddLoadComplete(var_5_0, function()
		local var_6_0 = arg_5_0._currentForm

		PreCombatLayer = var_2_10001

		if var_6_0 ~= var_2_10001.FORM_EDIT then
			local var_6_1 = arg_5_0._formationLogic

			var_0.SwitchToPreviewMode(var_6_1)
		end

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

		findTF = var_3

		local var_7_1 = var_3(var_7_0, "stars")
		local var_7_2 = arg_7_1.energy

		Ship = var_5

		local var_7_3 = var_7_2 <= var_5.ENERGY_MID

		findTF = var_5

		local var_7_4 = var_5(var_7_0, "energy")
		local var_7_5

		if var_7_3 then
			var_7_5 = arg_7_1

			local var_7_6

			var_7_6, var_7_5 = arg_7_1.getEnergyPrint(var_7_5)
			GetSpriteFromAtlas = var_2_10008

			if not var_2_10008("energy", var_7_6) then
				warning = var_9

				var_9("找不到疲劳")
			end

			setImageSprite = var_9

			var_9(var_7_4, var_2_10008)
		end

		local var_7_7 = arg_5_0.contextData.system

		pg = var_7_5

		local var_7_8 = var_7_5.battle_cost_template[var_7_7]

		setActive = var_2_10008

		var_2_10008(var_7_4, var_7_3 and var_7_8.enter_energy_cost > 0)

		local var_7_9 = arg_7_1:getStar()

		for iter_7_0 = 1, var_7_9 do
			cloneTplTo = var_2_10013

			var_2_10013(arg_5_0._starTpl, var_7_1)
		end

		GetSpriteFromAtlas = var_9

		local var_7_10 = "shiptype"

		shipType2print = var_11

		if not var_9(var_7_10, var_11(arg_7_1:getShipType())) then
			warning = var_7_10

			var_7_10("找不到船形, shipConfigId: " .. arg_7_1.configId)
		end

		setImageSprite = var_7_10
		findTF = var_11

		var_7_10(var_11(var_7_0, "type"), var_9, true)

		setText = var_7_10
		findTF = var_11

		var_7_10(var_11(var_7_0, "frame/lv_contain/lv"), arg_7_1.level)

		local var_7_11 = var_7_8.ship_exp_award

		if 0 < var_7_11 then
			getProxy = var_7_11
			ActivityProxy = var_11

			local var_7_12 = var_7_11(var_11)
			local var_7_13 = var_10.getBuffShipList(var_7_12)[arg_7_1:getGroupId()]
			local var_7_14 = var_7_0
			local var_7_15 = var_7_0.Find(var_7_14, "expbuff")

			setActive = var_7_14

			var_7_14(var_7_15, var_7_13 ~= nil)

			if var_7_13 then
				local var_7_16 = var_7_13 / 100
				local var_7_17 = var_7_13 % 100

				tostring = var_16

				local var_7_18 = var_16(var_7_16)
				local var_7_19

				if 0 < var_7_17 then
					var_7_19 = var_7_18

					local var_7_20 = "."

					tostring = var_2_10019
					var_7_18 = var_7_19 .. var_7_20 .. var_2_10019(var_7_17)
				end

				setText = var_7_19

				local var_7_21 = var_7_15
				local var_7_22 = var_7_15.Find(var_7_21, "text")

				string = var_7_21

				var_7_19(var_7_22, var_7_21.format("EXP +%s%%", var_7_18))
			end
		else
			local var_7_23 = var_7_0
			local var_7_24 = var_7_0.Find(var_7_23, "expbuff")

			setActive = var_7_23

			var_7_23(var_7_24, false)
		end

		return
	end)

	local var_5_2 = arg_5_0._formationLogic

	var_1.AddLongPress(var_5_2, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_5_0
		local var_8_1 = var_4.emit

		BossSinglePreCombatMediator = var_2_10006

		var_8_1(var_8_0, var_2_10006.OPEN_SHIP_INFO, arg_8_1.id, arg_8_2)

		return
	end)

	local var_5_3 = arg_5_0._formationLogic

	var_1.AddBeginDrag(var_5_3, function(arg_9_0)
		findTF = var_2_10001

		local var_9_0 = var_2_10001(arg_9_0, "info")

		SetActive = var_2

		var_2(var_9_0, false)

		return
	end)

	local var_5_4 = arg_5_0._formationLogic

	var_1.AddEndDrag(var_5_4, function(arg_10_0)
		findTF = var_2_10001

		local var_10_0 = var_2_10001(arg_10_0, "info")

		SetActive = var_2

		var_2(var_10_0, true)

		return
	end)

	local var_5_5 = arg_5_0._formationLogic

	var_1.AddClick(var_5_5, function(arg_11_0, arg_11_1, arg_11_2)
		return
	end)

	local var_5_6 = arg_5_0._formationLogic

	var_1.AddShiftOnly(var_5_6, function(arg_12_0)
		local var_12_0 = arg_5_0
		local var_12_1 = var_1.emit

		BossSinglePreCombatMediator = var_2_10003

		var_12_1(var_12_0, var_2_10003.CHANGE_FLEET_SHIPS_ORDER, arg_12_0)

		return
	end)

	local var_5_7 = arg_5_0._formationLogic

	var_1.AddRemoveShip(var_5_7, function(arg_13_0, arg_13_1)
		return
	end)

	local var_5_8 = arg_5_0._formationLogic

	var_1.AddCheckRemove(var_5_8, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		arg_14_0()

		return
	end)

	local var_5_9 = arg_5_0._formationLogic

	var_1.AddSwitchToDisplayMode(var_5_9, function()
		local var_15_0 = arg_5_0

		PreCombatLayer = var_2_10001
		var_15_0._currentForm = var_2_10001.FORM_EDIT

		local var_15_1 = arg_5_0._checkBtn

		var_0.GetComponent(var_15_1, "Button").interactable = true

		local var_15_2 = arg_5_0

		var_0.SetFleetStepper(var_15_2)

		setActive = var_0

		local var_15_3 = arg_5_0._checkBtn

		var_0(var_1.Find(var_15_3, "save"), true)

		setActive = var_0

		local var_15_4 = arg_5_0._checkBtn

		var_0(var_1.Find(var_15_4, "edit"), false)

		return
	end)

	local var_5_10 = arg_5_0._formationLogic

	var_1.AddSwitchToShiftMode(var_5_10, function()
		local var_16_0 = arg_5_0

		var_0.SetFleetStepper(var_16_0)

		local var_16_1 = arg_5_0._checkBtn

		var_0.GetComponent(var_16_1, "Button").interactable = false

		return
	end)

	local var_5_11 = arg_5_0._formationLogic

	var_1.AddSwitchToPreviewMode(var_5_11, function()
		local var_17_0 = arg_5_0

		PreCombatLayer = var_2_10001
		var_17_0._currentForm = var_2_10001.FORM_PREVIEW

		local var_17_1 = arg_5_0._checkBtn

		var_0.GetComponent(var_17_1, "Button").interactable = true

		local var_17_2 = arg_5_0

		var_0.SetFleetStepper(var_17_2)

		setActive = var_0

		local var_17_3 = arg_5_0._checkBtn

		var_0(var_1.Find(var_17_3, "save"), false)

		setActive = var_0

		local var_17_4 = arg_5_0._checkBtn

		var_0(var_1.Find(var_17_4, "edit"), true)

		return
	end)

	local var_5_12 = arg_5_0._formationLogic

	var_1.AddGridTipClick(var_5_12, function(arg_18_0, arg_18_1)
		return
	end)

	local var_5_13 = arg_5_0._formationLogic

	var_1.DisableTip(var_5_13)

	return
end

function var_0_1.SetPlayerInfo(arg_19_0, arg_19_1)
	return
end

function var_0_1.SetSubFlag(arg_20_0, arg_20_1)
	arg_20_0._subUseable = arg_20_1 or false

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

	Clone = var_3

	local var_22_1 = var_3(var_22_0.award_display)

	checkExist = var_4
	pg = var_1_10005

	if var_4(var_1_10005.expedition_activity_template[arg_22_1], {
		"pt_drop_display"
	}) then
		type = var_5

		if var_5(var_4) == "table" then
			getProxy = var_5
			ActivityProxy = var_6

			local var_22_2 = var_5(var_6)

			for iter_22_0 = #var_4, 1, -1 do
				if var_22_2:getActivityById(var_4[iter_22_0][1]) and not var_1_10010:isEnd() then
					table = var_11

					local var_22_3 = var_11.insert
					local var_22_4 = var_22_1
					local var_22_5 = 1

					var_1_10014 = {
						2
					}
					id2ItemId = var_1_10015
					var_1_10014[2] = var_1_10015(var_4[iter_22_0][2])

					var_22_3(var_22_4, var_22_5, var_1_10014)
				end
			end
		end
	end

	local var_22_6 = arg_22_0.contextData.system

	SYSTEM_BOSS_EXPERIMENT = var_6

	if var_22_6 ~= var_6 then
		ipairs = var_22_6

		for iter_22_1, iter_22_2 in var_22_6(var_22_1) do
			cloneTplTo = var_1_10010
			var_1_10010 = var_1_10010(arg_22_0._item, arg_22_0._spoilsContainer)

			local var_22_7 = {
				id = iter_22_2[2],
				type = iter_22_2[1]
			}

			updateDrop = var_12

			var_12(var_1_10010, var_22_7)

			onButton = var_12

			local var_22_8 = arg_22_0

			var_1_10014 = var_1_10010

			local function var_22_9()
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

					var_1.emit(var_23_5, var_0_1.ON_DROP, var_22_7)
				end

				return
			end

			SFX_PANEL = var_1_10016

			var_12(var_22_8, var_1_10014, var_22_9, var_1_10016)
		end
	end

	local function var_22_10(arg_24_0, arg_24_1)
		type = var_2_10002

		local var_24_0

		if var_2_10002(arg_24_0) == "table" then
			setActive = var_24_0

			var_24_0(arg_24_1, true)

			i18n = var_24_0
			PreCombatLayer = var_3
			var_24_0 = var_24_0(var_3.ObjectiveList[arg_24_0[1]], arg_24_0[2])
			setWidgetText = var_3

			var_3(arg_24_1, var_24_0)
		else
			setActive = var_24_0

			var_24_0(arg_24_1, false)
		end

		return
	end

	local var_22_11 = {}

	findTF = var_1_10007
	var_22_11[1] = var_1_10007(arg_22_0._goals, "goal_tpl")
	findTF = var_7
	var_22_11[2] = var_7(arg_22_0._goals, "goal_sink")
	findTF = var_7
	var_22_11[3] = var_7(arg_22_0._goals, "goal_time")

	local var_22_12 = {
		var_22_0.objective_1,
		var_22_0.objective_2,
		var_22_0.objective_3
	}
	local var_22_13 = 1

	ipairs = var_9

	for iter_22_3, iter_22_4 in var_9(var_22_12) do
		type = var_1_10014

		if var_1_10014(iter_22_4) ~= "string" then
			var_22_10(iter_22_4, var_22_11[var_22_13])

			var_22_13 = var_22_13 + 1
		end
	end

	for iter_22_5 = var_22_13, #var_22_11 do
		var_22_10("", var_22_11[iter_22_5])
	end

	local var_22_15

	if var_22_0.guide_desc then
		local var_22_14 = #var_22_0.guide_desc

		var_22_15 = 0 < var_22_14
	end

	setActive = var_10

	var_10(arg_22_0.guideDesc, var_22_15)

	if var_22_15 then
		setText = var_10

		var_10(arg_22_0.guideDesc, var_22_0.guide_desc)
	end

	return
end

function var_0_1.SetFleets(arg_25_0, arg_25_1)
	_ = var_1_10002

	local var_25_0 = var_1_10002.filter

	_ = var_1_10003

	local var_25_1 = var_25_0(var_1_10003.values(arg_25_1), function(arg_26_0)
		local var_26_0 = arg_26_0
		local var_26_1 = arg_26_0.getFleetType(var_26_0)

		FleetType = var_26_0

		return var_26_1 == var_26_0.Normal
	end)

	arg_25_0._fleetVOs = {}
	_ = var_3

	var_3.each(var_25_1, function(arg_27_0)
		arg_25_0._fleetVOs[arg_27_0.id] = arg_27_0

		return
	end)
	arg_25_0:CheckLegalFleet()

	return
end

function var_0_1.SetCurrentFleet(arg_28_0, arg_28_1)
	arg_28_0._currentFleetVO = arg_28_0._fleetVOs[arg_28_1]

	local var_28_0 = arg_28_0._formationLogic

	var_2.SetFleetVO(var_28_0, arg_28_0._currentFleetVO)
	arg_28_0:CheckLegalFleet()

	ipairs = var_2

	for iter_28_0, iter_28_1 in var_2(arg_28_0._legalFleetIdList) do
		if arg_28_0._currentFleetVO.id == iter_28_1 then
			arg_28_0._curFleetIndex = iter_28_0

			break
		end
	end

	return
end

function var_0_1.CheckLegalFleet(arg_29_0)
	arg_29_0._legalFleetIdList = {}
	pairs = var_1

	for iter_29_0, iter_29_1 in var_1(arg_29_0._fleetVOs) do
		local var_29_0 = #iter_29_1.ships

		if 0 < var_29_0 then
			local var_29_1 = iter_29_1.id

			FleetProxy = var_7

			if var_29_1 ~= var_7.PVP_FLEET_ID then
				table = var_29_1

				var_29_1.insert(arg_29_0._legalFleetIdList, iter_29_1.id)
			end
		end
	end

	table = var_1

	var_1.sort(arg_29_0._legalFleetIdList)

	return
end

function var_0_1.UpdateFleetView(arg_30_0, arg_30_1)
	arg_30_0:displayFleetInfo()
	arg_30_0:updateFleetBg()

	local var_30_0 = arg_30_0._formationLogic

	var_2.UpdateGridVisibility(var_30_0)

	local var_30_1 = arg_30_0._formationLogic
	local var_30_2 = var_2.ResetGrid

	TeamType = var_1_10004

	local var_30_3 = var_1_10004.Vanguard
	local var_30_4 = arg_30_0._currentForm

	PreCombatLayer = var_1_10006

	var_30_2(var_30_1, var_30_3, var_30_4 ~= var_1_10006.FORM_EDIT)

	local var_30_5 = arg_30_0._formationLogic
	local var_30_6 = var_2.ResetGrid

	TeamType = var_30_3

	local var_30_7 = var_30_3.Main
	local var_30_8 = arg_30_0._currentForm

	PreCombatLayer = var_6

	var_30_6(var_30_5, var_30_7, var_30_8 ~= var_6.FORM_EDIT)

	local var_30_9 = arg_30_0._formationLogic
	local var_30_10 = var_2.ResetGrid

	TeamType = var_30_7

	local var_30_11 = var_30_7.Submarine
	local var_30_12 = arg_30_0._currentForm

	PreCombatLayer = var_6

	var_30_10(var_30_9, var_30_11, var_30_12 ~= var_6.FORM_EDIT)
	arg_30_0:resetFormationComponent()

	if arg_30_1 then
		local var_30_13 = arg_30_0._formationLogic

		var_2.LoadAllCharacter(var_30_13)
	else
		local var_30_14 = arg_30_0._formationLogic

		var_2.SetAllCharacterPos(var_30_14)
	end

	return
end

function var_0_1.updateFleetBg(arg_31_0)
	local var_31_0 = arg_31_0._currentFleetVO
	local var_31_1 = var_1.getFleetType(var_31_0)

	setActive = var_31_0

	local var_31_2 = arg_31_0._bgFleet

	FleetType = var_1_10004

	var_31_0(var_31_2, var_31_1 == var_1_10004.Normal)

	setActive = var_31_0

	local var_31_3 = arg_31_0._bgSub

	FleetType = var_4

	var_31_0(var_31_3, var_31_1 == var_4.Submarine)

	return
end

function var_0_1.resetFormationComponent(arg_32_0)
	SetActive = var_1_10001

	local var_32_0 = arg_32_0._gridTFs.main[1]
	local var_32_1 = var_2.Find(var_32_0, "flag")
	local var_32_2 = arg_32_0._currentFleetVO
	local var_32_3 = var_3.getTeamByName

	TeamType = var_1_10005

	var_1_10001(var_32_1, #var_32_3(var_32_2, var_1_10005.Main) ~= 0)

	SetActive = var_1_10001

	local var_32_4 = arg_32_0._gridTFs.submarine[1]
	local var_32_5 = var_2.Find(var_32_4, "flag")
	local var_32_6 = arg_32_0._currentFleetVO
	local var_32_7 = var_3.getTeamByName

	TeamType = var_5

	var_1_10001(var_32_5, #var_32_7(var_32_6, var_5.Submarine) ~= 0)

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

function var_0_1.quickExitFunc(arg_35_0)
	local var_35_0 = arg_35_0._currentForm

	PreCombatLayer = var_1_10002

	if var_35_0 == var_1_10002.FORM_EDIT then
		local var_35_1 = arg_35_0
		local var_35_2 = arg_35_0.emit

		BossSinglePreCombatMediator = var_1_10003

		var_35_2(var_35_1, var_1_10003.ON_ABORT_EDIT)
	end

	var_0_1.super.quickExitFunc(arg_35_0)

	return
end

function var_0_1.didEnter(arg_36_0)
	onButton = var_1_10001

	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0._backBtn

	local function var_36_2()
		local var_37_0 = {}
		local var_37_1 = arg_36_0._currentForm

		PreCombatLayer = var_2_10002

		if var_37_1 == var_2_10002.FORM_EDIT then
			table = var_37_1

			var_37_1.insert(var_37_0, function(arg_38_0)
				pg = var_3_10001

				local var_38_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_38_1 = var_1.ShowMsgBox
				local var_38_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10004
				var_38_2.content = var_3_10004("battle_preCombatLayer_save_confirm")

				function var_38_2.onYes()
					local var_39_0 = arg_36_0
					local var_39_1 = var_0.emit

					BossSinglePreCombatMediator = var_4_10002

					var_39_1(var_39_0, var_4_10002.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_40_0 = var_5_10000.TipsMgr.GetInstance()
						local var_40_1 = var_0.ShowTips

						i18n = var_5_10002

						var_40_1(var_40_0, var_5_10002("battle_preCombatLayer_save_success"))
						arg_38_0()

						return
					end)

					return
				end

				function var_38_2.onNo()
					local var_41_0 = arg_36_0
					local var_41_1 = var_0.emit

					BossSinglePreCombatMediator = var_4_10002

					var_41_1(var_41_0, var_4_10002.ON_ABORT_EDIT)
					arg_38_0()

					return
				end

				var_38_1(var_38_0, var_38_2)

				return
			end)
		end

		seriesAsync = var_37_1

		var_37_1(var_37_0, function()
			GetOrAddComponent = var_3_10000

			local var_42_0 = arg_36_0._tf

			typeof = var_3_10002
			CanvasGroup = var_3_10003
			var_3_10000(var_42_0, var_3_10002(var_3_10003)).interactable = false

			local var_42_1 = arg_36_0

			var_1.uiExitAnimating(var_42_1)

			LeanTween = var_1

			local var_42_2 = var_1.delayedCall
			local var_42_3 = 0.3

			System = var_3_10003

			var_42_2(var_42_3, var_3_10003.Action(function()
				local var_43_0 = arg_36_0

				var_0.closeView(var_43_0)

				return
			end))

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_36_0, var_36_1, var_36_2, var_1_10005)

	onButton = var_1_10001

	local var_36_3 = arg_36_0
	local var_36_4 = arg_36_0._startBtn

	local function var_36_5()
		local var_44_0 = {}
		local var_44_1 = arg_36_0._currentForm

		PreCombatLayer = var_2_10002

		if var_44_1 == var_2_10002.FORM_EDIT then
			table = var_44_1

			var_44_1.insert(var_44_0, function(arg_45_0)
				pg = var_3_10001

				local var_45_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_45_1 = var_1.ShowMsgBox
				local var_45_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10004
				var_45_2.content = var_3_10004("battle_preCombatLayer_save_march")

				function var_45_2.onYes()
					local var_46_0 = arg_36_0
					local var_46_1 = var_0.emit

					BossSinglePreCombatMediator = var_4_10002

					var_46_1(var_46_0, var_4_10002.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_47_0 = var_5_10000.TipsMgr.GetInstance()
						local var_47_1 = var_0.ShowTips

						i18n = var_5_10002

						var_47_1(var_47_0, var_5_10002("battle_preCombatLayer_save_success"))
						arg_45_0()

						return
					end)

					return
				end

				var_45_1(var_45_0, var_45_2)

				return
			end)
		end

		seriesAsync = var_44_1

		var_44_1(var_44_0, function()
			local var_48_0 = arg_36_0
			local var_48_1 = var_0.emit

			BossSinglePreCombatMediator = var_3_10002

			var_48_1(var_48_0, var_3_10002.ON_START, arg_36_0._currentFleetVO.id)

			return
		end)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10005

	var_1_10001(var_36_3, var_36_4, var_36_5, var_1_10005)

	onButton = var_1_10001

	local var_36_6 = arg_36_0
	local var_36_7 = arg_36_0._checkBtn

	local function var_36_8()
		local var_49_0 = arg_36_0._currentForm

		PreCombatLayer = var_2_10001

		local var_49_1

		if var_49_0 == var_2_10001.FORM_EDIT then
			var_49_1 = arg_36_0

			local var_49_2 = var_0.emit

			BossSinglePreCombatMediator = var_2_10002

			var_49_2(var_49_1, var_2_10002.ON_COMMIT_EDIT, function()
				pg = var_3_10000

				local var_50_0 = var_3_10000.TipsMgr.GetInstance()
				local var_50_1 = var_0.ShowTips

				i18n = var_3_10002

				var_50_1(var_50_0, var_3_10002("battle_preCombatLayer_save_success"))

				local var_50_2 = arg_36_0._formationLogic

				var_0.SwitchToPreviewMode(var_50_2)

				return
			end)
		else
			local var_49_3 = arg_36_0._currentForm

			PreCombatLayer = var_49_1

			if var_49_3 == var_49_1.FORM_PREVIEW then
				local var_49_4 = arg_36_0._formationLogic

				var_49_3.SwitchToDisplayMode(var_49_4)
			else
				assert = var_49_3

				var_49_3("currentForm error")
			end
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_36_6, var_36_7, var_36_8, var_1_10005)

	arg_36_0._currentForm = arg_36_0.contextData.form
	arg_36_0.contextData.form = nil

	local var_36_9 = arg_36_0

	arg_36_0.UpdateFleetView(var_36_9, true)

	local var_36_10 = arg_36_0._currentForm

	PreCombatLayer = var_36_9

	if var_36_10 == var_36_9.FORM_EDIT then
		local var_36_11 = arg_36_0._formationLogic

		var_36_10.SwitchToDisplayMode(var_36_11)
	else
		local var_36_12 = arg_36_0._formationLogic

		var_36_10.SwitchToPreviewMode(var_36_12)
	end

	setActive = var_36_10

	var_36_10(arg_36_0._autoToggle, true)

	onToggle = var_36_10

	local var_36_13 = arg_36_0
	local var_36_14 = arg_36_0._autoToggle

	local function var_36_15(arg_51_0)
		local var_51_0 = arg_36_0
		local var_51_1 = var_1.emit

		BossSinglePreCombatMediator = var_2_10003

		var_51_1(var_51_0, var_2_10003.ON_AUTO, {
			isOn = not arg_51_0,
			toggle = arg_36_0._autoToggle
		})

		if arg_51_0 and arg_36_0._subUseable == true then
			setActive = var_51_1

			var_51_1(arg_36_0._autoSubToggle, true)

			onToggle = var_51_1

			local var_51_2 = arg_36_0
			local var_51_3 = arg_36_0._autoSubToggle

			local function var_51_4(arg_52_0)
				local var_52_0 = arg_36_0
				local var_52_1 = var_1.emit

				BossSinglePreCombatMediator = var_3_10003

				var_52_1(var_52_0, var_3_10003.ON_SUB_AUTO, {
					isOn = not arg_52_0,
					toggle = arg_36_0._autoSubToggle
				})

				return
			end

			SFX_PANEL = var_5
			SFX_PANEL = var_2_10006

			var_51_1(var_51_2, var_51_3, var_51_4, var_5, var_2_10006)

			triggerToggle = var_51_1

			local var_51_5 = arg_36_0._autoSubToggle

			ys = var_51_3

			var_51_1(var_51_5, var_51_3.Battle.BattleState.IsAutoSubActive())
		else
			setActive = var_51_1

			var_51_1(arg_36_0._autoSubToggle, false)
		end

		return
	end

	SFX_PANEL = var_1_10005
	SFX_PANEL = var_1_10006

	var_36_10(var_36_13, var_36_14, var_36_15, var_1_10005, var_1_10006)

	triggerToggle = var_36_10

	local var_36_16 = arg_36_0._autoToggle

	ys = var_36_14

	var_36_10(var_36_16, var_36_14.Battle.BattleState.IsAutoBotActive())

	onNextTick = var_36_10

	var_36_10(function()
		local var_53_0 = arg_36_0

		var_0.uiStartAnimating(var_53_0)

		return
	end)

	local var_36_17 = arg_36_0.contextData.stageId

	getProxy = var_2
	ActivityProxy = var_3

	local var_36_18 = var_2(var_3)
	local var_36_19 = var_2.getActivityById(var_36_18, arg_36_0.contextData.actId)
	local var_36_20 = var_2.GetEnemyDataByStageId(var_36_19, var_36_17)
	local var_36_21

	if var_3.IsContinuousType(var_36_20) then
		::label_36_0::

		var_1_10006 = var_2
		var_36_21 = var_2.HasPassStage(var_1_10006, var_36_17)
	end

	setActive = var_1_10006

	var_1_10006(arg_36_0._continuousBtn, var_4)

	setActive = var_1_10006

	local var_36_22 = arg_36_0._continuousBtn

	var_1_10006(var_7.Find(var_36_22, "lock"), not var_36_21)

	if var_36_21 then
		Color = var_1_10006

		if not var_1_10006.white then
			Color = var_1_10006
			var_1_10006 = var_1_10006.New(0.2980392156862745, 0.2980392156862745, 0.2980392156862745)
		end

		setImageColor = var_7

		var_7(arg_36_0._continuousBtn, var_1_10006)

		setTextColor = var_7

		local var_36_23 = arg_36_0._continuousBtn

		var_7(var_8.Find(var_36_23, "text"), var_1_10006)

		setTextColor = var_7

		local var_36_24 = arg_36_0._continuousBtn

		var_7(var_8.Find(var_36_24, "text_en"), var_1_10006)

		onButton = var_7

		local var_36_25 = arg_36_0
		local var_36_26 = arg_36_0._continuousBtn

		local function var_36_27()
			local var_54_1

			if var_36_21 then
				local var_54_0 = arg_36_0

				var_54_1 = var_54_1.emit
				BossSinglePreCombatMediator = var_2_10002

				var_54_1(var_54_0, var_2_10002.SHOW_CONTINUOUS_OPERATION_WINDOW, arg_36_0._currentFleetVO.id)
			else
				pg = var_54_1

				local var_54_2 = var_54_1.TipsMgr.GetInstance()
				local var_54_3 = var_0.ShowTips

				i18n = var_2_10002

				var_54_3(var_54_2, var_2_10002("multiple_sorties_locked_tip"))
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_36_25, var_36_26, var_36_27, var_1_10011)

		return
	end
end

function var_0_1.displayFleetInfo(arg_55_0)
	local var_55_0 = arg_55_0._currentFleetVO
	local var_55_1 = var_1.getFleetType(var_55_0)

	setActive = var_55_0

	local var_55_2 = arg_55_0._vanguardGS.parent

	FleetType = var_1_10004

	var_55_0(var_55_2, var_55_1 == var_1_10004.Normal)

	setActive = var_55_0

	local var_55_3 = arg_55_0._mainGS.parent

	FleetType = var_4

	var_55_0(var_55_3, var_55_1 == var_4.Normal)

	math = var_55_0

	local var_55_4 = var_55_0.floor
	local var_55_5 = arg_55_0._currentFleetVO
	local var_55_6 = var_3.GetGearScoreSum

	TeamType = var_1_10005

	local var_55_7 = var_55_4(var_55_6(var_55_5, var_1_10005.Vanguard))

	math = var_3

	local var_55_8 = var_3.floor
	local var_55_9 = arg_55_0._currentFleetVO
	local var_55_10 = var_4.GetGearScoreSum

	TeamType = var_1_10006

	local var_55_11 = var_55_8(var_55_10(var_55_9, var_1_10006.Main))

	setActive = var_4

	local var_55_12 = arg_55_0._subGS.parent

	FleetType = var_6

	var_4(var_55_12, var_55_1 == var_6.Submarine)

	math = var_4

	local var_55_13 = var_4.floor
	local var_55_14 = arg_55_0._currentFleetVO
	local var_55_15 = var_5.GetGearScoreSum

	TeamType = var_1_10007

	local var_55_16 = var_55_13(var_55_15(var_55_14, var_1_10007.Submarine))
	local var_55_17 = arg_55_0._currentFleetVO
	local var_55_18 = var_5.GetCostSum(var_55_17)
	local var_55_19 = arg_55_0.contextData.system

	pg = var_7

	local var_55_20 = var_7.battle_cost_template[var_55_19].oil_cost == 0 and 0 or var_55_18.oil

	setActive = var_1_10009

	var_1_10009(arg_55_0._costContainer, true)
	var_0_2.tweenNumText(arg_55_0._costText, var_55_20)
	var_0_2.tweenNumText(arg_55_0._vanguardGS, var_55_7)
	var_0_2.tweenNumText(arg_55_0._mainGS, var_55_11)
	var_0_2.tweenNumText(arg_55_0._subGS, var_55_16)

	getProxy = var_9
	ActivityProxy = var_10

	local var_55_21 = var_9(var_10)
	local var_55_22 = var_9.getActivityById(var_55_21, arg_55_0.contextData.actId)
	local var_55_23 = var_9.getConfig(var_55_22, "type")

	ActivityConst = var_55_22

	if var_55_23 == var_55_22.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
		Fleet = var_55_23

		if not var_55_23.DEFAULT_NAME_BOSS_SINGLE_VARIABLE_ACT then
			Fleet = var_55_23
			var_55_23 = var_55_23.DEFAULT_NAME_BOSS_SINGLE_ACT
		end

		setText = var_11

		var_11(arg_55_0._fleetNameText, var_55_23[arg_55_0._currentFleetVO.id])

		setText = var_11

		var_11(arg_55_0._fleetNumText, arg_55_0._currentFleetVO.id)

		local var_55_24 = arg_55_0.contextData.stageId

		pg = var_12

		local var_55_25 = var_12.battle_cost_template[var_55_19].oil_cost > 0
		local var_55_26 = 0
		local var_55_27 = 0
		local var_55_28 = false

		ipairs = var_1_10017

		for iter_55_0, iter_55_1 in var_1_10017({
			arg_55_0.contextData.fleets[1]
		}) do
			local var_55_29 = iter_55_1:GetCostSum().oil

			if not var_55_25 then
				var_55_29 = 0
			end

			var_55_27 = var_55_27 + var_55_29

			local var_55_30 = iter_55_0 == 1
			local var_55_31 = arg_55_0.contextData.costLimit[var_55_30 and 1 or 2]

			if 0 < var_55_31 then
				var_55_28 = var_55_28 or var_55_31 < var_55_29
				math = var_25
				var_55_29 = var_25.min(var_55_29, var_55_31)
			end

			var_55_26 = var_55_26 + var_55_29
		end

		setTextColor = var_17

		local var_55_32 = arg_55_0._costText

		if var_55_28 then
			Color = var_55_33

			local var_55_33

			if not var_55_33(0.9803921568627451, 0.39215686274509803, 0.39215686274509803) then
				Color = var_55_33
				var_55_33 = var_55_33.white
			end

			var_17(var_55_32, var_55_33)
			var_0_2.tweenNumText(arg_55_0._costText, var_55_26)

			setActive = var_17

			var_17(arg_55_0._costTip, var_55_28)

			if var_55_28 then
				onButton = var_17

				var_17(arg_55_0, arg_55_0._costTip, function()
					pg = var_2_10000

					local var_56_0 = var_2_10000.MsgboxMgr.GetInstance()
					local var_56_1 = var_0.ShowMsgBox
					local var_56_2 = {
						hideNo = true
					}

					i18n = var_2_10003
					var_56_2.content = var_2_10003("use_oil_limit_help", var_55_27, var_55_26)

					var_56_1(var_56_0, var_56_2)

					return
				end)
			end

			return
		end
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
