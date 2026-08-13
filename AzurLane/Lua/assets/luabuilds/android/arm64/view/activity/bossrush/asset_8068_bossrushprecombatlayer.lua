class = var_0_10000

local var_0_0 = "BossRushPreCombatLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

import = var_0_10001

local var_0_2 = var_0_10001("view.ship.FormationUI")
local var_0_3 = {
	[99] = true
}

function var_0_1.getUIName(arg_1_0)
	return "BossRushPreCombatUI"
end

function var_0_1.ResUISettings(arg_2_0)
	return true
end

function var_0_1.tempCache(arg_3_0)
	return true
end

function var_0_1.init(arg_4_0)
	arg_4_0:CommonInit()

	BaseFormation = var_1
	arg_4_0._formationLogic = var_1.New(arg_4_0._tf, arg_4_0._heroContainer, arg_4_0._heroInfo, arg_4_0._gridTFs)

	arg_4_0:Register()

	return
end

function var_0_1.CommonInit(arg_5_0)
	arg_5_0.eventTriggers = {}

	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_1.Find(var_5_0, "adapt")

	arg_5_0._startBtn = var_1.Find(var_5_1, "right/start")
	arg_5_0._costContainer = var_1:Find("right/start/cost_container")

	local var_5_2 = arg_5_0._costContainer

	arg_5_0._popup = var_2.Find(var_5_2, "popup")

	local var_5_3 = arg_5_0._popup

	arg_5_0._costText = var_2.Find(var_5_3, "Text")
	arg_5_0._moveLayer = var_1:Find("moveLayer")

	local var_5_4 = var_1
	local var_5_5 = var_1.Find(var_5_4, "middle")

	arg_5_0._autoToggle = var_1:Find("auto_toggle")
	arg_5_0._autoSubToggle = var_1:Find("sub_toggle_container/sub_toggle")
	arg_5_0._fleetInfo = var_5_5:Find("fleet_info")
	arg_5_0._fleetNameText = var_5_5:Find("fleet_info/fleet_name/Text")
	arg_5_0._fleetNumText = var_5_5:Find("fleet_info/fleet_number")
	setActive = var_3

	local var_5_6 = arg_5_0._fleetInfo
	local var_5_7 = arg_5_0.contextData.system

	SYSTEM_DUEL = var_1_10007

	var_3(var_5_6, var_5_7 ~= var_1_10007)

	arg_5_0._mainGS = var_5_5:Find("gear_score/main/Text")
	arg_5_0._vanguardGS = var_5_5:Find("gear_score/vanguard/Text")
	arg_5_0._subGS = var_5_5:Find("gear_score/submarine/Text")
	arg_5_0._bgFleet = var_5_5:Find("mask/grid_bg")
	arg_5_0._bgSub = var_5_5:Find("mask/bg_sub")

	local var_5_8 = {}

	TeamType = var_5_4
	var_5_8[var_5_4.Vanguard] = {}
	TeamType = var_4
	var_5_8[var_4.Main] = {}
	TeamType = var_4
	var_5_8[var_4.Submarine] = {}
	arg_5_0._gridTFs = var_5_8
	arg_5_0._gridFrame = var_5_5:Find("mask/GridFrame")

	for iter_5_0 = 1, 3 do
		local var_5_9 = arg_5_0._gridTFs

		TeamType = var_1_10008

		local var_5_10 = var_5_9[var_1_10008.Main]
		local var_5_11 = arg_5_0._gridFrame

		var_5_10[iter_5_0] = var_1_10008.Find(var_5_11, "main_" .. iter_5_0)

		local var_5_12 = arg_5_0._gridTFs

		TeamType = var_1_10008

		local var_5_13 = var_5_12[var_1_10008.Vanguard]
		local var_5_14 = arg_5_0._gridFrame

		var_5_13[iter_5_0] = var_1_10008.Find(var_5_14, "vanguard_" .. iter_5_0)

		local var_5_15 = arg_5_0._gridTFs

		TeamType = var_1_10008

		local var_5_16 = var_5_15[var_1_10008.Submarine]
		local var_5_17 = arg_5_0._gridFrame

		var_5_16[iter_5_0] = var_1_10008.Find(var_5_17, "submarine_" .. iter_5_0)
	end

	arg_5_0._nextPage = var_1:Find("middle/nextPage")
	arg_5_0._prevPage = var_1:Find("middle/prevPage")
	arg_5_0._heroContainer = var_5_5:Find("HeroContainer")
	arg_5_0._checkBtn = var_5_5:Find("checkBtn")

	local var_5_18 = arg_5_0._tf

	arg_5_0._blurPanel = var_3.Find(var_5_18, "blur_panel")

	local var_5_19 = arg_5_0._blurPanel

	arg_5_0.topPanel = var_3.Find(var_5_19, "top")

	local var_5_20 = arg_5_0._blurPanel

	arg_5_0.topPanelBg = var_3.Find(var_5_20, "top_bg")

	local var_5_21 = arg_5_0.topPanel

	arg_5_0._backBtn = var_3.Find(var_5_21, "back_btn")
	arg_5_0._spoilsContainer = var_1:Find("right/infomation/atlasloot/spoils/items/items_container")
	arg_5_0._item = var_1:Find("right/infomation/atlasloot/spoils/items/item_tpl")
	SetActive = var_3

	var_3(arg_5_0._item, false)

	arg_5_0._goals = var_1:Find("right/infomation/target/goal")
	arg_5_0._heroInfo = arg_5_0:getTpl("heroInfo")

	local var_5_22 = arg_5_0

	arg_5_0._starTpl = arg_5_0.getTpl(var_5_22, "star_tpl")
	setText = var_3
	findTF = var_5_22

	local var_5_23 = var_5_22(var_1, "middle/gear_score/vanguard/line/Image/Text1")

	i18n = var_6

	var_3(var_5_23, var_6("pre_combat_vanguard"))

	setText = var_3
	findTF = var_5_23

	local var_5_24 = var_5_23(var_1, "middle/gear_score/main/line/Image/Text1")

	i18n = var_6

	var_3(var_5_24, var_6("pre_combat_main"))

	setText = var_3
	findTF = var_5_24

	local var_5_25 = var_5_24(var_1, "middle/gear_score/submarine/line/Image/text1")

	i18n = var_6

	var_3(var_5_25, var_6("pre_combat_submarine"))

	setText = var_3

	local var_5_26 = arg_5_0._costContainer
	local var_5_27 = var_5.Find(var_5_26, "title")

	i18n = var_6

	var_3(var_5_27, var_6("pre_combat_consume"))

	setText = var_3
	findTF = var_5_27

	local var_5_28 = var_5_27(var_1, "right/infomation/target/title/GameObject")

	i18n = var_6

	var_3(var_5_28, var_6("pre_combat_targets"))

	setText = var_3
	findTF = var_5_28

	local var_5_29 = var_5_28(var_1, "right/infomation/atlasloot/atlasloot/title/GameObject")

	i18n = var_6

	var_3(var_5_29, var_6("pre_combat_atlasloot"))

	setText = var_3

	local var_5_30 = arg_5_0._startBtn
	local var_5_31 = var_5.Find(var_5_30, "text")

	i18n = var_6

	var_3(var_5_31, var_6("pre_combat_start"))

	setText = var_3

	local var_5_32 = arg_5_0._startBtn
	local var_5_33 = var_5.Find(var_5_32, "text_en")

	i18n = var_6

	var_3(var_5_33, var_6("pre_combat_start_en"))

	arg_5_0._middle = var_1:Find("middle")
	arg_5_0._right = var_1:Find("right")
	setAnchoredPosition = var_3

	var_3(arg_5_0._middle, {
		x = -840
	})

	setAnchoredPosition = var_3

	var_3(arg_5_0._right, {
		x = 470
	})

	local var_5_34 = arg_5_0._middle

	arg_5_0.guideDesc = var_3.Find(var_5_34, "guideDesc")

	local var_5_35 = arg_5_0._startBtn

	arg_5_0._costTip = var_3.Find(var_5_35, "cost_container/popup/tip")
	arg_5_0._continuousBtn = var_1:Find("right/multiple")
	setText = var_3

	local var_5_36 = arg_5_0._continuousBtn
	local var_5_37 = var_5.Find(var_5_36, "text")

	i18n = var_6

	var_3(var_5_37, var_6("multiple_sorties_title"))

	setText = var_3

	local var_5_38 = arg_5_0._continuousBtn
	local var_5_39 = var_5.Find(var_5_38, "text_en")

	i18n = var_6

	var_3(var_5_39, var_6("multiple_sorties_title_eng"))

	return
end

function var_0_1.Register(arg_6_0)
	local var_6_0 = arg_6_0._formationLogic

	var_1.AddLoadComplete(var_6_0, function()
		return
	end)

	local var_6_1 = arg_6_0._formationLogic

	var_1.AddHeroInfoModify(var_6_1, function(arg_8_0, arg_8_1)
		setAnchoredPosition = var_2_10002

		var_2_10002(arg_8_0, {
			x = 0,
			y = 0
		})

		SetActive = var_2_10002

		var_2_10002(arg_8_0, true)

		arg_8_0.name = "info"
		findTF = var_2

		local var_8_0 = var_2(arg_8_0, "info")

		findTF = var_2_10003

		local var_8_1 = var_2_10003(var_8_0, "stars")
		local var_8_2 = arg_8_1.energy

		Ship = var_5

		local var_8_3 = var_8_2 <= var_5.ENERGY_MID

		findTF = var_5

		local var_8_4 = var_5(var_8_0, "energy")
		local var_8_6

		if var_8_3 then
			local var_8_5 = arg_8_1
			local var_8_7

			var_8_6, var_8_7 = arg_8_1.getEnergyPrint(var_8_5)
			GetSpriteFromAtlas = var_8_5

			if not var_8_5("energy", var_8_6) then
				warning = var_2_10009

				var_2_10009("找不到疲劳")
			end

			setImageSprite = var_2_10009

			var_2_10009(var_8_4, var_8)
		end

		setActive = var_8_6

		local var_8_8 = var_8_4

		if var_8_3 then
			::label_8_0::

			var_2_10009 = arg_6_0.contextData.system
			SYSTEM_DUEL = var_2_10010
			var_2_10009 = var_2_10009 ~= var_2_10010
		end

		var_8_6(var_8_8, var_2_10009)

		local var_8_9 = arg_8_1:getStar()

		for iter_8_0 = 1, var_8_9 do
			cloneTplTo = var_2_10011

			var_2_10011(arg_6_0._starTpl, var_8_1)
		end

		GetSpriteFromAtlas = var_7

		local var_8_10 = "shiptype"

		shipType2print = iter_8_0

		if not var_7(var_8_10, iter_8_0(arg_8_1:getShipType())) then
			warning = var_8

			var_8("找不到船形, shipConfigId: " .. arg_8_1.configId)
		end

		setImageSprite = var_8
		findTF = var_10

		var_8(var_10(var_8_0, "type"), var_7, true)

		setText = var_8
		findTF = var_10

		var_8(var_10(var_8_0, "frame/lv_contain/lv"), arg_8_1.level)

		local var_8_11 = var_8_0:Find("expbuff")

		setActive = var_8_10

		var_8_10(var_8_11, false)

		return
	end)

	local var_6_2 = arg_6_0._formationLogic

	var_1.AddLongPress(var_6_2, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		local var_9_0 = arg_6_0
		local var_9_1 = var_4.emit

		BossRushPreCombatMediator = var_2_10007

		var_9_1(var_9_0, var_2_10007.OPEN_SHIP_INFO, arg_9_1.id, arg_9_2)

		return
	end)

	local var_6_3 = arg_6_0._formationLogic

	var_1.AddBeginDrag(var_6_3, function(arg_10_0)
		findTF = var_2_10001

		local var_10_0 = var_2_10001(arg_10_0, "info")

		SetActive = var_2_10002

		var_2_10002(var_10_0, false)

		return
	end)

	local var_6_4 = arg_6_0._formationLogic

	var_1.AddEndDrag(var_6_4, function(arg_11_0)
		findTF = var_2_10001

		local var_11_0 = var_2_10001(arg_11_0, "info")

		SetActive = var_2_10002

		var_2_10002(var_11_0, true)

		return
	end)

	local var_6_5 = arg_6_0._formationLogic

	var_1.AddClick(var_6_5, function(arg_12_0, arg_12_1, arg_12_2)
		pg = var_2_10003

		local var_12_0 = var_2_10003.CriMgr.GetInstance()
		local var_12_1 = var_3.PlaySoundEffect_V3

		SFX_UI_CLICK = var_2_10006

		var_12_1(var_12_0, var_2_10006)

		local var_12_2 = arg_6_0
		local var_12_3 = var_3.emit

		BossRushPreCombatMediator = var_2_10006

		var_12_3(var_12_2, var_2_10006.CHANGE_FLEET_SHIP, arg_12_0, arg_12_2, arg_12_1)

		return
	end)

	local var_6_6 = arg_6_0._formationLogic

	var_1.AddShiftOnly(var_6_6, function(arg_13_0)
		local var_13_0 = arg_6_0
		local var_13_1 = var_1.emit

		BossRushPreCombatMediator = var_2_10004

		var_13_1(var_13_0, var_2_10004.CHANGE_FLEET_SHIPS_ORDER, arg_13_0)

		return
	end)

	local var_6_7 = arg_6_0._formationLogic

	var_1.AddRemoveShip(var_6_7, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_6_0
		local var_14_1 = var_2.emit

		BossRushPreCombatMediator = var_2_10005

		var_14_1(var_14_0, var_2_10005.REMOVE_SHIP, arg_14_0, arg_14_1)

		return
	end)

	local var_6_8 = arg_6_0._formationLogic

	var_1.AddCheckRemove(var_6_8, function(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
		local var_15_1

		if not arg_15_3:canRemove(arg_15_2) then
			local var_15_0 = arg_15_3
			local var_15_2

			var_15_1, var_15_2 = arg_15_3.getShipPos(var_15_0, arg_15_2)
			pg = var_15_0
			var_2_10009 = var_15_0.TipsMgr.GetInstance()

			local var_15_3 = var_7.ShowTips

			i18n = var_2_10010

			local var_15_4 = "ship_formationUI_removeError_onlyShip"
			local var_15_5 = arg_15_2
			local var_15_6 = arg_15_2.getConfigTable(var_15_5).name
			local var_15_7

			if not arg_15_3.name then
				var_15_7 = ""
			end

			Fleet = var_15_5

			var_15_3(var_2_10009, var_2_10010(var_15_4, var_15_6, var_15_7, var_15_5.C_TEAM_NAME[var_15_2]))
			arg_15_0()
		else
			pg = var_15_1

			local var_15_8 = var_15_1.MsgboxMgr.GetInstance()
			local var_15_9 = var_5.ShowMsgBox
			local var_15_10 = {
				hideNo = false,
				zIndex = -100
			}

			i18n = var_2_10009
			var_15_10.content = var_2_10009("battle_preCombatLayer_quest_leaveFleet", arg_15_2:getConfigTable().name)
			var_15_10.onYes = arg_15_1
			var_15_10.onNo = arg_15_0

			var_15_9(var_15_8, var_15_10)
		end

		return
	end)

	local var_6_9 = arg_6_0._formationLogic

	var_1.AddSwitchToDisplayMode(var_6_9, function()
		local var_16_0 = arg_6_0

		var_0.SetFleetStepper(var_16_0)

		return
	end)

	local var_6_10 = arg_6_0._formationLogic

	var_1.AddSwitchToShiftMode(var_6_10, function()
		local var_17_0 = arg_6_0

		var_0.SetFleetStepper(var_17_0)

		return
	end)

	local var_6_11 = arg_6_0._formationLogic

	var_1.AddSwitchToPreviewMode(var_6_11, function()
		local var_18_0 = arg_6_0

		var_0.SetFleetStepper(var_18_0)

		return
	end)

	local var_6_12 = arg_6_0._formationLogic

	var_1.AddGridTipClick(var_6_12, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_6_0
		local var_19_1 = var_2.emit

		BossRushPreCombatMediator = var_2_10005

		var_19_1(var_19_0, var_2_10005.CHANGE_FLEET_SHIP, nil, arg_6_0._currentFleetVO, arg_19_0)

		return
	end)

	return
end

function var_0_1.SetPlayerInfo(arg_20_0, arg_20_1)
	return
end

function var_0_1.SetSubFlag(arg_21_0, arg_21_1)
	arg_21_0._subUseable = arg_21_1 or false

	arg_21_0:UpdateSubToggle()

	return
end

function var_0_1.SetShips(arg_22_0, arg_22_1)
	arg_22_0._shipVOs = arg_22_1

	local var_22_0 = arg_22_0._formationLogic

	var_2.SetShipVOs(var_22_0, arg_22_0._shipVOs)

	return
end

function var_0_1.SetStageIds(arg_23_0, arg_23_1)
	removeAllChildren = var_1_10002

	var_1_10002(arg_23_0._spoilsContainer)

	local var_23_0 = {}

	table = var_1_10003

	var_1_10003.Foreach(arg_23_1, function(arg_24_0, arg_24_1)
		pg = var_2_10002

		local var_24_0 = var_2_10002.expedition_data_template[arg_24_1]

		Clone = var_2_10003

		local var_24_1 = var_2_10003(var_24_0.award_display)

		checkExist = var_2_10004
		pg = var_2_10006

		local var_24_2

		if var_2_10004(var_2_10006.expedition_activity_template[arg_24_1], {
			"pt_drop_display"
		}) then
			type = var_24_2

			if var_24_2(var_4) == "table" then
				getProxy = var_24_2
				ActivityProxy = var_7
				var_24_2 = var_24_2(var_7)

				for iter_24_0 = #var_4, 1, -1 do
					if var_24_2:getActivityById(var_4[iter_24_0][1]) and not var_10:isEnd() then
						table = var_11

						local var_24_3 = var_11.insert
						local var_24_4 = var_24_1

						var_2_10014 = 1

						local var_24_5 = {
							2
						}

						id2ItemId = var_2_10016
						var_24_5[2] = var_2_10016(var_4[iter_24_0][2])

						var_24_3(var_24_4, var_2_10014, var_24_5)
					end
				end
			end
		end

		table = var_24_2

		var_24_2.insertto(var_23_0, var_24_1)

		if arg_24_0 > 1 then
			return
		end

		local function var_24_6(arg_25_0, arg_25_1)
			type = var_3_10002

			local var_25_0

			if var_3_10002(arg_25_0) == "table" then
				setActive = var_25_0

				var_25_0(arg_25_1, true)

				i18n = var_25_0
				PreCombatLayer = var_4
				var_25_0 = var_25_0(var_4.ObjectiveList[arg_25_0[1]], arg_25_0[2])
				setWidgetText = var_3_10003

				var_3_10003(arg_25_1, var_25_0)
			else
				setActive = var_25_0

				var_25_0(arg_25_1, false)
			end

			return
		end

		local var_24_7 = {}

		findTF = var_7
		var_24_7[1] = var_7(arg_23_0._goals, "goal_tpl")
		findTF = var_7
		var_24_7[2] = var_7(arg_23_0._goals, "goal_sink")
		findTF = var_7
		var_24_7[3] = var_7(arg_23_0._goals, "goal_time")

		local var_24_8 = {
			var_24_0.objective_1,
			var_24_0.objective_2,
			var_24_0.objective_3
		}
		local var_24_9 = 1

		ipairs = var_9

		for iter_24_1, iter_24_2 in var_9(var_24_8) do
			type = var_2_10014

			if var_2_10014(iter_24_2) ~= "string" then
				var_24_6(iter_24_2, var_24_7[var_24_9])

				var_24_9 = var_24_9 + 1
			end
		end

		for iter_24_3 = var_24_9, #var_24_7 do
			var_24_6("", var_24_7[iter_24_3])
		end

		return
	end)

	local var_23_1 = {}

	ipairs = var_4

	for iter_23_0, iter_23_1 in var_4(var_23_0) do
		if (function()
			ipairs = var_2_10000

			for iter_26_0, iter_26_1 in var_2_10000(var_23_1) do
				if iter_23_1[1] == iter_26_1[1] and iter_23_1[2] == iter_26_1[2] then
					return false
				end
			end

			return true
		end)() then
			table = var_10

			var_10.insert(var_23_1, iter_23_1)
		end
	end

	var_23_0 = var_23_1
	ipairs = var_4

	for iter_23_2, iter_23_3 in var_4(var_23_0) do
		cloneTplTo = var_1_10009
		var_1_10009 = var_1_10009(arg_23_0._item, arg_23_0._spoilsContainer)

		local var_23_2 = {
			id = iter_23_3[2],
			type = iter_23_3[1]
		}

		updateDrop = var_11

		var_11(var_1_10009, var_23_2)

		onButton = var_11

		local var_23_3 = arg_23_0
		local var_23_4 = var_1_10009

		local function var_23_5()
			Item = var_2_10000

			if var_2_10000.getConfigData(iter_23_3[2]) and var_0_3[var_0.type] then
				local var_27_0 = var_0.display_icon
				local var_27_1 = {}

				ipairs = var_2_10003

				for iter_27_0, iter_27_1 in var_2_10003(var_27_0) do
					local var_27_2 = iter_27_1[1]
					local var_27_3 = iter_27_1[2]

					var_27_1[#var_27_1 + 1] = {
						hideName = true,
						type = var_27_2,
						id = var_27_3
					}
				end

				local var_27_4 = arg_23_0

				var_3.emit(var_27_4, var_0_1.ON_DROP_LIST, {
					item2Row = true,
					itemList = var_27_1,
					content = var_0.display
				})
			else
				local var_27_5 = arg_23_0

				var_1.emit(var_27_5, var_0_1.ON_DROP, var_23_2)
			end

			return
		end

		SFX_PANEL = var_1_10016

		var_11(var_23_3, var_23_4, var_23_5, var_1_10016)
	end

	return
end

function var_0_1.SetFleets(arg_28_0, arg_28_1)
	arg_28_0._fleetVOs = {}
	arg_28_0._legalFleetIdList = {}
	_ = var_2

	var_2.each(arg_28_1, function(arg_29_0)
		local var_29_0 = arg_28_0._fleetVOs

		var_29_0[arg_29_0.id] = arg_29_0
		table = var_29_0

		var_29_0.insert(arg_28_0._legalFleetIdList, arg_29_0.id)

		return
	end)

	return
end

function var_0_1.SetCurrentFleet(arg_30_0, arg_30_1)
	arg_30_0._currentFleetVO = arg_30_0._fleetVOs[arg_30_1]

	local var_30_0 = arg_30_0._formationLogic

	var_2.SetFleetVO(var_30_0, arg_30_0._currentFleetVO)

	ipairs = var_2

	for iter_30_0, iter_30_1 in var_2(arg_30_0._legalFleetIdList) do
		if arg_30_0._currentFleetVO.id == iter_30_1 then
			arg_30_0._curFleetIndex = iter_30_0

			break
		end
	end

	return
end

function var_0_1.CheckLegalFleet(arg_31_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.UpdateFleetView(arg_32_0, arg_32_1)
	arg_32_0:displayFleetInfo()
	arg_32_0:updateFleetBg()

	local var_32_0 = arg_32_0._formationLogic

	var_2.UpdateGridVisibility(var_32_0)

	local var_32_1 = arg_32_0._formationLogic
	local var_32_2 = var_2.ResetGrid

	TeamType = var_1_10005

	var_32_2(var_32_1, var_1_10005.Vanguard, false)

	local var_32_3 = arg_32_0._formationLogic
	local var_32_4 = var_2.ResetGrid

	TeamType = var_5

	var_32_4(var_32_3, var_5.Main, false)

	local var_32_5 = arg_32_0._formationLogic
	local var_32_6 = var_2.ResetGrid

	TeamType = var_5

	var_32_6(var_32_5, var_5.Submarine, false)
	arg_32_0:resetFormationComponent()

	if arg_32_1 then
		local var_32_7 = arg_32_0._formationLogic

		var_2.LoadAllCharacter(var_32_7)
	else
		local var_32_8 = arg_32_0._formationLogic

		var_2.SetAllCharacterPos(var_32_8)
	end

	return
end

function var_0_1.updateFleetBg(arg_33_0)
	local var_33_0 = arg_33_0._currentFleetVO
	local var_33_1 = var_1.getFleetType(var_33_0)

	setActive = var_1_10002

	local var_33_2 = arg_33_0._bgFleet

	FleetType = var_1_10005

	var_1_10002(var_33_2, var_33_1 == var_1_10005.Normal)

	setActive = var_1_10002

	local var_33_3 = arg_33_0._bgSub

	FleetType = var_5

	var_1_10002(var_33_3, var_33_1 == var_5.Submarine)

	return
end

function var_0_1.resetFormationComponent(arg_34_0)
	SetActive = var_1_10001

	local var_34_0 = arg_34_0._gridTFs.main[1]
	local var_34_1 = var_3.Find(var_34_0, "flag")
	local var_34_2 = arg_34_0._currentFleetVO
	local var_34_3 = var_4.getTeamByName

	TeamType = var_1_10007

	var_1_10001(var_34_1, #var_34_3(var_34_2, var_1_10007.Main) ~= 0)

	SetActive = var_1_10001

	local var_34_4 = arg_34_0._gridTFs.submarine[1]
	local var_34_5 = var_3.Find(var_34_4, "flag")
	local var_34_6 = arg_34_0._currentFleetVO
	local var_34_7 = var_4.getTeamByName

	TeamType = var_7

	var_1_10001(var_34_5, #var_34_7(var_34_6, var_7.Submarine) ~= 0)

	return
end

function var_0_1.uiStartAnimating(arg_35_0)
	local var_35_0 = 0
	local var_35_1 = 0.3

	shiftPanel = var_1_10003

	var_1_10003(arg_35_0._middle, 0, nil, var_35_1, var_35_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_35_0._right, 0, nil, var_35_1, var_35_0, true, true)

	return
end

function var_0_1.uiExitAnimating(arg_36_0)
	shiftPanel = var_1_10001

	var_1_10001(arg_36_0._middle, -840, nil, nil, nil, true, true)

	shiftPanel = var_1_10001

	var_1_10001(arg_36_0._right, 470, nil, nil, nil, true, true)

	return
end

function var_0_1.didEnter(arg_37_0)
	onButton = var_1_10001

	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0._backBtn

	local function var_37_2()
		GetOrAddComponent = var_2_10000

		local var_38_0 = arg_37_0._tf

		typeof = var_2_10003
		CanvasGroup = var_2_10005
		var_2_10000(var_38_0, var_2_10003(var_2_10005)).interactable = false

		local var_38_1 = arg_37_0

		var_1.uiExitAnimating(var_38_1)

		LeanTween = var_1

		local var_38_2 = var_1.delayedCall
		local var_38_3 = 0.3

		System = var_2_10004

		var_38_2(var_38_3, var_2_10004.Action(function()
			local var_39_0 = arg_37_0

			var_0.emit(var_39_0, var_0_1.ON_CLOSE)

			return
		end))

		local var_38_4 = arg_37_0
		local var_38_5 = var_1.emit

		BossRushPreCombatMediator = var_4

		var_38_5(var_38_4, var_4.ON_UPDATE_CUSTOM_FLEET)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_37_0, var_37_1, var_37_2, var_1_10006)

	onButton = var_1_10001

	local var_37_3 = arg_37_0
	local var_37_4 = arg_37_0._tf
	local var_37_5 = var_4.Find(var_37_4, "blur_panel/top/option")

	local function var_37_6()
		local var_40_0 = arg_37_0

		var_0.quickExitFunc(var_40_0)

		local var_40_1 = arg_37_0
		local var_40_2 = var_0.emit

		BossRushPreCombatMediator = var_2_10003

		var_40_2(var_40_1, var_2_10003.ON_UPDATE_CUSTOM_FLEET)

		return
	end

	SFX_PANEL = var_37_4

	var_1_10001(var_37_3, var_37_5, var_37_6, var_37_4)

	onButton = var_1_10001

	local var_37_7 = arg_37_0
	local var_37_8 = arg_37_0._startBtn

	local function var_37_9()
		local var_41_0 = arg_37_0
		local var_41_1 = var_0.emit

		BossRushPreCombatMediator = var_2_10003

		var_41_1(var_41_0, var_2_10003.ON_START)

		return
	end

	SFX_UI_WEIGHANCHOR = var_37_4

	var_1_10001(var_37_7, var_37_8, var_37_9, var_37_4)

	onButton = var_1_10001

	local var_37_10 = arg_37_0
	local var_37_11 = arg_37_0._nextPage

	local function var_37_12()
		local var_42_0 = arg_37_0
		local var_42_1 = var_0.emit

		BossRushPreCombatMediator = var_2_10003

		var_42_1(var_42_0, var_2_10003.ON_CHANGE_FLEET, arg_37_0._legalFleetIdList[arg_37_0._curFleetIndex + 1])

		return
	end

	SFX_PANEL = var_37_4

	var_1_10001(var_37_10, var_37_11, var_37_12, var_37_4)

	onButton = var_1_10001

	local var_37_13 = arg_37_0
	local var_37_14 = arg_37_0._prevPage

	local function var_37_15()
		local var_43_0 = arg_37_0
		local var_43_1 = var_0.emit

		BossRushPreCombatMediator = var_2_10003

		var_43_1(var_43_0, var_2_10003.ON_CHANGE_FLEET, arg_37_0._legalFleetIdList[arg_37_0._curFleetIndex - 1])

		return
	end

	SFX_PANEL = var_37_4

	var_1_10001(var_37_13, var_37_14, var_37_15, var_37_4)
	arg_37_0:UpdateFleetView(true)

	pg = var_1

	local var_37_16 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_37_16, arg_37_0._tf)

	GetOrAddComponent = var_1

	local var_37_17 = arg_37_0._tf

	typeof = var_4
	CanvasGroup = var_37_4

	local var_37_18 = var_1(var_37_17, var_4(var_37_4))

	var_37_18.interactable = true
	setActive = var_37_18

	var_37_18(arg_37_0._autoToggle, true)

	onToggle = var_37_18

	local var_37_19 = arg_37_0
	local var_37_20 = arg_37_0._autoToggle

	local function var_37_21(arg_44_0)
		local var_44_0 = arg_37_0
		local var_44_1 = var_1.emit

		BossRushPreCombatMediator = var_2_10004

		var_44_1(var_44_0, var_2_10004.ON_AUTO, {
			isOn = not arg_44_0,
			toggle = arg_37_0._autoToggle
		})

		arg_37_0.autoFlag = arg_44_0

		local var_44_2 = arg_37_0

		var_1.UpdateSubToggle(var_44_2)

		return
	end

	SFX_PANEL = var_37_4
	SFX_PANEL = var_7

	var_37_18(var_37_19, var_37_20, var_37_21, var_37_4, var_7)

	onToggle = var_37_18

	local var_37_22 = arg_37_0
	local var_37_23 = arg_37_0._autoSubToggle

	local function var_37_24(arg_45_0)
		local var_45_0 = arg_37_0
		local var_45_1 = var_1.emit

		BossRushPreCombatMediator = var_2_10004

		var_45_1(var_45_0, var_2_10004.ON_SUB_AUTO, {
			isOn = not arg_45_0,
			toggle = arg_37_0._autoSubToggle
		})

		return
	end

	SFX_PANEL = var_37_4
	SFX_PANEL = var_7

	var_37_18(var_37_22, var_37_23, var_37_24, var_37_4, var_7)

	triggerToggle = var_37_18

	local var_37_25 = arg_37_0._autoToggle

	ys = var_37_23

	var_37_18(var_37_25, var_37_23.Battle.BattleState.IsAutoBotActive())

	onNextTick = var_37_18

	var_37_18(function()
		local var_46_0 = arg_37_0

		var_0.uiStartAnimating(var_46_0)

		return
	end)

	getProxy = var_37_18
	ActivityProxy = var_3

	local var_37_26 = var_37_18(var_3)
	local var_37_27 = var_1.getActivityById(var_37_26, arg_37_0.contextData.actId)
	local var_37_28 = arg_37_0.contextData.seriesData

	;(function()
		local var_47_0 = var_37_28
		local var_47_1 = var_0.GetType(var_47_0)

		BossRushSeriesData = var_2_10001

		local var_47_2 = var_47_1 == var_2_10001.TYPE.NORMAL

		setActive = var_1

		var_1(arg_37_0._continuousBtn, var_47_2)

		if not var_47_2 then
			return
		end

		local var_47_3
		local var_47_4 = var_37_27
		local var_47_5 = var_2.getConfig(var_47_4, "type")

		ActivityConst = var_3

		if var_47_5 == var_3.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
			local var_47_6 = var_37_27

			var_47_3 = var_47_5.HasPlayerDefeatSeries(var_47_6, var_37_28.id)
		else
			local var_47_7 = var_37_27

			var_47_3 = var_47_5.HasPassSeries(var_47_7, var_37_28.id)
		end

		setActive = var_47_5

		local var_47_8 = arg_37_0._continuousBtn

		var_47_5(var_4.Find(var_47_8, "lock"), not var_47_3)

		if var_47_3 then
			Color = var_47_5

			if not var_47_5.white then
				Color = var_47_5
				var_47_5 = var_47_5.New(0.2980392156862745, 0.2980392156862745, 0.2980392156862745)
			end

			setImageColor = var_3

			var_3(arg_37_0._continuousBtn, var_47_5)

			setTextColor = var_3

			local var_47_9 = arg_37_0._continuousBtn

			var_3(var_5.Find(var_47_9, "text"), var_47_5)

			setTextColor = var_3

			local var_47_10 = arg_37_0._continuousBtn

			var_3(var_5.Find(var_47_10, "text_en"), var_47_5)

			onButton = var_3

			local var_47_11 = arg_37_0
			local var_47_12 = arg_37_0._continuousBtn

			local function var_47_13()
				local var_48_1

				if var_47_3 then
					local var_48_0 = arg_37_0

					var_48_1 = var_48_1.emit
					BossRushPreCombatMediator = var_3_10003

					var_48_1(var_48_0, var_3_10003.SHOW_CONTINUOUS_OPERATION_WINDOW, arg_37_0._currentFleetVO.id)
				else
					pg = var_48_1

					local var_48_2 = var_48_1.TipsMgr.GetInstance()
					local var_48_3 = var_0.ShowTips

					i18n = var_3_10003

					var_48_3(var_48_2, var_3_10003("multiple_sorties_locked_tip"))
				end

				return
			end

			SFX_PANEL = var_8

			var_3(var_47_11, var_47_12, var_47_13, var_8)

			return
		end
	end)()

	local var_37_29 = var_37_28:GetExpeditionIds()
	local var_37_30 = var_37_28
	local var_37_31 = var_37_28.GetBossIcons(var_37_30)
	local var_37_32 = arg_37_0._tf
	local var_37_33 = var_6.Find(var_37_32, "adapt/middle/Boss")

	UIItemList = var_37_30

	var_37_30.StaticAlign(var_37_33, var_37_33:GetChild(0), #var_37_29, function(arg_49_0, arg_49_1, arg_49_2)
		UIItemList = var_2_10003

		if arg_49_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_49_0 = var_37_29[arg_49_1 + 1]
		local var_49_1 = var_37_31[arg_49_1 + 1][1]

		pg = var_5

		local var_49_2 = var_5.expedition_data_template[var_49_0].level
		local var_49_3 = arg_49_2
		local var_49_4 = arg_49_2.Find(var_49_3, "shiptpl")

		findTF = var_2_10008

		local var_49_5 = var_2_10008(var_49_4, "icon_bg")

		findTF = var_49_3

		local var_49_6 = var_49_3(var_49_4, "icon_bg/frame")

		SetCompomentEnabled = var_10

		var_10(var_49_5, "Image", false)

		SetCompomentEnabled = var_10

		var_10(var_49_6, "Image", false)

		setActive = var_10

		var_10(arg_49_2:Find("shiptpl/icon_bg/lv"), false)

		local var_49_7 = arg_49_2
		local var_49_8 = arg_49_2.Find(var_49_7, "shiptpl/icon_bg/icon")

		GetImageSpriteFromAtlasAsync = var_11

		var_11("SquareIcon/" .. var_49_1, "", var_49_8)

		findTF = var_11

		if var_11(var_49_4, "ship_type") then
			setActive = var_49_7

			var_49_7(var_11, true)

			setImageSprite = var_49_7

			local var_49_9 = var_11

			GetSpriteFromAtlas = var_15

			local var_49_10 = "shiptype"

			shipType2print = var_2_10018

			var_49_7(var_49_9, var_15(var_49_10, var_2_10018(var_37_31[arg_49_1 + 1][2])))
		end

		return
	end)
	arg_37_0:SetFleetStepper()
	arg_37_0:SetStageIds(arg_37_0.contextData.stageIds)

	return
end

function var_0_1.UpdateSubToggle(arg_50_0)
	if arg_50_0.autoFlag and arg_50_0._subUseable == true then
		setActive = var_1

		var_1(arg_50_0._autoSubToggle, true)

		triggerToggle = var_1

		local var_50_0 = arg_50_0._autoSubToggle

		ys = var_4

		var_1(var_50_0, var_4.Battle.BattleState.IsAutoSubActive())
	else
		setActive = var_1

		var_1(arg_50_0._autoSubToggle, false)
	end

	return
end

function var_0_1.displayFleetInfo(arg_51_0)
	local var_51_0 = arg_51_0._currentFleetVO
	local var_51_1 = var_1.getFleetType(var_51_0)

	setActive = var_1_10002

	local var_51_2 = arg_51_0._vanguardGS.parent

	FleetType = var_1_10005

	var_1_10002(var_51_2, var_51_1 == var_1_10005.Normal)

	setActive = var_1_10002

	local var_51_3 = arg_51_0._mainGS.parent

	FleetType = var_5

	var_1_10002(var_51_3, var_51_1 == var_5.Normal)

	math = var_1_10002

	local var_51_4 = var_1_10002.floor
	local var_51_5 = arg_51_0._currentFleetVO
	local var_51_6 = var_4.GetGearScoreSum

	TeamType = var_1_10007

	local var_51_7 = var_51_4(var_51_6(var_51_5, var_1_10007.Vanguard))

	math = var_51_0

	local var_51_8 = var_51_0.floor
	local var_51_9 = arg_51_0._currentFleetVO
	local var_51_10 = var_5.GetGearScoreSum

	TeamType = var_1_10008

	local var_51_11 = var_51_8(var_51_10(var_51_9, var_1_10008.Main))

	setActive = var_4

	local var_51_12 = arg_51_0._subGS.parent

	FleetType = var_51_9

	var_4(var_51_12, var_51_1 == var_51_9.Submarine)

	math = var_4

	local var_51_13 = var_4.floor
	local var_51_14 = arg_51_0._currentFleetVO
	local var_51_15 = var_6.GetGearScoreSum

	TeamType = var_1_10009

	local var_51_16 = var_51_13(var_51_15(var_51_14, var_1_10009.Submarine))
	local var_51_17 = arg_51_0.contextData.system

	setActive = var_6

	local var_51_18 = arg_51_0._costContainer

	SYSTEM_DUEL = var_9

	var_6(var_51_18, var_51_17 ~= var_9)
	var_0_2.tweenNumText(arg_51_0._vanguardGS, var_51_7)
	var_0_2.tweenNumText(arg_51_0._mainGS, var_51_11)
	var_0_2.tweenNumText(arg_51_0._subGS, var_51_16)

	setText = var_6

	local var_51_19 = arg_51_0._fleetNameText

	Fleet = var_9

	var_6(var_51_19, var_9.DEFAULT_NAME[arg_51_0._curFleetIndex])

	setText = var_6

	var_6(arg_51_0._fleetNumText, arg_51_0._curFleetIndex)

	local var_51_20 = arg_51_0.contextData.seriesData
	local var_51_21 = var_6.GetExpeditionIds(var_51_20)
	local var_51_22 = arg_51_0._tf
	local var_51_23 = var_8.Find(var_51_22, "adapt/middle/Boss")

	UIItemList = var_51_20

	var_51_20.StaticAlign(var_51_23, var_51_23:GetChild(0), #var_51_21, function(arg_52_0, arg_52_1, arg_52_2)
		UIItemList = var_2_10003

		if arg_52_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_52_2

		if arg_52_1 + 1 ~= arg_51_0._curFleetIndex then
			local var_52_0 = arg_51_0._curFleetIndex

			if not (#var_51_21 < var_52_0) then
				local var_52_1 = arg_51_0.contextData.mode

				BossRushSeriesData = var_4

				if var_52_1 ~= var_4.MODE.SINGLE then
					var_52_2 = false

					goto label_52_0
				end
			end
		end

		var_52_2 = true

		::label_52_0::

		setActive = var_4

		var_4(arg_52_2:Find("Select"), var_52_2)

		setActive = var_4

		var_4(arg_52_2:Find("Image"), var_52_2)

		return
	end)

	local var_51_24 = arg_51_0.contextData.seriesData.mode

	underscore = var_51_22

	local var_51_25 = var_51_22.to_array(arg_51_0.contextData.fleets)

	table = var_11

	local var_51_26 = var_11.remove(var_51_25)
	local var_51_27 = false
	local var_51_28 = (function()
		local var_53_0 = 0

		pg = var_2_10001

		local var_53_1 = var_2_10001.battle_cost_template[var_51_17]
		local var_53_2 = var_0
		local var_53_3 = var_2.GetOilLimit(var_53_2)
		local var_53_4 = var_53_1.oil_cost > 0

		local function var_53_5(arg_54_0, arg_54_1)
			local var_54_0 = 0

			if var_53_4 then
				var_54_0 = arg_54_0:GetCostSum().oil

				if 0 < arg_54_1 then
					math = var_3
					var_54_0 = var_3.min(arg_54_1, var_54_0)

					local var_54_1

					if var_51_27 then
						var_54_1 = var_54_0 < arg_54_1
					end

					var_51_27 = var_54_1
				end
			end

			return var_54_0
		end

		local var_53_6 = var_0
		local var_53_7 = #var_5.GetExpeditionIds(var_53_6)
		local var_53_8 = var_53_5(var_51_26, var_53_3[2]) * var_53_7

		for iter_53_0 = 1, var_53_7 do
			local var_53_9 = var_53_5
			local var_53_10

			if not var_51_25[iter_53_0] then
				var_53_10 = var_51_25[1]
			end

			var_53_8 = var_53_8 + var_53_9(var_53_10, var_53_3[1])
		end

		return var_53_8
	end)()

	local function var_51_29()
		local var_55_0 = 0

		pg = var_2_10001

		local var_55_1 = var_2_10001.battle_cost_template[var_51_17]
		local var_55_2 = var_0
		local var_55_3 = var_2.GetOilLimit(var_55_2)
		local var_55_4 = var_55_1.oil_cost > 0

		local function var_55_5(arg_56_0, arg_56_1)
			local var_56_0 = 0

			if var_55_4 then
				var_56_0 = arg_56_0:GetCostSum().oil
			end

			return var_56_0
		end

		local var_55_6 = var_0
		local var_55_7 = #var_5.GetExpeditionIds(var_55_6)
		local var_55_8 = var_55_5(var_51_26, var_55_3[2]) * var_55_7

		for iter_55_0 = 1, var_55_7 do
			local var_55_9 = var_55_5
			local var_55_10

			if not var_51_25[iter_55_0] then
				var_55_10 = var_51_25[1]
			end

			var_55_8 = var_55_8 + var_55_9(var_55_10, var_55_3[1])
		end

		return var_55_8
	end

	local var_51_30 = 0

	if var_51_27 then
		var_51_30 = var_51_29()
	end

	var_0_2.tweenNumText(arg_51_0._costText, var_51_28)

	setActive = var_17

	var_17(arg_51_0._costTip, var_51_27)

	if var_51_27 then
		onButton = var_17

		var_17(arg_51_0, arg_51_0._costTip, function()
			pg = var_2_10000

			local var_57_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_57_1 = var_0.ShowMsgBox
			local var_57_2 = {
				hideNo = true
			}

			i18n = var_2_10004
			var_57_2.content = var_2_10004("use_oil_limit_help", var_51_30, var_51_28)

			var_57_1(var_57_0, var_57_2)

			return
		end)
	end

	return
end

function var_0_1.SetFleetStepper(arg_58_0)
	SetActive = var_1_10001

	var_1_10001(arg_58_0._nextPage, arg_58_0._curFleetIndex < #arg_58_0._legalFleetIdList)

	SetActive = var_1_10001

	var_1_10001(arg_58_0._prevPage, arg_58_0._curFleetIndex > 1)

	return
end

function var_0_1.onBackPressed(arg_59_0)
	pg = var_1_10001

	local var_59_0 = var_1_10001.CriMgr.GetInstance()
	local var_59_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_59_1(var_59_0, var_1_10004)

	triggerButton = var_59_1

	var_59_1(arg_59_0._backBtn)

	return
end

function var_0_1.willExit(arg_60_0)
	pg = var_1_10001

	local var_60_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_60_0, arg_60_0._tf)

	local var_60_1 = arg_60_0._formationLogic

	var_1.Destroy(var_60_1)

	arg_60_0._formationLogic = nil

	return
end

return var_0_1
