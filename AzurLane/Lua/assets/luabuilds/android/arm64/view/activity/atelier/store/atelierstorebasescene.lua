local var_0_0 = class("AtelierStoreBaseScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AtelierStoreUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.storehouseRect = GetComponent(arg_2_0._tf:Find("Window/ScrollView"), "LScrollRect")

	setActive(arg_2_0._tf:Find("Window/ScrollView/Item"), false)
	arg_2_0:InitCustom()

	return
end

function var_0_0.InitCustom(arg_3_0)
	setText(arg_3_0._tf:Find("Window/Empty"), i18n("ryza_tip_no_item"))

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0.activity = arg_4_0.contextData.activity

	onButton(arg_4_0, arg_4_0._tf:Find("Window/Close"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0._tf:Find("BG"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)
	arg_4_0:ShowStoreHouseWindow()

	return
end

function var_0_0.ShowStoreHouseWindow(arg_7_0)
	local var_7_0

	if not arg_7_0.contextData.versionIndex then
		var_7_0 = 1
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)

	local var_7_1 = _.filter(_.values(arg_7_0.activity:GetItems()), function(arg_8_0)
		return arg_8_0.count > 0 and arg_8_0:GetVersion() == var_7_0 and arg_8_0:IsShow() ~= 0
	end)

	table.sort(var_7_1, function(arg_9_0, arg_9_1)
		return arg_9_0:GetConfigID() < arg_9_1:GetConfigID()
	end)
	setActive(arg_7_0._tf:Find("Window/Empty"), #var_7_1 == 0)
	setActive(arg_7_0._tf:Find("Window/ScrollView"), #var_7_1 > 0)

	if #var_7_1 == 0 then
		return
	end

	function arg_7_0.storehouseRect.onUpdateItem(arg_10_0, arg_10_1)
		arg_10_0 = arg_10_0 + 1

		local var_10_0 = tf(arg_10_1)
		local var_10_1 = var_7_1[arg_10_0]

		arg_7_0:UpdateRyzaItem(var_10_0:Find("IconBG"), var_7_1[arg_10_0])
		setScrollText(var_10_0:Find("NameBG/Rect/Name"), var_7_1[arg_10_0]:GetName())
		onButton(arg_7_0, var_10_0, function()
			arg_7_0:ShowItemDetail(var_10_1)

			return
		end, SFX_PANEL)

		return
	end

	arg_7_0.storehouseRect:SetTotalCount(#var_7_1)

	return
end

function var_0_0.UpdateRyzaItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = "icon_frame_" .. arg_12_2:GetRarity()

	if small then
		var_12_0 = var_12_0 .. "_small"
	end

	GetImageSpriteFromAtlasAsync("ui/AtelierCommonUI_atlas", var_12_0, arg_12_1)
	GetImageSpriteFromAtlasAsync(arg_12_2:GetIconPath(), "", arg_12_1:Find("Icon"))

	if not IsNil(arg_12_1:Find("Lv")) then
		setText(arg_12_1:Find("Lv/Text"), arg_12_2:GetLevel())
	end

	local var_12_1 = arg_12_2:GetProps()

	for iter_12_0, iter_12_1 in ipairs((CustomIndexLayer.Clone2Full(arg_12_1:Find("List"), #var_12_1))) do
		GetImageSpriteFromAtlasAsync("ui/AtelierCommonUI_atlas", "element_" .. AtelierFormulaCircle.ELEMENT_NAME[var_12_1[iter_12_0]], iter_12_1)
	end

	if not IsNil(arg_12_1:Find("Text")) then
		setText(arg_12_1:Find("Text"), arg_12_2.count)
	end

	return
end

function var_0_0.ShowItemDetail(arg_13_0, arg_13_1)
	arg_13_0:emit(AtelierMaterialDetailMediator.SHOW_DETAIL, arg_13_1)

	return
end

function var_0_0.willExit(arg_14_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_0
