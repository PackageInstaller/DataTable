local var_0_0 = class("AutoChessTipsSepcSubItem", ReduxView)

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
	arg_4_0:InitController()
end

function var_0_0.InitController(arg_5_0)
	arg_5_0.lvController_ = arg_5_0.controllerEx_:GetController("lv")
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.buffId_ = arg_6_1
	arg_6_0.index_ = arg_6_2
	arg_6_0.chessItemData_ = arg_6_3

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = AutoChessBuffCfg[arg_7_0.buffId_]

	AutoChessTools.GetChessBuffDesc(arg_7_0.chessItemData_, arg_7_0.buffId_, arg_7_0.desc_)
	arg_7_0.lvController_:SetSelectedIndex(arg_7_0.index_ - 1)
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
