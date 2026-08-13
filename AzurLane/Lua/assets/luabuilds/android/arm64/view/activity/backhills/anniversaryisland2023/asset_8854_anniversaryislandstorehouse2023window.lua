class = var_0_10000

local var_0_0 = "AnniversaryIslandStoreHouse2023Window"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	AutoLoader = var_1
	arg_1_0.loader = var_1.New()

	return
end

function var_0_1.getUIName(arg_2_0)
	return "AnniversaryIslandStoreHouse2023Window"
end

local var_0_2 = "ui/AtelierCommonUI_atlas"

function var_0_1.preload(arg_3_0, arg_3_1)
	table = var_1_10002

	var_1_10002.ParallelIpairsAsync({
		var_0_2
	}, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_3_0.loader

		var_3.LoadBundle(var_4_0, arg_4_1, arg_4_2)

		return
	end, arg_3_1)

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_1.Find(var_5_0, "Window/ScrollView")

	arg_5_0.storehouseRect = var_1.GetComponent(var_5_1, "LScrollRect")
	setActive = var_1

	local var_5_2 = arg_5_0._tf

	var_1(var_3.Find(var_5_2, "Window/ScrollView/Item"), false)

	return
end

function var_0_1.SetActivity(arg_6_0, arg_6_1)
	arg_6_0.items = arg_6_1:GetAllVitems()
	arg_6_0.itemList = {}
	table = var_2

	var_2.Foreach(arg_6_0.items, function(arg_7_0, arg_7_1)
		if arg_7_1 <= 0 then
			return
		end

		table = var_2

		local var_7_0 = var_2.insert
		local var_7_1 = arg_6_0.itemList

		WorkBenchItem = var_2_10005

		var_7_0(var_7_1, var_2_10005.New({
			configId = arg_7_0,
			count = arg_7_1
		}))

		return
	end)

	table = var_2

	var_2.sort(arg_6_0.itemList, function(arg_8_0, arg_8_1)
		return arg_8_0:GetConfigID() < arg_8_1:GetConfigID()
	end)

	return
end

function var_0_1.didEnter(arg_9_0)
	local var_9_0 = arg_9_0.storehouseRect

	function var_9_0.onUpdateItem(arg_10_0, arg_10_1)
		arg_10_0 = arg_10_0 + 1
		tf = var_2_10002

		local var_10_0 = var_2_10002(arg_10_1)
		local var_10_1 = arg_9_0.itemList[arg_10_0]
		local var_10_2 = arg_9_0

		var_4.UpdateItem(var_10_2, var_10_0:Find("IconBG"), var_10_1)

		setScrollText = var_4

		local var_10_3 = var_10_0:Find("NameBG/Rect/Name")
		local var_10_4 = var_10_1

		var_4(var_10_3, var_10_1.GetName(var_10_4))

		onButton = var_4

		local var_10_5 = arg_9_0
		local var_10_6 = var_10_0

		local function var_10_7()
			local var_11_0 = arg_9_0
			local var_11_1 = var_0.emit

			WorkBenchItemDetailMediator = var_3_10003

			var_11_1(var_11_0, var_3_10003.SHOW_DETAIL, var_10_1)

			return
		end

		SFX_PANEL = var_10_4

		var_4(var_10_5, var_10_6, var_10_7, var_10_4)

		return
	end

	onButton = var_9_0

	local var_9_1 = arg_9_0
	local var_9_2 = arg_9_0._tf
	local var_9_3 = var_4.Find(var_9_2, "Window/Close")

	local function var_9_4()
		local var_12_0 = arg_9_0

		var_0.onBackPressed(var_12_0)

		return
	end

	SFX_CANCEL = var_9_2

	var_9_0(var_9_1, var_9_3, var_9_4, var_9_2)

	onButton = var_9_0

	local var_9_5 = arg_9_0
	local var_9_6 = arg_9_0._tf

	var_9_0(var_9_5, var_4.Find(var_9_6, "BG"), function()
		local var_13_0 = arg_9_0

		var_0.onBackPressed(var_13_0)

		return
	end)
	arg_9_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_14_0)
	local var_14_0 = arg_14_0.itemList

	setActive = var_1_10002

	local var_14_1 = arg_14_0._tf

	var_1_10002(var_4.Find(var_14_1, "Window/Empty"), #var_14_0 == 0)

	setActive = var_1_10002

	local var_14_2 = arg_14_0._tf

	var_1_10002(var_4.Find(var_14_2, "Window/ScrollView"), #var_14_0 > 0)

	local var_14_3 = arg_14_0.storehouseRect

	var_2.SetTotalCount(var_14_3, #var_14_0)

	return
end

function var_0_1.UpdateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = "icon_frame_" .. arg_15_2:GetRarity()
	local var_15_1 = arg_15_0.loader

	var_4.GetSpriteQuiet(var_15_1, var_0_2, var_15_0, arg_15_1)

	local var_15_2 = arg_15_0.loader

	var_4.GetSpriteQuiet(var_15_2, arg_15_2:GetIconPath(), "", arg_15_1:Find("Icon"))

	IsNil = var_4

	if not var_4(arg_15_1:Find("Text")) then
		setText = var_4

		var_4(arg_15_1:Find("Text"), arg_15_2.count)
	end

	return
end

function var_0_1.willExit(arg_16_0)
	local var_16_0 = arg_16_0.loader

	var_1.Clear(var_16_0)

	return
end

return var_0_1
