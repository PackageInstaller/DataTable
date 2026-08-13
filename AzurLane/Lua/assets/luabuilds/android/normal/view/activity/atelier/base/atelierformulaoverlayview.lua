class = var_0_10000

local var_0_0 = "AtelierFormulaOverlayView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2
	arg_1_0.bundleName = arg_1_2.bundleName

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitCustom()

	return
end

function var_0_1.InitCustom(arg_3_0)
	return
end

function var_0_1.SetContextData(arg_4_0, arg_4_1)
	arg_4_0.contextData = arg_4_1

	return
end

function var_0_1.SetActivity(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf

	var_1_10001(var_6_0, var_3.Find(var_6_1, "List"), function()
		local var_7_0 = arg_6_0._parentClass

		var_0.OnClickFormulaBack(var_7_0)

		return
	end)

	return
end

local var_0_2 = {}

AtelierFormula = var_2
var_0_2[var_2.TYPE.EQUIP] = "text_equip"
AtelierFormula = var_2
var_0_2[var_2.TYPE.ITEM] = "text_item"
AtelierFormula = var_2
var_0_2[var_2.TYPE.TOOL] = "text_other"
AtelierFormula = var_2
var_0_2[var_2.TYPE.OTHER] = "text_other"

function var_0_1.RefreshFormulaInfo(arg_8_0, arg_8_1)
	arg_8_0.contextData.formulaId = arg_8_1:GetConfigID()

	local var_8_0 = arg_8_0._parentClass.loader
	local var_8_1 = var_2.GetSpriteQuiet
	local var_8_2 = arg_8_0.bundleName
	local var_8_3 = var_0_2[arg_8_1:GetType()]

	description = var_6

	var_8_1(var_8_0, var_8_2, var_8_3, var_6:Find("Type"))

	local var_8_4 = {
		type = arg_8_1:GetProduction()[1],
		id = arg_8_1:GetProduction()[2]
	}
	local var_8_5 = arg_8_0._parentClass
	local var_8_6 = var_3.UpdateRyzaDrop
	local var_8_7 = arg_8_0._tf

	var_8_6(var_8_5, var_5.Find(var_8_7, "Icon"), var_8_4)

	setText = var_8_6

	local var_8_8 = arg_8_0._tf

	var_8_6(var_4.Find(var_8_8, "Name"), arg_8_1:GetName())

	setText = var_8_6

	local var_8_9 = arg_8_0._tf

	var_8_6(var_4.Find(var_8_9, "Description/Text"), arg_8_1:GetDesc())

	tostring = var_8_6

	local var_8_10 = var_8_6(arg_8_1:GetMaxLimit() - arg_8_1:GetUsedCount())

	if arg_8_1:GetMaxLimit() < 0 then
		var_8_10 = "∞"
	end

	setText = var_4

	local var_8_11 = arg_8_0._tf
	local var_8_12 = var_5.Find(var_8_11, "RestCount/Text")

	i18n = var_8_11

	var_4(var_8_12, var_8_11("ryza_rest_produce_count", var_8_10))

	return
end

function var_0_1.willExit(arg_9_0)
	arg_9_0:detach()

	return
end

return var_0_1
