local var_0_0 = class("EquipSkillInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.handler_ = arg_2_1
	arg_2_0.info_ = arg_2_2

	arg_2_0:RefreshUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.infoCG_.alpha = arg_4_0.info_.alpha
	arg_4_0.lv_.text = arg_4_0.info_.level
	arg_4_0.desc_.text = arg_4_0.info_.desc
end

function var_0_0.GetItemInfo(arg_5_0)
	return arg_5_0.info_
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
