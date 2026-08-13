class = var_0_10000

local var_0_0 = "BlueprintQuickExchangeView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BlueprintQuickExchangeUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rtBg = var_1.Find(var_2_0, "bg")
	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.rtBg

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_2_1, var_2_2, var_2_3, var_1_10006)

	local var_2_4 = arg_2_0._tf

	arg_2_0.rtPreview = var_1.Find(var_2_4, "window/preview/got")

	local var_2_5 = arg_2_0.rtPreview

	arg_2_0.rtEmpty = var_1.Find(var_2_5, "empty")
	setText = var_1

	local var_2_6 = arg_2_0.rtEmpty
	local var_2_7 = var_3.Find(var_2_6, "Text")

	i18n = var_4

	var_1(var_2_7, var_4("blueprint_exchange_empty_tip"))

	local var_2_8 = arg_2_0.rtPreview
	local var_2_9 = var_1.Find(var_2_8, "list")

	UIItemList = var_1_10002
	arg_2_0.itemList = var_1_10002.New(var_2_9, var_2_9:Find("item"))

	local var_2_10 = arg_2_0.itemList

	var_2.make(var_2_10, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_2_0.displayList[arg_4_1]
			local var_4_1 = arg_2_0.awardList[arg_4_1].count

			updateDrop = var_2_10005

			var_2_10005(arg_4_2:Find("icon"), var_4_0)

			onButton = var_2_10005

			local var_4_2 = arg_2_0
			local var_4_3 = arg_4_2
			local var_4_4 = arg_4_2.Find(var_4_3, "icon")

			local function var_4_5()
				local var_5_0 = arg_2_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10003

				var_5_1(var_5_0, var_3_10003.ON_DROP, var_4_0)

				return
			end

			SFX_PANEL = var_4_3

			var_2_10005(var_4_2, var_4_4, var_4_5, var_4_3)

			setText = var_2_10005

			var_2_10005(arg_4_2:Find("calc/value"), arg_2_0.countList[arg_4_1])

			setScrollText = var_2_10005

			var_2_10005(arg_4_2:Find("name/Text"), var_4_0:getConfig("name"))

			setText = var_2_10005

			local var_4_6 = arg_4_2:Find("kc")

			i18n = var_8

			var_2_10005(var_4_6, var_8("tec_tip_material_stock") .. ":" .. var_4_0.count)

			pressPersistTrigger = var_2_10005

			local var_4_7 = arg_4_2:Find("calc/plus")
			local var_4_8 = 0.5

			local function var_4_9()
				if var_4_0.count > arg_2_0.countList[arg_4_1] and arg_2_0.count + var_4_1 <= arg_2_0.need then
					local var_6_0 = arg_2_0.countList

					var_6_0[arg_4_1] = arg_2_0.countList[arg_4_1] + 1
					setText = var_6_0

					local var_6_1 = arg_4_2

					var_6_0(var_2.Find(var_6_1, "calc/value"), arg_2_0.countList[arg_4_1])

					local var_6_2 = arg_2_0

					var_6_2.count = arg_2_0.count + var_4_1
					setText = var_6_2

					local var_6_3 = arg_2_0.rtExchange
					local var_6_4 = var_2.Find(var_6_3, "bg/count")

					setColorStr = var_3

					var_6_2(var_6_4, var_3(arg_2_0.count, "#FFEC6E") .. "/" .. arg_2_0.need)
				end

				return
			end

			local var_4_10
			local var_4_11 = true
			local var_4_12 = true
			local var_4_13 = 0.1

			SFX_PANEL = var_2_10014

			var_2_10005(var_4_7, var_4_8, var_4_9, var_4_10, var_4_11, var_4_12, var_4_13, var_2_10014)

			pressPersistTrigger = var_2_10005

			local var_4_14 = arg_4_2:Find("calc/minus")
			local var_4_15 = 0.5

			local function var_4_16()
				if arg_2_0.countList[arg_4_1] > 0 then
					local var_7_0 = arg_2_0.countList

					var_7_0[arg_4_1] = arg_2_0.countList[arg_4_1] - 1
					setText = var_7_0

					local var_7_1 = arg_4_2

					var_7_0(var_2.Find(var_7_1, "calc/value"), arg_2_0.countList[arg_4_1])

					local var_7_2 = arg_2_0

					var_7_2.count = arg_2_0.count - var_4_1
					setText = var_7_2

					local var_7_3 = arg_2_0.rtExchange
					local var_7_4 = var_2.Find(var_7_3, "bg/count")

					setColorStr = var_3

					var_7_2(var_7_4, var_3(arg_2_0.count, "#FFEC6E") .. "/" .. arg_2_0.need)
				end

				return
			end

			local var_4_17
			local var_4_18 = true
			local var_4_19 = true
			local var_4_20 = 0.1

			SFX_PANEL = var_2_10014

			var_2_10005(var_4_14, var_4_15, var_4_16, var_4_17, var_4_18, var_4_19, var_4_20, var_2_10014)

			onButton = var_2_10005

			var_2_10005(arg_2_0, arg_4_2:Find("calc/max"), function()
				if var_4_0.count > arg_2_0.countList[arg_4_1] and arg_2_0.count + var_4_1 <= arg_2_0.need then
					math = var_0

					local var_8_0 = var_0.floor((arg_2_0.need - arg_2_0.count + var_4_1 - 1) / var_4_1)

					math = var_1

					local var_8_1 = var_1.min(var_8_0, var_4_0.count - arg_2_0.countList[arg_4_1])
					local var_8_2 = arg_2_0.countList

					var_8_2[arg_4_1] = arg_2_0.countList[arg_4_1] + var_8_1
					setText = var_8_2

					local var_8_3 = arg_4_2

					var_8_2(var_3.Find(var_8_3, "calc/value"), arg_2_0.countList[arg_4_1])

					local var_8_4 = arg_2_0

					var_8_4.count = arg_2_0.count + var_4_1 * var_8_1
					setText = var_8_4

					local var_8_5 = arg_2_0.rtExchange
					local var_8_6 = var_3.Find(var_8_5, "bg/count")

					setColorStr = var_4

					var_8_4(var_8_6, var_4(arg_2_0.count, "#FFEC6E") .. "/" .. arg_2_0.need)
				end

				return
			end)
		end

		return
	end)

	setText = var_2

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_4.Find(var_2_11, "window/cancel_button/label")

	i18n = var_5

	var_2(var_2_12, var_5("word_cancel"))

	onButton = var_2

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_5.Find(var_2_14, "window/cancel_button")

	local function var_2_16()
		local var_9_0 = arg_2_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_CANCEL = var_2_14

	var_2(var_2_13, var_2_15, var_2_16, var_2_14)

	onButton = var_2

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_5.Find(var_2_18, "window/confirm_button")

	local function var_2_20()
		if arg_2_0.count <= 0 then
			return
		end

		local var_10_0 = {}

		if arg_2_0.isSwitch then
			local var_10_1 = arg_2_0.blueprintVO

			if not var_1.IsFate(var_10_1) then
				table = var_1

				var_1.insert(var_10_0, function(arg_11_0)
					pg = var_3_10001

					local var_11_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_11_1 = var_1.ShowMsgBox
					local var_11_2 = {}

					i18n = var_3_10005
					var_11_2.content = var_3_10005("blueprint_lab_exchange_fate_unlock")
					var_11_2.onYes = arg_11_0

					var_11_1(var_11_0, var_11_2)

					return
				end)
			end
		end

		seriesAsync = var_1

		var_1(var_10_0, function()
			local var_12_0 = {}

			ipairs = var_3_10001

			for iter_12_0, iter_12_1 in var_3_10001(arg_2_0.displayList) do
				if arg_2_0.countList[iter_12_0] > 0 then
					table = var_6

					local var_12_1 = var_6.insert
					local var_12_2 = var_12_0
					local var_12_3 = {
						id = iter_12_1.id,
						count = arg_2_0.countList[iter_12_0]
					}

					Item = var_10
					var_12_3.arg = var_10.getConfigData(iter_12_1.id).usage_arg[arg_2_0.awardList[iter_12_0].index]

					var_12_1(var_12_2, var_12_3)
				end
			end

			local var_12_4 = arg_2_0
			local var_12_5 = var_1.emit

			ShipBluePrintMediator = iter_12_0

			var_12_5(var_12_4, iter_12_0.QUICK_EXCHAGE_BLUEPRINT, var_12_0)

			local var_12_6 = arg_2_0

			var_1.Hide(var_12_6)

			return
		end)

		return
	end

	SFX_CANCEL = var_2_18

	var_2(var_2_17, var_2_19, var_2_20, var_2_18)

	local var_2_21 = arg_2_0._tf

	arg_2_0.rtResult = var_2.Find(var_2_21, "window/result")

	local var_2_22 = arg_2_0.rtResult

	arg_2_0.rtTarget = var_2.Find(var_2_22, "target")

	local var_2_23 = arg_2_0.rtResult

	arg_2_0.rtExchange = var_2.Find(var_2_23, "exchange")

	local var_2_24 = arg_2_0.rtResult

	arg_2_0.fate = var_2.Find(var_2_24, "fate")

	local var_2_25 = arg_2_0.fate

	arg_2_0.fateText = var_2.Find(var_2_25, "Text")
	setText = var_2

	local var_2_26 = arg_2_0.rtExchange
	local var_2_27 = var_4.Find(var_2_26, "bg/title")

	i18n = var_5

	var_2(var_2_27, var_5("blueprint_exchange_select_display"))

	local var_2_28 = arg_2_0.rtResult

	arg_2_0.toggleSwitch = var_2.Find(var_2_28, "switch")
	setText = var_2

	local var_2_29 = arg_2_0.toggleSwitch
	local var_2_30 = var_4.Find(var_2_29, "front/Text_off")

	i18n = var_5

	var_2(var_2_30, var_5("show_fate_demand_count"))

	setText = var_2

	local var_2_31 = arg_2_0.toggleSwitch
	local var_2_32 = var_4.Find(var_2_31, "front/Text_on")

	i18n = var_5

	var_2(var_2_32, var_5("show_design_demand_count"))

	onToggle = var_2

	var_2(arg_2_0, arg_2_0.toggleSwitch, function(arg_13_0)
		arg_2_0.isSwitch = arg_13_0

		local var_13_0 = arg_2_0

		var_1.UpdateResult(var_13_0)

		setActive = var_1

		var_1(arg_2_0.fate, arg_2_0.isSwitch)

		return
	end)

	return
end

function var_0_1.Show(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_14_0, arg_14_0._tf)

	setActive = var_1

	var_1(arg_14_0._tf, true)

	return
end

function var_0_1.Hide(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_0, arg_15_0._tf, arg_15_0._parentTf)

	setActive = var_1

	var_1(arg_15_0._tf, false)

	return
end

function var_0_1.UpdateBlueprint(arg_16_0, arg_16_1)
	arg_16_0.blueprintVO = arg_16_1
	Drop = var_1_10002

	local var_16_0 = var_1_10002.New
	local var_16_1 = {}

	DROP_TYPE_ITEM = var_1_10005
	var_16_1.type = var_1_10005
	var_16_1.id = arg_16_1:getItemId()

	local var_16_2 = var_16_0(var_16_1)

	changeToScrollText = var_1_10003

	local var_16_3 = arg_16_0.rtResult

	var_1_10003(var_5.Find(var_16_3, "title/Text"), var_16_2:getName())

	arg_16_0.displayList = {}
	arg_16_0.awardList = {}
	getProxy = var_3
	BagProxy = var_5

	local var_16_4 = var_3(var_5)

	ipairs = var_16_1
	pg = var_6

	for iter_16_0, iter_16_1 in var_16_1(var_6.gameset.general_blueprint_list.description) do
		local var_16_5 = var_16_4

		if var_16_4.getItemCountById(var_16_5, iter_16_1) > 0 then
			local var_16_6

			ipairs = var_16_5
			Drop = var_1_10013
			var_1_10013 = var_1_10013.New

			local var_16_7 = {}

			DROP_TYPE_ITEM = var_1_10016
			var_16_7.type = var_1_10016
			var_16_7.id = iter_16_1

			local var_16_8 = var_1_10013(var_16_7)

			for iter_16_2, iter_16_3 in var_16_5(var_1_10013.getConfig(var_16_8, "display_icon")) do
				var_1_10016 = iter_16_3[1]
				DROP_TYPE_ITEM = var_1_10017

				if var_1_10016 == var_1_10017 and iter_16_3[2] == var_16_2.id then
					var_16_6 = {
						index = iter_16_2,
						count = iter_16_3[3]
					}
				end
			end

			if var_16_6 then
				table = var_11

				local var_16_9 = var_11.insert

				var_1_10013 = arg_16_0.displayList

				local var_16_10 = {}

				DROP_TYPE_ITEM = iter_16_3
				var_16_10.type = iter_16_3
				var_16_10.id = iter_16_1
				var_16_10.count = var_9

				var_16_9(var_1_10013, var_16_10)

				table = var_16_9

				var_16_9.insert(arg_16_0.awardList, var_16_6)
			end
		end
	end

	setActive = var_4

	var_4(arg_16_0.rtEmpty, #arg_16_0.displayList == 0)

	setActive = var_4

	var_4(arg_16_0.itemList.container, #arg_16_0.displayList > 0)

	updateDrop = var_4

	local var_16_11 = arg_16_0.rtResult

	var_4(var_6.Find(var_16_11, "target/IconTpl"), var_16_2)

	GetImageSpriteFromAtlasAsync = var_4

	local var_16_12 = "ui/fragresolveui_atlas"
	local var_16_13 = "bg_"

	ItemRarity = var_16_11

	local var_16_14 = var_16_13 .. var_16_11.Rarity2Print(var_16_2:getConfig("rarity"))
	local var_16_15 = arg_16_0.rtResult

	var_4(var_16_12, var_16_14, var_8.Find(var_16_15, "target/bg"))

	underscore = var_4
	arg_16_0.countList = var_4.map(arg_16_0.displayList, function(arg_17_0)
		return 0
	end)
	arg_16_0.count = 0

	local var_16_16 = arg_16_0.itemList

	var_4.align(var_16_16, #arg_16_0.displayList)

	triggerToggle = var_4

	var_4(arg_16_0.toggleSwitch, arg_16_1:canFateSimulation())

	setText = var_4

	local var_16_17 = arg_16_0.fateText

	if arg_16_1:IsFate() then
		i18n = var_16_18

		local var_16_18

		if not var_16_18("blueprint_lab_fate_unlock") then
			i18n = var_16_18
			var_16_18 = var_16_18("blueprint_lab_fate_lock")
		end

		var_4(var_16_17, var_16_18)

		return
	end
end

function var_0_1.UpdateResult(arg_18_0)
	local var_18_0

	if not arg_18_0.bagProxy then
		getProxy = var_18_0
		BagProxy = var_1_10003
		var_18_0 = var_18_0(var_1_10003)
	end

	arg_18_0.bagProxy = var_18_0
	math = var_18_0

	local var_18_1 = var_18_0.max
	local var_18_2 = arg_18_0.blueprintVO
	local var_18_3 = var_3.getUseageMaxItem(var_18_2)

	if arg_18_0.isSwitch then
		local var_18_4 = arg_18_0.blueprintVO
		local var_18_5

		if not var_4.getFateMaxLeftOver(var_18_4) then
			var_18_5 = 0
		end

		local var_18_6 = var_18_3 + var_18_5
		local var_18_7 = arg_18_0.bagProxy
		local var_18_8 = var_4.getItemCountById
		local var_18_9 = arg_18_0.blueprintVO

		arg_18_0.need = var_18_1(var_18_6 - var_18_8(var_18_7, var_7.getItemId(var_18_9)), 0)

		local var_18_10 = #arg_18_0.displayList

		while 0 < var_18_10 and arg_18_0.count > arg_18_0.need do
			local var_18_11 = arg_18_0.countList[var_18_10]

			if 0 < var_18_11 then
				var_18_11 = arg_18_0.awardList[var_18_10].count
				math = var_3

				local var_18_12 = var_3.floor((arg_18_0.count - arg_18_0.need + var_18_11 - 1) / var_18_11)
				local var_18_13

				if arg_18_0.countList[var_18_10] < var_18_12 then
					arg_18_0.count = arg_18_0.count - var_18_11 * arg_18_0.countList[var_18_10]
					var_18_13 = arg_18_0.countList
					var_18_13[var_18_10] = 0
				else
					arg_18_0.count = arg_18_0.count - var_18_11 * var_18_12
					var_18_13 = arg_18_0.countList
					var_18_13[var_18_10] = arg_18_0.countList[var_18_10] - var_18_12
				end

				setText = var_18_13

				local var_18_14 = arg_18_0.itemList.container
				local var_18_15 = var_6.GetChild(var_18_14, var_18_10 - 1)

				var_18_13(var_6.Find(var_18_15, "calc/value"), arg_18_0.countList[var_18_10])
			end

			var_18_10 = var_18_10 - 1
		end

		setText = var_18_11

		local var_18_16 = arg_18_0.rtExchange
		local var_18_17 = var_4.Find(var_18_16, "bg/count")

		setColorStr = var_18_2

		var_18_11(var_18_17, var_18_2(arg_18_0.count, "#FFEC6E") .. "/" .. arg_18_0.need)

		return
	end
end

return var_0_1
