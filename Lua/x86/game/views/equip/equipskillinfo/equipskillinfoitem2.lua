local var_0_0 = class("EquipSkillInfoItem2", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = EquipSkillCfg[arg_3_1]

	arg_3_0.lv_.text = GetTips("LEVEL") .. arg_3_3

	local var_3_1 = var_3_0.upgrade / var_3_0.percent * arg_3_3

	if var_3_0.desc_spec_value ~= nil and var_3_0.desc_spec_value ~= "" then
		arg_3_0.desc_.text = string.gsub(desc, tostring(var_3_1), var_3_0.desc_spec_value[i])
	else
		arg_3_0.desc_.text = GetCfgDescriptionWithValue(var_3_0.desc[1], tostring(var_3_1))
	end

	arg_3_0.infoCG_.alpha = arg_3_3 <= arg_3_2 and 1 or 0.5
end

return var_0_0
