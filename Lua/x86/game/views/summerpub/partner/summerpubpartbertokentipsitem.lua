local var_0_0 = class("SummerPubPartberTokenTipsItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.id = arg_1_2
	arg_1_0.cfg = SummerPubHeroCfg[arg_1_0.id]

	arg_1_0:AddListeners()
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.text_.text = GetI18NText(arg_2_0.cfg.possession_name) .. "\n" .. GetI18NText(arg_2_0.cfg.possession_desc)

	SetActive(arg_2_0.gameObject_, false)
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

return var_0_0
