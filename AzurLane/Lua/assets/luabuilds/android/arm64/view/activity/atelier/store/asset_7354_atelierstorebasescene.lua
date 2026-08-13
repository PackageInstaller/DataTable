class = var_0_10000

local var_0_0 = "AtelierStoreBaseScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AtelierStoreUI"
end

function var_0_1.init(arg_2_0)
	GetComponent = var_1_10001

	local var_2_0 = arg_2_0._tf

	arg_2_0.storehouseRect = var_1_10001(var_3.Find(var_2_0, "Window/ScrollView"), "LScrollRect")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "Window/ScrollView/Item")

	setActive = var_1_10002

	var_1_10002(var_2_2, false)
	arg_2_0:InitCustom()

	return
end

function var_0_1.InitCustom(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_3.Find(var_3_0, "Window/Empty")

	i18n = var_1_10004

	var_1_10001(var_3_1, var_1_10004("ryza_tip_no_item"))

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0.activity = arg_4_0.contextData.activity
	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_4.Find(var_4_1, "Window/Close")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_4_1

	var_1(var_4_0, var_4_2, var_4_3, var_4_1)

	onButton = var_1

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_4.Find(var_4_5, "BG")

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_4_5

	var_1(var_4_4, var_4_6, var_4_7, var_4_5)
	arg_4_0:ShowStoreHouseWindow()

	return
end

function var_0_1.ShowStoreHouseWindow(arg_7_0)
	local var_7_0

	if not arg_7_0.contextData.versionIndex then
		var_7_0 = 1
	end

	pg = var_1_10002

	local var_7_1 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_1, arg_7_0._tf)

	_ = var_2

	local var_7_2 = var_2.filter

	_ = var_7_1

	local var_7_3 = var_7_1.values
	local var_7_4 = arg_7_0.activity
	local var_7_5 = var_7_2(var_7_3(var_6.GetItems(var_7_4)), function(arg_8_0)
		return arg_8_0.count > 0 and arg_8_0:GetVersion() == var_7_0 and arg_8_0:IsShow() ~= 0
	end)

	table = var_1_10003

	var_1_10003.sort(var_7_5, function(arg_9_0, arg_9_1)
		return arg_9_0:GetConfigID() < arg_9_1:GetConfigID()
	end)

	setActive = var_3

	local var_7_6 = arg_7_0._tf

	var_3(var_5.Find(var_7_6, "Window/Empty"), #var_7_5 == 0)

	setActive = var_3

	local var_7_7 = arg_7_0._tf

	var_3(var_5.Find(var_7_7, "Window/ScrollView"), #var_7_5 > 0)

	if #var_7_5 == 0 then
		return
	end

	function arg_7_0.storehouseRect.onUpdateItem(arg_10_0, arg_10_1)
		arg_10_0 = arg_10_0 + 1
		tf = var_2_10002

		local var_10_0 = var_2_10002(arg_10_1)
		local var_10_1 = var_7_5[arg_10_0]
		local var_10_2 = arg_7_0

		var_4.UpdateRyzaItem(var_10_2, var_10_0:Find("IconBG"), var_10_1)

		setScrollText = var_4

		local var_10_3 = var_10_0:Find("NameBG/Rect/Name")
		local var_10_4 = var_10_1

		var_4(var_10_3, var_10_1.GetName(var_10_4))

		onButton = var_4

		local var_10_5 = arg_7_0
		local var_10_6 = var_10_0

		local function var_10_7()
			local var_11_0 = arg_7_0

			var_0.ShowItemDetail(var_11_0, var_10_1)

			return
		end

		SFX_PANEL = var_10_4

		var_4(var_10_5, var_10_6, var_10_7, var_10_4)

		return
	end

	local var_7_8 = arg_7_0.storehouseRect

	var_3.SetTotalCount(var_7_8, #var_7_5)

	return
end

function var_0_1.UpdateRyzaItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = "icon_frame_" .. arg_12_2:GetRarity()

	small = var_4

	if var_4 then
		var_12_0 = var_12_0 .. "_small"
	end

	GetImageSpriteFromAtlasAsync = var_4

	var_4("ui/AtelierCommonUI_atlas", var_12_0, arg_12_1)

	GetImageSpriteFromAtlasAsync = var_4

	var_4(arg_12_2:GetIconPath(), "", arg_12_1:Find("Icon"))

	IsNil = var_4

	if not var_4(arg_12_1:Find("Lv")) then
		setText = var_4

		var_4(arg_12_1:Find("Lv/Text"), arg_12_2:GetLevel())
	end

	local var_12_1 = arg_12_2
	local var_12_2 = arg_12_2.GetProps(var_12_1)

	CustomIndexLayer = var_1_10005

	local var_12_3 = var_1_10005.Clone2Full(arg_12_1:Find("List"), #var_12_2)

	ipairs = var_12_1

	for iter_12_0, iter_12_1 in var_12_1(var_12_3) do
		GetImageSpriteFromAtlasAsync = var_11

		local var_12_4 = "ui/AtelierCommonUI_atlas"
		local var_12_5 = "element_"

		AtelierFormulaCircle = var_1_10015

		var_11(var_12_4, var_12_5 .. var_1_10015.ELEMENT_NAME[var_12_2[iter_12_0]], iter_12_1)
	end

	IsNil = var_6

	if not var_6(arg_12_1:Find("Text")) then
		setText = var_6

		var_6(arg_12_1:Find("Text"), arg_12_2.count)
	end

	return
end

function var_0_1.ShowItemDetail(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.emit

	AtelierMaterialDetailMediator = var_1_10005

	var_13_1(var_13_0, var_1_10005.SHOW_DETAIL, arg_13_1)

	return
end

function var_0_1.willExit(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_0, arg_14_0._tf)

	return
end

return var_0_1
