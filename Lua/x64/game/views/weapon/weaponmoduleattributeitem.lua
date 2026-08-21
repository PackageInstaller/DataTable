local var_0_0 = class("WeaponModuleAttributeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_2_0, arg_2_0.gameObject_)
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.typeImage_.sprite = getSprite("Atlas/Common", PublicAttrCfg[arg_3_1].icon)
	arg_3_0.typeText_.text = GetI18NText(PublicAttrCfg[arg_3_1].name)
	arg_3_0.numText_.text = "+" .. arg_3_2
end

function var_0_0.SetIsShow(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
