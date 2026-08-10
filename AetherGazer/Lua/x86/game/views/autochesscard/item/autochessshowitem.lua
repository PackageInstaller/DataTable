local var_0_0 = class("AutoChessShowItem", AutoChessItem)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(arg_2_0, arg_2_0.originalGo_)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.sunglassController_ = arg_4_0.controllerEx_:GetController("sunglass")
	arg_4_0.gradeController_ = arg_4_0.battleChessControllerEX_:GetController("grade")
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.cardID_ = arg_5_1
	arg_5_0.chessID_ = arg_5_2
	arg_5_0.isSunglass_ = arg_5_3

	arg_5_0:UpdateIcon()
end

function var_0_0.UpdateIcon(arg_6_0)
	local var_6_0 = AutoChessCardCfg[arg_6_0.cardID_]
	local var_6_1 = AutoChessCfg[arg_6_0.chessID_]

	arg_6_0.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. var_6_0.pic)
	arg_6_0.roleLightImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. var_6_0.pic)

	if arg_6_0.isSunglass_ then
		local var_6_2 = string.isNullOrEmpty(var_6_0.sunglass) and "com_m" or var_6_0.sunglass

		arg_6_0.sunglassImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/Sunglass/" .. var_6_2)
	end

	arg_6_0:RefreshSunglassesState(arg_6_0.isSunglass_)
	arg_6_0.gradeController_:SetSelectedIndex(var_6_0.type - 1)
end

function var_0_0.RefreshSunglassesState(arg_7_0, arg_7_1)
	arg_7_0.isSunglass_ = arg_7_1

	arg_7_0.sunglassController_:SetSelectedState(arg_7_0.isSunglass_ == 1 and "show" or "hide")
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
