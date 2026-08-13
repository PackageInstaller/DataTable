class = var_0_10000

local var_0_0 = "WorkBenchItemDetailLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "WorkBenchItemDetailLayer"
end

function var_0_1.init(arg_2_0)
	AutoLoader = var_1_10001
	arg_2_0.loader = var_1_10001.New()

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "BG")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_CANCEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_4.Find(var_3_5, "Window/Close")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.onBackPressed(var_5_0)

		return
	end

	SFX_CANCEL = var_3_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_3_5)
	arg_3_0:UpdateItemDetail()

	pg = var_1

	local var_3_8 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_8, arg_3_0._tf)

	return
end

function var_0_1.UpdateItemDetail(arg_6_0)
	local var_6_0 = arg_6_0.contextData.material
	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.UpdateItem
	local var_6_3 = arg_6_0._tf

	var_6_2(var_6_1, var_5.Find(var_6_3, "Window/IconBG"), var_6_0)

	setText = var_6_2

	local var_6_4 = arg_6_0._tf

	var_6_2(var_4.Find(var_6_4, "Window/Name"), var_6_0:GetName())

	setText = var_6_2

	local var_6_5 = arg_6_0._tf

	var_6_2(var_4.Find(var_6_5, "Window/Description/Text"), var_6_0:GetDesc())

	local var_6_6 = var_6_0:GetSource()

	setText = var_1_10003

	local var_6_7 = arg_6_0._tf
	local var_6_8 = var_5.Find(var_6_7, "Window/Source")
	local var_6_9

	if not var_6_6[1] then
		var_6_9 = ""
	end

	var_1_10003(var_6_8, var_6_9)

	onButton = var_1_10003

	local var_6_10 = arg_6_0
	local var_6_11 = arg_6_0._tf
	local var_6_12 = var_6.Find(var_6_11, "Window/Go")

	local function var_6_13()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		GAME = var_2_10003

		local var_7_2 = var_2_10003.WORKBENCH_ITEM_GO
		local var_7_3 = var_6_0

		var_7_1(var_7_0, var_7_2, var_4.GetConfigID(var_7_3))

		return
	end

	SFX_PANEL = var_6_11

	var_1_10003(var_6_10, var_6_12, var_6_13, var_6_11)

	setActive = var_1_10003

	local var_6_14 = arg_6_0._tf
	local var_6_15 = var_5.Find(var_6_14, "Window/Go")

	table = var_6_12

	var_1_10003(var_6_15, var_6_12.getCount(var_6_0:GetSource()) > 1)

	return
end

local var_0_2 = "ui/AtelierCommonUI_atlas"

function var_0_1.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = "icon_frame_" .. arg_8_2:GetRarity()
	local var_8_1 = arg_8_0.loader

	var_4.GetSpriteQuiet(var_8_1, var_0_2, var_8_0, arg_8_1)

	local var_8_2 = arg_8_0.loader

	var_4.GetSpriteQuiet(var_8_2, arg_8_2:GetIconPath(), "", arg_8_1:Find("Icon"))

	IsNil = var_4

	if not var_4(arg_8_1:Find("Text")) then
		setText = var_4

		var_4(arg_8_1:Find("Text"), arg_8_2.count)
	end

	return
end

function var_0_1.willExit(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf)

	local var_9_1 = arg_9_0.loader

	var_1.Clear(var_9_1)

	return
end

return var_0_1
