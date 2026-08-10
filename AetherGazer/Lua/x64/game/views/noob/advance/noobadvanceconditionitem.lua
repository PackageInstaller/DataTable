local var_0_0 = class("NoobAdvanceConditionItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:BindCfgUI()

	arg_1_0.stateController_ = arg_1_0.controllerExcollection_:GetController("complate")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 == 1 then
		arg_2_0.stateController_:SetSelectedState(tostring(TaskTools:IsCompletedAllNoobAdvanceTask(arg_2_2)))

		arg_2_0.descText_.text = GetTips("NOOB_ADVANCE_TASK_CONDITION_COMPLETE")
	else
		local var_2_0 = ActivityNewbieTools:GetVersionID()
		local var_2_1 = NoobVersionCfg[var_2_0].noob_advance_task_open[arg_2_3]
		local var_2_2 = PlayerData:GetPlayerInfo().userLevel

		arg_2_0.stateController_:SetSelectedState(tostring(var_2_1 <= var_2_2))

		arg_2_0.descText_.text = string.format(GetTips("NOOB_ADVANCE_TASK_CONDITION_LEVEL"), var_2_1)
	end
end

return var_0_0
