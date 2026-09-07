local IslandSettingsPage = class("IslandSettingsPage", import("...base.IslandBasePage"))

IslandSettingsPage.SELECTCUSTOMGRAPHICSETTING = "IslandSettingsPage:SelectCustomGraphicSetting"
IslandSettingsPage.SELECTGRAPHICSETTINGLEVEL = "IslandSettingsPage:SelectGraphicSettinglevel"

function IslandSettingsPage:getUIName()
	return "IslandNewSettingsUI"
end

function IslandSettingsPage:AddListeners()
	self:AddListener(IslandSettingsPage.SELECTCUSTOMGRAPHICSETTING, self.OnSelectCustomGraphicSetting)
	self:AddListener(IslandSettingsPage.SELECTGRAPHICSETTINGLEVEL, self.OnSelectGraphicSettingLevel)
	self:AddListener(GAME.ISLAND_SETTING_FLAG_DONE, self.OnSettingFlagDone)

	return
end

function IslandSettingsPage:RemoveListeners()
	self:RemoveListener(IslandSettingsPage.SELECTCUSTOMGRAPHICSETTING, self.OnSelectCustomGraphicSetting)
	self:RemoveListener(IslandSettingsPage.SELECTGRAPHICSETTINGLEVEL, self.OnSelectGraphicSettingLevel)
	self:RemoveListener(GAME.ISLAND_SETTING_FLAG_DONE, self.OnSettingFlagDone)

	return
end

function IslandSettingsPage:OnSelectGraphicSettingLevel()
	self:emit(IslandSettingsOtherGraphicsPanle.EVT_UPDTAE)

	return
end

function IslandSettingsPage:OnSelectCustomGraphicSetting()
	self:emit(IslandSettingsGraphicsPanle.EVT_UPDTAE)

	return
end

function IslandSettingsPage:OnSettingFlagDone()
	local var_6_0 = self:GetPage(IslandSettingsCommonPage)

	if var_6_0 and var_6_0:GetLoaded() then
		var_6_0:Update()
	end

	return
end

function IslandSettingsPage:GetPage(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self.pages) do
		if isa(iter_7_1, arg_7_1) then
			return iter_7_1
		end
	end

	return
end

function IslandSettingsPage:OnLoaded()
	self.backBtn = self._tf:Find("top/closeBtn")

	local var_8_0 = self._tf:Find("pages")

	self.pages = {
		IslandSettings3DPage.New(var_8_0, self.event, {}),
		IslandSettingsOperationPage.New(var_8_0, self.event),
		IslandSettingsCommonPage.New(var_8_0, self.event, self.contextData)
	}
	self.toggles = {
		self._tf:Find("adapt/left_length/imageQuality"),
		self._tf:Find("adapt/left_length/operation"),
		self._tf:Find("adapt/left_length/common")
	}

	local function var_8_1(arg_9_0, arg_9_1)
		setText(arg_9_0:Find("selected/name"), arg_9_1)
		setText(arg_9_0:Find("name"), arg_9_1)

		return
	end

	var_8_1(self._tf:Find("adapt/left_length/imageQuality"), i18n("grapihcs3d_setting_3Dquality"))
	var_8_1(self._tf:Find("adapt/left_length/operation"), i18n("grapihcs3d_setting_control"))
	var_8_1(self._tf:Find("adapt/left_length/common"), i18n("grapihcs3d_setting_general"))
	setText(self._tf:Find("top/title/Text"), i18n("island_settings"))
	setText(self._tf:Find("top/title/Text/en"), i18n("island_settings_en"))

	return
end

function IslandSettingsPage:OnShow()
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	for iter_10_0, iter_10_1 in ipairs(self.toggles) do
		onToggle(self, iter_10_1, function(arg_12_0)
			if arg_12_0 then
				self:SwitchPage(iter_10_0)
			end

			return
		end, SFX_PANEL)
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:EnterDefaultPage()

	return
end

function IslandSettingsPage:EnterDefaultPage()
	triggerToggle(self.toggles[1], true)

	return
end

function IslandSettingsPage:SwitchPage(arg_14_1)
	if self.page and self.page ~= self.pages[arg_14_1] and self.page:GetLoaded() then
		self.page:Hide()
	end

	self.pages[arg_14_1]:ExecuteAction("Show")

	self.page = self.pages[arg_14_1]

	if isa(self.pages[arg_14_1], IslandSettings3DPage) then
		self.hasShow3d = true
	end

	if isa(self.pages[arg_14_1], IslandSettingsOperationPage) then
		self.hasShowOP = true
	end

	return
end

function IslandSettingsPage:GetPage(arg_15_1)
	if not self.pages then
		return nil
	end

	return _.detect(self.pages, function(arg_16_0)
		return isa(arg_16_0, arg_15_1)
	end)
end

function IslandSettingsPage:OnHide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.hasShow3d then
		GraphicSettingConst.SettingQuality(true)
	end

	if self.hasShowOP then
		self:emitCore(ISLAND_EVT.UPDATE_CUSTOM_OP_POSITON)
	end

	local var_17_0 = self:GetPage(IslandSettingsCommonPage)

	if var_17_0 and var_17_0:GetLoaded() then
		var_17_0:Save()
	end

	return
end

function IslandSettingsPage:OnDisable()
	self:OnHide()

	return
end

function IslandSettingsPage:OnDestroy()
	self:OnHide()

	for iter_19_0, iter_19_1 in pairs(self.pages) do
		iter_19_1:Destroy()
	end

	self.page = nil
	self.pages = nil

	return
end

return IslandSettingsPage
