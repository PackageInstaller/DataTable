local var_0_0 = class("SectionTargetItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.controllerEx_ = arg_1_0.controllerEx_:GetController("clear")
end

function var_0_0.Refresh(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 then
		arg_2_0.controllerEx_:SetSelectedState("state1")
	else
		arg_2_0.controllerEx_:SetSelectedState("state0")
	end

	if arg_2_2 then
		arg_2_0.targetText_.text = BattleInstance.GetStarMissionText(arg_2_2[1], arg_2_2[2], arg_2_2[3])

		SetActive(arg_2_0.gameObject_, true)
	else
		SetActive(arg_2_0.gameObject_, false)
	end
end

return var_0_0
