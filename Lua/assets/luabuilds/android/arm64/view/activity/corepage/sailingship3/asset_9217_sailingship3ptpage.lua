local SailingShip3PtPage = class("SailingShip3PtPage", import("view.activity.CorePage.CorePageNewPtTemplatePage"))

function SailingShip3PtPage:OnInit()
	SailingShip3PtPage.super.OnInit(self)
	setText(self.get, i18n("word_got"))

	return
end

function SailingShip3PtPage:OnShowFlush()
	setCanvasGroupAlpha(self._tf, 1)

	return
end

return SailingShip3PtPage
