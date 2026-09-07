local SiChuanOperaPage = class("SiChuanOperaPage", import(".TemplatePage.LoginTemplatePage"))

function SiChuanOperaPage:OnInit()
	SiChuanOperaPage.super.OnInit(self)

	self.dayText = self._tf:Find("AD/DayText")
	self.url = self._tf:Find("AD/url")

	return
end

function SiChuanOperaPage:OnFirstFlush()
	SiChuanOperaPage.super.OnFirstFlush(self)
	onButton(self, self.url, function()
		Application.OpenURL(self.activity:getConfig("config_client"))

		return
	end, SFX_PANEL)

	return
end

function SiChuanOperaPage:OnUpdateFlush()
	SiChuanOperaPage.super.OnUpdateFlush(self)
	setText(self.dayText, string.format("%02d", self.nday))

	return
end

return SiChuanOperaPage
