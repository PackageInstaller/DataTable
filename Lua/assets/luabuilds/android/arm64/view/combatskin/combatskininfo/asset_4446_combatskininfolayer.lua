local CombatSkinInfoLayer = class("CombatSkinInfoLayer", import("view.base.BaseUI"))

function CombatSkinInfoLayer:getUIName()
	return "CombatSkinInfoUI"
end

function CombatSkinInfoLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.closeBtn = self._tf:Find("display/top/btnBack")
	self.confirm = self._tf:Find("display/actions/confirm")
	self.skinViewTF = self._tf:Find("display")
	self.toggleList = UIItemList.New(self._tf:Find("display/info/display_panel/combat_skin/elementList"), self._tf:Find("display/info/display_panel/combat_skin/elementList/main"))

	setText(self.confirm:Find("upgrade"), i18n("text_consume"))
	setText(self._tf:Find("display/top/bg/infomation/title"), i18n("words_information"))

	return
end

function CombatSkinInfoLayer:didEnter()
	onButton(self, self._tf, function()
		self:emit(CombatSkinInfoLayer.ON_CLOSE)

		return
	end, SOUND_BACK)
	onButton(self, self.closeBtn, function()
		self:emit(CombatSkinInfoLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self.confirm, function()
		self:emit(CombatSkinInfoLayer.ON_CLOSE)

		return
	end, SFX_PANEL)
	self:InitPanel()

	return
end

function CombatSkinInfoLayer:InitPanel()
	local var_7_0 = self.contextData.skinID

	setText(self.skinViewTF:Find("info/display_panel/name_container/name"), pg.item_data_battleui[self.contextData.skinID].name)
	setText(self.skinViewTF:Find("info/display_panel/desc/Text"), pg.item_data_battleui[self.contextData.skinID].desc)

	local var_7_1 = pg.item_data_battleui[self.contextData.skinID].rare_display

	self.toggleList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("ui/combatskinrare", CombatSkinConst.TYPE_ICON_NAME[var_7_1[arg_8_1 + 1]], arg_8_2:Find("icon"), true)
			setScrollText(arg_8_2:Find("TextMask/Text"), i18n("battleui_display" .. var_7_1[arg_8_1 + 1]))
		end

		return
	end)
	self.toggleList:align(#pg.item_data_battleui[self.contextData.skinID].rare_display)
	onButton(self, self.skinViewTF:Find("info/play_btn"), function()
		self.combatPreview = CombatPreviewLayer.New(pg.UIMgr.GetInstance().OverlayMain)

		self.combatPreview:ExecuteAction("Show", var_7_0, function()
			self.combatPreview:Destroy()

			self.combatPreview = nil

			return
		end)

		return
	end, SPX_PANEL)
	updateDrop(self.skinViewTF:Find("info/equip"), Drop.New({
		count = 1,
		type = DROP_TYPE_COMBAT_UI_STYLE,
		id = self.contextData.skinID
	}))

	return
end

function CombatSkinInfoLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function CombatSkinInfoLayer:onBackPressed()
	if self.combatPreview then
		self.combatPreview:Destroy()

		self.combatPreview = nil
	else
		CombatSkinInfoLayer.super.onBackPressed(self)
	end

	return
end

return CombatSkinInfoLayer
