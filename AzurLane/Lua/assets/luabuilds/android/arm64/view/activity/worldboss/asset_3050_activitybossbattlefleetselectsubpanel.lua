class = var_0_10000

local var_0_0 = "ActivityBossBattleFleetSelectSubPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "ActivityBossFleetSelectView"
end

function var_0_1.InvokeParent(arg_2_0, arg_2_1, ...)
	if arg_2_0.viewParent then
		arg_2_0.viewParent[arg_2_1](arg_2_0.viewParent, ...)
	end

	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.tfShipTpl = var_1.Find(var_3_0, "panel/shiptpl")

	local var_3_1 = arg_3_0._tf

	arg_3_0.tfEmptyTpl = var_1.Find(var_3_1, "panel/emptytpl")

	local var_3_2 = {}

	FleetType = var_1_10002

	local var_3_3 = var_1_10002.Normal
	local var_3_4 = {}
	local var_3_5 = arg_3_0._tf

	var_3_4[1] = var_4.Find(var_3_5, "panel/fleet/1")

	local var_3_6 = arg_3_0._tf

	var_3_4[2] = var_4.Find(var_3_6, "panel/fleet/2")
	var_3_2[var_3_3] = var_3_4
	FleetType = var_3_3

	local var_3_7 = var_3_3.Submarine
	local var_3_8 = {}
	local var_3_9 = arg_3_0._tf

	var_3_8[1] = var_4.Find(var_3_9, "panel/sub/1")
	var_3_2[var_3_7] = var_3_8
	arg_3_0.tfFleets = var_3_2

	local var_3_10 = arg_3_0._tf

	arg_3_0.tfLimit = var_1.Find(var_3_10, "panel/limit_list/limit")

	local var_3_11 = arg_3_0._tf

	arg_3_0.tfLimitTips = var_1.Find(var_3_11, "panel/limit_list/limit_tip")

	local var_3_12 = arg_3_0._tf

	arg_3_0.tfLimitElite = var_1.Find(var_3_12, "panel/limit_list/limit_elite")

	local var_3_13 = arg_3_0._tf

	arg_3_0.tfLimitContainer = var_1.Find(var_3_13, "panel/limit_list/limit_elite/limit_list")

	local var_3_14 = arg_3_0._tf

	arg_3_0.rtCostLimit = var_1.Find(var_3_14, "panel/limit_list/cost_limit")

	local var_3_15 = arg_3_0._tf

	arg_3_0.btnBack = var_1.Find(var_3_15, "panel/btnBack")

	local var_3_16 = arg_3_0._tf

	arg_3_0.btnGo = var_1.Find(var_3_16, "panel/start_button")

	local var_3_17 = arg_3_0._tf

	arg_3_0.btnTry = var_1.Find(var_3_17, "panel/try_button")

	local var_3_18 = arg_3_0._tf

	arg_3_0.btnASHelp = var_1.Find(var_3_18, "panel/title/ASvalue")

	local var_3_19 = arg_3_0._tf

	arg_3_0.commanderToggle = var_1.Find(var_3_19, "panel/commander_btn")

	local var_3_20 = arg_3_0._tf

	arg_3_0.formationToggle = var_1.Find(var_3_20, "panel/formation_btn")

	local var_3_21 = arg_3_0._tf

	arg_3_0.toggleMask = var_1.Find(var_3_21, "mask")

	local var_3_22 = arg_3_0._tf

	arg_3_0.toggleList = var_1.Find(var_3_22, "mask/list")
	arg_3_0.toggles = {}

	for iter_3_0 = 0, arg_3_0.toggleList.childCount - 1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_3_23 = arg_3_0.toggles
		local var_3_24 = arg_3_0.toggleList

		var_1_10005(var_3_23, var_8.Find(var_3_24, "item" .. iter_3_0 + 1))
	end

	local var_3_25 = arg_3_0._tf

	arg_3_0.btnSp = var_1.Find(var_3_25, "panel/sp")

	local var_3_26 = arg_3_0._tf

	arg_3_0.spMask = var_1.Find(var_3_26, "mask_sp")
	setActive = var_1

	var_1(arg_3_0.tfShipTpl, false)

	setActive = var_1

	var_1(arg_3_0.tfEmptyTpl, false)

	setActive = var_1

	var_1(arg_3_0.toggleMask, false)

	setActive = var_1

	var_1(arg_3_0.btnSp, false)

	setActive = var_1

	var_1(arg_3_0.spMask, false)

	setActive = var_1

	var_1(arg_3_0.tfLimitElite, false)

	setActive = var_1

	var_1(arg_3_0.tfLimitTips, false)

	setActive = var_1

	var_1(arg_3_0.tfLimit, false)

	setActive = var_1

	local var_3_27 = arg_3_0._tf

	var_1(var_3.Find(var_3_27, "panel/title/ASvalue"), false)

	setText = var_1

	local var_3_28 = arg_3_0._tf
	local var_3_29 = var_3.Find(var_3_28, "panel/formation_btn/text")

	i18n = var_4

	var_1(var_3_29, var_4("autofight_formation"))

	setText = var_1

	local var_3_30 = arg_3_0._tf
	local var_3_31 = var_3.Find(var_3_30, "panel/commander_btn/text")

	i18n = var_4

	var_1(var_3_31, var_4("autofight_cat"))

	setText = var_1

	local var_3_32 = arg_3_0._tf
	local var_3_33 = var_3.Find(var_3_32, "panel/title/Image/text")

	i18n = var_4

	var_1(var_3_33, var_4("fleet_select_title"))
	arg_3_0:InitInteractable()

	return
end

function var_0_1.InitInteractable(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.btnGo

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.OnCombat(var_5_0)

		return
	end

	SFX_UI_WEIGHANCHOR_GO = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.btnTry

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.OnTrybat(var_6_0)

		return
	end

	SFX_UI_WEIGHANCHOR_GO = var_1_10006

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10006)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.btnBack

	local function var_4_8()
		local var_7_0 = arg_4_0

		var_0.OnCancel(var_7_0)

		local var_7_1 = arg_4_0

		var_0.OnCommit(var_7_1)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_4_6, var_4_7, var_4_8, var_1_10006)

	onButton = var_1_10001

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0._tf

	local function var_4_11()
		local var_8_0 = arg_4_0

		var_0.OnCancel(var_8_0)

		local var_8_1 = arg_4_0

		var_0.OnCommit(var_8_1)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_4_9, var_4_10, var_4_11, var_1_10006)

	onToggle = var_1_10001

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0.commanderToggle

	local function var_4_14(arg_9_0)
		if arg_9_0 then
			local var_9_0 = arg_4_0.viewParent.contextData

			var_9_0.showCommander = arg_9_0
			pairs = var_9_0

			for iter_9_0, iter_9_1 in var_9_0(arg_4_0.tfFleets) do
				for iter_9_2 = 1, #iter_9_1 do
					local var_9_1 = arg_4_0

					var_10.updateCommanderBtn(var_9_1, iter_9_0, iter_9_2)
				end
			end
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_12, var_4_13, var_4_14, var_1_10006)

	onToggle = var_1_10001

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.formationToggle

	local function var_4_17(arg_10_0)
		if arg_10_0 then
			local var_10_0 = arg_4_0.viewParent.contextData

			var_10_0.showCommander = not arg_10_0
			pairs = var_10_0

			for iter_10_0, iter_10_1 in var_10_0(arg_4_0.tfFleets) do
				for iter_10_2 = 1, #iter_10_1 do
					local var_10_1 = arg_4_0

					var_10.updateCommanderBtn(var_10_1, iter_10_0, iter_10_2)
				end
			end
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_15, var_4_16, var_4_17, var_1_10006)

	return
end

function var_0_1.SetFleets(arg_11_0, arg_11_1)
	local var_11_0 = {}

	FleetType = var_1_10003
	var_11_0[var_1_10003.Normal] = {}
	FleetType = var_3
	var_11_0[var_3.Submarine] = {}
	arg_11_0.fleets = var_11_0
	pairs = var_11_0

	for iter_11_0, iter_11_1 in var_11_0(arg_11_1) do
		iter_11_1:RemoveUnusedItems()

		if iter_11_1:isSubmarineFleet() then
			local var_11_1 = arg_11_0.fleets

			FleetType = var_1_10008

			local var_11_2 = #var_11_1[var_1_10008.Submarine]
			local var_11_3 = arg_11_0

			var_1_10008 = arg_11_0.getLimitNums
			FleetType = var_1_10011

			if var_11_2 < var_1_10008(var_11_3, var_1_10011.Submarine) then
				table = var_11_2

				local var_11_4 = var_11_2.insert
				local var_11_5 = arg_11_0.fleets

				FleetType = var_11_3

				var_11_4(var_11_5[var_11_3.Submarine], iter_11_1)
			end
		else
			local var_11_6 = arg_11_0.fleets

			FleetType = var_1_10008

			local var_11_7 = #var_11_6[var_1_10008.Normal]
			local var_11_8 = arg_11_0

			var_1_10008 = arg_11_0.getLimitNums
			FleetType = var_1_10011

			if var_11_7 < var_1_10008(var_11_8, var_1_10011.Normal) then
				table = var_11_7

				local var_11_9 = var_11_7.insert
				local var_11_10 = arg_11_0.fleets

				FleetType = var_11_8

				var_11_9(var_11_10[var_11_8.Normal], iter_11_1)
			end
		end
	end

	return
end

function var_0_1.SetOilLimit(arg_12_0, arg_12_1)
	_ = var_1_10002

	local var_12_0 = var_1_10002.any(arg_12_1, function(arg_13_0)
		return arg_13_0 > 0
	end)

	setActive = var_1_10003

	var_1_10003(arg_12_0.rtCostLimit, var_12_0)

	setText = var_1_10003

	local var_12_1 = arg_12_0.rtCostLimit
	local var_12_2 = var_5.Find(var_12_1, "text")

	i18n = var_6

	var_1_10003(var_12_2, var_6("formationScene_use_oil_limit_tip_worldboss"))

	if var_12_0 then
		local var_12_3 = 0
		local var_12_4 = arg_12_1[1]

		setActive = var_4

		local var_12_5 = arg_12_0.rtCostLimit

		var_4(var_6.Find(var_12_5, "cost_noraml/Text"), var_12_4 > 0)

		if 0 < var_12_4 then
			setText = var_4

			local var_12_6 = arg_12_0.rtCostLimit
			local var_12_7 = var_6.Find(var_12_6, "cost_noraml/Text")

			string = var_7

			local var_12_8 = var_7.format
			local var_12_9 = "%s(%d)"

			i18n = var_1_10010

			var_4(var_12_7, var_12_8(var_12_9, var_1_10010("formationScene_use_oil_limit_surface"), var_12_4))
		end

		local var_12_10 = 0

		setActive = var_4

		local var_12_11 = arg_12_0.rtCostLimit

		var_4(var_6.Find(var_12_11, "cost_boss/Text"), var_12_10 > 0)

		local var_12_12 = arg_12_1[2]

		setActive = var_4

		local var_12_13 = arg_12_0.rtCostLimit

		var_4(var_6.Find(var_12_13, "cost_sub/Text"), var_12_12 > 0)

		if 0 < var_12_12 then
			setText = var_4

			local var_12_14 = arg_12_0.rtCostLimit
			local var_12_15 = var_6.Find(var_12_14, "cost_sub/Text")

			string = var_7

			local var_12_16 = var_7.format
			local var_12_17 = "%s(%d)"

			i18n = var_1_10010

			var_4(var_12_15, var_12_16(var_12_17, var_1_10010("formationScene_use_oil_limit_submarine"), var_12_12))
		end
	end

	return
end

function var_0_1.SetSettings(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.groupNum = arg_14_1
	arg_14_0.submarineNum = arg_14_2
	arg_14_0.showTryBtn = arg_14_3

	return
end

function var_0_1.UpdateView(arg_15_0)
	arg_15_0:clearFleets()
	arg_15_0:UpdateFleets()

	LOCK_COMMANDER = var_1

	local var_15_3

	if not var_1 then
		pg = var_1

		local var_15_0 = var_1.SystemOpenMgr.GetInstance()
		local var_15_1 = var_1.isOpenSystem

		getProxy = var_1_10004
		PlayerProxy = var_1_10006

		local var_15_2 = var_1_10004(var_1_10006)

		var_15_3 = var_15_1(var_15_0, var_4.getRawData(var_15_2).level, "CommanderCatMediator")
	else
		var_15_3 = false
	end

	if false then
		var_15_3 = true
	end

	triggerToggle = var_1_10002

	local var_15_4

	if not arg_15_0.viewParent.contextData.showCommander or not var_15_3 or not arg_15_0.commanderToggle then
		var_15_4 = arg_15_0.formationToggle
	end

	var_1_10002(var_15_4, true)

	setActive = var_1_10002

	var_1_10002(arg_15_0.commanderToggle, var_15_3)

	setActive = var_1_10002

	var_1_10002(arg_15_0.btnTry, arg_15_0.showTryBtn)

	return
end

function var_0_1.getLimitNums(arg_16_0, arg_16_1)
	local var_16_0 = 0

	FleetType = var_1_10003

	if arg_16_1 == var_1_10003.Normal then
		var_16_0 = arg_16_0.groupNum
	else
		FleetType = var_3

		if arg_16_1 == var_3.Submarine then
			var_16_0 = arg_16_0.submarineNum
		end
	end

	return var_16_0 or 0
end

function var_0_1.UpdateFleets(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.tfFleets) do
		for iter_17_2 = 1, #iter_17_1 do
			arg_17_0:updateFleet(iter_17_0, iter_17_2)
		end
	end

	return
end

function var_0_1.updateFleet(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:updateCommanderBtn(arg_18_1, arg_18_2)

	local var_18_0 = arg_18_2 <= arg_18_0:getLimitNums(arg_18_1) and arg_18_0.fleets[arg_18_1][arg_18_2]
	local var_18_1 = arg_18_0.tfFleets[arg_18_1][arg_18_2]

	findTF = var_6

	local var_18_2 = var_6(var_18_1, "bg/name")
	local var_18_3 = var_18_1
	local var_18_4 = var_18_1.Find

	TeamType = var_1_10010

	local var_18_5 = var_18_4(var_18_3, var_1_10010.Main)
	local var_18_6 = var_18_1
	local var_18_7 = var_18_1.Find

	TeamType = var_1_10011

	local var_18_8 = var_18_7(var_18_6, var_1_10011.Vanguard)
	local var_18_9 = var_18_1
	local var_18_10 = var_18_1.Find

	TeamType = var_1_10012

	local var_18_11 = var_18_10(var_18_9, var_1_10012.Submarine)
	local var_18_12 = var_18_1:Find("btn_recom")
	local var_18_13 = var_18_1:Find("btn_clear")
	local var_18_14 = var_18_1
	local var_18_15 = var_18_1.Find(var_18_14, "selected")
	local var_18_16 = var_18_1:Find("commander")

	setActive = var_18_14

	var_18_14(var_18_15, false)

	setText = var_18_14

	var_18_14(var_18_2, "")

	local var_18_18

	if var_18_5 then
		setActive = var_18_14

		local var_18_17 = var_18_5

		var_18_18 = var_3 and var_18_0

		var_18_14(var_18_17, var_18_18)
	end

	if var_18_8 then
		setActive = var_18_14

		local var_18_19 = var_18_8

		var_18_18 = var_3 and var_18_0

		var_18_14(var_18_19, var_18_18)
	end

	if var_18_11 then
		setActive = var_18_14

		local var_18_20 = var_18_11

		var_18_18 = var_3 and var_18_0

		var_18_14(var_18_20, var_18_18)
	end

	if var_3 and var_18_0 then
		setText = var_18_14

		local var_18_21 = var_18_2

		Fleet = var_18_18

		local var_18_22

		if not var_18_18.DEFAULT_NAME_BOSS_ACT[var_18_0.id] then
			var_18_22 = ""
		end

		var_18_14(var_18_21, var_18_22)

		FleetType = var_18_14

		if arg_18_1 == var_18_14.Submarine then
			local var_18_23 = arg_18_0
			local var_18_24 = arg_18_0.updateShips
			local var_18_25 = var_18_11
			local var_18_26 = var_18_0.subShips

			var_1_10019 = var_18_0.id
			TeamType = var_1_10020

			var_18_24(var_18_23, var_18_25, var_18_26, var_1_10019, var_1_10020.Submarine)
		else
			local var_18_27 = arg_18_0
			local var_18_28 = arg_18_0.updateShips
			local var_18_29 = var_18_5
			local var_18_30 = var_18_0.mainShips

			var_1_10019 = var_18_0.id
			TeamType = var_1_10020

			var_18_28(var_18_27, var_18_29, var_18_30, var_1_10019, var_1_10020.Main)

			local var_18_31 = arg_18_0
			local var_18_32 = arg_18_0.updateShips
			local var_18_33 = var_18_8
			local var_18_34 = var_18_0.vanguardShips

			var_1_10019 = var_18_0.id
			TeamType = var_20

			var_18_32(var_18_31, var_18_33, var_18_34, var_1_10019, var_20.Vanguard)
		end

		arg_18_0:updateCommanders(var_18_16, var_18_0)

		onButton = var_14

		var_14(arg_18_0, var_18_12, function()
			local var_19_0 = arg_18_0

			var_0.emit(var_19_0, arg_18_0.viewParent.contextData.mediatorClass.ON_FLEET_RECOMMEND, var_18_0.id)

			return
		end)

		onButton = var_14

		local var_18_35 = arg_18_0
		local var_18_36 = var_18_13

		local function var_18_37()
			local var_20_0 = arg_18_0

			var_0.emit(var_20_0, arg_18_0.viewParent.contextData.mediatorClass.ON_FLEET_CLEAR, var_18_0.id)

			return
		end

		SFX_UI_CLICK = var_1_10019

		var_14(var_18_35, var_18_36, var_18_37, var_1_10019)
	end

	return
end

function var_0_1.updateShips(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	removeAllChildren = var_1_10005

	var_1_10005(arg_21_1)

	getProxy = var_1_10005
	BayProxy = var_7

	local var_21_0 = var_1_10005(var_7)

	for iter_21_0 = 1, 3 do
		local var_21_1 = var_21_0
		local var_21_2

		if not var_21_0.getShipById(var_21_1, arg_21_2[iter_21_0]) or not arg_21_0.tfShipTpl then
			var_21_2 = arg_21_0.tfEmptyTpl
		end

		cloneTplTo = var_21_1

		local var_21_3 = var_21_1(var_21_2, arg_21_1)

		setActive = var_13

		var_13(var_21_3, true)

		if var_10 then
			updateShip = var_13

			var_13(var_21_3, var_10)

			setActive = var_13

			var_13(var_21_3:Find("event_block"), var_10:getFlag("inEvent"))
		end

		setActive = var_13

		var_13(var_21_3:Find("ship_type"), false)

		GetOrAddComponent = var_13

		local var_21_4 = var_21_3

		typeof = var_16
		UILongPressTrigger = var_18

		local var_21_5 = var_13(var_21_4, var_16(var_18)).onLongPressed

		var_14.RemoveAllListeners(var_21_5)

		local function var_21_6()
			local var_22_0 = arg_21_0

			var_0.emit(var_22_0, arg_21_0.viewParent.contextData.mediatorClass.ON_OPEN_DOCK, {
				fleet = arg_21_2,
				shipVO = var_0,
				fleetIndex = arg_21_3,
				teamType = arg_21_4
			})

			return
		end

		onButton = var_21_4

		var_21_4(arg_21_0, var_21_3, var_21_6)

		local var_21_7 = var_13.onLongPressed

		var_15.AddListener(var_21_7, function()
			if var_0 then
				local var_23_0 = arg_21_0

				var_0.OnLongPressShip(var_23_0, arg_21_2[iter_21_0], arg_21_3)
			else
				var_21_6()
			end

			return
		end)
	end

	return
end

function var_0_1.updateCommanderBtn(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2 <= arg_24_0:getLimitNums(arg_24_1) and arg_24_0.fleets[arg_24_1][arg_24_2]
	local var_24_1 = arg_24_0.tfFleets[arg_24_1][arg_24_2]
	local var_24_2 = var_5.Find(var_24_1, "btn_select")
	local var_24_3 = var_5:Find("btn_clear")
	local var_24_4 = var_5:Find("btn_recom")
	local var_24_5 = var_5
	local var_24_6 = var_5.Find(var_24_5, "blank")
	local var_24_7 = var_5:Find("commander")

	setActive = var_24_5

	var_24_5(var_24_2, false)

	setActive = var_24_5

	var_24_5(var_24_3, var_3 and not arg_24_0.viewParent.contextData.showCommander)

	setActive = var_24_5

	var_24_5(var_24_4, var_3 and not arg_24_0.viewParent.contextData.showCommander)

	setActive = var_24_5

	var_24_5(var_24_7, var_3 and var_24_0 and arg_24_0.viewParent.contextData.showCommander)

	setActive = var_24_5

	var_24_5(var_24_6, not var_3 or var_3 and not var_24_0 and arg_24_0.viewParent.contextData.showCommander)

	return
end

function var_0_1.updateCommanders(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0 = 1, 2 do
		local var_25_0 = arg_25_2:getCommanderByPos(iter_25_0)
		local var_25_1 = arg_25_1:Find("pos" .. iter_25_0)
		local var_25_2 = var_8.Find(var_25_1, "add")
		local var_25_3 = var_8
		local var_25_4 = var_8.Find(var_25_3, "info")

		setActive = var_25_1

		var_25_1(var_25_2, not var_25_0)

		setActive = var_25_1

		var_25_1(var_25_4, var_25_0)

		if var_25_0 then
			Commander = var_25_1
			var_25_1 = var_25_1.rarity2Frame

			local var_25_5 = var_25_0

			var_25_1 = var_25_1(var_25_0.getRarity(var_25_5))
			setImageSprite = var_25_3
			var_1_10016 = var_25_4

			local var_25_6 = var_25_4.Find(var_1_10016, "frame")

			GetSpriteFromAtlas = var_25_5

			var_25_3(var_25_6, var_25_5("weaponframes", "commander_" .. var_25_1))

			GetImageSpriteFromAtlasAsync = var_25_3

			var_25_3("CommanderHrz/" .. var_25_0:getPainting(), "", var_25_4:Find("mask/icon"))
		end

		onButton = var_25_1

		local var_25_7 = arg_25_0
		local var_25_8 = var_25_2

		local function var_25_9()
			local var_26_0 = arg_25_0

			var_0.InvokeParent(var_26_0, "openCommanderPanel", arg_25_2, arg_25_2.id)

			return
		end

		SFX_PANEL = var_1_10016

		var_25_1(var_25_7, var_25_8, var_25_9, var_1_10016)

		onButton = var_25_1

		local var_25_10 = arg_25_0
		local var_25_11 = var_25_4

		local function var_25_12()
			local var_27_0 = arg_25_0

			var_0.InvokeParent(var_27_0, "openCommanderPanel", arg_25_2, arg_25_2.id)

			return
		end

		SFX_PANEL = var_1_10016

		var_25_1(var_25_10, var_25_11, var_25_12, var_1_10016)
	end

	return
end

function var_0_1.clearFleets(arg_28_0)
	pairs = var_1_10001

	for iter_28_0, iter_28_1 in var_1_10001(arg_28_0.tfFleets) do
		_ = var_1_10006

		var_1_10006.each(iter_28_1, function(arg_29_0)
			local var_29_0 = arg_28_0

			var_1.clearFleet(var_29_0, arg_29_0)

			return
		end)
	end

	return
end

function var_0_1.clearFleet(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1
	local var_30_1 = arg_30_1.Find

	TeamType = var_1_10005

	local var_30_2 = var_30_1(var_30_0, var_1_10005.Main)
	local var_30_3 = arg_30_1
	local var_30_4 = arg_30_1.Find

	TeamType = var_1_10006

	local var_30_5 = var_30_4(var_30_3, var_1_10006.Vanguard)
	local var_30_6 = arg_30_1
	local var_30_7 = arg_30_1.Find

	TeamType = var_1_10007

	local var_30_8 = var_30_7(var_30_6, var_1_10007.Submarine)

	if var_30_2 then
		removeAllChildren = var_30_3

		var_30_3(var_30_2)
	end

	if var_30_5 then
		removeAllChildren = var_30_3

		var_30_3(var_30_5)
	end

	if var_30_8 then
		removeAllChildren = var_30_3

		var_30_3(var_30_8)
	end

	return
end

function var_0_1.OnShow(arg_31_0)
	pg = var_1_10001

	local var_31_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_31_0, arg_31_0._tf, {
		groupDelta = -1,
		groupName = "ActivityBossSceneTemplate"
	})

	return
end

function var_0_1.OnHide(arg_32_0)
	pg = var_1_10001

	local var_32_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_32_0, arg_32_0._tf, arg_32_0.viewParent._tf)

	triggerToggle = var_1

	var_1(arg_32_0.commanderToggle, false)

	return
end

function var_0_1.OnCancel(arg_33_0)
	arg_33_0:InvokeParent("hideFleetEdit")

	return
end

function var_0_1.OnCommit(arg_34_0)
	arg_34_0:InvokeParent("commitEdit")

	return
end

function var_0_1.OnCombat(arg_35_0)
	arg_35_0:InvokeParent("commitEdit")
	arg_35_0:InvokeParent("commitCombat")

	return
end

function var_0_1.OnTrybat(arg_36_0)
	arg_36_0:InvokeParent("commitEdit")
	arg_36_0:InvokeParent("commitTrybat")

	return
end

function var_0_1.OnLongPressShip(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0:InvokeParent("openShipInfo", arg_37_1, arg_37_2)

	return
end

return var_0_1
