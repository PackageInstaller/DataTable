local OriginShopSingleWindow = class("OriginShopSingleWindow", import("...base.BaseSubView"))

function OriginShopSingleWindow:getUIName()
	return "ShopsUISinglebox"
end

function OriginShopSingleWindow:OnLoaded()
	self.itemTF = self._tf:Find("window/item")
	self.nameTF = self.itemTF:Find("display_panel/name_container/name/Text"):GetComponent(typeof(Text))
	self.descTF = self.itemTF:Find("display_panel/desc/Text"):GetComponent(typeof(Text))
	self.itemOwnTF = self.itemTF:Find("left/own")
	self.itemDetailTF = self.itemTF:Find("left/detail")
	self.confirmBtn = self._tf:Find("window/actions/confirm_btn")

	setText(self._tf:Find("window/actions/cancel_btn/pic"), i18n("shop_word_cancel"))
	setText(self._tf:Find("window/actions/confirm_btn/pic"), i18n("shop_word_exchange"))
	setText(self.itemTF:Find("ship_group/locked/Text"), i18n("tag_ship_locked"))
	setText(self.itemTF:Find("ship_group/unlocked/Text"), i18n("tag_ship_unlocked"))

	return
end

function OriginShopSingleWindow:OnInit()
	onButton(self, self._tf:Find("window/actions/cancel_btn"), function()
		self:Close()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg"), function()
		self:Close()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("window/top/btnBack"), function()
		self:Close()

		return
	end, SFX_CANCEL)

	return
end

function OriginShopSingleWindow:Open(arg_7_1, arg_7_2)
	self.opening = true

	self:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:InitWindow(arg_7_1, arg_7_2)

	return
end

function OriginShopSingleWindow:InitWindow(arg_8_1, arg_8_2)
	local var_8_0 = isa(arg_8_1, WorldNShopCommodity) and arg_8_1:GetDropInfo() or arg_8_1:getDropInfo()

	updateDrop(self.itemTF:Find("left/IconTpl"), var_8_0)
	UpdateOwnDisplay(self.itemOwnTF, var_8_0)
	RegisterDetailButton(self, self.itemDetailTF, var_8_0)
	onButton(self, self.confirmBtn, function()
		existCall(arg_8_2, arg_8_1, 1)
		self:Close()

		return
	end, SFX_CANCEL)

	local var_8_1 = var_8_0.type == DROP_TYPE_SHIP
	local var_8_2 = self.itemTF:Find("ship_group")

	SetActive(var_8_2, var_8_0.type == DROP_TYPE_SHIP)

	if var_8_1 then
		local var_8_3 = tobool(getProxy(CollectionProxy):getShipGroup(pg.ship_data_template[var_8_0.id].group_type))

		SetActive(var_8_2:Find("unlocked"), var_8_3)
		SetActive(var_8_2:Find("locked"), not var_8_3)
	end

	self.descTF.text = var_8_0.desc or var_8_0:getConfig("desc")
	self.nameTF.text = var_8_0:getConfig("name")

	return
end

function OriginShopSingleWindow:Close()
	if self.opening then
		self.opening = false

		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
		self:Hide()
	end

	return
end

function OriginShopSingleWindow:OnDestroy()
	if self.opening then
		self:Close()
	end

	return
end

return OriginShopSingleWindow
