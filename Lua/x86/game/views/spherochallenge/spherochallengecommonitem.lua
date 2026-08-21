local var_0_0 = class("SPHeroChallengeCommonItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController = arg_2_0.controller:GetController("state")
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	arg_3_0.itemID = arg_3_1.id

	if arg_3_1.state then
		arg_3_0.stateController:SetSelectedState(arg_3_1.state)

		if arg_3_0.itemID > 0 and ItemCfg[arg_3_0.itemID] then
			-- block empty
		end
	end
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
