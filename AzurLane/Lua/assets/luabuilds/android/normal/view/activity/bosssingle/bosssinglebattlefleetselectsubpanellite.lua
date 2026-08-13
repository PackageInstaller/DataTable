class = var_0_10000

local var_0_0 = "BossSingleBattleFleetSelectSubPanelLite"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "BossSingleFleetSelectView"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.tfShipTpl = var_1.Find(var_2_0, "panel/shiptpl")

	local var_2_1 = arg_2_0._tf

	arg_2_0.tfEmptyTpl = var_1.Find(var_2_1, "panel/emptytpl")

	local var_2_2 = {}

	FleetType = var_2_1

	local var_2_3 = var_2_1.Normal
	local var_2_4 = {}
	local var_2_5 = arg_2_0._tf

	var_2_4[1] = var_4.Find(var_2_5, "panel/fleet/1")

	local var_2_6 = arg_2_0._tf

	var_2_4[2] = var_4.Find(var_2_6, "panel/fleet/2")
	var_2_2[var_2_3] = var_2_4
	FleetType = var_2_3

	local var_2_7 = var_2_3.Submarine
	local var_2_8 = {}
	local var_2_9 = arg_2_0._tf

	var_2_8[1] = var_4.Find(var_2_9, "panel/sub/1")
	var_2_2[var_2_7] = var_2_8
	arg_2_0.tfFleets = var_2_2

	local var_2_10 = arg_2_0._tf

	arg_2_0.limitList = var_1.Find(var_2_10, "panel/limit_list")

	local var_2_11 = arg_2_0._tf

	arg_2_0.btnBack = var_1.Find(var_2_11, "panel/btnBack")

	local var_2_12 = arg_2_0._tf

	arg_2_0.btnGo = var_1.Find(var_2_12, "panel/start_button")

	local var_2_13 = arg_2_0._tf

	arg_2_0.btnTry = var_1.Find(var_2_13, "panel/try_button")

	local var_2_14 = arg_2_0._tf

	arg_2_0.btnASHelp = var_1.Find(var_2_14, "panel/title/ASvalue")

	local var_2_15 = arg_2_0._tf

	arg_2_0.commanderToggle = var_1.Find(var_2_15, "panel/commander_btn")

	local var_2_16 = arg_2_0._tf

	arg_2_0.formationToggle = var_1.Find(var_2_16, "panel/formation_btn")

	local var_2_17 = arg_2_0._tf

	arg_2_0.toggleMask = var_1.Find(var_2_17, "mask")

	local var_2_18 = arg_2_0._tf

	arg_2_0.toggleList = var_1.Find(var_2_18, "mask/list")
	arg_2_0.toggles = {}

	for iter_2_0 = 0, arg_2_0.toggleList.childCount - 1 do
		table = var_2_9
		var_2_9 = var_2_9.insert

		local var_2_19 = arg_2_0.toggles
		local var_2_20 = arg_2_0.toggleList

		var_2_9(var_2_19, var_7.Find(var_2_20, "item" .. iter_2_0 + 1))
	end

	local var_2_21 = arg_2_0._tf

	arg_2_0.btnSp = var_1.Find(var_2_21, "panel/sp")

	local var_2_22 = arg_2_0._tf

	arg_2_0.spMask = var_1.Find(var_2_22, "mask_sp")
	setActive = var_1

	var_1(arg_2_0.tfShipTpl, false)

	setActive = var_1

	var_1(arg_2_0.tfEmptyTpl, false)

	setActive = var_1

	var_1(arg_2_0.toggleMask, false)

	setActive = var_1

	var_1(arg_2_0.btnSp, false)

	setActive = var_1

	var_1(arg_2_0.spMask, false)

	setActive = var_1

	var_1(arg_2_0.btnASHelp, false)

	setActive = var_1

	var_1(arg_2_0.commanderToggle, false)

	setActive = var_1

	var_1(arg_2_0.btnTry, false)

	setActive = var_1

	var_1(arg_2_0.limitList, false)

	setText = var_1

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_2.Find(var_2_23, "panel/formation_btn/text")

	i18n = var_2_23

	var_1(var_2_24, var_2_23("autofight_formation"))

	setText = var_1

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_2.Find(var_2_25, "panel/commander_btn/text")

	i18n = var_2_25

	var_1(var_2_26, var_2_25("autofight_cat"))

	setText = var_1

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_2.Find(var_2_27, "panel/title/Image/text")

	i18n = var_2_27

	var_1(var_2_28, var_2_27("fleet_select_title"))
	arg_2_0:InitInteractable()

	return
end

function var_0_1.InitInteractable(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.btnGo

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.OnCombat(var_4_0)

		local var_4_1 = arg_3_0

		var_0.OnHide(var_4_1)

		return
	end

	SFX_UI_WEIGHANCHOR_GO = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.btnBack

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.OnHide(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.OnHide(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.toggleMask

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.hideToggleMask(var_7_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	return
end

function var_0_1.SetFleets(arg_8_0, arg_8_1)
	local var_8_0 = {}

	FleetType = var_1_10003
	var_8_0[var_1_10003.Normal] = {
		1
	}
	FleetType = var_3
	var_8_0[var_3.Submarine] = {}
	arg_8_0.selectIds = var_8_0
	_ = var_8_0
	_ = var_3

	local var_8_1 = var_8_0(var_3.values(arg_8_1))
	local var_8_2 = var_2.chain(var_8_1)
	local var_8_3 = var_2.filter(var_8_2, function(arg_9_0)
		return arg_9_0:isRegularFleet()
	end)
	local var_8_4 = var_2.sort(var_8_3, function(arg_10_0, arg_10_1)
		return arg_10_0.id < arg_10_1.id
	end)

	arg_8_0.fleets = var_2.value(var_8_4)

	return
end

function var_0_1.SetSettings(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0.groupNum = arg_11_1
	arg_11_0.submarineNum = arg_11_2
	arg_11_0.stageID = arg_11_3
	arg_11_0.system = arg_11_4
	arg_11_0.actID = arg_11_5

	return
end

function var_0_1.UpdateView(arg_12_0)
	arg_12_0:clearFleets()
	arg_12_0:UpdateFleets()

	return
end

function var_0_1.getLimitNums(arg_13_0, arg_13_1)
	local var_13_0 = 0

	FleetType = var_1_10003

	if arg_13_1 == var_1_10003.Normal then
		var_13_0 = arg_13_0.groupNum
	else
		FleetType = var_3

		if arg_13_1 == var_3.Submarine then
			var_13_0 = arg_13_0.submarineNum
		end
	end

	return var_13_0 or 0
end

function var_0_1.UpdateFleets(arg_14_0)
	pairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.tfFleets) do
		for iter_14_2 = 1, #iter_14_1 do
			arg_14_0:updateFleet(iter_14_0, iter_14_2)
		end
	end

	return
end

function var_0_1.showToggleMask(arg_15_0, arg_15_1, arg_15_2)
	setActive = var_1_10003

	var_1_10003(arg_15_0.toggleMask, true)

	_ = var_1_10003

	local var_15_0 = var_1_10003.filter(arg_15_0.fleets, function(arg_16_0)
		return arg_16_0:getFleetType() == arg_15_1
	end)

	ipairs = var_4

	for iter_15_0, iter_15_1 in var_4(arg_15_0.toggles) do
		local var_15_1 = var_15_0[iter_15_0]

		setActive = var_1_10010

		var_1_10010(iter_15_1, var_15_1)

		if var_15_1 then
			local var_15_2 = iter_15_1

			var_1_10010 = iter_15_1.GetComponent
			typeof = var_12
			Toggle = var_1_10013
			var_1_10010 = var_1_10010(var_15_2, var_12(var_1_10013))

			local var_15_3 = iter_15_1:Find("lock")

			var_1_10013 = var_15_1

			local var_15_4

			var_15_4, var_1_10013 = var_15_1.isUnlock(var_1_10013)
			setToggleEnabled = var_1_10014

			var_1_10014(iter_15_1, var_15_4)

			setActive = var_1_10014

			var_1_10014(var_15_3, not var_15_4)

			table = var_1_10014
			var_1_10014 = var_1_10014.contains(arg_15_0.selectIds[arg_15_1], var_15_1.id)
			setActive = var_15

			var_15(iter_15_1:Find("on"), var_1_10014)

			setActive = var_15

			var_15(iter_15_1:Find("off"), not var_1_10014)

			if var_15_4 then
				var_1_10010.isOn = false
				onToggle = var_15

				local var_15_5 = arg_15_0
				local var_15_6 = iter_15_1

				local function var_15_7(arg_17_0)
					if arg_17_0 then
						setActive = var_2_10001

						var_2_10001(arg_15_0.toggleMask, false)
						arg_15_2(var_15_1.id)
					end

					return
				end

				SFX_UI_TAG = var_1_10019

				var_15(var_15_5, var_15_6, var_15_7, var_1_10019)
			else
				onButton = var_15

				local var_15_8 = arg_15_0
				local var_15_9 = var_15_3

				local function var_15_10()
					pg = var_2_10000

					local var_18_0 = var_2_10000.TipsMgr.GetInstance()

					var_0.ShowTips(var_18_0, var_1_10013)

					return
				end

				SFX_UI_CLICK = var_1_10019

				var_15(var_15_8, var_15_9, var_15_10, var_1_10019)
			end
		end
	end

	return
end

function var_0_1.hideToggleMask(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0.toggleMask, false)

	return
end

function var_0_1.updateFleet(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2 <= arg_20_0:getLimitNums(arg_20_1)
	local var_20_1 = arg_20_0.selectIds[arg_20_1][arg_20_2]
	local var_20_2 = arg_20_0:getFleetById(var_20_1)
	local var_20_3 = arg_20_0.tfFleets[arg_20_1][arg_20_2]

	findTF = var_8

	local var_20_4 = var_8(var_20_3, "bg/name")
	local var_20_5 = var_20_3
	local var_20_6 = var_20_3.Find

	TeamType = var_1_10011

	local var_20_7 = var_20_6(var_20_5, var_1_10011.Main)
	local var_20_8 = var_20_3
	local var_20_9 = var_20_3.Find

	TeamType = var_1_10012

	local var_20_10 = var_20_9(var_20_8, var_1_10012.Vanguard)
	local var_20_11 = var_20_3
	local var_20_12 = var_20_3.Find

	TeamType = var_1_10013

	local var_20_13 = var_20_12(var_20_11, var_1_10013.Submarine)

	setActive = var_20_11

	var_20_11(var_20_3:Find("btn_recom"), false)

	local var_20_14 = var_20_3
	local var_20_15 = var_20_3.Find(var_20_14, "btn_clear")

	setActive = var_20_14

	var_20_14(var_20_15, false)

	local var_20_16 = var_20_3
	local var_20_17 = var_20_3.Find(var_20_16, "btn_select")

	setActive = var_20_16

	var_20_16(var_20_17, var_20_0)

	local var_20_18 = var_20_3:Find("selected")
	local var_20_19 = var_20_3
	local var_20_20 = var_20_3.Find(var_20_19, "commander")

	setActive = var_20_19

	var_20_19(var_20_18, false)

	setText = var_20_19

	var_20_19(var_20_4, "")

	if var_20_7 then
		setActive = var_20_19

		var_20_19(var_20_7, var_20_0 and var_20_2)
	end

	if var_20_10 then
		setActive = var_20_19

		var_20_19(var_20_10, var_20_0 and var_20_2)
	end

	if var_20_13 then
		setActive = var_20_19

		var_20_19(var_20_13, var_20_0 and var_20_2)
	end

	if var_20_0 and var_20_2 then
		setText = var_20_19

		local var_20_21 = var_20_4
		local var_20_22

		if not var_20_2 or not var_20_2:GetName() then
			var_20_22 = ""
		end

		var_20_19(var_20_21, var_20_22)

		FleetType = var_20_19

		if arg_20_1 == var_20_19.Submarine then
			local var_20_23 = arg_20_0

			var_20_19 = arg_20_0.updateShips

			local var_20_24 = var_20_13
			local var_20_25 = var_20_2.subShips

			var_1_10020 = var_20_2.id
			TeamType = var_1_10021

			var_20_19(var_20_23, var_20_24, var_20_25, var_1_10020, var_1_10021.Submarine)
		else
			local var_20_26 = arg_20_0

			var_20_19 = arg_20_0.updateShips

			local var_20_27 = var_20_7
			local var_20_28 = var_20_2.mainShips

			var_1_10020 = var_20_2.id
			TeamType = var_1_10021

			var_20_19(var_20_26, var_20_27, var_20_28, var_1_10020, var_1_10021.Main)

			local var_20_29 = arg_20_0

			var_20_19 = arg_20_0.updateShips

			local var_20_30 = var_20_10
			local var_20_31 = var_20_2.vanguardShips

			var_1_10020 = var_20_2.id
			TeamType = var_21

			var_20_19(var_20_29, var_20_30, var_20_31, var_1_10020, var_21.Vanguard)
		end
	end

	onButton = var_20_19

	local var_20_32 = arg_20_0
	local var_20_33 = var_20_17

	local function var_20_34()
		arg_20_0.toggleList.position = (var_20_17.position + var_20_15.position) / 2

		local var_21_0 = arg_20_0.toggleList
		local var_21_1 = arg_20_0.toggleList.anchoredPosition

		Vector2 = var_2
		var_21_0.anchoredPosition = var_21_1 + var_2(-arg_20_0.toggleList.rect.width / 2, -var_20_17.rect.height / 2)

		local var_21_2 = arg_20_0

		var_0.showToggleMask(var_21_2, arg_20_1, function(arg_22_0)
			local var_22_0 = arg_20_0

			var_1.hideToggleMask(var_22_0)

			local var_22_1 = arg_20_0

			var_1.selectFleet(var_22_1, arg_20_1, arg_20_2, arg_22_0)

			return
		end)

		return
	end

	SFX_UI_CLICK = var_1_10020

	var_20_19(var_20_32, var_20_33, var_20_34, var_1_10020)

	return
end

function var_0_1.getFleetById(arg_23_0, arg_23_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_23_0.fleets, function(arg_24_0)
		return arg_24_0.id == arg_23_1
	end)
end

function var_0_1.updateShips(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	removeAllChildren = var_1_10005

	var_1_10005(arg_25_1)

	getProxy = var_1_10005
	BayProxy = var_6

	local var_25_0 = var_1_10005(var_6)

	for iter_25_0 = 1, 3 do
		if var_25_0:getShipById(arg_25_2[iter_25_0]) then
			local var_25_1 = var_10 and arg_25_0.tfShipTpl

			cloneTplTo = var_12

			local var_25_2 = var_12(var_25_1, arg_25_1)

			setActive = var_13

			var_13(var_25_2, true)

			if var_10 then
				updateShip = var_13

				var_13(var_25_2, var_10)

				setActive = var_13

				var_13(var_25_2:Find("event_block"), false)
			end

			setActive = var_13

			var_13(var_25_2:Find("ship_type"), false)
		end
	end

	return
end

function var_0_1.selectFleet(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0.selectIds[arg_26_1]

	if 0 < arg_26_3 then
		table = var_5

		if var_5.contains(var_26_0, arg_26_3) then
			return
		end
	end

	FleetType = var_5

	if arg_26_1 == var_5.Normal and arg_26_0:getLimitNums(arg_26_1) > 0 and arg_26_3 == 0 then
		_ = var_5

		if #var_5.filter(var_26_0, function(arg_27_0)
			return arg_27_0 > 0
		end) == 1 then
			pg = var_5

			local var_26_1 = var_5.TipsMgr.GetInstance()
			local var_26_2 = var_5.ShowTips

			i18n = var_7

			var_26_2(var_26_1, var_7("level_fleet_lease_one_ship"))

			return
		end
	end

	if arg_26_0:getFleetById(arg_26_3) then
		if not var_5:isUnlock() then
			return
		end

		if var_5:isLegalToFight() ~= true then
			pg = var_6

			local var_26_3 = var_6.TipsMgr.GetInstance()
			local var_26_4 = var_6.ShowTips

			i18n = var_1_10008

			var_26_4(var_26_3, var_1_10008("level_fleet_not_enough"))

			return
		end
	end

	var_26_0[arg_26_2] = arg_26_3

	arg_26_0:updateFleet(arg_26_1, arg_26_2)

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

	TeamType = var_1_10004

	local var_30_2 = var_30_1(var_30_0, var_1_10004.Main)
	local var_30_3 = arg_30_1
	local var_30_4 = arg_30_1.Find

	TeamType = var_1_10005

	local var_30_5 = var_30_4(var_30_3, var_1_10005.Vanguard)
	local var_30_6 = arg_30_1
	local var_30_7 = arg_30_1.Find

	TeamType = var_1_10006

	local var_30_8 = var_30_7(var_30_6, var_1_10006.Submarine)

	if var_30_2 then
		removeAllChildren = var_30_6

		var_30_6(var_30_2)
	end

	if var_30_5 then
		removeAllChildren = var_30_6

		var_30_6(var_30_5)
	end

	if var_30_8 then
		removeAllChildren = var_30_6

		var_30_6(var_30_8)
	end

	return
end

function var_0_1.OnShow(arg_31_0)
	pg = var_1_10001

	local var_31_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_31_0, arg_31_0._tf)

	setActive = var_1

	var_1(arg_31_0._tf, true)

	return
end

function var_0_1.OnHide(arg_32_0)
	pg = var_1_10001

	local var_32_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_32_0, arg_32_0._tf, arg_32_0.viewParent._tf)

	setActive = var_1

	var_1(arg_32_0._tf, false)

	return
end

function var_0_1.OnCombat(arg_33_0)
	local var_33_0 = {}
	local var_33_1 = arg_33_0.fleets
	local var_33_2 = arg_33_0.selectIds

	FleetType = var_1_10004
	var_33_0[1] = var_33_1[var_33_2[var_1_10004.Normal][1]]

	local var_33_3 = arg_33_0
	local var_33_4 = arg_33_0.emit

	ActivityMediator = var_4

	var_33_4(var_33_3, var_4.GO_SINGLE_PRECOMBAT, {
		system = arg_33_0.system,
		stageId = arg_33_0.stageID,
		activityID = arg_33_0.actID,
		fleets = var_33_0
	})

	return
end

return var_0_1
