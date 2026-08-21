local var_0_0 = class("SpringFestivalZumaTalentDescItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	local var_3_0 = ActivityZumaTalentCfg[arg_3_1]

	if arg_3_0.titleText_ then
		arg_3_0.titleText_.text = var_3_0.name
	end

	arg_3_0.descText_.text = var_3_0.desc
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
