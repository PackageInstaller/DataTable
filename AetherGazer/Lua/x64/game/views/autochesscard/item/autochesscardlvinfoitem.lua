local var_0_0 = class("AutoChessCardLvInfoItem", ReduxView)

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

	arg_3_0.lvController_ = arg_3_0.controllerEx_:GetController("lv")
	arg_3_0.richText_ = arg_3_0:FindCom("RichText", "", arg_3_0.descTrs_)

	TerminologyTools.AddTerminologyHandler(arg_3_0, arg_3_0.richText_, arg_3_0.button_, nil)
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2)
	if AutoChessTools.IsPlayerChess(arg_5_1) then
		arg_5_0.lvController_:SetSelectedIndex(arg_5_2 - 1)

		arg_5_0.richText_.text = GetTips("AUTO_CHESS_2_ADMIN_SKILL")
	else
		local var_5_0 = AutoChessTools.GetChessBuffStr(arg_5_1, arg_5_2)

		arg_5_0.lvController_:SetSelectedIndex(arg_5_2 - 1)

		arg_5_0.richText = RichTextTools.SetMixedTextWithImage(arg_5_0.richText_, var_5_0)
		arg_5_0.richText.text = var_5_0
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.richText_:RemoveAllListeners()
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
