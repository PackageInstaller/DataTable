class = var_0_10000

local var_0_0 = var_0_10000("AssignedItemPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	tf = var_3
	arg_1_0._tf = var_3(arg_1_1)
	arg_1_0.isInited = false
	arg_1_0.selectedVO = nil
	arg_1_0.count = 1
	arg_1_0.view = arg_1_2

	return
end

function var_0_0.show(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0._tf, true)

	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	return
end

function var_0_0.hide(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0._tf, false)

	arg_3_0.selectedVO = nil
	arg_3_0.itemVO = nil
	arg_3_0.count = 1
	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_3_0, arg_3_0._tf, arg_3_0.view._tf)

	if arg_3_0.selectedItem then
		triggerToggle = var_1

		var_1(arg_3_0.selectedItem, false)
	end

	arg_3_0.selectedItem = nil

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.isInited = true
	UIItemList = var_1

	local var_4_0 = var_1.New
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "got/bottom/scroll/list")
	local var_4_3 = arg_4_0._tf

	arg_4_0.ulist = var_4_0(var_4_2, var_4.Find(var_4_3, "got/bottom/scroll/list/tpl"))

	local var_4_4 = arg_4_0._tf

	arg_4_0.confirmBtn = var_1.Find(var_4_4, "calc/confirm")

	local var_4_5 = arg_4_0._tf

	arg_4_0.rightArr = var_1.Find(var_4_5, "calc/value_bg/add")

	local var_4_6 = arg_4_0._tf

	arg_4_0.leftArr = var_1.Find(var_4_6, "calc/value_bg/mius")

	local var_4_7 = arg_4_0._tf

	arg_4_0.maxBtn = var_1.Find(var_4_7, "calc/max")

	local var_4_8 = arg_4_0._tf

	arg_4_0.valueText = var_1.Find(var_4_8, "calc/value_bg/Text")

	local var_4_9 = arg_4_0._tf

	arg_4_0.itemTF = var_1.Find(var_4_9, "item/bottom/item")

	local var_4_10 = arg_4_0._tf

	arg_4_0.nameTF = var_1.Find(var_4_10, "item/bottom/name_bg/name")

	local var_4_11 = arg_4_0._tf

	arg_4_0.descTF = var_1.Find(var_4_11, "item/bottom/desc")
	onButton = var_1

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0._tf

	local function var_4_14()
		local var_5_0 = arg_4_0

		var_0.hide(var_5_0)

		return
	end

	SFX_PANEL = var_4_3

	var_1(var_4_12, var_4_13, var_4_14, var_4_3)

	onButton = var_1

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.rightArr

	local function var_4_17()
		if not arg_4_0.itemVO then
			return
		end

		local var_6_0 = arg_4_0

		math = var_2_10001
		var_6_0.count = var_2_10001.min(arg_4_0.count + 1, arg_4_0.itemVO.count)

		local var_6_1 = arg_4_0

		var_0.updateValue(var_6_1)

		return
	end

	SFX_PANEL = var_4_3

	var_1(var_4_15, var_4_16, var_4_17, var_4_3)

	onButton = var_1

	local var_4_18 = arg_4_0
	local var_4_19 = arg_4_0.leftArr

	local function var_4_20()
		if not arg_4_0.itemVO then
			return
		end

		local var_7_0 = arg_4_0

		math = var_2_10001
		var_7_0.count = var_2_10001.max(arg_4_0.count - 1, 1)

		local var_7_1 = arg_4_0

		var_0.updateValue(var_7_1)

		return
	end

	SFX_PANEL = var_4_3

	var_1(var_4_18, var_4_19, var_4_20, var_4_3)

	onButton = var_1

	local var_4_21 = arg_4_0
	local var_4_22 = arg_4_0.maxBtn

	local function var_4_23()
		if not arg_4_0.itemVO then
			return
		end

		arg_4_0.count = arg_4_0.itemVO.count

		local var_8_0 = arg_4_0

		var_0.updateValue(var_8_0)

		return
	end

	SFX_PANEL = var_4_3

	var_1(var_4_21, var_4_22, var_4_23, var_4_3)

	onButton = var_1

	local var_4_24 = arg_4_0
	local var_4_25 = arg_4_0.confirmBtn

	local function var_4_26()
		if not arg_4_0.selectedVO or not arg_4_0.itemVO or arg_4_0.count <= 0 then
			return
		end

		local var_9_0 = arg_4_0.view
		local var_9_1 = var_0.emit

		EquipmentMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_USE_ITEM, arg_4_0.itemVO.id, arg_4_0.count, arg_4_0.selectedVO)

		local var_9_2 = arg_4_0

		var_0.hide(var_9_2)

		return
	end

	SFX_PANEL = var_4_3

	var_1(var_4_24, var_4_25, var_4_26, var_4_3)

	return
end

function var_0_0.updateValue(arg_10_0)
	setText = var_1_10001

	var_1_10001(arg_10_0.valueText, arg_10_0.count)

	local var_10_0 = arg_10_0.ulist

	var_1.each(var_10_0, function(arg_11_0, arg_11_1)
		setText = var_2_10002

		var_2_10002(arg_11_1:Find("item/bg/icon_bg/count"), arg_10_0.count)

		return
	end)

	return
end

function var_0_0.update(arg_12_0, arg_12_1)
	arg_12_0.itemVO = arg_12_1

	if not arg_12_0.isInited then
		arg_12_0:init()
	end

	local var_12_0 = arg_12_1:getConfig("display_icon")

	arg_12_0.selectedItem = nil

	local var_12_1 = arg_12_0.ulist

	var_3.make(var_12_1, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = var_12_0[arg_13_1 + 1]
			local var_13_1 = {
				type = var_13_0[1],
				id = var_13_0[2],
				count = var_13_0[3]
			}

			updateDrop = var_5

			var_5(arg_13_2:Find("item/bg"), var_13_1)

			local var_13_2 = arg_13_2:Find("item/bg/icon_bg/count")

			onToggle = var_2_10006

			local var_13_3 = arg_12_0
			local var_13_4 = arg_13_2

			local function var_13_5(arg_14_0)
				if arg_14_0 then
					local var_14_0 = arg_12_0
					local var_14_1 = arg_12_1

					var_14_0.selectedVO = var_2.getConfig(var_14_1, "usage_arg")[arg_13_1 + 1]
					setText = var_14_0

					var_14_0(var_13_2, arg_12_0.count * var_13_0[3])

					arg_12_0.selectedItem = arg_13_2
				end

				return
			end

			SFX_PANEL = var_2_10011

			var_2_10006(var_13_3, var_13_4, var_13_5, var_2_10011)

			setScrollText = var_2_10006

			var_2_10006(arg_13_2:Find("name_bg/Text"), var_13_1:getConfig("name"))
		end

		return
	end)

	local var_12_2 = arg_12_0.ulist

	var_3.align(var_12_2, #var_12_0)
	arg_12_0:updateValue()

	updateDrop = var_3

	local var_12_3 = arg_12_0.itemTF
	local var_12_4 = var_5.Find(var_12_3, "bg")
	local var_12_5 = {}

	DROP_TYPE_ITEM = var_12_3
	var_12_5.type = var_12_3
	var_12_5.id = arg_12_1.id
	var_12_5.count = arg_12_1.count

	var_3(var_12_4, var_12_5)

	setText = var_3

	var_3(arg_12_0.nameTF, arg_12_1:getConfig("name"))

	setText = var_3

	var_3(arg_12_0.descTF, arg_12_1:getConfig("display"))

	return
end

function var_0_0.dispose(arg_15_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_15_0)

	return
end

return var_0_0
