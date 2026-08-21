local var_0_0 = class("AutoChessIllustatedAdminSkillItem", ReduxView)

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

	arg_3_0.gradeController_ = arg_3_0.controllerEx_:GetController("grade")
	arg_3_0.richText_ = arg_3_0:FindCom("RichText", "", arg_3_0.buffDescText_.transform)

	TerminologyTools.AddTerminologyHandler(arg_3_0, arg_3_0.richText_, nil, nil)
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = AutoChessBuffCfg[arg_5_1]
	local var_5_1 = AutoChessTools.GetChessBuffStr(nil, nil, arg_5_1)

	arg_5_0.richText = RichTextTools.SetMixedTextWithImage(arg_5_0.richText_, var_5_1)
	arg_5_0.richText_.text = var_5_1

	arg_5_0.gradeController_:SetSelectedIndex(arg_5_2 - 1)

	arg_5_0.skillIcon_.sprite = AutoChessTools.GetBuffIcon(var_5_0.icon)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
