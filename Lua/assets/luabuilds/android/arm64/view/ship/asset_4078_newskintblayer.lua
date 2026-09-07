local NewSkinTBLayer = class("NewSkinTBLayer", import("view.ship.NewSkinLayer"))

function NewSkinTBLayer:getUIName()
	return "NewSkinUI"
end

function NewSkinTBLayer:preload(arg_2_1)
	local var_2_0 = pg.ship_skin_template[self.contextData.skinId]
	local var_2_1 = pg.ship_skin_template[self.contextData.skinId].bg_sp and var_2_0.bg_sp ~= "" and var_2_0.bg_sp or var_2_0.bg and #var_2_0.bg > 0 and var_2_0.bg or var_2_0.rarity_bg and #var_2_0.rarity_bg > 0 and var_2_0.rarity_bg
	local var_2_2

	var_2_2 = var_2_1 and "bg/star_level_bg_" .. var_2_1 or nil

	if var_2_2 then
		GetSpriteFromAtlasAsync(var_2_2, "", arg_2_1)
	else
		existCall(arg_2_1)
	end

	return
end

function NewSkinTBLayer:setSkinPri(arg_3_1)
	local var_3_0 = self:loadUISync("getrole")

	var_3_0.layer = LayerMask.NameToLayer("UI")
	var_3_0.transform.localPosition = Vector3(0, 0, -10)

	setParent(var_3_0, self._tf, false)
	setActive(var_3_0, false)
	onNextTick(function()
		setActive(var_3_0, true)

		return
	end)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_DOCKYARD_CHARGET)

	self.cg.alpha = 1
	self._shade:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0)

	self:recyclePainting()

	self._skinConfig = pg.ship_skin_template[arg_3_1]

	local var_3_1 = self._skinConfig.bg_sp and self._skinConfig.bg_sp ~= "" and self._skinConfig.bg_sp or self._skinConfig.bg and #self._skinConfig.bg > 0 and self._skinConfig.bg or self._skinConfig.rarity_bg and #self._skinConfig.rarity_bg > 0 and self._skinConfig.rarity_bg

	if var_3_1 then
		pg.DynamicBgMgr.GetInstance():LoadBg(self, var_3_1, self._bg, self._staticBg, function(arg_5_0)
			self.isLoadBg = true

			return
		end, function(arg_6_0)
			self.isLoadBg = true

			return
		end)
	end

	setPaintingPrefabAsync(self._paintingTF, self._skinConfig.painting, "huode")

	self._skinName.text = i18n("ship_newSkin_name", self._skinConfig.name)

	local var_3_5, var_3_6, var_3_7 = EducateCharWordHelper.GetWordAndCV(NewEducateHelper.GetSecIdBySkinId(arg_3_1), "login")
	local var_3_8 = var_3_6

	setWidgetText(self._dialogue, SwitchSpecialChar(var_3_7, true), "desc/Text")

	self._dialogue.transform.localScale = Vector3(0, 1, 1)

	SetActive(self._dialogue, false)
	SetActive(self._dialogue, true)
	LeanTween.scale(self._dialogue, Vector3(1, 1, 1), 0.1):setOnComplete(System.Action(function()
		setActive(self._shade, false)
		setActive(self.clickTF, true)
		self:voice(var_3_8)

		return
	end))

	return
end

function NewSkinTBLayer:didEnter()
	self.shipName = NewEducateHelper.GetShipNameBySecId(self.contextData.secId)

	onButton(self, self._viewBtn, function()
		self.isInView = true

		self:paintView()
		setActive(self.clickTF, false)

		return
	end, SFX_PANEL)
	onButton(self, self._shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeNewSkin)

		return
	end, SFX_PANEL)
	onButton(self, self.clickTF, function()
		if self.isInView or not self.isLoadBg then
			return
		end

		self:showExitTip()

		return
	end, SFX_CANCEL)
	onButton(self, self.changeSkinBtn, function()
		if NewEducateHelper.IsUnlockDefaultShip(NewEducateHelper.GetSecIdBySkinId(self.contextData.skinId)) then
			self.hideExitTip = true

			self:emit(NewSkinTBMediator.GO_SET_TB_SKIN)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_special_character_buy_unlock"))
		end

		return
	end)

	if self.contextData.isClose then
		onNextTick(function()
			self:closeView()

			return
		end)
	end

	return
end

function NewSkinTBLayer:willExit()
	pg.CpkPlayMgr.GetInstance():DisposeCpkMovie()

	if not self.hideExitTip then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_newSkinLayer_get", NewEducateHelper.GetShipNameBySecId(self.contextData.secId), pg.ship_skin_template[self.contextData.skinId].name), COLOR_GREEN)
	end

	self:recyclePainting()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self:stopVoice()

	if self.loadedCVBankName then
		pg.CriMgr.UnloadCVBank(self.loadedCVBankName)

		self.loadedCVBankName = nil
	end

	self.selectShipPage:Destroy()
	cameraPaintViewAdjust(false)

	return
end

return NewSkinTBLayer
