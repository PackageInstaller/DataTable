local var_0_0 = class("HeroTrammelsAttrItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = PublicAttrCfg[arg_5_1[1]].name
	local var_5_1 = ""

	if PublicAttrCfg[arg_5_1[1]].percent == 1 then
		var_5_1 = string.format("+%.2f%%", arg_5_1[2] / 10)
	else
		var_5_1 = string.format("+%d", arg_5_1[2])
	end

	arg_5_0.m_attrName.text = var_5_0
	arg_5_0.m_attrAdd.text = var_5_1
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
