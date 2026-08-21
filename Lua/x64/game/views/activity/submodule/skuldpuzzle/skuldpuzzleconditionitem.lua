local var_0_0 = class("SkuldPuzzleConditionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.controllerexcollection_:GetController("state")
	arg_2_0.remindController_ = arg_2_0.controllerexcollection_:GetController("remind")
	arg_2_0.showNumController_ = arg_2_0.controllerexcollection_:GetController("showNum")
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	arg_3_0.conditionID = arg_3_1
	arg_3_0.descText_.text = SkuldPuzzleConditionCfg[arg_3_1].condition_desc

	arg_3_0:ChangeState(false)
	arg_3_0:ShowRemindState(false)

	arg_3_0.taskitemAni_.enabled = false
end

function var_0_0.CheckIsUseAllChipCondition(arg_4_0)
	return SkuldPuzzleConditionCfg[arg_4_0.conditionID].condition_type == 1
end

function var_0_0.GetFinishConditionNum(arg_5_0)
	return SkuldPuzzleConditionCfg[arg_5_0.conditionID].condition_value[2]
end

function var_0_0.GetIsFinish(arg_6_0)
	return arg_6_0.isFinish
end

function var_0_0.GetConditionID(arg_7_0)
	return arg_7_0.conditionID
end

function var_0_0.ChangeState(arg_8_0, arg_8_1)
	arg_8_0.stateController_:SetSelectedState(arg_8_1 and "finish" or "normal")

	if arg_8_0.isFinish == false and arg_8_1 then
		arg_8_0.taskitemAni_:Play("item_finish", 0, 0)

		arg_8_0.taskitemAni_.enabled = true
	end

	arg_8_0.isFinish = arg_8_1
end

function var_0_0.ShowRemindState(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_0.isFinish == false then
		arg_9_0.remindController_:SetSelectedState("show")
	else
		arg_9_0.remindController_:SetSelectedState("hide")
	end
end

function var_0_0.UpdateShowNum(arg_10_0, arg_10_1)
	if arg_10_0:CheckIsUseAllChipCondition() then
		arg_10_0.showNumController_:SetSelectedState("false")
	else
		arg_10_0.showNumController_:SetSelectedState("true")

		arg_10_0.textnumText_.text = string.format(GetTips("SKULD_PUZZLE_CONDITION"), arg_10_1, arg_10_0:GetFinishConditionNum())
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
