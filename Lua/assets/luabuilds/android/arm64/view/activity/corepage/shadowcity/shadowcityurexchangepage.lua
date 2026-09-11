local ShadowCityURExchangePage = class("ShadowCityURExchangePage", import("view.activity.CorePage.GeZiUR.GeZiURExchangePage"))

function ShadowCityURExchangePage:OnInit()
	ShadowCityURExchangePage.super.OnInit(self)
	setText(self._msgBoxLabel, i18n("title_info"))

	return
end

return ShadowCityURExchangePage
