class = var_0_10000

local var_0_0 = "BossSingleBattleFleetSelectSubPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "BossSingleFleetSelectView"
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

	FleetType = var_3_1

	local var_3_3 = var_3_1.Normal
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
	setText = var_1

	local var_3_13 = arg_3_0.tfLimitElite
	local var_3_14 = var_2.Find(var_3_13, "sub/Text")

	i18n = var_3_13

	var_1(var_3_14, var_3_13("ship_limit_notice"))

	local var_3_15 = arg_3_0._tf

	arg_3_0.tfLimitContainer = var_1.Find(var_3_15, "panel/limit_list/limit_elite/limit_list")

	local var_3_16 = arg_3_0._tf

	arg_3_0.rtCostLimit = var_1.Find(var_3_16, "panel/limit_list/cost_limit")

	local var_3_17 = arg_3_0._tf

	arg_3_0.btnBack = var_1.Find(var_3_17, "panel/btnBack")

	local var_3_18 = arg_3_0._tf

	arg_3_0.btnGo = var_1.Find(var_3_18, "panel/start_button")

	local var_3_19 = arg_3_0._tf

	arg_3_0.btnTry = var_1.Find(var_3_19, "panel/try_button")

	local var_3_20 = arg_3_0._tf

	arg_3_0.btnASHelp = var_1.Find(var_3_20, "panel/title/ASvalue")

	local var_3_21 = arg_3_0._tf

	arg_3_0.commanderToggle = var_1.Find(var_3_21, "panel/commander_btn")

	local var_3_22 = arg_3_0._tf

	arg_3_0.formationToggle = var_1.Find(var_3_22, "panel/formation_btn")

	local var_3_23 = arg_3_0._tf

	arg_3_0.toggleMask = var_1.Find(var_3_23, "mask")

	local var_3_24 = arg_3_0._tf

	arg_3_0.toggleList = var_1.Find(var_3_24, "mask/list")
	arg_3_0.toggles = {}

	for iter_3_0 = 0, arg_3_0.toggleList.childCount - 1 do
		table = var_3_9
		var_3_9 = var_3_9.insert

		local var_3_25 = arg_3_0.toggles
		local var_3_26 = arg_3_0.toggleList

		var_3_9(var_3_25, var_7.Find(var_3_26, "item" .. iter_3_0 + 1))
	end

	local var_3_27 = arg_3_0._tf

	arg_3_0.btnSp = var_1.Find(var_3_27, "panel/sp")

	local var_3_28 = arg_3_0._tf

	arg_3_0.spMask = var_1.Find(var_3_28, "mask_sp")
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

	local var_3_29 = arg_3_0._tf

	var_1(var_2.Find(var_3_29, "panel/title/ASvalue"), false)

	setText = var_1

	local var_3_30 = arg_3_0._tf
	local var_3_31 = var_2.Find(var_3_30, "panel/formation_btn/text")

	i18n = var_3_30

	var_1(var_3_31, var_3_30("autofight_formation"))

	setText = var_1

	local var_3_32 = arg_3_0._tf
	local var_3_33 = var_2.Find(var_3_32, "panel/commander_btn/text")

	i18n = var_3_32

	var_1(var_3_33, var_3_32("autofight_cat"))

	setText = var_1

	local var_3_34 = arg_3_0._tf
	local var_3_35 = var_2.Find(var_3_34, "panel/title/Image/text")

	i18n = var_3_34

	var_1(var_3_35, var_3_34("fleet_select_title"))
	arg_3_0:InitInteractable()

	return
end

function var_0_1.InitInteractable(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.btnGo

	local function var_4_2()
		local var_5_0 = arg_4_0
		local var_5_1, var_5_2 = var_0.CheckValid(var_5_0)

		if var_5_1 then
			local var_5_3 = arg_4_0

			var_2_10002.OnCombat(var_5_3)
		else
			pg = var_2_10002

			local var_5_4 = var_2_10002.TipsMgr.GetInstance()

			var_2.ShowTips(var_5_4, var_5_2)
		end

		return
	end

	SFX_UI_WEIGHANCHOR_GO = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.btnBack

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.OnCancel(var_6_0)

		local var_6_1 = arg_4_0

		var_0.OnCommit(var_6_1)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10005)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0._tf

	local function var_4_8()
		local var_7_0 = arg_4_0

		var_0.OnCancel(var_7_0)

		local var_7_1 = arg_4_0

		var_0.OnCommit(var_7_1)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_4_6, var_4_7, var_4_8, var_1_10005)

	onToggle = var_1_10001

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.commanderToggle

	local function var_4_11(arg_8_0)
		if arg_8_0 then
			local var_8_0 = arg_4_0.viewParent.contextData

			var_8_0.showCommander = arg_8_0
			pairs = var_8_0

			for iter_8_0, iter_8_1 in var_8_0(arg_4_0.tfFleets) do
				for iter_8_2 = 1, #iter_8_1 do
					local var_8_1 = arg_4_0

					var_10.updateCommanderBtn(var_8_1, iter_8_0, iter_8_2)
				end
			end
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_9, var_4_10, var_4_11, var_1_10005)

	onToggle = var_1_10001

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0.formationToggle

	local function var_4_14(arg_9_0)
		if arg_9_0 then
			local var_9_0 = arg_4_0.viewParent.contextData

			var_9_0.showCommander = not arg_9_0
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

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_12, var_4_13, var_4_14, var_1_10005)

	return
end

function var_0_1.SetFleets(arg_10_0, arg_10_1)
	local var_10_0 = {}

	FleetType = var_1_10003
	var_10_0[var_1_10003.Normal] = {}
	FleetType = var_3
	var_10_0[var_3.Submarine] = {}
	arg_10_0.fleets = var_10_0
	pairs = var_10_0

	for iter_10_0, iter_10_1 in var_10_0(arg_10_1) do
		iter_10_1:RemoveUnusedItems()

		local var_10_1 = iter_10_1

		if iter_10_1.isSubmarineFleet(var_10_1) then
			local var_10_2 = arg_10_0.fleets

			FleetType = var_10_1

			local var_10_3 = #var_10_2[var_10_1.Submarine]
			local var_10_4 = arg_10_0

			var_10_1 = arg_10_0.getLimitNums
			FleetType = var_1_10010

			if var_10_3 < var_10_1(var_10_4, var_1_10010.Submarine) then
				table = var_10_3

				local var_10_5 = var_10_3.insert

				var_10_1 = arg_10_0.fleets
				FleetType = var_10_4

				var_10_5(var_10_1[var_10_4.Submarine], iter_10_1)
			end
		else
			local var_10_6 = arg_10_0.fleets

			FleetType = var_10_1

			local var_10_7 = #var_10_6[var_10_1.Normal]
			local var_10_8 = arg_10_0
			local var_10_9 = arg_10_0.getLimitNums

			FleetType = var_1_10010

			if var_10_7 < var_10_9(var_10_8, var_1_10010.Normal) then
				table = var_10_7

				local var_10_10 = var_10_7.insert
				local var_10_11 = arg_10_0.fleets

				FleetType = var_10_8

				var_10_10(var_10_11[var_10_8.Normal], iter_10_1)
			end
		end
	end

	return
end

function var_0_1.SetOilLimit(arg_11_0, arg_11_1)
	_ = var_1_10002

	local var_11_0 = var_1_10002.any(arg_11_1, function(arg_12_0)
		return arg_12_0 > 0
	end)

	setActive = var_3

	var_3(arg_11_0.rtCostLimit, var_11_0)

	setText = var_3

	local var_11_1 = arg_11_0.rtCostLimit
	local var_11_2 = var_4.Find(var_11_1, "text")

	i18n = var_11_1

	var_3(var_11_2, var_11_1("formationScene_use_oil_limit_tip_worldboss"))

	if var_11_0 then
		local var_11_3 = 0
		local var_11_4 = arg_11_1[1]

		setActive = var_11_2

		local var_11_5 = arg_11_0.rtCostLimit

		var_11_2(var_5.Find(var_11_5, "cost_noraml/Text"), var_11_4 > 0)

		if 0 < var_11_4 then
			setText = var_4

			local var_11_6 = arg_11_0.rtCostLimit
			local var_11_7 = var_5.Find(var_11_6, "cost_noraml/Text")

			string = var_11_6

			local var_11_8 = var_11_6.format
			local var_11_9 = "%s(%d)"

			i18n = var_1_10008

			var_4(var_11_7, var_11_8(var_11_9, var_1_10008("formationScene_use_oil_limit_surface"), var_11_4))
		end

		local var_11_10 = 0

		setActive = var_4

		local var_11_11 = arg_11_0.rtCostLimit

		var_4(var_5.Find(var_11_11, "cost_boss/Text"), var_11_10 > 0)

		local var_11_12 = arg_11_1[2]

		setActive = var_4

		local var_11_13 = arg_11_0.rtCostLimit

		var_4(var_5.Find(var_11_13, "cost_sub/Text"), var_11_12 > 0)

		if 0 < var_11_12 then
			setText = var_4

			local var_11_14 = arg_11_0.rtCostLimit
			local var_11_15 = var_5.Find(var_11_14, "cost_sub/Text")

			string = var_11_14

			local var_11_16 = var_11_14.format
			local var_11_17 = "%s(%d)"

			i18n = var_1_10008

			var_4(var_11_15, var_11_16(var_11_17, var_1_10008("formationScene_use_oil_limit_submarine"), var_11_12))
		end
	end

	return
end

function var_0_1.SetSettings(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	arg_13_0.groupNum = arg_13_1
	arg_13_0.submarineNum = arg_13_2
	arg_13_0.showTryBtn = arg_13_3
	arg_13_0.propetyLimitation = arg_13_4
	arg_13_0.index = arg_13_5

	return
end

function var_0_1.UpdateView(arg_14_0)
	arg_14_0:clearFleets()
	arg_14_0:UpdateFleets()

	local var_14_0 = arg_14_0

	arg_14_0.updatePropetyLimit(var_14_0)

	LOCK_COMMANDER = var_1

	local var_14_3

	if not var_1 then
		pg = var_1
		var_14_0 = var_1.SystemOpenMgr.GetInstance()

		local var_14_1 = var_1.isOpenSystem

		getProxy = var_1_10003
		PlayerProxy = var_1_10004

		local var_14_2 = var_1_10003(var_1_10004)

		var_14_3 = var_14_1(var_14_0, var_3.getRawData(var_14_2).level, "CommanderCatMediator")
	else
		var_14_3 = false
	end

	if false then
		var_14_3 = true
	end

	triggerToggle = var_14_0

	local var_14_4

	if not arg_14_0.viewParent.contextData.showCommander or not var_14_3 or not arg_14_0.commanderToggle then
		var_14_4 = arg_14_0.formationToggle
	end

	var_14_0(var_14_4, true)

	setActive = var_14_0

	var_14_0(arg_14_0.commanderToggle, var_14_3)

	setActive = var_14_0

	var_14_0(arg_14_0.btnTry, arg_14_0.showTryBtn)

	return
end

function var_0_1.getLimitNums(arg_15_0, arg_15_1)
	local var_15_0 = 0

	FleetType = var_1_10003

	if arg_15_1 == var_1_10003.Normal then
		var_15_0 = arg_15_0.groupNum
	else
		FleetType = var_3

		if arg_15_1 == var_3.Submarine then
			var_15_0 = arg_15_0.submarineNum
		end
	end

	return var_15_0 or 0
end

function var_0_1.UpdateFleets(arg_16_0)
	pairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(arg_16_0.tfFleets) do
		for iter_16_2 = 1, #iter_16_1 do
			arg_16_0:updateFleet(iter_16_0, iter_16_2)
		end
	end

	return
end

function var_0_1.updateFleet(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:updateCommanderBtn(arg_17_1, arg_17_2)

	local var_17_0 = arg_17_2 <= arg_17_0:getLimitNums(arg_17_1) and arg_17_0.fleets[arg_17_1][arg_17_2]
	local var_17_1 = arg_17_0.tfFleets[arg_17_1][arg_17_2]

	findTF = var_6

	local var_17_2 = var_6(var_17_1, "bg/name")
	local var_17_3 = var_17_1
	local var_17_4 = var_17_1.Find

	TeamType = var_1_10009

	local var_17_5 = var_17_4(var_17_3, var_1_10009.Main)
	local var_17_6 = var_17_1
	local var_17_7 = var_17_1.Find

	TeamType = var_1_10010

	local var_17_8 = var_17_7(var_17_6, var_1_10010.Vanguard)
	local var_17_9 = var_17_1
	local var_17_10 = var_17_1.Find

	TeamType = var_1_10011

	local var_17_11 = var_17_10(var_17_9, var_1_10011.Submarine)
	local var_17_12 = var_17_1:Find("btn_recom")
	local var_17_13 = var_17_1:Find("btn_clear")
	local var_17_14 = var_17_1:Find("selected")
	local var_17_15 = var_17_1
	local var_17_16 = var_17_1.Find(var_17_15, "commander")

	setActive = var_17_15

	var_17_15(var_17_14, false)

	setText = var_17_15

	var_17_15(var_17_2, "")

	if var_17_5 then
		setActive = var_17_15

		var_17_15(var_17_5, var_3 and var_17_0)
	end

	if var_17_8 then
		setActive = var_17_15

		var_17_15(var_17_8, var_3 and var_17_0)
	end

	if var_17_11 then
		setActive = var_17_15

		var_17_15(var_17_11, var_3 and var_17_0)
	end

	local var_17_17 = arg_17_0.viewParent.contextData.bossActivity
	local var_17_18 = var_14.getConfig(var_17_17, "type")

	ActivityConst = var_17_17

	if var_17_18 == var_17_17.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
		Fleet = var_17_18

		if not var_17_18.DEFAULT_NAME_BOSS_SINGLE_VARIABLE_ACT then
			Fleet = var_17_18
			var_17_18 = var_17_18.DEFAULT_NAME_BOSS_SINGLE_ACT
		end

		if var_3 and var_17_0 then
			setText = var_15

			local var_17_19 = var_17_2
			local var_17_20

			if not var_17_18[var_17_0.id] then
				var_17_20 = ""
			end

			var_15(var_17_19, var_17_20)

			FleetType = var_15

			if arg_17_1 == var_15.Submarine then
				local var_17_21 = arg_17_0
				local var_17_22 = arg_17_0.updateShips
				local var_17_23 = var_17_11
				local var_17_24 = var_17_0.subShips

				var_1_10019 = var_17_0.id
				TeamType = var_1_10020

				var_17_22(var_17_21, var_17_23, var_17_24, var_1_10019, var_1_10020.Submarine)
			else
				local var_17_25 = arg_17_0
				local var_17_26 = arg_17_0.updateShips
				local var_17_27 = var_17_5
				local var_17_28 = var_17_0.mainShips

				var_1_10019 = var_17_0.id
				TeamType = var_1_10020

				var_17_26(var_17_25, var_17_27, var_17_28, var_1_10019, var_1_10020.Main)

				local var_17_29 = arg_17_0
				local var_17_30 = arg_17_0.updateShips
				local var_17_31 = var_17_8
				local var_17_32 = var_17_0.vanguardShips

				var_1_10019 = var_17_0.id
				TeamType = var_20

				var_17_30(var_17_29, var_17_31, var_17_32, var_1_10019, var_20.Vanguard)
			end

			arg_17_0:updateCommanders(var_17_16, var_17_0)

			onButton = var_15

			var_15(arg_17_0, var_17_12, function()
				local var_18_0 = arg_17_0

				var_0.emit(var_18_0, arg_17_0.viewParent.contextData.mediatorClass.ON_FLEET_RECOMMEND, var_17_0.id)

				return
			end)

			onButton = var_15

			local var_17_33 = arg_17_0
			local var_17_34 = var_17_13

			local function var_17_35()
				local var_19_0 = arg_17_0

				var_0.emit(var_19_0, arg_17_0.viewParent.contextData.mediatorClass.ON_FLEET_CLEAR, var_17_0.id)

				return
			end

			SFX_UI_CLICK = var_1_10019

			var_15(var_17_33, var_17_34, var_17_35, var_1_10019)
		end

		return
	end
end

function var_0_1.updateShips(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	removeAllChildren = var_1_10005

	var_1_10005(arg_20_1)

	getProxy = var_1_10005
	BayProxy = var_6

	local var_20_0 = var_1_10005(var_6)

	for iter_20_0 = 1, 3 do
		local var_20_1

		if not var_20_0:getShipById(arg_20_2[iter_20_0]) or not arg_20_0.tfShipTpl then
			var_20_1 = arg_20_0.tfEmptyTpl
		end

		cloneTplTo = var_12

		local var_20_2 = var_12(var_20_1, arg_20_1)

		setActive = var_13

		var_13(var_20_2, true)

		if var_10 then
			updateShip = var_13

			var_13(var_20_2, var_10)

			setActive = var_13

			var_13(var_20_2:Find("event_block"), var_10:getFlag("inEvent"))
		end

		setActive = var_13

		var_13(var_20_2:Find("ship_type"), false)

		GetOrAddComponent = var_13

		local var_20_3 = var_20_2

		typeof = var_15
		UILongPressTrigger = var_16

		local var_20_4 = var_13(var_20_3, var_15(var_16)).onLongPressed

		var_14.RemoveAllListeners(var_20_4)

		local function var_20_5()
			local var_21_0 = arg_20_0

			var_0.emit(var_21_0, arg_20_0.viewParent.contextData.mediatorClass.ON_OPEN_DOCK, {
				fleet = arg_20_2,
				shipVO = var_0,
				fleetIndex = arg_20_3,
				teamType = arg_20_4
			})

			return
		end

		onButton = var_20_4

		var_20_4(arg_20_0, var_20_2, var_20_5)

		local var_20_6 = var_13.onLongPressed

		var_15.AddListener(var_20_6, function()
			if var_0 then
				local var_22_0 = arg_20_0

				var_0.OnLongPressShip(var_22_0, arg_20_2[iter_20_0], arg_20_3)
			else
				var_20_5()
			end

			return
		end)
	end

	return
end

function var_0_1.updateCommanderBtn(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_2 <= arg_23_0:getLimitNums(arg_23_1) and arg_23_0.fleets[arg_23_1][arg_23_2]
	local var_23_1 = arg_23_0.tfFleets[arg_23_1][arg_23_2]
	local var_23_2 = var_5.Find(var_23_1, "btn_select")
	local var_23_3 = var_5:Find("btn_clear")
	local var_23_4 = var_5:Find("btn_recom")
	local var_23_5 = var_5:Find("blank")
	local var_23_6 = var_5
	local var_23_7 = var_5.Find(var_23_6, "commander")

	setActive = var_23_6

	var_23_6(var_23_2, false)

	setActive = var_23_6

	var_23_6(var_23_3, var_3 and not arg_23_0.viewParent.contextData.showCommander)

	setActive = var_23_6

	var_23_6(var_23_4, var_3 and not arg_23_0.viewParent.contextData.showCommander)

	setActive = var_23_6

	var_23_6(var_23_7, var_3 and var_23_0 and arg_23_0.viewParent.contextData.showCommander)

	setActive = var_23_6

	var_23_6(var_23_5, not var_3 or var_3 and not var_23_0 and arg_23_0.viewParent.contextData.showCommander)

	return
end

function var_0_1.updateCommanders(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0 = 1, 2 do
		local var_24_0 = arg_24_2:getCommanderByPos(iter_24_0)
		local var_24_1 = arg_24_1:Find("pos" .. iter_24_0)
		local var_24_2 = var_8.Find(var_24_1, "add")
		local var_24_3 = var_8
		local var_24_4 = var_8.Find(var_24_3, "info")

		setActive = var_24_3

		var_24_3(var_24_2, not var_24_0)

		setActive = var_24_3

		var_24_3(var_24_4, var_24_0)

		if var_24_0 then
			Commander = var_24_3
			var_24_3 = var_24_3.rarity2Frame(var_24_0:getRarity())
			setImageSprite = var_12

			local var_24_5 = var_24_4
			local var_24_6 = var_24_4.Find(var_24_5, "frame")

			GetSpriteFromAtlas = var_24_5

			var_12(var_24_6, var_24_5("weaponframes", "commander_" .. var_24_3))

			GetImageSpriteFromAtlasAsync = var_12

			local var_24_7 = "CommanderHrz/"

			var_1_10015 = var_24_0

			var_12(var_24_7 .. var_24_0.getPainting(var_1_10015), "", var_24_4:Find("mask/icon"))
		end

		onButton = var_24_3

		local var_24_8 = arg_24_0
		local var_24_9 = var_24_2

		local function var_24_10()
			local var_25_0 = arg_24_0

			var_0.InvokeParent(var_25_0, "openCommanderPanel", arg_24_2, arg_24_2.id)

			return
		end

		SFX_PANEL = var_1_10015

		var_24_3(var_24_8, var_24_9, var_24_10, var_1_10015)

		onButton = var_24_3

		local var_24_11 = arg_24_0
		local var_24_12 = var_24_4

		local function var_24_13()
			local var_26_0 = arg_24_0

			var_0.InvokeParent(var_26_0, "openCommanderPanel", arg_24_2, arg_24_2.id)

			return
		end

		SFX_PANEL = var_1_10015

		var_24_3(var_24_11, var_24_12, var_24_13, var_1_10015)
	end

	return
end

function var_0_1.clearFleets(arg_27_0)
	pairs = var_1_10001

	for iter_27_0, iter_27_1 in var_1_10001(arg_27_0.tfFleets) do
		_ = var_1_10006

		var_1_10006.each(iter_27_1, function(arg_28_0)
			local var_28_0 = arg_27_0

			var_1.clearFleet(var_28_0, arg_28_0)

			return
		end)
	end

	return
end

function var_0_1.clearFleet(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1
	local var_29_1 = arg_29_1.Find

	TeamType = var_1_10004

	local var_29_2 = var_29_1(var_29_0, var_1_10004.Main)
	local var_29_3 = arg_29_1
	local var_29_4 = arg_29_1.Find

	TeamType = var_1_10005

	local var_29_5 = var_29_4(var_29_3, var_1_10005.Vanguard)
	local var_29_6 = arg_29_1
	local var_29_7 = arg_29_1.Find

	TeamType = var_1_10006

	local var_29_8 = var_29_7(var_29_6, var_1_10006.Submarine)

	if var_29_2 then
		removeAllChildren = var_29_6

		var_29_6(var_29_2)
	end

	if var_29_5 then
		removeAllChildren = var_29_6

		var_29_6(var_29_5)
	end

	if var_29_8 then
		removeAllChildren = var_29_6

		var_29_6(var_29_8)
	end

	return
end

function var_0_1.updatePropetyLimit(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.toggleMask, false)

	setActive = var_1_10001

	var_1_10001(arg_30_0.tfLimit, false)

	setActive = var_1_10001

	var_1_10001(arg_30_0.tfLimitTips, false)

	setActive = var_1_10001

	var_1_10001(arg_30_0.tfLimitElite, #arg_30_0.propetyLimitation > 0)

	if #arg_30_0.propetyLimitation > 0 then
		UIItemList = var_1

		local var_30_0 = var_1.New
		local var_30_1 = arg_30_0.tfLimitContainer
		local var_30_2 = arg_30_0.tfLimitContainer
		local var_30_3 = var_30_0(var_30_1, var_3.GetChild(var_30_2, 0))
		local var_30_4, var_30_5 = arg_30_0:IsPropertyLimitationSatisfy()

		var_30_3:make(function(arg_31_0, arg_31_1, arg_31_2)
			arg_31_1 = arg_31_1 + 1
			UIItemList = var_2_10003

			if arg_31_0 == var_2_10003.EventUpdate then
				local var_31_0 = arg_30_0.propetyLimitation[arg_31_1]

				unpack = var_2_10004

				local var_31_1, var_31_2, var_31_3, var_31_4 = var_2_10004(var_31_0)
				local var_31_6

				if var_30_4[arg_31_1] == 1 then
					local var_31_5 = arg_31_2:Find("Text")

					var_31_6 = var_31_6.GetComponent
					typeof = var_10
					Text = var_2_10011
					var_31_6 = var_31_6(var_31_5, var_10(var_2_10011))
					Color = var_31_5
					var_31_6.color = var_31_5.New(1, 0.9607843137254902, 0.5019607843137255)
				else
					local var_31_7 = arg_31_2:Find("Text")

					var_31_6 = var_31_6.GetComponent
					typeof = var_10
					Text = var_2_10011
					var_31_6 = var_31_6(var_31_7, var_10(var_2_10011))
					Color = var_31_7
					var_31_6.color = var_31_7.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)
				end

				setActive = var_31_6

				var_31_6(arg_31_2, true)

				AttributeType = var_31_6

				local var_31_8 = var_31_6.EliteCondition2Name(var_31_1, var_31_4)

				AttributeType = var_9

				local var_31_9 = var_31_8 .. var_9.eliteConditionCompareTip(var_31_2) .. var_31_3

				setText = var_9

				var_9(arg_31_2:Find("Text"), var_31_9)
			end

			return
		end)
		var_30_3:align(#arg_30_0.propetyLimitation)
	end

	return
end

function var_0_1.OnShow(arg_32_0)
	pg = var_1_10001

	local var_32_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_32_0, arg_32_0._tf)

	return
end

function var_0_1.OnHide(arg_33_0)
	pg = var_1_10001

	local var_33_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_33_0, arg_33_0._tf, arg_33_0.viewParent._tf)

	triggerToggle = var_1

	var_1(arg_33_0.commanderToggle, false)

	return
end

function var_0_1.OnCancel(arg_34_0)
	arg_34_0:InvokeParent("hideFleetEdit")

	return
end

function var_0_1.OnCommit(arg_35_0)
	arg_35_0:InvokeParent("commitEdit")

	return
end

function var_0_1.OnCombat(arg_36_0)
	arg_36_0:InvokeParent("commitEdit")
	arg_36_0:InvokeParent("commitCombat")

	return
end

function var_0_1.OnLongPressShip(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0:InvokeParent("openShipInfo", arg_37_1, arg_37_2)

	return
end

function var_0_1.IsPropertyLimitationSatisfy(arg_38_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_38_0 = var_1_10001(var_1_10002)
	local var_38_1 = var_1.getRawData(var_38_0)
	local var_38_2 = arg_38_0.propetyLimitation
	local var_38_3 = {}

	ipairs = var_1_10004

	for iter_38_0, iter_38_1 in var_1_10004(var_38_2) do
		var_38_3[iter_38_1[1]] = 0
	end

	local var_38_4 = 0
	local var_38_5 = {}

	for iter_38_2 = 1, 2 do
		local var_38_6 = arg_38_0.fleets

		FleetType = var_1_10011

		if var_38_6[var_1_10011.Normal][iter_38_2] then
			pairs = var_1_10011

			for iter_38_5, iter_38_4 in var_1_10011(var_10.mainShips) do
				table = var_1_10016

				var_1_10016.insert(var_38_5, iter_38_4)
			end

			pairs = var_1_10011

			for iter_38_5, iter_38_6 in var_1_10011(var_10.vanguardShips) do
				table = var_1_10016

				var_1_10016.insert(var_38_5, iter_38_6)
			end
		end
	end

	local var_38_7 = {}
	local var_38_8 = {}

	ipairs = var_8

	for iter_38_7, iter_38_8 in var_8(var_38_2) do
		unpack = var_1_10013

		local var_38_9, var_38_10

		var_1_10013, iter_38_5, var_38_9, var_38_10 = var_1_10013(iter_38_8)
		string = var_1_10017

		if var_1_10017.sub(var_1_10013, 1, 5) == "fleet" then
			var_38_7[var_1_10013] = 0
			var_38_8[var_1_10013] = var_38_10
		end
	end

	ipairs = var_8

	for iter_38_9, iter_38_10 in var_8(var_38_5) do
		local var_38_11 = var_38_1[iter_38_10]

		var_38_4 = var_38_4 + 1
		intProperties = iter_38_5
		iter_38_5 = iter_38_5(var_38_11:getProperties())
		pairs = var_15

		for iter_38_11, iter_38_12 in var_15(var_38_3) do
			string = var_1_10020

			if var_1_10020.sub(iter_38_11, 1, 5) == "fleet" then
				if iter_38_11 == "fleet_totle_level" then
					var_38_7[iter_38_11] = var_38_7[iter_38_11] + var_38_11.level
				end
			elseif iter_38_11 == "level" then
				var_38_3[iter_38_11] = iter_38_12 + var_38_11.level
			else
				var_38_3[iter_38_11] = iter_38_12 + iter_38_5[iter_38_11]
			end
		end
	end

	pairs = var_8

	for iter_38_13, iter_38_14 in var_8(var_38_7) do
		if iter_38_13 == "fleet_totle_level" and iter_38_14 > var_38_8[iter_38_13] then
			var_38_3[iter_38_13] = var_38_3[iter_38_13] + 1
		end
	end

	local var_38_12 = {}

	ipairs = var_9

	for iter_38_15, iter_38_16 in var_9(var_38_2) do
		unpack = iter_38_5

		local var_38_13, var_38_14

		iter_38_5, var_38_13, var_38_14 = iter_38_5(iter_38_16)

		if iter_38_5 == "level" and 0 < var_38_4 then
			math = var_1_10017
			var_38_3[iter_38_5] = var_1_10017.ceil(var_38_3[iter_38_5] / var_38_4)
		end

		AttributeType = var_1_10017
		var_1_10017 = var_1_10017.EliteConditionCompare(var_38_13, var_38_3[iter_38_5], var_38_14) and 1 or 0
		var_38_12[iter_38_15] = var_1_10017
	end

	return var_38_12, var_38_3
end

function var_0_1.CheckValid(arg_39_0)
	local var_39_0 = arg_39_0.viewParent.contextData.bossActivity
	local var_39_1, var_39_2 = var_1.CheckCntByIdx(var_39_0, arg_39_0.index)

	if not var_39_1 then
		return var_39_1, var_39_2
	end

	local var_39_3, var_39_4 = arg_39_0:IsPropertyLimitationSatisfy()
	local var_39_5 = 1

	ipairs = var_1_10006

	for iter_39_0, iter_39_1 in var_1_10006(var_39_3) do
		var_39_5 = var_39_5 * iter_39_1
	end

	if var_39_5 ~= 1 then
		local var_39_6 = false

		i18n = var_7

		local var_39_7 = var_7("elite_disable_property_unsatisfied")

		return
	end

	return true
end

return var_0_1
