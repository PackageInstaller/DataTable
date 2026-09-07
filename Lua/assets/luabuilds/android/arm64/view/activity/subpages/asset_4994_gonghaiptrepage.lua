local GongHaiPtRePage = class("GongHaiPtRePage", import(".TemplatePage.PtTemplatePage"))

function GongHaiPtRePage:OnFirstFlush()
	GongHaiPtRePage.super.OnFirstFlush(self)
	setText(self.bg:Find("title"), i18n("pt_count_tip"))

	return
end

return GongHaiPtRePage
