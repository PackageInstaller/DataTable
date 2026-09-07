local SpWeaponSkillInfoLayer = class("SpWeaponSkillInfoLayer", import("view.ship.SkillInfoLayer"))

function SpWeaponSkillInfoLayer:getUIName()
	return "SkillInfoUI"
end

function SpWeaponSkillInfoLayer:didEnter()
	onButton(self, self._tf, function()
		self:emit(SpWeaponSkillInfoLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self.backBtn, function()
		self:emit(SpWeaponSkillInfoLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("panel/buttonList/ok_button"), function()
		self:emit(SpWeaponSkillInfoLayer.ON_CLOSE)

		return
	end, SFX_CONFIRM)
	onButton(self, self.upgradeBtn, function()
		self:emit(SkillInfoMediator.WARP_TO_TACTIC)

		return
	end, SFX_UI_CLICK)
	onButton(self, self.metaBtn, function()
		local var_7_0
		local var_7_1

		if self.contextData.shipId then
			var_7_1 = getProxy(BayProxy):getShipById(self.contextData.shipId)
			var_7_0 = var_7_1:isMetaShip()
		end

		if var_7_0 then
			self:emit(SkillInfoMediator.WARP_TO_META_TACTICS, var_7_1.configId)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.btnTypeNormal, function()
		self:showInfo(false)
		self:flushTypeBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.btnTypeWorld, function()
		self:showInfo(true)
		self:flushTypeBtn()

		return
	end, SFX_PANEL)

	if tobool(pg.skill_world_display[self.contextData.skillId]) then
		self:flushTypeBtn()
	else
		setActive(self.btnTypeNormal, false)
		setActive(self.btnTypeWorld, false)
	end

	self:showBase()
	self:showInfo(false)
	setText(self._tf:Find("panel/top/title_list/infomation/title"), i18n("words_information"))
	setText(self.buttonList:Find("ok_button/Image"), i18n("text_confirm"))
	setText(self.buttonList:Find("level_button/Image"), i18n("msgbox_text_upgrade"))

	return
end

function SpWeaponSkillInfoLayer:flushTypeBtn()
	setActive(self.btnTypeNormal, self.isWorld)
	setActive(self.btnTypeWorld, not self.isWorld)

	return
end

function SpWeaponSkillInfoLayer:showBase()
	local var_11_0 = getSkillName(self.contextData.skillId)

	if not self.contextData.unlock then
		var_11_0 = setColorStr(var_11_0, "#a2a2a2")
	end

	setText(self.skillInfoName, var_11_0)

	local var_11_1 = getSkillConfig(self.contextData.skillId)

	assert(var_11_1)
	LoadImageSpriteAsync("skillicon/" .. var_11_1.icon, self.skillInfoIcon)
	setActive(self.upgradeBtn, false)
	setActive(self.metaBtn, false)

	return
end

function SpWeaponSkillInfoLayer:showInfo(arg_12_1)
	self.isWorld = arg_12_1

	local var_12_0 = self.contextData.skillId
	local var_12_1 = self.contextData.unlock
	local var_12_2

	if self.contextData.skillOnShip then
		var_12_2 = self.contextData.skillOnShip.level or 1
	end

	setText(self.skillInfoLv, "Lv." .. var_12_2)

	local var_12_3 = getSkillDesc(var_12_0, var_12_2, arg_12_1)

	if not var_12_1 then
		var_12_3 = setColorStr(i18n("spweapon_tip_skill_locked") .. var_12_3, "#a2a2a2")
	end

	setText(self.skillInfoIntro, var_12_3)

	return
end

function SpWeaponSkillInfoLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.contextData.onExit then
		self.contextData.onExit()
	end

	return
end

return SpWeaponSkillInfoLayer
