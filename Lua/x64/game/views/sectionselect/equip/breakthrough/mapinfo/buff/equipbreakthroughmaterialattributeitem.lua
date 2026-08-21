local var_0_0 = class("EquipBreakThroughMaterialAttributeItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = EquipBreakThroughMaterialItemCfg[arg_3_1]

	arg_3_0.icon_.sprite = getSprite("Atlas/EquipBreakThroughMaterialIcon", var_3_0.icon)

	local var_3_1 = getAttributeAffixValue(arg_3_1, arg_3_2)

	arg_3_0.descText_.text = string.format(GetI18NText(var_3_0.desc), var_3_1 / 10)
end

return var_0_0
