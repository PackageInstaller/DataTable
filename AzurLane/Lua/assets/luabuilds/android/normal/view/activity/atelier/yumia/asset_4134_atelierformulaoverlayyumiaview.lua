class = var_0_10000

local var_0_0 = "AtelierFormulaOverlayYumiaView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.Atelier.base.AtelierFormulaOverlayView"))

function var_0_1.InitCustom(arg_1_0)
	setText = var_1_10001

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "closeBtn/Text")

	i18n = var_1_0

	var_1_10001(var_1_1, var_1_0("yumia_atelier_tip6"))

	setText = var_1_10001

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_2.Find(var_1_2, "RestCount/Text_1")

	i18n = var_1_2

	var_1_10001(var_1_3, var_1_2("yumia_atelier_tip8"))

	setText = var_1_10001

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_2.Find(var_1_4, "List/Text")

	i18n = var_1_4

	var_1_10001(var_1_5, var_1_4("yumia_atelier_tip9"))

	return
end

function var_0_1.didEnter(arg_2_0)
	var_0_1.super.didEnter(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf

	var_1(var_2_0, var_3.Find(var_2_1, "closeBtn"), function()
		local var_3_0 = arg_2_0._parentClass

		var_0.OnClickFormulaBack(var_3_0)

		return
	end)

	return
end

function var_0_1.RefreshFormulaInfo(arg_4_0, arg_4_1)
	arg_4_0.contextData.formulaId = arg_4_1:GetConfigID()

	local var_4_0 = {
		type = arg_4_1:GetProduction()[1],
		id = arg_4_1:GetProduction()[2]
	}
	local var_4_1 = arg_4_0._parentClass
	local var_4_2 = var_3.UpdateRyzaDrop
	local var_4_3 = arg_4_0._tf

	var_4_2(var_4_1, var_5.Find(var_4_3, "Icon"), var_4_0)

	setText = var_4_2

	local var_4_4 = arg_4_0._tf

	var_4_2(var_4.Find(var_4_4, "Name"), arg_4_1:GetName())

	setText = var_4_2

	local var_4_5 = arg_4_0._tf

	var_4_2(var_4.Find(var_4_5, "Description/Text"), arg_4_1:GetDesc())

	tostring = var_4_2

	local var_4_6 = var_4_2(arg_4_1:GetMaxLimit() - arg_4_1:GetUsedCount())

	if arg_4_1:GetMaxLimit() < 0 then
		var_4_6 = "∞"
	end

	setText = var_4

	local var_4_7 = arg_4_0._tf

	var_4(var_5.Find(var_4_7, "RestCount/cntText"), var_4_6)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	SetActive = var_1_10002

	var_1_10002(arg_5_0._go, arg_5_1)

	return
end

return var_0_1
