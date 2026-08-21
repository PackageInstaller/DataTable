local var_0_0 = class("AutoChessTipsSubItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_3_0)
	TerminologyTools.AddTerminologyHandler(arg_3_0, arg_3_0.desc_, arg_3_0.button_, nil)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.buffId_ = arg_5_1
	arg_5_0.chessItemData_ = arg_5_2

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = AutoChessBuffCfg[arg_6_0.buffId_]

	arg_6_0.name_.text = var_6_0.name
	arg_6_0.icon_.sprite = AutoChessTools.GetBuffIcon(var_6_0.icon)

	AutoChessTools.GetChessBuffDesc(arg_6_0.chessItemData_, arg_6_0.buffId_, arg_6_0.desc_)
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
