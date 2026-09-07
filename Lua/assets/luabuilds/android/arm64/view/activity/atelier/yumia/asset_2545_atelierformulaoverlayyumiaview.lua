local AtelierFormulaOverlayYumiaView = class("AtelierFormulaOverlayYumiaView", import("view.activity.Atelier.base.AtelierFormulaOverlayView"))

function AtelierFormulaOverlayYumiaView:InitCustom()
	setText(self._tf:Find("closeBtn/Text"), i18n("yumia_atelier_tip6"))
	setText(self._tf:Find("RestCount/Text_1"), i18n("yumia_atelier_tip8"))
	setText(self._tf:Find("List/Text"), i18n("yumia_atelier_tip9"))

	return
end

function AtelierFormulaOverlayYumiaView:didEnter()
	AtelierFormulaOverlayYumiaView.super.didEnter(self)
	onButton(self, self._tf:Find("closeBtn"), function()
		self._parentClass:OnClickFormulaBack()

		return
	end)

	return
end

function AtelierFormulaOverlayYumiaView:RefreshFormulaInfo(arg_4_1)
	self.contextData.formulaId = arg_4_1:GetConfigID()

	self._parentClass:UpdateRyzaDrop(self._tf:Find("Icon"), {
		type = arg_4_1:GetProduction()[1],
		id = arg_4_1:GetProduction()[2]
	})
	setText(self._tf:Find("Name"), arg_4_1:GetName())
	setText(self._tf:Find("Description/Text"), arg_4_1:GetDesc())

	local var_4_0 = tostring(arg_4_1:GetMaxLimit() - arg_4_1:GetUsedCount())

	setText(self._tf:Find("RestCount/cntText"), (arg_4_1:GetMaxLimit() < 0 or nil) and "∞")

	return
end

function AtelierFormulaOverlayYumiaView:Show(arg_5_1)
	SetActive(self._go, arg_5_1)

	return
end

return AtelierFormulaOverlayYumiaView
