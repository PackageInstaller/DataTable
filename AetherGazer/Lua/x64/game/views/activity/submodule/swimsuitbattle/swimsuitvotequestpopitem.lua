local var_0_0 = class("SwimsuitVoteQuestPopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.task1Item_ = SwimsuitVoteQuestTaskItem.New(arg_2_0.task1Go_)
	arg_2_0.task2Item_ = SwimsuitVoteQuestTaskItem.New(arg_2_0.task2Go_)
	arg_2_0.titleController_ = arg_2_0.mainControllerEx_:GetController("title")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.titleController_:SetSelectedState(tostring(arg_3_1))

	local var_3_0 = SwimsuitBattleData:GetTaskIdByRound(arg_3_1)

	arg_3_0.task1Item_:SetData(var_3_0[1], arg_3_1)
	arg_3_0.task2Item_:SetData(var_3_0[2], arg_3_1)
end

function var_0_0.Dispose(arg_4_0)
	if arg_4_0.task1Item_ then
		arg_4_0.task1Item_:Dispose()

		arg_4_0.task1Item_ = nil
	end

	if arg_4_0.task2Item_ then
		arg_4_0.task2Item_:Dispose()

		arg_4_0.task2Item_ = nil
	end

	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
