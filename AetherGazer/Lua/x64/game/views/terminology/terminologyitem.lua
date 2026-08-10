local var_0_0 = class("TerminologyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.super.Dispose(arg_4_0)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.id_ = arg_5_1

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = TerminologyCfg[arg_6_0.id_]

	if var_6_0 == nil then
		Debug.LogError(string.format("TerminologyItem: could not find terminology for id %d", arg_6_0.id_))

		return
	end

	arg_6_0.titleText_.text = TerminologyTools.GetCfgTitle(var_6_0)
	arg_6_0.descText_.text = TerminologyTools.GetCfgDescription(var_6_0)
end

return var_0_0
