local var_0_0 = class("AtelierFormulaOverlayYumiaView", import("view.activity.Atelier.base.AtelierFormulaOverlayView"))

function var_0_0.InitCustom(arg_1_0)
	setText(arg_1_0._tf:Find("closeBtn/Text"), i18n("yumia_atelier_tip6"))
	setText(arg_1_0._tf:Find("RestCount/Text_1"), i18n("yumia_atelier_tip8"))
	setText(arg_1_0._tf:Find("List/Text"), i18n("yumia_atelier_tip9"))

	return
end

function var_0_0.didEnter(arg_2_0)
	var_0_0.super.didEnter(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("closeBtn"), function()
		arg_2_0._parentClass:OnClickFormulaBack()

		return
	end)

	return
end

function var_0_0.RefreshFormulaInfo(arg_4_0, arg_4_1)
	arg_4_0.contextData.formulaId = arg_4_1:GetConfigID()

	arg_4_0._parentClass:UpdateRyzaDrop(arg_4_0._tf:Find("Icon"), {
		type = arg_4_1:GetProduction()[1],
		id = arg_4_1:GetProduction()[2]
	})
	setText(arg_4_0._tf:Find("Name"), arg_4_1:GetName())
	setText(arg_4_0._tf:Find("Description/Text"), arg_4_1:GetDesc())

	local var_4_0 = tostring(arg_4_1:GetMaxLimit() - arg_4_1:GetUsedCount())

	if arg_4_1:GetMaxLimit() < 0 then
		var_4_0 = "∞"
	end

	setText(arg_4_0._tf:Find("RestCount/cntText"), var_4_0)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0._go, arg_5_1)

	return
end

return var_0_0
