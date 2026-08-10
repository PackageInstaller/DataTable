local var_0_0 = import("game.views.regressionNew.pageViews.RegressionTaskContent")
local var_0_1 = class("RegressionDailyTaskContent", var_0_0)

function var_0_1.InitNode(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/task", {
			taskIndex = TaskConst.TASK_TYPE.DAILY
		}, ViewConst.SYSTEM_ID.TASK_PLOT)
	end)

	arg_1_0.stateController = arg_1_0.controller_:GetController("state")
end

function var_0_1.RefreshUI(arg_3_0)
	local var_3_0 = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.REGRESSION_DAILY_NEW]
	local var_3_1 = true

	for iter_3_0 = 1, #var_3_0 do
		local var_3_2 = TaskData2:GetTask(var_3_0[iter_3_0])

		if var_3_2 then
			arg_3_0.scoreValueTxt_.text = var_3_2.progress

			if var_3_2.complete_flag == 0 then
				var_3_1 = false
			end
		end
	end

	local var_3_3 = TaskData2:GetTask(var_3_0[1])

	if var_3_3 then
		arg_3_0.scoreValueTxt_.text = var_3_3.progress
	end

	if var_3_1 then
		arg_3_0.stateController:SetSelectedState("received")
	else
		arg_3_0.stateController:SetSelectedState("score")
	end

	arg_3_0.descTxt_.text = GetTips("NEW_REGRESSION_DAILY_DESC")
end

function var_0_1.Dispose(arg_4_0)
	var_0_1.super.Dispose(arg_4_0)
end

return var_0_1
