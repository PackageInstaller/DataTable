local EquipmentSkinInfoUIForShopWindow = class("EquipmentSkinInfoUIForShopWindow", import("view.base.BaseSubView"))

function EquipmentSkinInfoUIForShopWindow:getUIName()
	return "EquipmentSkinInfoUIForShop"
end

function EquipmentSkinInfoUIForShopWindow:OnLoaded()
	self.displayPanel = self._tf:Find("display")
	self.displayActions = self.displayPanel:Find("actions")
	self.displayNameTxt = self.displayPanel:Find("info/display_panel/name_container/name"):GetComponent(typeof(Text))
	self.displayDescTxt = self.displayPanel:Find("info/display_panel/desc"):GetComponent(typeof(Text))
	self.playBtn = self.displayPanel:Find("info/play_btn")
	self.confirmBtn = self._tf:Find("display/actions/confirm")

	setText(self._tf:Find("display/top/bg/infomation/title"), i18n("words_information"))
	setText(self._tf:Find("display/actions/cancel/upgrade"), i18n("msgbox_text_cancel"))
	setText(self._tf:Find("display/actions/confirm/change"), i18n("shop_word_exchange"))

	return
end

function EquipmentSkinInfoUIForShopWindow:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SOUND_BACK)
	onButton(self, self._tf:Find("display/top/btnBack"), function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("display/actions/cancel"), function()
		self:Hide()

		return
	end, SFX_CANCEL)

	return
end

function EquipmentSkinInfoUIForShopWindow:Show(arg_7_1)
	EquipmentSkinInfoUIForShopWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:UpdateSkinView(arg_7_1)

	self.showing = true

	return
end

function EquipmentSkinInfoUIForShopWindow:Open(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:getConfig("commodity_id") or arg_8_1:getConfig("effect_args")[1]

	onButton(self, self.confirmBtn, function()
		if arg_8_2 then
			arg_8_2(arg_8_1, 1, pg.equip_skin_template[var_8_0].name)
		end

		self:Hide()

		return
	end, SFX_CANCEL)
	self:Show(var_8_0)

	return
end

function EquipmentSkinInfoUIForShopWindow:UpdateSkinView(arg_10_1)
	assert(pg.equip_skin_template[arg_10_1], "miss config equip_skin_template >> " .. arg_10_1)

	self.displayNameTxt.text = pg.equip_skin_template[arg_10_1].name
	self.displayDescTxt.text = pg.equip_skin_template[arg_10_1].desc

	setScrollText(self.displayPanel:Find("info/display_panel/equip_type/mask/Text"), table.concat(_.map(pg.equip_skin_template[arg_10_1].equip_type, function(arg_11_0)
		return EquipType.Type2Name2(arg_11_0)
	end), ","))
	onButton(self, self.playBtn, function()
		self:emit(NewShopMainMediator.ON_ESKIN_PREVIEW, arg_10_1)

		return
	end, SFX_PANEL)
	updateDrop(self.displayPanel:Find("info/equip"), {
		type = DROP_TYPE_EQUIPMENT_SKIN,
		id = arg_10_1
	})

	return
end

function EquipmentSkinInfoUIForShopWindow:Hide()
	if self.showing then
		EquipmentSkinInfoUIForShopWindow.super.Hide(self)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

		self.showing = false
	end

	return
end

function EquipmentSkinInfoUIForShopWindow:OnDestroy()
	self:Hide()

	return
end

return EquipmentSkinInfoUIForShopWindow
