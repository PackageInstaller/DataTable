class = var_0_10000

local var_0_0 = "WSFleetPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	map = "table",
	onCancel = "function",
	btnGo = "userdata",
	transform = "userdata",
	toggles = "table",
	rtLimitTips = "userdata",
	btnBack = "userdata",
	toggleList = "userdata",
	toggleMask = "userdata",
	rtShipTpl = "userdata",
	rtEmptyTpl = "userdata",
	fleets = "table",
	onConfirm = "function",
	rtFleets = "table",
	rtLimitElite = "userdata",
	rtLimit = "userdata",
	selectIds = "table"
}

function var_0_1.Setup(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_1.Dispose(arg_2_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0.transform

	arg_3_0.rtShipTpl = var_1.Find(var_3_0, "panel/shiptpl")
	arg_3_0.rtEmptyTpl = var_1:Find("panel/emptytpl")

	local var_3_1 = {}

	FleetType = var_1_10003
	var_3_1[var_1_10003.Normal] = {
		var_1:Find("panel/bg/content/fleet/1"),
		var_1:Find("panel/bg/content/fleet/2"),
		var_1:Find("panel/bg/content/fleet/3"),
		var_1:Find("panel/bg/content/fleet/4")
	}
	FleetType = var_3
	var_3_1[var_3.Submarine] = {
		var_1:Find("panel/bg/content/sub/1")
	}
	arg_3_0.rtFleets = var_3_1
	arg_3_0.rtLimit = var_1:Find("panel/limit")
	arg_3_0.rtLimitElite = var_1:Find("panel/limit_elite")
	arg_3_0.rtLimitTips = var_1:Find("panel/limit_tip")
	arg_3_0.btnBack = var_1:Find("panel/btnBack")
	arg_3_0.btnGo = var_1:Find("panel/start_button")
	arg_3_0.toggleMask = var_1:Find("mask")
	arg_3_0.toggleList = var_1:Find("mask/list")
	arg_3_0.toggles = {}

	for iter_3_0 = 0, arg_3_0.toggleList.childCount - 1 do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_3_2 = arg_3_0.toggles
		local var_3_3 = arg_3_0.toggleList

		var_1_10006(var_3_2, var_9.Find(var_3_3, "item" .. iter_3_0 + 1))
	end

	setActive = var_2

	var_2(arg_3_0.rtShipTpl, false)

	setActive = var_2

	var_2(arg_3_0.rtEmptyTpl, false)

	setActive = var_2

	var_2(arg_3_0.toggleMask, false)

	return
end

function var_0_1.UpdateMulti(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.map = arg_4_1
	_ = var_1_10004
	_ = var_1_10006

	local var_4_0 = var_1_10004(var_1_10006.values(arg_4_2))
	local var_4_1 = var_4.chain(var_4_0)
	local var_4_2 = var_4.filter(var_4_1, function(arg_5_0)
		return arg_5_0:isRegularFleet()
	end)
	local var_4_3 = var_4.sort(var_4_2, function(arg_6_0, arg_6_1)
		return arg_6_0.id < arg_6_1.id
	end)

	arg_4_0.fleets = var_4.value(var_4_3)

	local var_4_4 = {}

	FleetType = var_1_10005
	var_4_4[var_1_10005.Normal] = {}
	FleetType = var_5
	var_4_4[var_5.Submarine] = {}
	arg_4_0.selectIds = var_4_4
	ipairs = var_4_4

	for iter_4_0, iter_4_1 in var_4_4(arg_4_3 or {}) do
		if arg_4_0:getFleetById(iter_4_1) then
			local var_4_5 = var_1_10009:getFleetType()

			if #arg_4_0.selectIds[var_4_5] < arg_4_0:getLimitNums(var_4_5) then
				table = var_12

				var_12.insert(var_11, iter_4_1)
			end
		end
	end

	setActive = var_4

	var_4(arg_4_0.rtLimitElite, false)

	setActive = var_4

	var_4(arg_4_0.rtLimitTips, false)

	setActive = var_4

	var_4(arg_4_0.rtLimit, true)

	onButton = var_4

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.btnGo

	local function var_4_8()
		local var_7_0 = arg_4_0.onConfirm
		local var_7_1 = arg_4_0

		var_7_0(var_2.getSelectIds(var_7_1))

		return
	end

	SFX_UI_WEIGHANCHOR_GO = var_1_10009

	var_4(var_4_6, var_4_7, var_4_8, var_1_10009)

	onButton = var_4

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.btnBack

	local function var_4_11()
		arg_4_0.onCancel()

		return
	end

	SFX_CANCEL = var_1_10009

	var_4(var_4_9, var_4_10, var_4_11, var_1_10009)

	onButton = var_4

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0.transform

	local function var_4_14()
		arg_4_0.onCancel()

		return
	end

	SFX_CANCEL = var_1_10009

	var_4(var_4_12, var_4_13, var_4_14, var_1_10009)

	onButton = var_4

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.toggleMask

	local function var_4_17()
		local var_10_0 = arg_4_0

		var_0.hideToggleMask(var_10_0)

		return
	end

	SFX_CANCEL = var_1_10009

	var_4(var_4_15, var_4_16, var_4_17, var_1_10009)
	arg_4_0:clearFleets()
	arg_4_0:updateFleets()
	arg_4_0:updateLimit()

	return
end

function var_0_1.getFleetById(arg_11_0, arg_11_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_11_0.fleets, function(arg_12_0)
		return arg_12_0.id == arg_11_1
	end)
end

function var_0_1.getLimitNums(arg_13_0, arg_13_1)
	local var_13_0 = 0

	FleetType = var_1_10003

	if arg_13_1 == var_1_10003.Normal then
		var_13_0 = 4
	else
		FleetType = var_3

		if arg_13_1 == var_3.Submarine then
			var_13_0 = 1
		end
	end

	return var_13_0
end

function var_0_1.getSelectIds(arg_14_0)
	local var_14_0 = {}

	pairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0.selectIds) do
		ipairs = var_1_10007

		for iter_14_2, iter_14_3 in var_1_10007(iter_14_1) do
			if 0 < iter_14_3 then
				table = var_12

				var_12.insert(var_14_0, iter_14_3)
			end
		end
	end

	_ = var_2

	var_2.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0 < arg_15_1
	end)

	return var_14_0
end

function var_0_1.updateFleets(arg_16_0)
	pairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(arg_16_0.rtFleets) do
		for iter_16_2 = 1, #iter_16_1 do
			arg_16_0:updateFleet(iter_16_0, iter_16_2)
		end
	end

	return
end

function var_0_1.updateLimit(arg_17_0)
	_ = var_1_10001

	local var_17_0 = var_1_10001.filter
	local var_17_1 = arg_17_0.selectIds

	FleetType = var_1_10004

	local var_17_2 = #var_17_0(var_17_1[var_1_10004.Normal], function(arg_18_0)
		return arg_18_0 > 0
	end)

	_ = var_1_10002

	local var_17_3 = var_1_10002.filter
	local var_17_4 = arg_17_0.selectIds

	FleetType = var_1_10005

	local var_17_5 = #var_17_3(var_17_4[var_1_10005.Submarine], function(arg_19_0)
		return arg_19_0 > 0
	end)
	local var_17_6 = arg_17_0
	local var_17_7 = arg_17_0.getLimitNums

	FleetType = var_1_10006

	local var_17_8 = var_17_7(var_17_6, var_1_10006.Normal)

	setText = var_4

	local var_17_9 = arg_17_0.rtLimit
	local var_17_10 = var_6.Find(var_17_9, "number")

	string = var_1_10007

	var_4(var_17_10, var_1_10007.format("%d/%d", var_17_2, var_17_8))

	local var_17_11 = arg_17_0
	local var_17_12 = arg_17_0.getLimitNums

	FleetType = var_7

	local var_17_13 = var_17_12(var_17_11, var_7.Submarine)

	setText = var_17_6

	local var_17_14 = arg_17_0.rtLimit
	local var_17_15 = var_7.Find(var_17_14, "number_sub")

	string = var_17_9

	var_17_6(var_17_15, var_17_9.format("%d/%d", var_17_5, var_17_13))

	return
end

function var_0_1.selectFleet(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	fleetId = var_1_10004

	if var_1_10004 ~= arg_20_3 then
		local var_20_0 = arg_20_0.selectIds[arg_20_1]

		if 0 < arg_20_3 then
			table = var_5

			if var_5.contains(var_20_0, arg_20_3) then
				return
			end
		end

		FleetType = var_5

		if arg_20_1 == var_5.Normal and arg_20_0:getLimitNums(arg_20_1) > 0 and arg_20_3 == 0 then
			_ = var_5

			if #var_5.filter(var_20_0, function(arg_21_0)
				return arg_21_0 > 0
			end) == 1 then
				pg = var_5

				local var_20_1 = var_5.TipsMgr.GetInstance()
				local var_20_2 = var_5.ShowTips

				i18n = var_8

				var_20_2(var_20_1, var_8("level_fleet_lease_one_ship"))

				return
			end
		end

		if arg_20_0:getFleetById(arg_20_3) then
			if not var_5:isUnlock() then
				return
			end

			if var_5:isLegalToFight() ~= true then
				pg = var_6

				local var_20_3 = var_6.TipsMgr.GetInstance()
				local var_20_4 = var_6.ShowTips

				i18n = var_1_10009

				var_20_4(var_20_3, var_1_10009("level_fleet_not_enough"))

				return
			end
		end

		var_20_0[arg_20_2] = arg_20_3

		arg_20_0:updateFleet(arg_20_1, arg_20_2)
		arg_20_0:updateLimit()
	end

	return
end

function var_0_1.updateFleet(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.selectIds[arg_22_1][arg_22_2]
	local var_22_1 = arg_22_0:getFleetById(var_22_0)
	local var_22_2 = arg_22_2 <= arg_22_0:getLimitNums(arg_22_1)
	local var_22_3 = arg_22_0.rtFleets[arg_22_1][arg_22_2]
	local var_22_4 = var_7.Find(var_22_3, "bg/name")
	local var_22_5 = var_7:Find("main")
	local var_22_6 = var_7:Find("vanguard")
	local var_22_7 = var_7:Find("sub")
	local var_22_8 = var_7:Find("btn_select")
	local var_22_9 = var_7:Find("btn_recom")
	local var_22_10 = var_7:Find("btn_clear")
	local var_22_11 = var_7
	local var_22_12 = var_7.Find(var_22_11, "blank")
	local var_22_13 = var_7:Find("selected")

	setText = var_22_11

	var_22_11(var_22_4, "")

	setActive = var_22_11

	var_22_11(var_22_13, false)

	setActive = var_22_11

	var_22_11(var_22_8, var_22_2)

	setActive = var_22_11

	var_22_11(var_22_10, var_22_2)

	setActive = var_22_11

	var_22_11(var_22_9, false)

	setActive = var_22_11

	var_22_11(var_22_12, not var_22_2)

	if var_22_5 then
		setActive = var_22_11

		var_22_11(var_22_5, var_22_2 and var_22_1)
	end

	if var_22_6 then
		setActive = var_22_11

		var_22_11(var_22_6, var_22_2 and var_22_1)
	end

	if var_22_7 then
		setActive = var_22_11

		var_22_11(var_22_7, var_22_2 and var_22_1)
	end

	if var_22_2 then
		if var_22_1 then
			setText = var_22_11

			local var_22_14 = var_22_4

			if var_22_1.name == "" then
				Fleet = var_20

				local var_22_15

				if not var_20.DEFAULT_NAME[var_22_1.id] then
					var_22_15 = var_22_1.name
				end

				var_22_11(var_22_14, var_22_15)

				FleetType = var_22_11

				if arg_22_1 == var_22_11.Submarine then
					arg_22_0:updateShips(var_22_7, var_22_1.subShips)
				else
					arg_22_0:updateShips(var_22_5, var_22_1.mainShips)
					arg_22_0:updateShips(var_22_6, var_22_1.vanguardShips)
				end

				onButton = var_22_11

				local var_22_16 = arg_22_0
				local var_22_17 = var_22_8

				local function var_22_18()
					arg_22_0.toggleList.position = (var_22_8.position + var_22_10.position) / 2

					local var_23_0 = arg_22_0.toggleList
					local var_23_1 = arg_22_0.toggleList.anchoredPosition

					Vector2 = var_2
					var_23_0.anchoredPosition = var_23_1 + var_2(-arg_22_0.toggleList.rect.width / 2, -var_22_8.rect.height / 2)

					local var_23_2 = arg_22_0

					var_0.showToggleMask(var_23_2, arg_22_1, function(arg_24_0)
						local var_24_0 = arg_22_0

						var_1.hideToggleMask(var_24_0)

						local var_24_1 = arg_22_0

						var_1.selectFleet(var_24_1, arg_22_1, arg_22_2, arg_24_0)

						return
					end)

					return
				end

				SFX_UI_CLICK = var_1_10022

				var_22_11(var_22_16, var_22_17, var_22_18, var_1_10022)

				onButton = var_22_11

				local var_22_19 = arg_22_0
				local var_22_20 = var_22_10

				local function var_22_21()
					local var_25_0 = arg_22_0

					var_0.selectFleet(var_25_0, arg_22_1, arg_22_2, 0)

					return
				end

				SFX_UI_CLICK = var_1_10022

				var_22_11(var_22_19, var_22_20, var_22_21, var_1_10022)

				return
			end
		end
	end
end

function var_0_1.updateShips(arg_26_0, arg_26_1, arg_26_2)
	UIItemList = var_1_10003

	local var_26_0 = var_1_10003.New(arg_26_1, arg_26_0.rtShipTpl)

	var_3.make(var_26_0, function(arg_27_0, arg_27_1, arg_27_2)
		UIItemList = var_2_10003

		if arg_27_0 == var_2_10003.EventUpdate then
			getProxy = var_3
			BayProxy = var_2_10005

			local var_27_0 = var_3(var_2_10005)
			local var_27_1 = var_3.getShipById(var_27_0, arg_26_2[arg_27_1 + 1])

			updateShip = var_2_10005

			var_2_10005(arg_27_2, var_27_1)

			local var_27_2 = arg_27_2
			local var_27_3 = arg_27_2.Find(var_27_2, "icon_bg/energy")

			if var_27_1:getEnergeConfig() and var_6.id <= 2 then
				setActive = var_27_2

				var_27_2(var_27_3, true)

				GetImageSpriteFromAtlasAsync = var_27_2

				var_27_2("energy", var_6.icon, var_27_3)
			else
				setActive = var_27_2

				var_27_2(var_27_3, false)
			end
		end

		return
	end)
	var_3:align(#arg_26_2)

	return
end

function var_0_1.showToggleMask(arg_28_0, arg_28_1, arg_28_2)
	setActive = var_1_10003

	var_1_10003(arg_28_0.toggleMask, true)

	_ = var_1_10003

	local var_28_0 = var_1_10003.filter(arg_28_0.fleets, function(arg_29_0)
		return arg_29_0:getFleetType() == arg_28_1
	end)

	ipairs = var_1_10004

	for iter_28_0, iter_28_1 in var_1_10004(arg_28_0.toggles) do
		local var_28_1 = var_28_0[iter_28_0]

		setActive = var_1_10010

		var_1_10010(iter_28_1, var_28_1)

		if var_28_1 then
			local var_28_2

			var_1_10010, var_28_2 = var_28_1:isUnlock()

			local var_28_3 = iter_28_1
			local var_28_4 = iter_28_1.Find(var_28_3, "lock")

			setButtonEnabled = var_28_5

			var_28_5(iter_28_1, var_1_10010)

			setActive = var_28_5

			var_28_5(var_28_4, not var_1_10010)

			local var_28_5

			if var_1_10010 then
				table = var_28_5
				var_28_5 = var_28_5.contains(arg_28_0.selectIds[arg_28_1], var_28_1.id)
				setActive = var_28_3
				var_1_10018 = iter_28_1

				var_28_3(iter_28_1.Find(var_1_10018, "selected"), var_28_5)

				setActive = var_28_3
				var_1_10018 = iter_28_1

				var_28_3(iter_28_1.Find(var_1_10018, "text"), not var_28_5)

				setActive = var_28_3
				var_1_10018 = iter_28_1

				var_28_3(iter_28_1.Find(var_1_10018, "text_selected"), var_28_5)

				onButton = var_28_3

				local var_28_6 = arg_28_0
				local var_28_7 = iter_28_1

				function var_1_10018()
					arg_28_2(var_28_1.id)

					return
				end

				SFX_UI_TAG = var_19

				var_28_3(var_28_6, var_28_7, var_1_10018, var_19)
			else
				onButton = var_28_5

				local var_28_8 = arg_28_0
				local var_28_9 = var_28_4

				local function var_28_10()
					pg = var_2_10000

					local var_31_0 = var_2_10000.TipsMgr.GetInstance()

					var_0.ShowTips(var_31_0, var_28_2)

					return
				end

				SFX_UI_CLICK = var_1_10018

				var_28_5(var_28_8, var_28_9, var_28_10, var_1_10018)
			end
		end
	end

	return
end

function var_0_1.hideToggleMask(arg_32_0)
	setActive = var_1_10001

	var_1_10001(arg_32_0.toggleMask, false)

	return
end

function var_0_1.clearFleets(arg_33_0)
	pairs = var_1_10001

	for iter_33_0, iter_33_1 in var_1_10001(arg_33_0.rtFleets) do
		_ = var_1_10006

		var_1_10006.each(iter_33_1, function(arg_34_0)
			local var_34_0 = arg_33_0

			var_1.clearFleet(var_34_0, arg_34_0)

			return
		end)
	end

	return
end

function var_0_1.clearFleet(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1:Find("main")
	local var_35_1 = arg_35_1
	local var_35_2 = arg_35_1.Find(var_35_1, "vanguard")
	local var_35_3 = arg_35_1:Find("sub")

	if var_35_0 then
		removeAllChildren = var_35_1

		var_35_1(var_35_0)
	end

	if var_35_2 then
		removeAllChildren = var_35_1

		var_35_1(var_35_2)
	end

	if var_35_3 then
		removeAllChildren = var_35_1

		var_35_1(var_35_3)
	end

	return
end

return var_0_1
