local var_0_0 = class("EquipSeizureAffixItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.affixID_ = arg_2_1

	arg_2_0:RefreshUI()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ActivityAffixPoolCfg[arg_4_0.affixID_]

	arg_4_0.nameText_.text = var_4_0.name
	arg_4_0.descText_.text = getAffixDesc(var_4_0.affix)
	arg_4_0.iconImage_.sprite = getAffixSprite(var_4_0.affix)
end

return var_0_0
