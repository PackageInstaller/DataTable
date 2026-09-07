local IslandTechAwardPage = class("IslandTechAwardPage", import("...base.IslandBasePage"))

function IslandTechAwardPage:getUIName()
	return "IslandTechAwardUI"
end

function IslandTechAwardPage:OnLoaded()
	self.nameTF = self._tf:Find("window/name_bg/Text")
	self.iconTF = self._tf:Find("window/icon_bg/Image")
	self.tipTF = self._tf:Find("window/tip")

	return
end

function IslandTechAwardPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandTechAwardPage:OnShow(arg_5_1)
	LoadImageSpriteAsync("island/IslandTechnology/" .. pg.island_technology_template[arg_5_1].tech_icon, self.iconTF, true)
	setText(self.nameTF, pg.island_technology_template[arg_5_1].tech_name)
	setText(self.tipTF, pg.island_technology_template[arg_5_1].complete_tips)
	self:BlurPanel()

	return
end

function IslandTechAwardPage:OnHide()
	self:UnBlurPanel()

	return
end

function IslandTechAwardPage:OnDisable()
	self:OnHide()

	return
end

function IslandTechAwardPage:OnDestroy()
	self:OnHide()

	return
end

return IslandTechAwardPage
