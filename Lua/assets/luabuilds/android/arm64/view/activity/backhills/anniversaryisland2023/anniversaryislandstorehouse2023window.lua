local var_0_0 = class("AnniversaryIslandStoreHouse2023Window", import("view.base.BaseUI"))

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.loader = AutoLoader.New()

	return
end

function var_0_0.getUIName(arg_2_0)
	return "AnniversaryIslandStoreHouse2023Window"
end

local var_0_1 = "ui/AtelierCommonUI_atlas"

function var_0_0.preload(arg_3_0, arg_3_1)
	table.ParallelIpairsAsync({
		var_0_1
	}, function(arg_4_0, arg_4_1, arg_4_2)
		arg_3_0.loader:LoadBundle(arg_4_1, arg_4_2)

		return
	end, arg_3_1)

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.storehouseRect = arg_5_0._tf:Find("Window/ScrollView"):GetComponent("LScrollRect")

	setActive(arg_5_0._tf:Find("Window/ScrollView/Item"), false)

	return
end

function var_0_0.SetActivity(arg_6_0, arg_6_1)
	arg_6_0.items = arg_6_1:GetAllVitems()
	arg_6_0.itemList = {}

	table.Foreach(arg_6_0.items, function(arg_7_0, arg_7_1)
		if arg_7_1 <= 0 then
			return
		end

		table.insert(arg_6_0.itemList, WorkBenchItem.New({
			configId = arg_7_0,
			count = arg_7_1
		}))

		return
	end)
	table.sort(arg_6_0.itemList, function(arg_8_0, arg_8_1)
		return arg_8_0:GetConfigID() < arg_8_1:GetConfigID()
	end)

	return
end

function var_0_0.didEnter(arg_9_0)
	function arg_9_0.storehouseRect.onUpdateItem(arg_10_0, arg_10_1)
		arg_10_0 = arg_10_0 + 1

		local var_10_0 = tf(arg_10_1)
		local var_10_1 = arg_9_0.itemList[arg_10_0]

		arg_9_0:UpdateItem(var_10_0:Find("IconBG"), arg_9_0.itemList[arg_10_0])
		setScrollText(var_10_0:Find("NameBG/Rect/Name"), arg_9_0.itemList[arg_10_0]:GetName())
		onButton(arg_9_0, var_10_0, function()
			arg_9_0:emit(WorkBenchItemDetailMediator.SHOW_DETAIL, var_10_1)

			return
		end, SFX_PANEL)

		return
	end

	onButton(arg_9_0, arg_9_0._tf:Find("Window/Close"), function()
		arg_9_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_9_0, arg_9_0._tf:Find("BG"), function()
		arg_9_0:onBackPressed()

		return
	end)
	arg_9_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_14_0)
	setActive(arg_14_0._tf:Find("Window/Empty"), #arg_14_0.itemList == 0)
	setActive(arg_14_0._tf:Find("Window/ScrollView"), #arg_14_0.itemList > 0)
	arg_14_0.storehouseRect:SetTotalCount(#arg_14_0.itemList)

	return
end

function var_0_0.UpdateItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.loader:GetSpriteQuiet(var_0_1, "icon_frame_" .. arg_15_2:GetRarity(), arg_15_1)
	arg_15_0.loader:GetSpriteQuiet(arg_15_2:GetIconPath(), "", arg_15_1:Find("Icon"))

	if not IsNil(arg_15_1:Find("Text")) then
		setText(arg_15_1:Find("Text"), arg_15_2.count)
	end

	return
end

function var_0_0.willExit(arg_16_0)
	arg_16_0.loader:Clear()

	return
end

return var_0_0
