class = var_0_10000

local var_0_0 = "WorldAssignedItemView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "StoreHouseItemAssignedView"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "operate")

	UIItemList = var_2_0
	arg_2_0.ulist = var_2_0.New(var_2_1:Find("got/bottom/list"), var_2_1:Find("got/bottom/list/tpl"))
	arg_2_0.confirmBtn = var_2_1:Find("actions/confirm")
	setText = var_2

	local var_2_2 = arg_2_0.confirmBtn
	local var_2_3 = var_3.Find(var_2_2, "Image")

	i18n = var_2_2

	var_2(var_2_3, var_2_2("text_confirm"))

	arg_2_0.cancelBtn = var_2_1:Find("actions/cancel")
	setText = var_2

	local var_2_4 = arg_2_0.cancelBtn
	local var_2_5 = var_3.Find(var_2_4, "Image")

	i18n = var_2_4

	var_2(var_2_5, var_2_4("text_cancel"))

	arg_2_0.rightArr = var_2_1:Find("calc/value_bg/add")
	arg_2_0.leftArr = var_2_1:Find("calc/value_bg/mius")
	arg_2_0.maxBtn = var_2_1:Find("calc/max")
	arg_2_0.valueText = var_2_1:Find("calc/value_bg/Text")
	arg_2_0.itemTF = var_2_1:Find("item")
	arg_2_0.nameTF = var_2_1:Find("item/display_panel/name_container/name/Text")
	arg_2_0.descTF = var_2_1:Find("item/display_panel/desc/Text")
	onButton = var_2

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_4.Find(var_2_7, "bg")

	local function var_2_9()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_2_6, var_2_8, var_2_9, var_6)

	onButton = var_2

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.cancelBtn

	local function var_2_12()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_2_10, var_2_11, var_2_12, var_6)

	pressPersistTrigger = var_2

	local var_2_13 = arg_2_0.rightArr
	local var_2_14 = 0.5

	local function var_2_15(arg_5_0)
		if not arg_2_0.itemVO then
			arg_5_0()

			return
		end

		local var_5_0 = arg_2_0

		math = var_2_10002
		var_5_0.count = var_2_10002.min(arg_2_0.count + 1, arg_2_0.itemVO.count)

		local var_5_1 = arg_2_0

		var_1.updateValue(var_5_1)

		return
	end

	local var_2_16
	local var_2_17 = true
	local var_2_18 = true
	local var_2_19 = 0.1

	SFX_PANEL = var_1_10010

	var_2(var_2_13, var_2_14, var_2_15, var_2_16, var_2_17, var_2_18, var_2_19, var_1_10010)

	pressPersistTrigger = var_2

	local var_2_20 = arg_2_0.leftArr
	local var_2_21 = 0.5

	local function var_2_22(arg_6_0)
		if not arg_2_0.itemVO then
			arg_6_0()

			return
		end

		local var_6_0 = arg_2_0

		math = var_2_10002
		var_6_0.count = var_2_10002.max(arg_2_0.count - 1, 1)

		local var_6_1 = arg_2_0

		var_1.updateValue(var_6_1)

		return
	end

	local var_2_23
	local var_2_24 = true
	local var_2_25 = true
	local var_2_26 = 0.1

	SFX_PANEL = var_1_10010

	var_2(var_2_20, var_2_21, var_2_22, var_2_23, var_2_24, var_2_25, var_2_26, var_1_10010)

	onButton = var_2

	local var_2_27 = arg_2_0
	local var_2_28 = arg_2_0.maxBtn

	local function var_2_29()
		if not arg_2_0.itemVO then
			return
		end

		arg_2_0.count = arg_2_0.itemVO.count

		local var_7_0 = arg_2_0

		var_0.updateValue(var_7_0)

		return
	end

	SFX_PANEL = var_2_23

	var_2(var_2_27, var_2_28, var_2_29, var_2_23)

	onButton = var_2

	local var_2_30 = arg_2_0
	local var_2_31 = arg_2_0.confirmBtn

	local function var_2_32()
		if not arg_2_0.selectedIndex or not arg_2_0.itemVO or arg_2_0.count <= 0 then
			return
		end

		local var_8_0 = arg_2_0
		local var_8_1 = var_0.emit

		WorldInventoryMediator = var_2_10002

		local var_8_2 = var_2_10002.OnUseItem
		local var_8_3 = arg_2_0.itemVO.id
		local var_8_4 = arg_2_0.count
		local var_8_5 = arg_2_0.itemVO

		var_8_1(var_8_0, var_8_2, var_8_3, var_8_4, var_5.getConfig(var_8_5, "usage_arg")[arg_2_0.selectedIndex])

		local var_8_6 = arg_2_0

		var_0.Hide(var_8_6)

		return
	end

	SFX_PANEL = var_2_23

	var_2(var_2_30, var_2_31, var_2_32, var_2_23)

	return
end

function var_0_1.Show(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_9_0, arg_9_0._tf)

	setActive = var_1

	var_1(arg_9_0._tf, true)

	return
end

function var_0_1.Hide(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0._parentTf)

	setActive = var_1

	var_1(arg_10_0._tf, false)

	return
end

function var_0_1.updateValue(arg_11_0)
	setText = var_1_10001

	var_1_10001(arg_11_0.valueText, arg_11_0.count)

	local var_11_0 = arg_11_0.ulist

	var_1.each(var_11_0, function(arg_12_0, arg_12_1)
		isActive = var_2_10002

		if not var_2_10002(arg_12_1) then
			return
		end

		setText = var_2

		var_2(arg_12_1:Find("item/icon_bg/count"), arg_11_0.count)

		return
	end)

	return
end

function var_0_1.update(arg_13_0, arg_13_1)
	arg_13_0.count = 1
	arg_13_0.selectedIndex = nil
	arg_13_0.selectedItem = nil
	arg_13_0.itemVO = arg_13_1
	underscore = var_2
	arg_13_0.displayDrops = var_2.map(arg_13_1:getConfig("usage_arg"), function(arg_14_0)
		return {
			type = arg_14_0[1],
			id = arg_14_0[2],
			count = arg_14_0[3]
		}
	end)

	local var_13_0 = arg_13_0.ulist

	var_2.make(var_13_0, function(arg_15_0, arg_15_1, arg_15_2)
		arg_15_1 = arg_15_1 + 1
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			updateDrop = var_3

			var_3(arg_15_2:Find("item"), arg_13_0.displayDrops[arg_15_1])

			local var_15_0 = arg_15_2
			local var_15_1 = arg_15_2.Find(var_15_0, "item/icon_bg/count")

			onToggle = var_15_0

			local var_15_2 = arg_13_0
			local var_15_3 = arg_15_2

			local function var_15_4(arg_16_0)
				if arg_16_0 then
					arg_13_0.selectedIndex = arg_15_1
					arg_13_0.selectedItem = arg_15_2
				elseif arg_13_0.selectedIndex == arg_15_1 then
					arg_13_0.selectedIndex = nil
					arg_13_0.selectedItem = nil
				end

				return
			end

			SFX_PANEL = var_2_10008

			var_15_0(var_15_2, var_15_3, var_15_4, var_2_10008)

			setScrollText = var_15_0

			local var_15_5 = arg_15_2:Find("name_bg/Text")
			local var_15_6 = arg_13_0.displayDrops[arg_15_1]

			var_15_0(var_15_5, var_6.getConfig(var_15_6, "name"))

			local var_15_7 = arg_13_0
			local var_15_8

			if not arg_13_0.selectedItem then
				var_15_8 = arg_15_2
			end

			var_15_7.selectedItem = var_15_8
		end

		return
	end)

	local var_13_1 = arg_13_0.ulist

	var_2.align(var_13_1, #arg_13_0.displayDrops)

	triggerToggle = var_2

	var_2(arg_13_0.selectedItem, true)
	arg_13_0:updateValue()

	Drop = var_2

	local var_13_2 = var_2.New({
		type = arg_13_1.type,
		id = arg_13_1.id,
		count = arg_13_1.count
	})

	updateDrop = var_3

	local var_13_3 = arg_13_0.itemTF
	local var_13_4 = var_4.Find(var_13_3, "left/IconTpl")

	setmetatable = var_13_3

	var_3(var_13_4, var_13_3({
		count = 0
	}, {
		__index = var_13_2
	}))

	UpdateOwnDisplay = var_3

	local var_13_5 = arg_13_0.itemTF

	var_3(var_4.Find(var_13_5, "left/own"), var_13_2)

	setText = var_3

	var_3(arg_13_0.nameTF, arg_13_1:getConfig("name"))

	setText = var_3

	var_3(arg_13_0.descTF, arg_13_1:getConfig("display"))

	return
end

return var_0_1
