class = var_0_10000

local var_0_0 = "LevelEliteFleetPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BasePanel"))
local var_0_2 = {
	vanguard = 1,
	submarine = 3,
	main = 2
}

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.tfShipTpl = var_1.Find(var_1_0, "panel/shiptpl")

	local var_1_1 = arg_1_0._tf

	arg_1_0.tfEmptyTpl = var_1.Find(var_1_1, "panel/emptytpl")

	local var_1_2 = {}

	FleetType = var_1_1

	local var_1_3 = var_1_1.Normal
	local var_1_4 = {}
	local var_1_5 = arg_1_0._tf

	var_1_4[1] = var_4.Find(var_1_5, "panel/fleet/1")

	local var_1_6 = arg_1_0._tf

	var_1_4[2] = var_4.Find(var_1_6, "panel/fleet/2")
	var_1_2[var_1_3] = var_1_4
	FleetType = var_1_3

	local var_1_7 = var_1_3.Submarine
	local var_1_8 = {}
	local var_1_9 = arg_1_0._tf

	var_1_8[1] = var_4.Find(var_1_9, "panel/sub/1")
	var_1_2[var_1_7] = var_1_8
	arg_1_0.tfFleets = var_1_2

	local var_1_10 = arg_1_0._tf

	arg_1_0.tfLimit = var_1.Find(var_1_10, "panel/limit")

	local var_1_11 = arg_1_0._tf

	arg_1_0.tfLimitTips = var_1.Find(var_1_11, "panel/limit_tip")

	local var_1_12 = arg_1_0._tf

	arg_1_0.tfLimitElite = var_1.Find(var_1_12, "panel/limit_elite")

	local var_1_13 = arg_1_0._tf

	arg_1_0.tfLimitContainer = var_1.Find(var_1_13, "panel/limit_elite/limit_list")

	local var_1_14 = arg_1_0._tf

	arg_1_0.tfLimitTpl = var_1.Find(var_1_14, "panel/limit_elite/condition")

	local var_1_15 = arg_1_0._tf

	arg_1_0.btnBack = var_1.Find(var_1_15, "panel/btnBack")

	local var_1_16 = arg_1_0._tf

	arg_1_0.btnGo = var_1.Find(var_1_16, "panel/start_button")

	local var_1_17 = arg_1_0._tf

	arg_1_0.btnAdHelp = var_1.Find(var_1_17, "panel/title/ADvalue/helpbtn")

	local var_1_18 = arg_1_0._tf

	arg_1_0.commanderBtn = var_1.Find(var_1_18, "panel/commander_btn")

	local var_1_19 = arg_1_0._tf

	arg_1_0.toggleMask = var_1.Find(var_1_19, "mask")
	setActive = var_1

	var_1(arg_1_0.tfShipTpl, false)

	setActive = var_1

	var_1(arg_1_0.tfEmptyTpl, false)

	setActive = var_1

	var_1(arg_1_0.tfLimitTpl, false)

	setActive = var_1

	var_1(arg_1_0.toggleMask, false)

	arg_1_0.onConfirm = nil
	arg_1_0.onCancel = nil
	arg_1_0.onClick = nil
	arg_1_0.onLongPressed = nil
	arg_1_0.onEliteClear = nil
	arg_1_0.onEliteRecommend = nil

	return
end

function var_0_1.set(arg_2_0, arg_2_1)
	arg_2_0.chapter = arg_2_1

	local var_2_0 = arg_2_0.chapter

	arg_2_0.propetyLimitation = var_2.getConfig(var_2_0, "property_limitation")

	local var_2_1 = arg_2_0.chapter

	arg_2_0.eliteFleetList = var_2.getEliteFleetList(var_2_1)

	local var_2_2 = arg_2_0.chapter

	arg_2_0.chapterADValue = var_2.getConfig(var_2_2, "air_dominance")
	math = var_2

	local var_2_3 = var_2.max
	local var_2_4 = arg_2_0.chapter

	arg_2_0.suggestionValue = var_2_3(var_3.getConfig(var_2_4, "best_air_dominance"), 150)

	local var_2_5 = arg_2_0.chapter

	arg_2_0.eliteCommanderList = var_2.getEliteFleetCommanders(var_2_5)

	local var_2_6 = arg_2_0.chapter

	arg_2_0.typeLimitations = var_2.getConfig(var_2_6, "limitation")
	onButton = var_2

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.btnGo

	local function var_2_9()
		if arg_2_0.onConfirm then
			arg_2_0.onConfirm()
		end

		return
	end

	SFX_UI_WEIGHANCHOR_GO = var_1_10006

	var_2(var_2_7, var_2_8, var_2_9, var_1_10006)

	onButton = var_2

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.btnAdHelp

	local function var_2_12()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_4_2.type = var_2_10003
		i18n = var_2_10003
		var_4_2.helps = var_2_10003("help_battle_ac")

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_UI_CLICK = var_1_10006

	var_2(var_2_10, var_2_11, var_2_12, var_1_10006)

	onButton = var_2

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.btnBack

	local function var_2_15()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10006

	var_2(var_2_13, var_2_14, var_2_15, var_1_10006)

	onButton = var_2

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0._tf

	local function var_2_18()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10006

	var_2(var_2_16, var_2_17, var_2_18, var_1_10006)

	onToggle = var_2

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0.commanderBtn

	local function var_2_21(arg_7_0)
		arg_2_0.parent.contextData.EditingCommander = arg_7_0

		local var_7_0 = arg_2_0

		var_1.flush(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_2_19, var_2_20, var_2_21, var_1_10006)

	triggerToggle = var_2

	var_2(arg_2_0.commanderBtn, arg_2_0.parent.contextData.EditingCommander)

	setActive = var_2

	var_2(arg_2_0.commanderBtn, arg_2_0.parent.openedCommanerSystem)
	arg_2_0:flush()

	return
end

function var_0_1.clear(arg_8_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_8_0.commanderBtn, false)

	return
end

function var_0_1.flush(arg_9_0)
	arg_9_0:updateLimit()

	OPEN_AIR_DOMINANCE = var_1

	if var_1 and arg_9_0.chapterADValue > 0 then
		setActive = var_1

		local var_9_0 = arg_9_0._tf

		var_1(var_2.Find(var_9_0, "panel/title/ADvalue"), true)
		arg_9_0:updateFleetPanelADValue()
	else
		setActive = var_1

		local var_9_1 = arg_9_0._tf

		var_1(var_2.Find(var_9_1, "panel/title/ADvalue"), false)
	end

	arg_9_0:updateFleets()

	return
end

function var_0_1.updateLimit(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.toggleMask, false)

	setActive = var_1_10001

	var_1_10001(arg_10_0.tfLimit, false)

	setActive = var_1_10001

	var_1_10001(arg_10_0.tfLimitTips, #arg_10_0.propetyLimitation == 0)

	setActive = var_1_10001

	var_1_10001(arg_10_0.tfLimitElite, #arg_10_0.propetyLimitation > 0)

	removeAllChildren = var_1_10001

	var_1_10001(arg_10_0.tfLimitContainer)

	if #arg_10_0.propetyLimitation > 0 then
		local var_10_0 = arg_10_0.chapter
		local var_10_1, var_10_2 = var_1.IsPropertyLimitationSatisfy(var_10_0)

		ipairs = var_3

		for iter_10_0, iter_10_1 in var_3(arg_10_0.propetyLimitation) do
			unpack = var_1_10008

			local var_10_3, var_10_4, var_10_5

			var_1_10008, var_10_3, var_10_4, var_10_5 = var_1_10008(iter_10_1)
			cloneTplTo = var_1_10012
			var_1_10012 = var_1_10012(arg_10_0.tfLimitTpl, arg_10_0.tfLimitContainer)

			local var_10_7

			if var_10_1[iter_10_0] == 1 then
				local var_10_6 = var_1_10012:Find("Text")

				var_10_7 = var_10_7.GetComponent
				typeof = var_15
				Text = var_1_10016
				var_10_7 = var_10_7(var_10_6, var_15(var_1_10016))
				Color = var_10_6
				var_10_7.color = var_10_6.New(1, 0.9607843137254902, 0.5019607843137255)
			else
				local var_10_8 = var_1_10012:Find("Text")

				var_10_7 = var_10_7.GetComponent
				typeof = var_15
				Text = var_1_10016
				var_10_7 = var_10_7(var_10_8, var_15(var_1_10016))
				Color = var_10_8
				var_10_7.color = var_10_8.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)
			end

			setActive = var_10_7

			var_10_7(var_1_10012, true)

			AttributeType = var_10_7

			local var_10_9 = var_10_7.EliteCondition2Name(var_1_10008, var_10_5)

			AttributeType = var_14

			local var_10_10 = (var_10_9 .. var_14.eliteConditionCompareTip(var_10_3) .. var_10_4) .. "（" .. var_10_2[var_1_10008] .. "）"

			setText = var_14
			var_1_10016 = var_1_10012

			var_14(var_1_10012.Find(var_1_10016, "Text"), var_10_10)
		end

		setActive = var_3

		local var_10_11 = arg_10_0.tfLimitElite
		local var_10_12 = var_4.Find(var_10_11, "sub")
		local var_10_13 = arg_10_0.chapter

		var_3(var_10_12, var_5.getConfig(var_10_13, "submarine_num") > 0)
	end

	return
end

function var_0_1.updateFleetPanelADValue(arg_11_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)
	local var_11_1 = 0

	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.eliteFleetList) do
		local var_11_2 = {}

		pairs = var_1_10009

		for iter_11_2, iter_11_3 in var_1_10009(arg_11_0.eliteCommanderList[iter_11_0]) do
			getProxy = var_1_10014
			CommanderProxy = var_1_10015
			var_1_10015 = var_1_10014(var_1_10015)
			var_11_2[iter_11_2] = var_1_10014.getCommanderById(var_1_10015, iter_11_3)
		end

		ipairs = var_1_10009

		for iter_11_4, iter_11_5 in var_1_10009(iter_11_1) do
			calcAirDominanceValue = var_1_10014
			var_11_1 = var_11_1 + var_1_10014(var_11_0:getShipById(iter_11_5), var_11_2)
		end
	end

	math = var_3

	local var_11_3 = var_3.floor(var_11_1)
	local var_11_4 = arg_11_0._tf
	local var_11_5 = var_3.Find(var_11_4, "panel/title/ADvalue/Text")

	setText = var_11_4

	local var_11_6 = var_11_5

	i18n = iter_11_0

	var_11_4(var_11_6, iter_11_0("level_scene_title_word_5"))

	setText = var_11_4

	local var_11_7 = var_11_5
	local var_11_8 = var_11_5.Find(var_11_7, "Num1")

	setColorStr = var_11_7

	local var_11_9 = var_11_3
	local var_11_10

	if var_11_3 < arg_11_0.suggestionValue then
		var_11_10 = "#f1dc36"
	else
		COLOR_WHITE = var_11_10
	end

	var_11_4(var_11_8, var_11_7(var_11_9, var_11_10))

	setText = var_11_4

	var_11_4(var_11_5:Find("Num2"), arg_11_0.suggestionValue)

	return
end

function var_0_1.initAddButton(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = arg_12_0.eliteFleetList[arg_12_4]
	local var_12_1 = {}
	local var_12_2 = {}

	ipairs = var_1_10008

	for iter_12_0, iter_12_1 in var_1_10008(var_12_0) do
		var_12_1[arg_12_0.parent.shipVOs[iter_12_1]] = true

		local var_12_3 = arg_12_0.parent.shipVOs[iter_12_1]

		if arg_12_2 == var_13.getTeamType(var_12_3) then
			table = var_13

			var_13.insert(var_12_2, iter_12_1)
		end
	end

	removeAllChildren = var_8

	var_8(arg_12_1)

	local var_12_4 = 0
	local var_12_5 = false
	local var_12_6 = 0

	Clone = iter_12_0
	arg_12_3 = iter_12_0(arg_12_3)
	table = var_11

	var_11.sort(arg_12_3, function(arg_13_0, arg_13_1)
		type = var_2_10002

		local var_13_0 = var_2_10002(arg_13_0)

		type = var_3

		if var_13_0 == var_3(arg_13_1) then
			return var_3 < var_13_0
		elseif arg_13_1 == 0 or var_3 == "string" and arg_13_0 ~= 0 then
			return true
		else
			return false
		end

		return
	end)

	local var_12_7 = {}
	local var_12_8 = {}

	for iter_12_2 = 1, 3 do
		local var_12_9
		local var_12_10
		local var_12_11
		local var_12_12

		if not var_12_2[iter_12_2] or not arg_12_0.parent.shipVOs[var_12_2[iter_12_2]] then
			var_12_12 = nil
		end

		if var_12_12 then
			ipairs = var_1_10021

			for iter_12_3, iter_12_4 in var_1_10021(arg_12_3) do
				ShipType = var_1_10026

				if var_1_10026.ContainInLimitBundle(iter_12_4, var_12_12:getShipType()) then
					var_12_10 = var_12_12
					var_12_11 = iter_12_4
					table = var_1_10026

					var_1_10026.remove(arg_12_3, iter_12_3)

					table = var_1_10026

					var_1_10026.insert(var_12_7, iter_12_3)

					var_12_5 = var_12_5 or iter_12_4 ~= 0

					break
				end
			end
		else
			var_12_11 = arg_12_3[1]
			table = var_1_10021

			var_1_10021.remove(arg_12_3, 1)

			table = var_1_10021

			var_1_10021.insert(var_12_7, 1)
		end

		if var_12_11 == 0 then
			var_12_6 = var_12_6 + 1
		end

		if var_12_10 then
			cloneTplTo = var_1_10021

			if not var_1_10021(arg_12_0.tfShipTpl, arg_12_1) then
				cloneTplTo = var_1_10021
				var_1_10021 = var_1_10021(arg_12_0.tfEmptyTpl, arg_12_1)
			end

			table = var_1_10022

			var_1_10022.insert(var_12_8, var_1_10021)

			setActive = var_1_10022

			var_1_10022(var_1_10021, true)

			if var_12_10 then
				updateShip = var_1_10022

				var_1_10022(var_1_10021, var_12_10)

				setActive = var_1_10022

				var_1_10022(var_1_10021:Find("event_block"), var_12_10:getFlag("inEvent"))

				var_12_1[var_12_10] = true
			else
				var_12_4 = var_12_4 + 1
			end

			findTF = var_1_10022

			local var_12_13 = var_1_10022(var_1_10021, "icon_bg")

			setActive = var_1_10022

			var_1_10022(var_1_10021:Find("ship_type"), true)

			type = var_1_10022

			local var_12_15

			if var_1_10022(var_12_11) == "number" then
				if var_12_11 ~= 0 then
					GetSpriteFromAtlas = var_1_10022

					local var_12_14 = "shiptype"

					ShipType = var_12_15
					var_1_10022 = var_1_10022(var_12_14, var_12_15.Type2CNLabel(var_12_11))
					setImageSprite = var_12_14

					var_12_14(var_1_10021:Find("ship_type"), var_1_10022, true)
				else
					setActive = var_1_10022
					var_12_15 = var_1_10021

					var_1_10022(var_1_10021.Find(var_12_15, "ship_type"), false)
				end
			else
				type = var_1_10022

				if var_1_10022(var_12_11) == "string" then
					GetSpriteFromAtlas = var_1_10022

					local var_12_16 = "shiptype"

					ShipType = var_12_15
					var_1_10022 = var_1_10022(var_12_16, var_12_15.BundleType2CNLabel(var_12_11))
					setImageSprite = var_12_16

					var_12_16(var_1_10021:Find("ship_type"), var_1_10022, true)
				end
			end

			setActive = var_1_10022

			var_1_10022(var_1_10021:Find("ship_type"), not var_12_10 and var_12_11 ~= 0)

			_ = var_1_10022
			var_1_10022 = var_1_10022.map(var_12_0, function(arg_14_0)
				return arg_12_0.parent.shipVOs[arg_14_0]
			end)
			table = var_23

			var_23.sort(var_1_10022, function(arg_15_0, arg_15_1)
				if not (var_0_2[arg_15_0:getTeamType()] < var_0_2[arg_15_1:getTeamType()]) then
					if var_0_2[arg_15_0:getTeamType()] == var_0_2[arg_15_1:getTeamType()] then
						table = var_2

						local var_15_0 = var_2.indexof(var_12_0, arg_15_0.id)

						table = var_3

						local var_15_1

						if not (var_15_0 < var_3.indexof(var_12_0, arg_15_1.id)) then
							var_15_1 = false

							goto label_15_0
						end

						var_15_1 = true

						::label_15_0::

						return var_15_1
					end
				end
			end)

			GetOrAddComponent = var_23

			local var_12_17 = var_12_13

			typeof = var_25
			UILongPressTrigger = var_1_10026

			local var_12_18 = var_23(var_12_17, var_25(var_1_10026)).onReleased

			var_24.RemoveAllListeners(var_12_18)

			local var_12_19 = var_23.onLongPressed

			var_24.RemoveAllListeners(var_12_19)

			local var_12_20 = var_23.onReleased

			var_24.AddListener(var_12_20, function()
				arg_12_0.onClick({
					shipType = var_12_11,
					fleet = var_12_1,
					chapter = arg_12_0.chapter,
					shipVO = var_12_10,
					fleetIndex = arg_12_4,
					teamType = arg_12_2
				})

				return
			end)

			local var_12_21 = var_23.onLongPressed

			var_24.AddListener(var_12_21, function()
				if not var_12_10 then
					arg_12_0.onClick({
						shipType = var_12_11,
						fleet = var_12_1,
						chapter = arg_12_0.chapter,
						shipVO = var_12_10,
						fleetIndex = arg_12_4,
						teamType = arg_12_2
					})
				else
					arg_12_0.onLongPressed({
						shipId = var_12_10.id,
						shipVOs = var_1_10022,
						chapter = arg_12_0.chapter
					})
				end

				return
			end)
		end
	end

	for iter_12_5 = 3, 1, -1 do
		local var_12_22 = var_12_8[iter_12_5]

		var_17.SetSiblingIndex(var_12_22, var_12_7[iter_12_5] - 1)
	end

	if (var_12_5 == true or var_12_6 == 3) and var_12_4 ~= 3 then
		return true
	else
		return false
	end

	return
end

function var_0_1.initCommander(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_3:getEliteFleetCommanders()[arg_18_1]

	for iter_18_0 = 1, 2 do
		local var_18_1 = var_18_0[iter_18_0]
		local var_18_2

		if var_18_1 then
			getProxy = var_1_10012
			CommanderProxy = var_1_10013
			var_1_10013 = var_1_10012(var_1_10013)
			var_18_2 = var_1_10012.getCommanderById(var_1_10013, var_18_1)
		end

		var_1_10013 = arg_18_2

		local var_18_3 = arg_18_2.Find(var_1_10013, "pos" .. iter_18_0)

		var_1_10013 = var_1_10012.Find(var_18_3, "add")

		local var_18_4 = var_1_10012
		local var_18_5 = var_1_10012.Find(var_18_4, "info")

		setActive = var_18_4

		var_18_4(var_1_10013, not var_18_2)

		setActive = var_18_4

		var_18_4(var_18_5, var_18_2)

		if var_18_2 then
			Commander = var_18_4

			local var_18_6 = var_18_4.rarity2Frame(var_18_2:getRarity())

			setImageSprite = var_16

			local var_18_7 = var_18_5
			local var_18_8 = var_18_5.Find(var_18_7, "frame")

			GetSpriteFromAtlas = var_18_7

			var_16(var_18_8, var_18_7("weaponframes", "commander_" .. var_18_6))

			GetImageSpriteFromAtlasAsync = var_16

			local var_18_9 = "CommanderHrz/" .. var_18_2:getPainting()
			local var_18_10 = ""

			var_1_10020 = var_18_5

			var_16(var_18_9, var_18_10, var_18_5.Find(var_1_10020, "mask/icon"))
		end

		local var_18_11 = arg_18_3
		local var_18_12 = arg_18_3.wrapEliteFleet(var_18_11, arg_18_1)

		onButton = var_18_11

		local var_18_13 = arg_18_0
		local var_18_14 = var_1_10013

		local function var_18_15()
			local var_19_0 = arg_18_0.parent

			var_0.openCommanderPanel(var_19_0, var_18_12, arg_18_3.id, arg_18_1)

			return
		end

		SFX_PANEL = var_1_10020

		var_18_11(var_18_13, var_18_14, var_18_15, var_1_10020)

		onButton = var_18_11

		local var_18_16 = arg_18_0
		local var_18_17 = var_18_5

		local function var_18_18()
			local var_20_0 = arg_18_0.parent

			var_0.openCommanderPanel(var_20_0, var_18_12, arg_18_3.id, arg_18_1)

			return
		end

		SFX_PANEL = var_1_10020

		var_18_11(var_18_16, var_18_17, var_18_18, var_1_10020)
	end

	return
end

function var_0_1.updateFleets(arg_21_0)
	ipairs = var_1_10001

	local var_21_0 = arg_21_0.tfFleets

	FleetType = var_1_10003

	for iter_21_0, iter_21_1 in var_1_10001(var_21_0[var_1_10003.Normal]) do
		local var_21_1 = iter_21_1:Find("btn_clear")
		local var_21_2 = iter_21_1:Find("btn_recom")
		local var_21_3 = iter_21_1:Find("btn_select")
		local var_21_4 = iter_21_1:Find("blank")
		local var_21_5 = iter_21_1
		local var_21_6 = iter_21_1.Find(var_21_5, "commander")

		setActive = var_21_5

		var_21_5(var_21_3, false)

		setActive = var_21_5
		findTF = var_12

		var_21_5(var_12(iter_21_1, "selected"), false)

		local var_21_7 = arg_21_0.chapter
		local var_21_8 = iter_21_0 <= var_11.getConfig(var_21_7, "group_num")

		setActive = var_21_7
		findTF = var_13

		local var_21_9 = iter_21_1

		TeamType = var_1_10015

		var_21_7(var_13(var_21_9, var_1_10015.Main), var_21_8)

		setActive = var_21_7
		findTF = var_13

		local var_21_10 = iter_21_1

		TeamType = var_1_10015

		var_21_7(var_13(var_21_10, var_1_10015.Vanguard), var_21_8)

		setActive = var_21_7

		var_21_7(var_21_1, var_21_8 and not arg_21_0.contextData.EditingCommander)

		setActive = var_21_7

		var_21_7(var_21_2, var_21_8 and not arg_21_0.contextData.EditingCommander)

		setActive = var_21_7

		var_21_7(var_21_4, not var_21_8)

		setActive = var_21_7

		var_21_7(var_21_6, var_21_8 and arg_21_0.contextData.EditingCommander)

		setText = var_21_7

		local var_21_11 = iter_21_1
		local var_21_12 = iter_21_1.Find(var_21_11, "bg/name")

		if var_21_8 then
			Fleet = var_21_11

			local var_21_13

			if not var_21_11.DEFAULT_NAME[iter_21_0] then
				var_21_13 = ""
			end

			var_21_7(var_21_12, var_21_13)

			if var_21_8 then
				local var_21_14 = arg_21_0.typeLimitations[iter_21_0][1]
				local var_21_15 = var_12[2]
				local var_21_16 = arg_21_0

				var_1_10015 = arg_21_0.initAddButton

				local var_21_17 = iter_21_1
				local var_21_18 = iter_21_1.Find

				TeamType = var_1_10019

				local var_21_19 = var_21_18(var_21_17, var_1_10019.Main)

				TeamType = var_21_17
				var_1_10015 = var_1_10015(var_21_16, var_21_19, var_21_17.Main, var_21_14, iter_21_0)

				local var_21_20 = arg_21_0
				local var_21_21 = arg_21_0.initAddButton

				var_1_10019 = iter_21_1

				local var_21_22 = iter_21_1.Find

				TeamType = var_20

				local var_21_23 = var_21_22(var_1_10019, var_20.Vanguard)

				TeamType = var_1_10019

				local var_21_24 = var_21_21(var_21_20, var_21_23, var_1_10019.Vanguard, var_21_15, iter_21_0)

				arg_21_0:initCommander(iter_21_0, var_21_6, arg_21_0.chapter)

				if var_1_10015 and var_21_24 then
					setActive = var_17
					var_1_10019 = iter_21_1

					var_17(iter_21_1.Find(var_1_10019, "selected"), true)
				end

				onButton = var_17

				var_17(arg_21_0, var_21_1, function()
					if #arg_21_0.eliteFleetList[iter_21_0] ~= 0 then
						pg = var_0

						local var_22_0 = var_0.MsgboxMgr.GetInstance()
						local var_22_1 = var_0.ShowMsgBox
						local var_22_2 = {}

						i18n = var_2_10003
						var_22_2.content = var_2_10003("battle_preCombatLayer_clear_confirm")

						function var_22_2.onYes()
							arg_21_0.onEliteClear({
								index = iter_21_0,
								chapterVO = arg_21_0.chapter
							})

							return
						end

						var_22_1(var_22_0, var_22_2)
					end

					return
				end)

				onButton = var_17

				var_17(arg_21_0, var_21_2, function()
					if #arg_21_0.eliteFleetList[iter_21_0] ~= 6 then
						if var_0 ~= 0 then
							pg = var_1

							local var_24_0 = var_1.MsgboxMgr.GetInstance()
							local var_24_1 = var_1.ShowMsgBox
							local var_24_2 = {}

							i18n = var_2_10004
							var_24_2.content = var_2_10004("battle_preCombatLayer_auto_confirm")

							function var_24_2.onYes()
								arg_21_0.onEliteRecommend({
									index = iter_21_0,
									chapterVO = arg_21_0.chapter
								})

								return
							end

							var_24_1(var_24_0, var_24_2)
						else
							arg_21_0.onEliteRecommend({
								index = iter_21_0,
								chapterVO = arg_21_0.chapter
							})
						end
					end

					return
				end)
			end
		end
	end

	ipairs = var_1

	local var_21_25 = arg_21_0.tfFleets

	FleetType = var_3

	for iter_21_2, iter_21_3 in var_1(var_21_25[var_3.Submarine]) do
		local var_21_26 = iter_21_2 + 2
		local var_21_27 = iter_21_3:Find("btn_clear")
		local var_21_28 = iter_21_3:Find("btn_recom")
		local var_21_29 = iter_21_3:Find("btn_select")
		local var_21_30 = iter_21_3:Find("blank")
		local var_21_31 = iter_21_3
		local var_21_32 = iter_21_3.Find(var_21_31, "commander")

		setActive = var_21_31

		var_21_31(var_21_29, false)

		setActive = var_21_31
		findTF = var_13

		var_21_31(var_13(iter_21_3, "selected"), false)

		setActive = var_21_31
		findTF = var_13

		local var_21_33 = iter_21_3

		TeamType = var_15

		local var_21_34 = var_13(var_21_33, var_15.Submarine)
		local var_21_35 = arg_21_0.chapter

		var_21_31(var_21_34, iter_21_2 <= var_14.getConfig(var_21_35, "submarine_num"))

		setActive = var_21_31

		local var_21_36 = var_21_27
		local var_21_37 = arg_21_0.chapter

		var_21_31(var_21_36, iter_21_2 <= var_14.getConfig(var_21_37, "submarine_num") and not arg_21_0.contextData.EditingCommander)

		setActive = var_21_31

		local var_21_38 = var_21_28
		local var_21_39 = arg_21_0.chapter

		var_21_31(var_21_38, iter_21_2 <= var_14.getConfig(var_21_39, "submarine_num") and not arg_21_0.contextData.EditingCommander)

		setActive = var_21_31

		local var_21_40 = var_21_30
		local var_21_41 = arg_21_0.chapter

		var_21_31(var_21_40, iter_21_2 > var_14.getConfig(var_21_41, "submarine_num"))

		setActive = var_21_31

		local var_21_42 = var_21_32
		local var_21_43 = arg_21_0.chapter

		var_21_31(var_21_42, iter_21_2 <= var_14.getConfig(var_21_43, "submarine_num") and arg_21_0.contextData.EditingCommander)

		setText = var_21_31

		local var_21_44 = iter_21_3:Find("bg/name")
		local var_21_45 = arg_21_0.chapter

		if iter_21_2 <= var_14.getConfig(var_21_45, "submarine_num") then
			Fleet = var_14

			local var_21_46 = var_14.DEFAULT_NAME

			Fleet = var_21_45

			local var_21_47

			if not var_21_46[var_21_45.SUBMARINE_FLEET_ID + iter_21_2 - 1] then
				var_21_47 = ""
			end

			var_21_31(var_21_44, var_21_47)
			arg_21_0:initCommander(var_21_26, var_21_32, arg_21_0.chapter)

			local var_21_48 = arg_21_0.chapter

			if iter_21_2 <= var_12.getConfig(var_21_48, "submarine_num") then
				local var_21_49 = arg_21_0
				local var_21_50 = arg_21_0.initAddButton
				local var_21_51 = iter_21_3
				local var_21_52 = iter_21_3.Find

				TeamType = var_16

				local var_21_53 = var_21_52(var_21_51, var_16.Main)

				TeamType = var_21_51

				if var_21_50(var_21_49, var_21_53, var_21_51.Submarine, {
					0,
					0,
					0
				}, var_21_26) then
					setActive = var_21_49

					var_21_49(iter_21_3:Find("selected"), true)
				end

				onButton = var_21_49

				var_21_49(arg_21_0, var_21_27, function()
					if #arg_21_0.eliteFleetList[var_21_26] ~= 0 then
						pg = var_0

						local var_26_0 = var_0.MsgboxMgr.GetInstance()
						local var_26_1 = var_0.ShowMsgBox
						local var_26_2 = {}

						i18n = var_2_10003
						var_26_2.content = var_2_10003("battle_preCombatLayer_clear_confirm")

						function var_26_2.onYes()
							arg_21_0.onEliteClear({
								index = var_21_26,
								chapterVO = arg_21_0.chapter
							})

							return
						end

						var_26_1(var_26_0, var_26_2)
					end

					return
				end)

				onButton = var_21_49

				var_21_49(arg_21_0, var_21_28, function()
					if #arg_21_0.eliteFleetList[var_21_26] ~= 3 then
						if var_0 ~= 0 then
							pg = var_1

							local var_28_0 = var_1.MsgboxMgr.GetInstance()
							local var_28_1 = var_1.ShowMsgBox
							local var_28_2 = {}

							i18n = var_2_10004
							var_28_2.content = var_2_10004("battle_preCombatLayer_auto_confirm")

							function var_28_2.onYes()
								arg_21_0.onEliteRecommend({
									index = var_21_26,
									chapterVO = arg_21_0.chapter
								})

								return
							end

							var_28_1(var_28_0, var_28_2)
						else
							arg_21_0.onEliteRecommend({
								index = var_21_26,
								chapterVO = arg_21_0.chapter
							})
						end
					end

					return
				end)
			end
		end
	end

	return
end

return var_0_1
