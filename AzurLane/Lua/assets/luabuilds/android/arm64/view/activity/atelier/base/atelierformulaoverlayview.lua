local var_0_0 = class("AtelierFormulaOverlayView", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2
	arg_1_0.bundleName = arg_1_2.bundleName

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitCustom()

	return
end

function var_0_0.InitCustom(arg_3_0)
	return
end

function var_0_0.SetContextData(arg_4_0, arg_4_1)
	arg_4_0.contextData = arg_4_1

	return
end

function var_0_0.SetActivity(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf:Find("List"), function()
		arg_6_0._parentClass:OnClickFormulaBack()

		return
	end)

	return
end

local var_0_1 = {
	[AtelierFormula.TYPE.EQUIP] = "text_equip",
	[AtelierFormula.TYPE.ITEM] = "text_item",
	[AtelierFormula.TYPE.TOOL] = "text_other",
	[AtelierFormula.TYPE.OTHER] = "text_other"
}

function var_0_0.RefreshFormulaInfo(arg_8_0, arg_8_1)
	arg_8_0.contextData.formulaId = arg_8_1:GetConfigID()

	arg_8_0._parentClass.loader:GetSpriteQuiet(arg_8_0.bundleName, var_0_1[arg_8_1:GetType()], description:Find("Type"))
	arg_8_0._parentClass:UpdateRyzaDrop(arg_8_0._tf:Find("Icon"), {
		type = arg_8_1:GetProduction()[1],
		id = arg_8_1:GetProduction()[2]
	})
	setText(arg_8_0._tf:Find("Name"), arg_8_1:GetName())
	setText(arg_8_0._tf:Find("Description/Text"), arg_8_1:GetDesc())

	local var_8_0 = tostring(arg_8_1:GetMaxLimit() - arg_8_1:GetUsedCount())

	if arg_8_1:GetMaxLimit() < 0 then
		var_8_0 = "∞"
	end

	setText(arg_8_0._tf:Find("RestCount/Text"), i18n("ryza_rest_produce_count", var_8_0))

	return
end

function var_0_0.willExit(arg_9_0)
	arg_9_0:detach()

	return
end

return var_0_0
