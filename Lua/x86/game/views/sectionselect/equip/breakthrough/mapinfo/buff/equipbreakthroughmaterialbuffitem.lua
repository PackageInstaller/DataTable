local var_0_0 = class("EquipBreakThroughMaterialBuffItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	local var_3_0 = EquipBreakThroughMaterialItemCfg[arg_3_1]

	arg_3_0.nameText_.text = GetI18NText(var_3_0.name)
	arg_3_0.descText_.text = getAffixDesc(var_3_0.params)
	arg_3_0.icon_.sprite = getSprite("Atlas/EquipBreakThroughMaterialIcon", var_3_0.icon)
end

return var_0_0
