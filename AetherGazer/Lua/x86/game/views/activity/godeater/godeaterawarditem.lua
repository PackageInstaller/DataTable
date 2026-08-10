local var_0_0 = class("GodEaterAwardItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.statusControlller = arg_1_0.benefititemControllerexcollection_:GetController("isFull")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.iconImg_.sprite = ItemTools.getItemSprite(arg_2_1.reward_param[1] or 0)
	arg_2_0.textnumText_.text = arg_2_1.addedNum .. "/" .. arg_2_1.reward_param[3]
	arg_2_0.premintextText_.text = string.format(GetTips("GODEATER_DES_4"), arg_2_1.reward_param[2] * (3600 / arg_2_1.second))

	arg_2_0.statusControlller:SetSelectedState(arg_2_1.addedNum >= arg_2_1.reward_param[3] and "true" or "false")
end

function var_0_0.ShowReceiveAnimation(arg_3_0, arg_3_1)
	arg_3_0.benefititemAni_:Play("idle", 0, 0)
	AnimatorTools.PlayAnimationWithCallback(arg_3_0.benefititemAni_, "benefitItem_receive", function()
		if arg_3_1 then
			arg_3_1()
		end
	end)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	AnimatorTools.Stop()
end

return var_0_0
