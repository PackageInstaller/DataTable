local var_0_0 = class("SwimsuitBattleVoteRoundHead", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.headController_ = arg_2_0.mainControllerEx_:GetController("head")
	arg_2_0.winerController_ = arg_2_0.mainControllerEx_:GetController("winer")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_1 then
		arg_3_0.headController_:SetSelectedState("state1")
	else
		arg_3_0.headController_:SetSelectedState("state0")

		local var_3_0 = SwimsuitVoteHeroCfg[arg_3_1]

		arg_3_0.headImg_.spriteAsync = "TextureConfig/Character/LittleIcon/" .. var_3_0.show_image
	end

	if arg_3_2 then
		arg_3_0.winerController_:SetSelectedState("true")
	else
		arg_3_0.winerController_:SetSelectedState("false")
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
