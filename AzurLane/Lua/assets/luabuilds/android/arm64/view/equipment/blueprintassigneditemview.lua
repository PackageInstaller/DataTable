class = var_0_10000

local var_0_0 = "BlueprintAssignedItemView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".AssignedItemView"))

function var_0_1.getUIName(arg_1_0)
	return "BlueprintItemAssignedView"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.countOver = var_1.Find(var_2_0, "operate/calc/value_bg/over_count")
	setText = var_1

	local var_2_1 = arg_2_0.countOver

	i18n = var_4

	var_1(var_2_1, var_4("blueprint_select_overflow"))

	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.maxBtn

	local function var_2_4()
		if not arg_2_0.itemVO or not arg_2_0.selectedIndex then
			return
		end

		local var_3_0 = arg_2_0.displayDrops[arg_2_0.selectedIndex]
		local var_3_1 = arg_2_0.count * var_3_0.count
		local var_3_2 = arg_2_0

		if var_3_1 < var_2.GetBlueprintNeed(var_3_2, var_3_0.id) then
			local var_3_3 = arg_2_0

			math = var_3_2
			var_3_3.count = var_3_2.floor((var_2 + var_3_0.count - 1) / var_3_0.count)

			local var_3_4 = arg_2_0

			math = var_4
			var_3_4.count = var_4.min(arg_2_0.count, arg_2_0.itemVO.count)
		else
			arg_2_0.count = arg_2_0.itemVO.count
		end

		local var_3_5 = arg_2_0

		var_3.updateValue(var_3_5)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_2, var_2_3, var_2_4, var_6)

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.confirmBtn

	local function var_2_7()
		if not arg_2_0.selectedIndex or not arg_2_0.itemVO or arg_2_0.count <= 0 then
			return
		end

		local var_4_0 = arg_2_0.displayDrops[arg_2_0.selectedIndex]
		local var_4_1 = arg_2_0.count * var_4_0.count
		local var_4_2 = arg_2_0
		local var_4_3 = var_2.GetBlueprintNeed(var_4_2, var_4_0.id)
		local var_4_4 = {}

		if arg_2_0.isSwitch then
			local var_4_5 = arg_2_0

			if not var_4.checkBlueprintIsFate(var_4_5, var_4_0.id) then
				if var_4_1 <= var_4_3 then
					table = var_4

					var_4.insert(var_4_4, function(arg_5_0)
						pg = var_3_10001

						local var_5_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_5_1 = var_1.ShowMsgBox
						local var_5_2 = {}

						i18n = var_3_10005
						var_5_2.content = var_3_10005("blueprint_exchange_fate_unlock")
						var_5_2.onYes = arg_5_0

						var_5_1(var_5_0, var_5_2)

						return
					end)
				else
					table = var_4

					var_4.insert(var_4_4, function(arg_6_0)
						pg = var_3_10001

						local var_6_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_6_1 = var_1.ShowMsgBox
						local var_6_2 = {}

						i18n = var_3_10005

						local var_6_3 = "blueprint_exchange_fate_unlock_over"
						local var_6_4 = var_4_0

						var_6_2.content = var_3_10005(var_6_3, var_8.getConfig(var_6_4, "name"), var_4_1 - var_4_3)
						var_6_2.onYes = arg_6_0

						var_6_1(var_6_0, var_6_2)

						return
					end)
				end

				goto label_4_0
			end
		end

		if not arg_2_0.isAllNeedZero and var_4_3 < var_4_1 then
			table = var_4

			var_4.insert(var_4_4, function(arg_7_0)
				pg = var_3_10001

				local var_7_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_7_1 = var_1.ShowMsgBox
				local var_7_2 = {}

				i18n = var_3_10005

				local var_7_3 = "blueprint_select_overflow_tip"
				local var_7_4 = var_4_0

				var_7_2.content = var_3_10005(var_7_3, var_8.getConfig(var_7_4, "name"), var_4_1 - var_4_3)
				var_7_2.onYes = arg_7_0

				var_7_1(var_7_0, var_7_2)

				return
			end)
		end

		::label_4_0::

		seriesAsync = var_4

		var_4(var_4_4, function()
			local var_8_0 = arg_2_0
			local var_8_1 = var_0.emit

			EquipmentMediator = var_3_10003

			local var_8_2 = var_3_10003.ON_USE_ITEM
			local var_8_3 = arg_2_0.itemVO.id
			local var_8_4 = arg_2_0.count
			local var_8_5 = arg_2_0.itemVO

			var_8_1(var_8_0, var_8_2, var_8_3, var_8_4, var_6.getConfig(var_8_5, "usage_arg")[arg_2_0.selectedIndex])

			local var_8_6 = arg_2_0

			var_0.Hide(var_8_6)

			return
		end)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_5, var_2_6, var_2_7, var_6)

	local var_2_8 = arg_2_0._tf

	arg_2_0.toggleSwitch = var_1.Find(var_2_8, "operate/got/top/switch_btn")
	setText = var_1

	local var_2_9 = arg_2_0.toggleSwitch
	local var_2_10 = var_3.Find(var_2_9, "Text_off")

	i18n = var_4

	var_1(var_2_10, var_4("show_fate_demand_count"))

	setText = var_1

	local var_2_11 = arg_2_0.toggleSwitch
	local var_2_12 = var_3.Find(var_2_11, "Text_on")

	i18n = var_4

	var_1(var_2_12, var_4("show_design_demand_count"))

	onToggle = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.toggleSwitch

	local function var_2_15(arg_9_0)
		arg_2_0.isSwitch = arg_9_0

		local var_9_0 = arg_2_0

		var_1.updateValue(var_9_0)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_13, var_2_14, var_2_15, var_6)

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "operate/got/top/info/Text")

	i18n = var_2_14

	var_1(var_2_17, var_2_14("fate_unlock_icon_desc"))

	return
end

function var_0_1.GetBlueprintNeed(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_0.technologyProxy then
		getProxy = var_10_0
		TechnologyProxy = var_1_10004
		var_10_0 = var_10_0(var_1_10004)
	end

	arg_10_0.technologyProxy = var_10_0

	local var_10_1 = arg_10_0.technologyProxy
	local var_10_2 = var_2.getBluePrintById
	local var_10_3 = arg_10_0.technologyProxy
	local var_10_4 = var_10_2(var_10_1, var_5.GetBlueprint4Item(var_10_3, arg_10_1))
	local var_10_5

	if not arg_10_0.bagProxy then
		getProxy = var_10_5
		BagProxy = var_5
		var_10_5 = var_10_5(var_5)
	end

	arg_10_0.bagProxy = var_10_5
	warning = var_10_5

	var_10_5(arg_10_0.isSwitch)

	math = var_10_5

	local var_10_6 = var_10_5.max
	local var_10_7 = var_10_4:getUseageMaxItem()
	local var_10_8

	if not arg_10_0.isSwitch or not var_10_4:getFateMaxLeftOver() then
		var_10_8 = 0
	end

	local var_10_9 = var_10_7 + var_10_8
	local var_10_10 = arg_10_0.bagProxy

	return var_10_6(var_10_9 - var_6.getItemCountById(var_10_10, var_10_4:getItemId()), 0)
end

function var_0_1.checkBlueprintIsUnlock(arg_11_0, arg_11_1)
	local var_11_0

	if not arg_11_0.technologyProxy then
		getProxy = var_11_0
		TechnologyProxy = var_1_10004
		var_11_0 = var_11_0(var_1_10004)
	end

	arg_11_0.technologyProxy = var_11_0

	local var_11_1 = arg_11_0.technologyProxy
	local var_11_2 = var_2.getBluePrintById
	local var_11_3 = arg_11_0.technologyProxy
	local var_11_4 = var_11_2(var_11_1, var_5.GetBlueprint4Item(var_11_3, arg_11_1))

	return var_2.isUnlock(var_11_4)
end

function var_0_1.checkBlueprintIsFate(arg_12_0, arg_12_1)
	local var_12_0

	if not arg_12_0.technologyProxy then
		getProxy = var_12_0
		TechnologyProxy = var_1_10004
		var_12_0 = var_12_0(var_1_10004)
	end

	arg_12_0.technologyProxy = var_12_0

	local var_12_1 = arg_12_0.technologyProxy
	local var_12_2 = var_2.getBluePrintById
	local var_12_3 = arg_12_0.technologyProxy
	local var_12_4 = var_12_2(var_12_1, var_5.GetBlueprint4Item(var_12_3, arg_12_1))

	return var_2.IsFate(var_12_4)
end

function var_0_1.updateValue(arg_13_0)
	underscore = var_1_10001
	arg_13_0.isAllNeedZero = var_1_10001.all(arg_13_0.displayDrops, function(arg_14_0)
		local var_14_0 = arg_13_0

		return var_1.GetBlueprintNeed(var_14_0, arg_14_0.id) == 0
	end)

	arg_13_0:updateCountText()

	local var_13_0 = arg_13_0.ulist

	var_1.each(var_13_0, function(arg_15_0, arg_15_1)
		isActive = var_2_10002

		if not var_2_10002(arg_15_1) then
			return
		end

		arg_15_0 = arg_15_0 + 1

		local var_15_0 = arg_13_0.displayDrops[arg_15_0]
		local var_15_1 = arg_13_0.count * var_15_0.count
		local var_15_2 = arg_13_0
		local var_15_3 = var_4.GetBlueprintNeed(var_15_2, var_15_0.id)

		setText = var_2_10005

		local var_15_4 = arg_15_1:Find("item/icon_bg/count")

		setColorStr = var_2_10008

		var_2_10005(var_15_4, var_2_10008(var_15_1, not arg_13_0.isAllNeedZero and var_15_3 < var_15_1 and "#FF5A5A" or "#FFEC6E") .. "/" .. var_15_3)

		return
	end)

	return
end

function var_0_1.updateCountText(arg_16_0)
	local var_16_0 = arg_16_0.displayDrops[arg_16_0.selectedIndex]
	local var_16_1 = arg_16_0.count * var_16_0.count
	local var_16_2 = arg_16_0:GetBlueprintNeed(var_16_0.id)

	setText = var_1_10004

	local var_16_3 = arg_16_0.valueText

	if not arg_16_0.isAllNeedZero and var_16_2 < var_16_1 then
		setColorStr = var_7

		local var_16_4

		if not var_7(arg_16_0.count, "#FF5A5A") then
			var_16_4 = arg_16_0.count
		end

		var_1_10004(var_16_3, var_16_4)

		setActive = var_1_10004

		var_1_10004(arg_16_0.countOver, not arg_16_0.isAllNeedZero and var_16_2 < var_16_1)

		return
	end
end

function var_0_1.update(arg_17_0, arg_17_1)
	arg_17_0.count = 1
	arg_17_0.selectedIndex = nil
	arg_17_0.selectedItem = nil
	arg_17_0.isSwitch = false
	arg_17_0.itemVO = arg_17_1
	underscore = var_2

	local var_17_0 = var_2.map
	local var_17_1 = arg_17_1

	arg_17_0.displayDrops = var_17_0(arg_17_1.getConfig(var_17_1, "display_icon"), function(arg_18_0)
		return {
			type = arg_18_0[1],
			id = arg_18_0[2],
			count = arg_18_0[3]
		}
	end)

	local var_17_2 = arg_17_0.ulist

	var_2.make(var_17_2, function(arg_19_0, arg_19_1, arg_19_2)
		arg_19_1 = arg_19_1 + 1
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			updateDrop = var_3

			var_3(arg_19_2:Find("item"), arg_17_0.displayDrops[arg_19_1])

			onToggle = var_3

			local var_19_0 = arg_17_0
			local var_19_1 = arg_19_2

			local function var_19_2(arg_20_0)
				if arg_20_0 then
					arg_17_0.selectedIndex = arg_19_1
					arg_17_0.selectedItem = arg_19_2

					local var_20_0 = arg_17_0

					var_1.updateCountText(var_20_0)
				end

				return
			end

			SFX_PANEL = var_8

			var_3(var_19_0, var_19_1, var_19_2, var_8)

			triggerToggle = var_3

			var_3(arg_19_2, arg_19_1 == 1)

			setScrollText = var_3

			local var_19_3 = arg_19_2:Find("name_bg/Text")
			local var_19_4 = arg_17_0.displayDrops[arg_19_1]

			var_3(var_19_3, var_6.getConfig(var_19_4, "name"))

			local var_19_5 = arg_17_0
			local var_19_6

			if not arg_17_0.selectedItem then
				var_19_6 = arg_19_2
			end

			var_19_5.selectedItem = var_19_6
			setText = var_19_5

			local var_19_7 = arg_19_2:Find("item/tip/Text")

			i18n = var_6

			var_19_5(var_19_7, var_6("tech_character_get"))

			setActive = var_19_5

			local var_19_8 = arg_19_2:Find("item/tip")
			local var_19_9 = arg_17_0

			var_19_5(var_19_8, var_6.checkBlueprintIsUnlock(var_19_9, arg_17_0.displayDrops[arg_19_1].id))

			setActive = var_19_5

			local var_19_10 = arg_19_2:Find("fateFlag")
			local var_19_11 = arg_17_0

			var_19_5(var_19_10, var_6.checkBlueprintIsFate(var_19_11, arg_17_0.displayDrops[arg_19_1].id))
		end

		return
	end)

	local var_17_3 = arg_17_0.ulist

	var_2.align(var_17_3, #arg_17_0.displayDrops)

	triggerToggle = var_2

	var_2(arg_17_0.selectedItem, true)

	triggerToggle = var_2

	var_2(arg_17_0.toggleSwitch, false)

	Drop = var_2

	local var_17_4 = var_2.New
	local var_17_5 = {}

	DROP_TYPE_ITEM = var_5
	var_17_5.type = var_5
	var_17_5.id = arg_17_1.id
	var_17_5.count = arg_17_1.count

	local var_17_6 = var_17_4(var_17_5)

	updateDrop = var_1_10003

	local var_17_7 = arg_17_0.itemTF
	local var_17_8 = var_5.Find(var_17_7, "left/IconTpl")

	setmetatable = var_17_1

	var_1_10003(var_17_8, var_17_1({
		count = 0
	}, {
		__index = var_17_6
	}))

	UpdateOwnDisplay = var_1_10003

	local var_17_9 = arg_17_0.itemTF

	var_1_10003(var_5.Find(var_17_9, "left/own"), var_17_6)

	setText = var_1_10003

	var_1_10003(arg_17_0.nameTF, arg_17_1:getConfig("name"))

	setText = var_1_10003

	var_1_10003(arg_17_0.descTF, arg_17_1:getConfig("display"))

	return
end

return var_0_1
