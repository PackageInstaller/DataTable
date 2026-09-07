local WSAtlasRight = class("WSAtlasRight", import("...BaseEntity"))

WSAtlasRight.Fields = {
	btnSettings = "userdata",
	btnSwitch = "userdata",
	rtDisplayIcon = "userdata",
	transform = "userdata",
	rtNameBg = "userdata",
	rtDisplayPanel = "userdata",
	isDisplay = "boolean",
	world = "table",
	rtMapInfo = "userdata",
	wsWorldInfo = "table",
	rtBg = "userdata",
	rtWorldInfo = "userdata"
}

function WSAtlasRight:Setup()
	pg.DelegateInfo.New(self)
	self:Init()

	return
end

function WSAtlasRight:Dispose()
	self.wsWorldInfo:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

function WSAtlasRight:Init()
	self.rtBg = self.transform:Find("bg")
	self.rtNameBg = self.transform:Find("name_bg")
	self.rtDisplayIcon = self.transform:Find("line/display_icon")
	self.rtDisplayPanel = self.transform:Find("line/display_panel")
	self.rtWorldInfo = self.rtDisplayPanel:Find("world_info")
	self.btnSettings = self.rtDisplayPanel:Find("btns/settings_btn")
	self.btnSwitch = self.rtDisplayPanel:Find("btns/switch_btn")

	setText(self.rtWorldInfo:Find("power/bg/Word"), i18n("world_total_power"))
	setText(self.rtWorldInfo:Find("explore/mileage/Text"), i18n("world_mileage"))
	setText(self.rtWorldInfo:Find("explore/pressing/Text"), i18n("world_pressing"))

	self.wsWorldInfo = WSWorldInfo.New()
	self.wsWorldInfo.transform = self.rtWorldInfo

	self.wsWorldInfo:Setup()
	setActive(self.rtWorldInfo, nowWorld():IsSystemOpen(WorldConst.SystemWorldInfo))
	setText(self.rtDisplayIcon:Find("name"), i18n("world_map_title_tips"))
	onButton(self, self.rtDisplayIcon, function()
		self.isDisplay = not self.isDisplay

		self:Collapse()

		return
	end, SFX_PANEL)

	self.isDisplay = true

	self:Collapse()

	return
end

function WSAtlasRight:Collapse()
	if self.isDisplay then
		self.rtDisplayIcon:Find("icon").localScale = Vector3.one or Vector3(-1, 1, 1)
	end

	setActive(self.rtDisplayPanel, self.isDisplay)
	setActive(self.rtBg, self.isDisplay)
	setActive(self.rtNameBg, not self.isDisplay)

	return
end

function WSAtlasRight:SetOverSize(arg_6_1)
	self.rtBg.offsetMax = Vector2(-arg_6_1, self.rtBg.offsetMax.y)
	self.rtNameBg.offsetMax = Vector2(-arg_6_1, self.rtNameBg.offsetMax.y)

	return
end

return WSAtlasRight
