local var_0_0 = class("CaptureSectionModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RenderView(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = ActivitySwimSkinSubActivityTaskCfg[arg_3_1]

	arg_3_0.taskText_.text = var_3_0.description

	local var_3_1 = CaptureGameData:GetSectionTaskCompleteMap(arg_3_2, arg_3_3)

	SetActive(arg_3_0.successObj_, var_3_1[arg_3_1] or false)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
