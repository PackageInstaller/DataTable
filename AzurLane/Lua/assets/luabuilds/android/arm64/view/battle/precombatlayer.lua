class = var_0_10000

local var_0_0 = "PreCombatLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

import = var_0_10001

local var_0_2 = var_0_10001("..ship.FormationUI")
local var_0_3 = {
	[99] = true
}

var_0_1.FORM_EDIT = "EDIT"
var_0_1.FORM_PREVIEW = "PREVIEW"
var_0_1.ObjectiveList = {
	"battle_preCombatLayer_victory",
	"battle_preCombatLayer_undefeated",
	"battle_preCombatLayer_sink_limit",
	"battle_preCombatLayer_time_hold",
	"battle_preCombatLayer_time_limit",
	"battle_preCombatLayer_boss_destruct",
	"battle_preCombatLayer_damage_before_end",
	"battle_result_defeat_all_enemys",
	"battle_preCombatLayer_destory_transport_ship"
}

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

function var_0_1.init(arg_3_0)
	arg_3_0:CommonInit()

	BaseFormation = var_1
	arg_3_0._formationLogic = var_1.New(arg_3_0._tf, arg_3_0._heroContainer, arg_3_0._heroInfo, arg_3_0._gridTFs)

	arg_3_0:Register()

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

	local var_4_9 = arg_4_0._fleetInfo
	local var_4_10 = arg_4_0.contextData.system

	SYSTEM_DUEL = var_1_10006

	var_2(var_4_9, var_4_10 ~= var_1_10006)

	arg_4_0._mainGS = var_4_6:Find("gear_score/main/Text")
	arg_4_0._vanguardGS = var_4_6:Find("gear_score/vanguard/Text")
	arg_4_0._subGS = var_4_6:Find("gear_score/submarine/Text")
	arg_4_0._bgFleet = var_4_6:Find("mask/grid_bg")
	arg_4_0._bgSub = var_4_6:Find("mask/bg_sub")

	local var_4_11 = {}

	TeamType = var_4_5
	var_4_11[var_4_5.Vanguard] = {}
	TeamType = var_3
	var_4_11[var_3.Main] = {}
	TeamType = var_3
	var_4_11[var_3.Submarine] = {}
	arg_4_0._gridTFs = var_4_11
	arg_4_0._gridFrame = var_4_6:Find("mask/GridFrame")

	for iter_4_0 = 1, 3 do
		local var_4_12 = arg_4_0._gridTFs

		TeamType = var_1_10007

		local var_4_13 = var_4_12[var_1_10007.Main]
		local var_4_14 = arg_4_0._gridFrame

		var_4_13[iter_4_0] = var_1_10007.Find(var_4_14, "main_" .. iter_4_0)

		local var_4_15 = arg_4_0._gridTFs

		TeamType = var_1_10007

		local var_4_16 = var_4_15[var_1_10007.Vanguard]
		local var_4_17 = arg_4_0._gridFrame

		var_4_16[iter_4_0] = var_1_10007.Find(var_4_17, "vanguard_" .. iter_4_0)

		local var_4_18 = arg_4_0._gridTFs

		TeamType = var_1_10007

		local var_4_19 = var_4_18[var_1_10007.Submarine]
		local var_4_20 = arg_4_0._gridFrame

		var_4_19[iter_4_0] = var_1_10007.Find(var_4_20, "submarine_" .. iter_4_0)
	end

	local var_4_21 = arg_4_0.rtAdapt

	arg_4_0._nextPage = var_2.Find(var_4_21, "middle/nextPage")

	local var_4_22 = arg_4_0.rtAdapt

	arg_4_0._prevPage = var_2.Find(var_4_22, "middle/prevPage")
	arg_4_0._heroContainer = var_4_6:Find("HeroContainer")
	arg_4_0._checkBtn = var_4_6:Find("checkBtn")

	local var_4_23 = arg_4_0._tf

	arg_4_0._blurPanel = var_2.Find(var_4_23, "blur_panel")

	local var_4_24 = arg_4_0._blurPanel

	arg_4_0.topPanel = var_2.Find(var_4_24, "top")

	local var_4_25 = arg_4_0._blurPanel

	arg_4_0.topPanelBg = var_2.Find(var_4_25, "top_bg")

	local var_4_26 = arg_4_0.topPanel

	arg_4_0._backBtn = var_2.Find(var_4_26, "back_btn")

	local var_4_27 = arg_4_0.rtAdapt

	arg_4_0._spoilsContainer = var_2.Find(var_4_27, "right/infomation/atlasloot/spoils/items/items_container")

	local var_4_28 = arg_4_0.rtAdapt

	arg_4_0._item = var_2.Find(var_4_28, "right/infomation/atlasloot/spoils/items/item_tpl")
	SetActive = var_2

	var_2(arg_4_0._item, false)

	local var_4_29 = arg_4_0.rtAdapt

	arg_4_0._goals = var_2.Find(var_4_29, "right/infomation/target/goal")
	arg_4_0._heroInfo = arg_4_0:getTpl("heroInfo")
	arg_4_0._starTpl = arg_4_0:getTpl("star_tpl")
	setText = var_2

	local var_4_30 = arg_4_0.rtAdapt
	local var_4_31 = var_4.Find(var_4_30, "middle/gear_score/vanguard/line/Image/Text1")

	i18n = var_5

	var_2(var_4_31, var_5("pre_combat_vanguard"))

	setText = var_2

	local var_4_32 = arg_4_0.rtAdapt
	local var_4_33 = var_4.Find(var_4_32, "middle/gear_score/main/line/Image/Text1")

	i18n = var_5

	var_2(var_4_33, var_5("pre_combat_main"))

	setText = var_2

	local var_4_34 = arg_4_0.rtAdapt
	local var_4_35 = var_4.Find(var_4_34, "middle/gear_score/submarine/line/Image/text1")

	i18n = var_5

	var_2(var_4_35, var_5("pre_combat_submarine"))

	setText = var_2

	local var_4_36 = arg_4_0._costContainer
	local var_4_37 = var_4.Find(var_4_36, "title")

	i18n = var_5

	var_2(var_4_37, var_5("pre_combat_consume"))

	setText = var_2

	local var_4_38 = arg_4_0.rtAdapt
	local var_4_39 = var_4.Find(var_4_38, "right/infomation/target/title/GameObject")

	i18n = var_5

	var_2(var_4_39, var_5("pre_combat_targets"))

	setText = var_2

	local var_4_40 = arg_4_0.rtAdapt
	local var_4_41 = var_4.Find(var_4_40, "right/infomation/atlasloot/atlasloot/title/GameObject")

	i18n = var_5

	var_2(var_4_41, var_5("pre_combat_atlasloot"))

	setText = var_2

	local var_4_42 = arg_4_0._startBtn
	local var_4_43 = var_4.Find(var_4_42, "text")

	i18n = var_5

	var_2(var_4_43, var_5("pre_combat_start"))

	setText = var_2

	local var_4_44 = arg_4_0._startBtn
	local var_4_45 = var_4.Find(var_4_44, "text_en")

	i18n = var_5

	var_2(var_4_45, var_5("pre_combat_start_en"))

	local var_4_46 = arg_4_0.rtAdapt

	arg_4_0._middle = var_2.Find(var_4_46, "middle")

	local var_4_47 = arg_4_0.rtAdapt

	arg_4_0._right = var_2.Find(var_4_47, "right")
	setAnchoredPosition = var_2

	var_2(arg_4_0._middle, {
		x = -840
	})

	setAnchoredPosition = var_2

	var_2(arg_4_0._right, {
		x = 470
	})

	local var_4_48 = arg_4_0._middle

	arg_4_0.guideDesc = var_2.Find(var_4_48, "guideDesc")

	if arg_4_0.contextData.stageId then
		arg_4_0:SetStageID(arg_4_0.contextData.stageId)
	end

	return
end

function var_0_1.Register(arg_5_0)
	local var_5_0 = arg_5_0._formationLogic

	var_1.AddLoadComplete(var_5_0, function()
		if arg_5_0._currentForm ~= var_0_1.FORM_EDIT then
			local var_6_0 = arg_5_0._formationLogic

			var_0.SwitchToPreviewMode(var_6_0)
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

		local var_7_0 = arg_7_0:Find("info")
		local var_7_1 = var_2.Find(var_7_0, "stars")
		local var_7_2 = arg_7_1.energy

		Ship = var_7_0

		local var_7_3 = var_7_2 <= var_7_0.ENERGY_MID
		local var_7_4 = var_2
		local var_7_5 = var_2.Find(var_7_4, "energy")
		local var_7_6

		if var_7_3 then
			var_7_6 = arg_7_1

			local var_7_7

			var_7_7, var_7_4 = arg_7_1.getEnergyPrint(var_7_6)
			GetSpriteFromAtlas = var_7_6

			if not var_7_6("energy", var_7_7) then
				warning = var_2_10009

				var_2_10009("找不到疲劳")
			end

			setImageSprite = var_2_10009

			var_2_10009(var_7_5, var_7_6)
		end

		local var_7_8 = arg_5_0.contextData.system

		pg = var_7_4

		local var_7_9 = var_7_4.battle_cost_template[var_7_8]

		setActive = var_7_6

		var_7_6(var_7_5, var_7_3 and var_7_9.enter_energy_cost > 0)

		local var_7_10 = arg_7_1:getStar()

		for iter_7_0 = 1, var_7_10 do
			cloneTplTo = var_2_10013

			var_2_10013(arg_5_0._starTpl, var_7_1)
		end

		GetSpriteFromAtlas = var_9

		local var_7_11 = "shiptype"

		shipType2print = iter_7_0

		if not var_9(var_7_11, iter_7_0(arg_7_1:getShipType())) then
			warning = var_10

			var_10("找不到船形, shipConfigId: " .. arg_7_1.configId)
		end

		setImageSprite = var_10

		var_10(var_2:Find("type"), var_9, true)

		setText = var_10

		var_10(var_2:Find("frame/lv_contain/lv"), arg_7_1.level)

		local var_7_12 = var_7_9.ship_exp_award
		local var_7_14

		if 0 < var_7_12 then
			getProxy = var_7_12
			ActivityProxy = var_12

			local var_7_13 = var_7_12(var_12)

			var_7_14 = var_10.getBuffShipList(var_7_13)

			local var_7_15 = arg_7_1
			local var_7_16 = var_7_14[arg_7_1.getGroupId(var_7_15)]
			local var_7_17 = var_2:Find("expbuff")

			setActive = var_7_15

			var_7_15(var_7_17, var_7_16 ~= nil)

			if var_7_16 then
				local var_7_18 = var_7_16 / 100
				local var_7_19 = var_7_16 % 100

				tostring = var_16

				local var_7_20 = var_16(var_7_18)
				local var_7_21

				if 0 < var_7_19 then
					var_7_21 = var_7_20

					local var_7_22 = "."

					tostring = var_2_10019
					var_7_20 = var_7_21 .. var_7_22 .. var_2_10019(var_7_19)
				end

				setText = var_7_21

				local var_7_23 = var_7_17:Find("text")

				string = var_2_10020

				var_7_21(var_7_23, var_2_10020.format("EXP +%s%%", var_7_20))
			end
		else
			local var_7_24 = var_2:Find("expbuff")

			setActive = var_7_14

			var_7_14(var_7_24, false)
		end

		return
	end)

	local var_5_2 = arg_5_0._formationLogic

	var_1.AddLongPress(var_5_2, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_5_0
		local var_8_1 = var_4.emit

		PreCombatMediator = var_2_10007

		var_8_1(var_8_0, var_2_10007.OPEN_SHIP_INFO, arg_8_1.id, arg_8_2)

		return
	end)

	local var_5_3 = arg_5_0._formationLogic

	var_1.AddBeginDrag(var_5_3, function(arg_9_0)
		local var_9_0 = arg_9_0:Find("info")

		SetActive = var_2_10002

		var_2_10002(var_9_0, false)

		return
	end)

	local var_5_4 = arg_5_0._formationLogic

	var_1.AddEndDrag(var_5_4, function(arg_10_0)
		local var_10_0 = arg_10_0:Find("info")

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

		PreCombatMediator = var_2_10006

		var_11_3(var_11_2, var_2_10006.CHANGE_FLEET_SHIP, arg_11_0, arg_11_2, arg_11_1)

		return
	end)

	local var_5_6 = arg_5_0._formationLogic

	var_1.AddShiftOnly(var_5_6, function(arg_12_0)
		local var_12_0 = arg_5_0
		local var_12_1 = var_1.emit

		PreCombatMediator = var_2_10004

		var_12_1(var_12_0, var_2_10004.CHANGE_FLEET_SHIPS_ORDER, arg_12_0)

		return
	end)

	local var_5_7 = arg_5_0._formationLogic

	var_1.AddRemoveShip(var_5_7, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_5_0
		local var_13_1 = var_2.emit

		PreCombatMediator = var_2_10005

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
		arg_5_0._currentForm = var_0_1.FORM_EDIT

		local var_15_0 = arg_5_0._checkBtn

		var_0.GetComponent(var_15_0, "Button").interactable = true

		local var_15_1 = arg_5_0

		var_0.SetFleetStepper(var_15_1)

		setActive = var_0

		local var_15_2 = arg_5_0._checkBtn

		var_0(var_2.Find(var_15_2, "save"), true)

		setActive = var_0

		local var_15_3 = arg_5_0._checkBtn

		var_0(var_2.Find(var_15_3, "edit"), false)

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
		arg_5_0._currentForm = var_0_1.FORM_PREVIEW

		local var_17_0 = arg_5_0._checkBtn

		var_0.GetComponent(var_17_0, "Button").interactable = true

		local var_17_1 = arg_5_0

		var_0.SetFleetStepper(var_17_1)

		setActive = var_0

		local var_17_2 = arg_5_0._checkBtn

		var_0(var_2.Find(var_17_2, "save"), false)

		setActive = var_0

		local var_17_3 = arg_5_0._checkBtn

		var_0(var_2.Find(var_17_3, "edit"), true)

		return
	end)

	local var_5_12 = arg_5_0._formationLogic

	var_1.AddGridTipClick(var_5_12, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_5_0
		local var_18_1 = var_2.emit

		PreCombatMediator = var_2_10005

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

	if var_4(var_1_10006.expedition_activity_template[arg_22_1], {
		"pt_drop_display"
	}) then
		type = var_5

		if var_5(var_4) == "table" then
			getProxy = var_5
			ActivityProxy = var_7

			local var_22_2 = var_5(var_7)

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
			var_1_10014 = arg_22_0

			local var_22_8 = var_1_10010

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

			SFX_PANEL = var_1_10017

			var_12(var_1_10014, var_22_8, var_22_9, var_1_10017)
		end
	end

	local function var_22_10(arg_24_0, arg_24_1)
		type = var_2_10002

		local var_24_0

		if var_2_10002(arg_24_0) == "table" then
			setActive = var_24_0

			var_24_0(arg_24_1, true)

			i18n = var_24_0
			var_24_0 = var_24_0(var_0_1.ObjectiveList[arg_24_0[1]], arg_24_0[2])
			setWidgetText = var_2_10003

			var_2_10003(arg_24_1, var_24_0)
		else
			setActive = var_24_0

			var_24_0(arg_24_1, false)
		end

		return
	end

	local var_22_11 = {}
	local var_22_12 = arg_22_0._goals

	var_22_11[1] = var_7.Find(var_22_12, "goal_tpl")

	local var_22_13 = arg_22_0._goals

	var_22_11[2] = var_7.Find(var_22_13, "goal_sink")

	local var_22_14 = arg_22_0._goals

	var_22_11[3] = var_7.Find(var_22_14, "goal_time")

	local var_22_15 = {
		var_22_0.objective_1,
		var_22_0.objective_2,
		var_22_0.objective_3
	}
	local var_22_16 = 1

	ipairs = var_22_14

	for iter_22_3, iter_22_4 in var_22_14(var_22_15) do
		type = var_1_10014

		if var_1_10014(iter_22_4) ~= "string" then
			var_22_10(iter_22_4, var_22_11[var_22_16])

			var_22_16 = var_22_16 + 1
		end
	end

	for iter_22_5 = var_22_16, #var_22_11 do
		var_22_10("", var_22_11[iter_22_5])
	end

	local var_22_18

	if var_22_0.guide_desc then
		local var_22_17 = #var_22_0.guide_desc

		var_22_18 = 0 < var_22_17
	end

	setActive = var_10

	var_10(arg_22_0.guideDesc, var_22_18)

	if var_22_18 then
		setText = var_10

		var_10(arg_22_0.guideDesc, var_22_0.guide_desc)
	end

	return
end

function var_0_1.SetFleets(arg_25_0, arg_25_1)
	_ = var_1_10002

	local var_25_0 = var_1_10002.filter

	_ = var_1_10004

	local var_25_1 = var_25_0(var_1_10004.values(arg_25_1), function(arg_26_0)
		local var_26_0 = arg_26_0:getFleetType()

		FleetType = var_2_10002

		return var_26_0 == var_2_10002.Normal
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

	TeamType = var_1_10005

	var_30_2(var_30_1, var_1_10005.Vanguard, arg_30_0._currentForm ~= var_0_1.FORM_EDIT)

	local var_30_3 = arg_30_0._formationLogic
	local var_30_4 = var_2.ResetGrid

	TeamType = var_5

	var_30_4(var_30_3, var_5.Main, arg_30_0._currentForm ~= var_0_1.FORM_EDIT)

	local var_30_5 = arg_30_0._formationLogic
	local var_30_6 = var_2.ResetGrid

	TeamType = var_5

	var_30_6(var_30_5, var_5.Submarine, arg_30_0._currentForm ~= var_0_1.FORM_EDIT)
	arg_30_0:resetFormationComponent()

	if arg_30_1 then
		local var_30_7 = arg_30_0._formationLogic

		var_2.LoadAllCharacter(var_30_7)
	else
		local var_30_8 = arg_30_0._formationLogic

		var_2.SetAllCharacterPos(var_30_8)
	end

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

function var_0_1.quickExitFunc(arg_35_0)
	if arg_35_0._currentForm == var_0_1.FORM_EDIT then
		local var_35_0 = arg_35_0
		local var_35_1 = arg_35_0.emit

		PreCombatMediator = var_1_10004

		var_35_1(var_35_0, var_1_10004.ON_ABORT_EDIT)
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

		if arg_36_0._currentForm == var_0_1.FORM_EDIT then
			table = var_1

			var_1.insert(var_37_0, function(arg_38_0)
				pg = var_3_10001

				local var_38_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_38_1 = var_1.ShowMsgBox
				local var_38_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10005
				var_38_2.content = var_3_10005("battle_preCombatLayer_save_confirm")

				function var_38_2.onYes()
					local var_39_0 = arg_36_0
					local var_39_1 = var_0.emit

					PreCombatMediator = var_4_10003

					var_39_1(var_39_0, var_4_10003.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_40_0 = var_5_10000.TipsMgr.GetInstance()
						local var_40_1 = var_0.ShowTips

						i18n = var_5_10003

						var_40_1(var_40_0, var_5_10003("battle_preCombatLayer_save_success"))
						arg_38_0()

						return
					end)

					return
				end

				function var_38_2.onNo()
					local var_41_0 = arg_36_0
					local var_41_1 = var_0.emit

					PreCombatMediator = var_4_10003

					var_41_1(var_41_0, var_4_10003.ON_ABORT_EDIT)
					arg_38_0()

					return
				end

				var_38_1(var_38_0, var_38_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_37_0, function()
			GetOrAddComponent = var_3_10000

			local var_42_0 = arg_36_0._tf

			typeof = var_3_10003
			CanvasGroup = var_3_10005
			var_3_10000(var_42_0, var_3_10003(var_3_10005)).interactable = false

			local var_42_1 = arg_36_0

			var_1.uiExitAnimating(var_42_1)

			LeanTween = var_1

			local var_42_2 = var_1.delayedCall
			local var_42_3 = 0.3

			System = var_3_10004

			var_42_2(var_42_3, var_3_10004.Action(function()
				local var_43_0 = arg_36_0

				var_0.emit(var_43_0, var_0_1.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_36_0, var_36_1, var_36_2, var_1_10006)

	onButton = var_1_10001

	local var_36_3 = arg_36_0
	local var_36_4 = arg_36_0._startBtn

	local function var_36_5()
		local var_44_0 = {}

		if arg_36_0._currentForm == var_0_1.FORM_EDIT then
			table = var_1

			var_1.insert(var_44_0, function(arg_45_0)
				pg = var_3_10001

				local var_45_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_45_1 = var_1.ShowMsgBox
				local var_45_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10005
				var_45_2.content = var_3_10005("battle_preCombatLayer_save_march")

				function var_45_2.onYes()
					local var_46_0 = arg_36_0
					local var_46_1 = var_0.emit

					PreCombatMediator = var_4_10003

					var_46_1(var_46_0, var_4_10003.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_47_0 = var_5_10000.TipsMgr.GetInstance()
						local var_47_1 = var_0.ShowTips

						i18n = var_5_10003

						var_47_1(var_47_0, var_5_10003("battle_preCombatLayer_save_success"))
						arg_45_0()

						return
					end)

					return
				end

				var_45_1(var_45_0, var_45_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_44_0, function()
			local var_48_0 = arg_36_0
			local var_48_1 = var_0.emit

			PreCombatMediator = var_3_10003

			var_48_1(var_48_0, var_3_10003.ON_START, arg_36_0._currentFleetVO.id)

			return
		end)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10006

	var_1_10001(var_36_3, var_36_4, var_36_5, var_1_10006)

	onButton = var_1_10001

	local var_36_6 = arg_36_0
	local var_36_7 = arg_36_0._nextPage

	local function var_36_8()
		local var_49_0 = arg_36_0
		local var_49_1 = var_0.emit

		PreCombatMediator = var_2_10003

		var_49_1(var_49_0, var_2_10003.ON_CHANGE_FLEET, arg_36_0._legalFleetIdList[arg_36_0._curFleetIndex + 1])

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_36_6, var_36_7, var_36_8, var_1_10006)

	onButton = var_1_10001

	local var_36_9 = arg_36_0
	local var_36_10 = arg_36_0._prevPage

	local function var_36_11()
		local var_50_0 = arg_36_0
		local var_50_1 = var_0.emit

		PreCombatMediator = var_2_10003

		var_50_1(var_50_0, var_2_10003.ON_CHANGE_FLEET, arg_36_0._legalFleetIdList[arg_36_0._curFleetIndex - 1])

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_36_9, var_36_10, var_36_11, var_1_10006)

	onButton = var_1_10001

	local var_36_12 = arg_36_0
	local var_36_13 = arg_36_0._checkBtn

	local function var_36_14()
		if arg_36_0._currentForm == var_0_1.FORM_EDIT then
			local var_51_0 = arg_36_0
			local var_51_1 = var_0.emit

			PreCombatMediator = var_2_10003

			var_51_1(var_51_0, var_2_10003.ON_COMMIT_EDIT, function()
				pg = var_3_10000

				local var_52_0 = var_3_10000.TipsMgr.GetInstance()
				local var_52_1 = var_0.ShowTips

				i18n = var_3_10003

				var_52_1(var_52_0, var_3_10003("battle_preCombatLayer_save_success"))

				local var_52_2 = arg_36_0._formationLogic

				var_0.SwitchToPreviewMode(var_52_2)

				return
			end)
		elseif arg_36_0._currentForm == var_0_1.FORM_PREVIEW then
			local var_51_2 = arg_36_0._formationLogic

			var_0.SwitchToDisplayMode(var_51_2)
		else
			assert = var_0

			var_0("currentForm error")
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_36_12, var_36_13, var_36_14, var_1_10006)

	arg_36_0._currentForm = arg_36_0.contextData.form
	arg_36_0.contextData.form = nil

	arg_36_0:UpdateFleetView(true)

	if arg_36_0._currentForm == var_0_1.FORM_EDIT then
		local var_36_15 = arg_36_0._formationLogic

		var_1.SwitchToDisplayMode(var_36_15)
	else
		local var_36_16 = arg_36_0._formationLogic

		var_1.SwitchToPreviewMode(var_36_16)
	end

	pg = var_1

	local var_36_17 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_36_17, arg_36_0._tf)

	setActive = var_1

	var_1(arg_36_0._autoToggle, true)

	onToggle = var_1

	local var_36_18 = arg_36_0
	local var_36_19 = arg_36_0._autoToggle

	local function var_36_20(arg_53_0)
		local var_53_0 = arg_36_0
		local var_53_1 = var_1.emit

		PreCombatMediator = var_2_10004

		var_53_1(var_53_0, var_2_10004.ON_AUTO, {
			isOn = not arg_53_0,
			toggle = arg_36_0._autoToggle
		})

		if arg_53_0 and arg_36_0._subUseable == true then
			setActive = var_53_1

			var_53_1(arg_36_0._autoSubToggle, true)

			onToggle = var_53_1

			local var_53_2 = arg_36_0
			local var_53_3 = arg_36_0._autoSubToggle

			local function var_53_4(arg_54_0)
				local var_54_0 = arg_36_0
				local var_54_1 = var_1.emit

				PreCombatMediator = var_3_10004

				var_54_1(var_54_0, var_3_10004.ON_SUB_AUTO, {
					isOn = not arg_54_0,
					toggle = arg_36_0._autoSubToggle
				})

				return
			end

			SFX_PANEL = var_6
			SFX_PANEL = var_2_10007

			var_53_1(var_53_2, var_53_3, var_53_4, var_6, var_2_10007)

			triggerToggle = var_53_1

			local var_53_5 = arg_36_0._autoSubToggle

			ys = var_53_3

			var_53_1(var_53_5, var_53_3.Battle.BattleState.IsAutoSubActive())
		else
			setActive = var_53_1

			var_53_1(arg_36_0._autoSubToggle, false)
		end

		return
	end

	SFX_PANEL = var_1_10006
	SFX_PANEL = var_1_10007

	var_1(var_36_18, var_36_19, var_36_20, var_1_10006, var_1_10007)

	triggerToggle = var_1

	local var_36_21 = arg_36_0._autoToggle

	ys = var_36_19

	var_1(var_36_21, var_36_19.Battle.BattleState.IsAutoBotActive())

	onNextTick = var_1

	var_1(function()
		local var_55_0 = arg_36_0

		var_0.uiStartAnimating(var_55_0)

		return
	end)

	return
end

function var_0_1.displayFleetInfo(arg_56_0)
	local var_56_0 = arg_56_0._currentFleetVO
	local var_56_1 = var_1.getFleetType(var_56_0)

	setActive = var_1_10002

	local var_56_2 = arg_56_0._vanguardGS.parent

	FleetType = var_1_10005

	var_1_10002(var_56_2, var_56_1 == var_1_10005.Normal)

	setActive = var_1_10002

	local var_56_3 = arg_56_0._mainGS.parent

	FleetType = var_5

	var_1_10002(var_56_3, var_56_1 == var_5.Normal)

	math = var_1_10002

	local var_56_4 = var_1_10002.floor
	local var_56_5 = arg_56_0._currentFleetVO
	local var_56_6 = var_4.GetGearScoreSum

	TeamType = var_1_10007

	local var_56_7 = var_56_4(var_56_6(var_56_5, var_1_10007.Vanguard))

	math = var_56_0

	local var_56_8 = var_56_0.floor
	local var_56_9 = arg_56_0._currentFleetVO
	local var_56_10 = var_5.GetGearScoreSum

	TeamType = var_1_10008

	local var_56_11 = var_56_8(var_56_10(var_56_9, var_1_10008.Main))

	setActive = var_4

	local var_56_12 = arg_56_0._subGS.parent

	FleetType = var_56_9

	var_4(var_56_12, var_56_1 == var_56_9.Submarine)

	math = var_4

	local var_56_13 = var_4.floor
	local var_56_14 = arg_56_0._currentFleetVO
	local var_56_15 = var_6.GetGearScoreSum

	TeamType = var_1_10009

	local var_56_16 = var_56_13(var_56_15(var_56_14, var_1_10009.Submarine))
	local var_56_17 = arg_56_0._currentFleetVO
	local var_56_18 = var_5.GetCostSum(var_56_17)
	local var_56_19 = arg_56_0.contextData.system

	pg = var_56_17

	local var_56_20 = var_56_17.battle_cost_template[var_56_19].oil_cost == 0 and 0 or var_56_18.oil

	setActive = var_9

	local var_56_21 = arg_56_0._costContainer

	SYSTEM_DUEL = var_1_10012

	var_9(var_56_21, var_56_19 ~= var_1_10012)
	var_0_2.tweenNumText(arg_56_0._costText, var_56_20)
	var_0_2.tweenNumText(arg_56_0._vanguardGS, var_56_7)
	var_0_2.tweenNumText(arg_56_0._mainGS, var_56_11)
	var_0_2.tweenNumText(arg_56_0._subGS, var_56_16)

	setText = var_9

	var_9(arg_56_0._fleetNameText, var_0_2.defaultFleetName(arg_56_0._currentFleetVO))

	setText = var_9

	var_9(arg_56_0._fleetNumText, arg_56_0._currentFleetVO.id)

	return
end

function var_0_1.SetFleetStepper(arg_57_0)
	local var_57_0 = arg_57_0.contextData.system

	SYSTEM_DUEL = var_1_10002

	if var_57_0 == var_1_10002 or arg_57_0._currentForm == var_0_1.FORM_EDIT then
		SetActive = var_1_10002

		var_1_10002(arg_57_0._nextPage, false)

		SetActive = var_1_10002

		var_1_10002(arg_57_0._prevPage, false)
	else
		SetActive = var_1_10002

		var_1_10002(arg_57_0._nextPage, arg_57_0._curFleetIndex < #arg_57_0._legalFleetIdList)

		SetActive = var_1_10002

		var_1_10002(arg_57_0._prevPage, arg_57_0._curFleetIndex > 1)
	end

	return
end

function var_0_1.onBackPressed(arg_58_0)
	pg = var_1_10001

	local var_58_0 = var_1_10001.CriMgr.GetInstance()
	local var_58_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_58_1(var_58_0, var_1_10004)

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
