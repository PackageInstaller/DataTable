local AtelierStoreBaseScene = class("AtelierStoreBaseScene", import("view.base.BaseUI"))

function AtelierStoreBaseScene:getUIName()
	return "AtelierStoreUI"
end

function AtelierStoreBaseScene:init()
	self.storehouseRect = GetComponent(self._tf:Find("Window/ScrollView"), "LScrollRect")

	setActive(self._tf:Find("Window/ScrollView/Item"), false)
	self:InitCustom()

	return
end

function AtelierStoreBaseScene:InitCustom()
	setText(self._tf:Find("Window/Empty"), i18n("ryza_tip_no_item"))

	return
end

function AtelierStoreBaseScene:didEnter()
	self.activity = self.contextData.activity

	onButton(self, self._tf:Find("Window/Close"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("BG"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	self:ShowStoreHouseWindow()

	return
end

function AtelierStoreBaseScene:ShowStoreHouseWindow()
	local var_7_0 = self.contextData.versionIndex or 1

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_7_1 = _.filter(_.values(self.activity:GetItems()), function(arg_8_0)
		return arg_8_0.count > 0 and arg_8_0:GetVersion() == var_7_0 and arg_8_0:IsShow() ~= 0
	end)

	table.sort(var_7_1, function(arg_9_0, arg_9_1)
		return arg_9_0:GetConfigID() < arg_9_1:GetConfigID()
	end)
	setActive(self._tf:Find("Window/Empty"), #var_7_1 == 0)
	setActive(self._tf:Find("Window/ScrollView"), #var_7_1 > 0)

	if #var_7_1 == 0 then
		return
	end

	function self.storehouseRect.onUpdateItem(arg_10_0, arg_10_1)
		arg_10_0 = arg_10_0 + 1

		local var_10_0 = tf(arg_10_1)
		local var_10_1 = var_7_1[arg_10_0]

		self:UpdateRyzaItem(var_10_0:Find("IconBG"), var_7_1[arg_10_0])
		setScrollText(var_10_0:Find("NameBG/Rect/Name"), var_7_1[arg_10_0]:GetName())
		onButton(self, var_10_0, function()
			self:ShowItemDetail(var_10_1)

			return
		end, SFX_PANEL)

		return
	end

	self.storehouseRect:SetTotalCount(#var_7_1)

	return
end

function AtelierStoreBaseScene:UpdateRyzaItem(arg_12_1, arg_12_2)
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

function AtelierStoreBaseScene:ShowItemDetail(arg_13_1)
	self:emit(AtelierMaterialDetailMediator.SHOW_DETAIL, arg_13_1)

	return
end

function AtelierStoreBaseScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return AtelierStoreBaseScene
