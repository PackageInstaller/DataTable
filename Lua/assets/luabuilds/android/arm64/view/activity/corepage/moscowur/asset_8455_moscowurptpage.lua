local MoscowURPtPage = class("MoscowURPtPage", import("view.activity.CorePage.CorePageNewPtTemplatePage"))

function MoscowURPtPage:OnInit()
	MoscowURPtPage.super.OnInit(self)
	setText(self.bg:Find("exchange_btn/Text"), i18n("yumia_pt_3"))
	setText(self.bg:Find("gray/Text"), i18n("yumia_pt_2"))
	setText(self.bg:Find("get_btn/Text"), i18n("yumia_pt_2"))

	return
end

return MoscowURPtPage
