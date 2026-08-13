class = var_0_10000

local var_0_0 = "ActivityFleetPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..level.LevelEliteFleetPanel"))

var_0_1.ON_OPEN_DOCK = "ActivityFleetPanel:ON_OPEN_DOCK"
var_0_1.ON_FLEET_RECOMMEND = "ActivityFleetPanel:ON_FLEET_RECOMMEND"
var_0_1.ON_FLEET_CLEAR = "ActivityFleetPanel:ON_FLEET_CLEAR"

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	return
end

function var_0_1.set(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.groupNum = arg_2_1
	arg_2_0.submarineNum = arg_2_2
	setActive = var_1_10003

	var_1_10003(arg_2_0.tfLimitElite, false)

	setActive = var_1_10003

	var_1_10003(arg_2_0.tfLimitTips, false)

	setActive = var_1_10003

	var_1_10003(arg_2_0.tfLimit, false)

	onButton = var_1_10003

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.btnGo

	local function var_2_2()
		if arg_2_0.onCombat then
			arg_2_0.onCombat()
		end

		return
	end

	SFX_UI_WEIGHANCHOR_GO = var_1_10007

	var_1_10003(var_2_0, var_2_1, var_2_2, var_1_10007)

	onButton = var_1_10003

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.btnBack

	local function var_2_5()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		if arg_2_0.onCommit then
			arg_2_0.onCommit()
		end

		return
	end

	SFX_CANCEL = var_1_10007

	var_1_10003(var_2_3, var_2_4, var_2_5, var_1_10007)

	onButton = var_1_10003

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0._tf

	local function var_2_8()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		if arg_2_0.onCommit then
			arg_2_0.onCommit()
		end

		return
	end

	SFX_CANCEL = var_1_10007

	var_1_10003(var_2_6, var_2_7, var_2_8, var_1_10007)

	onButton = var_1_10003

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.toggleMask

	local function var_2_11()
		local var_6_0 = arg_2_0

		var_0.hideToggleMask(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10007

	var_1_10003(var_2_9, var_2_10, var_2_11, var_1_10007)

	onToggle = var_1_10003

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.commanderBtn

	local function var_2_14(arg_7_0)
		local var_7_0 = arg_2_0.parent.contextData

		var_7_0.showCommander = arg_7_0
		pairs = var_7_0

		for iter_7_0, iter_7_1 in var_7_0(arg_2_0.tfFleets) do
			for iter_7_2 = 1, #iter_7_1 do
				local var_7_1 = arg_2_0

				var_10.updateCommanderBtn(var_7_1, iter_7_0, iter_7_2)
			end
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10003(var_2_12, var_2_13, var_2_14, var_1_10007)

	triggerToggle = var_1_10003

	var_1_10003(arg_2_0.commanderBtn, arg_2_0.parent.contextData.showCommander)

	setActive = var_1_10003

	var_1_10003(arg_2_0.commanderBtn, arg_2_0.parent.openedCommanerSystem)
	arg_2_0:clearFleets()
	arg_2_0:updateFleets()

	return
end

function var_0_1.getLimitNums(arg_8_0, arg_8_1)
	local var_8_0 = 0

	FleetType = var_1_10003

	if arg_8_1 == var_1_10003.Normal then
		var_8_0 = arg_8_0.groupNum
	else
		FleetType = var_3

		if arg_8_1 == var_3.Submarine then
			var_8_0 = arg_8_0.submarineNum
		end
	end

	return var_8_0
end

function var_0_1.updateFleets(arg_9_0)
	pairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.tfFleets) do
		for iter_9_2 = 1, #iter_9_1 do
			arg_9_0:updateFleet(iter_9_0, iter_9_2)
		end
	end

	return
end

function var_0_1.updateLimit(arg_10_0)
	return
end

function var_0_1.updateCommanderBtn(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2 <= arg_11_0:getLimitNums(arg_11_1)
	local var_11_1 = arg_11_0.fleets[arg_11_1][arg_11_2]
	local var_11_2 = arg_11_0.tfFleets[arg_11_1][arg_11_2]
	local var_11_3 = var_5.Find(var_11_2, "btn_select")
	local var_11_4 = var_5:Find("btn_clear")
	local var_11_5 = var_5:Find("btn_recom")
	local var_11_6 = var_5:Find("blank")
	local var_11_7 = var_5
	local var_11_8 = var_5.Find(var_11_7, "commander")

	setActive = var_11_7

	var_11_7(var_11_3, false)

	setActive = var_11_7

	var_11_7(var_11_4, var_11_0 and not arg_11_0.parent.contextData.showCommander)

	setActive = var_11_7

	var_11_7(var_11_5, var_11_0 and not arg_11_0.parent.contextData.showCommander)

	setActive = var_11_7

	var_11_7(var_11_6, not var_11_0 or var_11_0 and not var_11_1 and arg_11_0.parent.contextData.showCommander)

	setActive = var_11_7

	local var_11_9 = var_11_8
	local var_11_10

	if arg_11_0.parent.contextData.showCommander then
		var_11_10 = var_11_0 and var_11_1
	end

	var_11_7(var_11_9, var_11_10)

	return
end

function var_0_1.updateFleet(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:updateCommanderBtn(arg_12_1, arg_12_2)

	local var_12_0 = arg_12_0.fleets[arg_12_1][arg_12_2]
	local var_12_1 = arg_12_2 <= arg_12_0:getLimitNums(arg_12_1)
	local var_12_2 = arg_12_0.tfFleets[arg_12_1][arg_12_2]

	findTF = var_6

	local var_12_3 = var_6(var_12_2, "bg/name")
	local var_12_4 = var_12_2
	local var_12_5 = var_12_2.Find

	TeamType = var_1_10009

	local var_12_6 = var_12_5(var_12_4, var_1_10009.Main)
	local var_12_7 = var_12_2
	local var_12_8 = var_12_2.Find

	TeamType = var_1_10010

	local var_12_9 = var_12_8(var_12_7, var_1_10010.Vanguard)
	local var_12_10 = var_12_2
	local var_12_11 = var_12_2.Find

	TeamType = var_1_10011

	local var_12_12 = var_12_11(var_12_10, var_1_10011.Submarine)
	local var_12_13 = var_12_2:Find("btn_select")
	local var_12_14 = var_12_2:Find("btn_recom")
	local var_12_15 = var_12_2:Find("btn_clear")
	local var_12_16 = var_12_2:Find("blank")
	local var_12_17 = var_12_2:Find("selected")
	local var_12_18 = var_12_2
	local var_12_19 = var_12_2.Find(var_12_18, "commander")

	setActive = var_12_18

	var_12_18(var_12_17, false)

	setText = var_12_18

	var_12_18(var_12_3, "")

	if var_12_6 then
		setActive = var_12_18

		var_12_18(var_12_6, var_12_1 and var_12_0)
	end

	if var_12_9 then
		setActive = var_12_18

		var_12_18(var_12_9, var_12_1 and var_12_0)
	end

	if var_12_12 then
		setActive = var_12_18

		var_12_18(var_12_12, var_12_1 and var_12_0)
	end

	if var_12_1 then
		if var_12_0 then
			setText = var_12_18

			local var_12_20 = var_12_3

			if var_12_0.name == "" then
				Fleet = var_18

				local var_12_21

				if not var_18.DEFAULT_NAME[var_12_0.id] then
					var_12_21 = var_12_0.name
				end

				var_12_18(var_12_20, var_12_21)

				FleetType = var_12_18

				if arg_12_1 == var_12_18.Submarine then
					local var_12_22 = arg_12_0

					var_12_18 = arg_12_0.updateShips

					local var_12_23 = var_12_12
					local var_12_24 = var_12_0.subShips

					var_1_10020 = var_12_0.id
					TeamType = var_1_10021

					var_12_18(var_12_22, var_12_23, var_12_24, var_1_10020, var_1_10021.Submarine, var_12_0)
				else
					local var_12_25 = arg_12_0

					var_12_18 = arg_12_0.updateShips

					local var_12_26 = var_12_6
					local var_12_27 = var_12_0.mainShips

					var_1_10020 = var_12_0.id
					TeamType = var_1_10021

					var_12_18(var_12_25, var_12_26, var_12_27, var_1_10020, var_1_10021.Main, var_12_0)

					local var_12_28 = arg_12_0

					var_12_18 = arg_12_0.updateShips

					local var_12_29 = var_12_9
					local var_12_30 = var_12_0.vanguardShips

					var_1_10020 = var_12_0.id
					TeamType = var_21

					var_12_18(var_12_28, var_12_29, var_12_30, var_1_10020, var_21.Vanguard, var_12_0)
				end

				arg_12_0:updateCommanders(var_12_19, var_12_0)

				onButton = var_12_18

				var_12_18(arg_12_0, var_12_14, function()
					local var_13_0 = arg_12_0.parent

					var_0.emit(var_13_0, var_0_1.ON_FLEET_RECOMMEND, var_12_0.id)

					return
				end)

				onButton = var_12_18

				local var_12_31 = arg_12_0
				local var_12_32 = var_12_15

				local function var_12_33()
					local var_14_0 = arg_12_0.parent

					var_0.emit(var_14_0, var_0_1.ON_FLEET_CLEAR, var_12_0.id)

					return
				end

				SFX_UI_CLICK = var_1_10020

				var_12_18(var_12_31, var_12_32, var_12_33, var_1_10020)

				return
			end
		end
	end
end

function var_0_1.updateCommanders(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0 = 1, 2 do
		local var_15_0 = arg_15_2:getCommanderByPos(iter_15_0)
		local var_15_1 = arg_15_1:Find("pos" .. iter_15_0)
		local var_15_2 = var_8.Find(var_15_1, "add")
		local var_15_3 = var_8
		local var_15_4 = var_8.Find(var_15_3, "info")

		setActive = var_15_3

		var_15_3(var_15_2, not var_15_0)

		setActive = var_15_3

		var_15_3(var_15_4, var_15_0)

		if var_15_0 then
			Commander = var_15_3
			var_15_3 = var_15_3.rarity2Frame(var_15_0:getRarity())
			setImageSprite = var_12

			local var_15_5 = var_15_4
			local var_15_6 = var_15_4.Find(var_15_5, "frame")

			GetSpriteFromAtlas = var_15_5

			var_12(var_15_6, var_15_5("weaponframes", "commander_" .. var_15_3))

			GetImageSpriteFromAtlasAsync = var_12

			local var_15_7 = "CommanderHrz/"

			var_1_10015 = var_15_0

			var_12(var_15_7 .. var_15_0.getPainting(var_1_10015), "", var_15_4:Find("mask/icon"))
		end

		onButton = var_15_3

		local var_15_8 = arg_15_0
		local var_15_9 = var_15_2

		local function var_15_10()
			local var_16_0 = arg_15_0.parent

			var_0.openCommanderPanel(var_16_0, arg_15_2, arg_15_2.id)

			return
		end

		SFX_PANEL = var_1_10015

		var_15_3(var_15_8, var_15_9, var_15_10, var_1_10015)

		onButton = var_15_3

		local var_15_11 = arg_15_0
		local var_15_12 = var_15_4

		local function var_15_13()
			local var_17_0 = arg_15_0.parent

			var_0.openCommanderPanel(var_17_0, arg_15_2, arg_15_2.id)

			return
		end

		SFX_PANEL = var_1_10015

		var_15_3(var_15_11, var_15_12, var_15_13, var_1_10015)
	end

	return
end

function var_0_1.updateShips(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	UIItemList = var_1_10006

	local var_18_0 = var_1_10006.New(arg_18_1, arg_18_0.tfShipTpl)

	var_6.make(var_18_0, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			getProxy = var_3
			BayProxy = var_2_10004

			local var_19_0 = var_3(var_2_10004)

			if var_3.getShipById(var_19_0, arg_18_2[arg_19_1 + 1]) then
				setActive = var_19_0

				var_19_0(arg_19_2:Find("icon_bg"), true)

				setActive = var_19_0

				var_19_0(arg_19_2:Find("empty"), false)

				updateShip = var_19_0

				var_19_0(arg_19_2, var_4)
			else
				setActive = var_19_0

				var_19_0(arg_19_2:Find("icon_bg"), false)

				setActive = var_19_0

				var_19_0(arg_19_2:Find("empty"), true)
			end

			setActive = var_19_0
			findTF = var_6

			var_19_0(var_6(arg_19_2, "ship_type"), false)

			GetOrAddComponent = var_19_0

			local var_19_1 = arg_19_2

			typeof = var_7
			UILongPressTrigger = var_8

			local var_19_2 = var_19_0(var_19_1, var_7(var_8))

			local function var_19_3()
				arg_18_0.onCancel()

				local var_20_0 = arg_18_0.parent

				var_0.emit(var_20_0, var_0_1.ON_OPEN_DOCK, {
					shipType = 0,
					fleet = arg_18_2,
					shipVO = var_0,
					fleetIndex = arg_18_3,
					teamType = arg_18_4
				})

				return
			end

			local var_19_4 = var_19_2.onReleased

			var_7.RemoveAllListeners(var_19_4)

			local var_19_5 = var_19_2.onLongPressed

			var_7.RemoveAllListeners(var_19_5)

			local var_19_6 = var_19_2.onReleased

			var_7.AddListener(var_19_6, function()
				var_19_3()

				return
			end)

			local var_19_7 = var_19_2.onLongPressed

			var_7.AddListener(var_19_7, function()
				if var_0 then
					arg_18_0.onCancel()

					local var_22_0 = arg_18_0.onLongPressShip
					local var_22_1 = var_0.id

					_ = var_3_10002

					local var_22_2 = var_3_10002.map
					local var_22_3 = arg_18_5

					var_22_0(var_22_1, var_22_2(var_3.getShipIds(var_22_3), function(arg_23_0)
						local var_23_0 = var_0

						return var_1.getShipById(var_23_0, arg_23_0)
					end))
				else
					var_19_3()
				end

				return
			end)
		end

		return
	end)
	var_6:align(3)

	return
end

function var_0_1.showToggleMask(arg_24_0, arg_24_1, arg_24_2)
	setActive = var_1_10003

	var_1_10003(arg_24_0.toggleMask, true)

	_ = var_1_10003

	local var_24_0 = var_1_10003.filter(arg_24_0.fleets, function(arg_25_0)
		return arg_25_0:getFleetType() == arg_24_1
	end)

	ipairs = var_4

	for iter_24_0, iter_24_1 in var_4(arg_24_0.toggles) do
		local var_24_1 = var_24_0[iter_24_0]

		setActive = var_1_10010

		var_1_10010(iter_24_1, var_24_1)

		if var_24_1 then
			local var_24_2

			var_1_10010, var_24_2 = var_24_1:isUnlock()

			local var_24_3 = iter_24_1
			local var_24_4 = iter_24_1.Find(var_24_3, "lock")

			setButtonEnabled = var_24_3

			var_24_3(iter_24_1, var_1_10010)

			setActive = var_24_3

			var_24_3(var_24_4, not var_1_10010)

			if var_1_10010 then
				table = var_24_3
				var_24_3 = var_24_3.contains(arg_24_0.selectIds[arg_24_1], var_24_1.id)
				setActive = var_14
				findTF = var_15

				var_14(var_15(iter_24_1, "selected"), var_24_3)

				setActive = var_14
				findTF = var_15

				var_14(var_15(iter_24_1, "text"), not var_24_3)

				setActive = var_14
				findTF = var_15

				var_14(var_15(iter_24_1, "text_selected"), var_24_3)

				onButton = var_14

				local var_24_5 = arg_24_0
				local var_24_6 = iter_24_1

				function var_1_10017()
					arg_24_2(var_24_1.id)

					return
				end

				SFX_UI_TAG = var_1_10018

				var_14(var_24_5, var_24_6, var_1_10017, var_1_10018)
			else
				onButton = var_24_3

				local var_24_7 = arg_24_0
				local var_24_8 = var_24_4

				local function var_24_9()
					pg = var_2_10000

					local var_27_0 = var_2_10000.TipsMgr.GetInstance()

					var_0.ShowTips(var_27_0, var_24_2)

					return
				end

				SFX_UI_CLICK = var_1_10017

				var_24_3(var_24_7, var_24_8, var_24_9, var_1_10017)
			end
		end
	end

	return
end

function var_0_1.hideToggleMask(arg_28_0)
	setActive = var_1_10001

	var_1_10001(arg_28_0.toggleMask, false)

	return
end

function var_0_1.setFleets(arg_29_0, arg_29_1)
	local var_29_0 = {}

	FleetType = var_1_10003
	var_29_0[var_1_10003.Normal] = {}
	FleetType = var_3
	var_29_0[var_3.Submarine] = {}
	arg_29_0.fleets = var_29_0
	pairs = var_29_0

	for iter_29_0, iter_29_1 in var_29_0(arg_29_1) do
		local var_29_1

		if iter_29_1:isSubmarineFleet() then
			table = var_29_1
			var_29_1 = var_29_1.insert

			local var_29_2 = arg_29_0.fleets

			FleetType = var_1_10009

			var_29_1(var_29_2[var_1_10009.Submarine], iter_29_1)
		else
			table = var_29_1

			local var_29_3 = var_29_1.insert
			local var_29_4 = arg_29_0.fleets

			FleetType = var_1_10009

			var_29_3(var_29_4[var_1_10009.Normal], iter_29_1)
		end
	end

	return
end

function var_0_1.clearFleets(arg_30_0)
	pairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0.tfFleets) do
		_ = var_1_10006

		var_1_10006.each(iter_30_1, function(arg_31_0)
			local var_31_0 = arg_30_0

			var_1.clearFleet(var_31_0, arg_31_0)

			return
		end)
	end

	return
end

function var_0_1.clearFleet(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1
	local var_32_1 = arg_32_1.Find

	TeamType = var_1_10004

	local var_32_2 = var_32_1(var_32_0, var_1_10004.Main)
	local var_32_3 = arg_32_1
	local var_32_4 = arg_32_1.Find

	TeamType = var_1_10005

	local var_32_5 = var_32_4(var_32_3, var_1_10005.Vanguard)
	local var_32_6 = arg_32_1
	local var_32_7 = arg_32_1.Find

	TeamType = var_1_10006

	local var_32_8 = var_32_7(var_32_6, var_1_10006.Submarine)

	if var_32_2 then
		removeAllChildren = var_32_6

		var_32_6(var_32_2)
	end

	if var_32_5 then
		removeAllChildren = var_32_6

		var_32_6(var_32_5)
	end

	if var_32_8 then
		removeAllChildren = var_32_6

		var_32_6(var_32_8)
	end

	return
end

function var_0_1.clear(arg_33_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_33_0.commanderBtn, false)

	return
end

return var_0_1
