local RegressionDailyTaskContent = class("RegressionDailyTaskContent", (import("game.views.regressionNew.pageViews.RegressionTaskContent")))

function RegressionDailyTaskContent:InitNode()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/task", {
			taskIndex = TaskConst.TASK_TYPE.DAILY
		}, ViewConst.SYSTEM_ID.TASK_PLOT)
	end)

	self.stateController = self.controller_:GetController("state")
end

function RegressionDailyTaskContent:RefreshUI()
	local var_3_0 = true

	for iter_3_0 = 1, #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.REGRESSION_DAILY_NEW] do
		local var_3_1 = TaskData2:GetTask(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.REGRESSION_DAILY_NEW][iter_3_0])

		if var_3_1 then
			self.scoreValueTxt_.text = var_3_1.progress

			if var_3_1.complete_flag == 0 then
				var_3_0 = false
			end
		end
	end

	local var_3_2 = TaskData2:GetTask(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.REGRESSION_DAILY_NEW][1])

	if var_3_2 then
		self.scoreValueTxt_.text = var_3_2.progress
	end

	if var_3_0 then
		self.stateController:SetSelectedState("received")
	else
		self.stateController:SetSelectedState("score")
	end

	self.descTxt_.text = GetTips("NEW_REGRESSION_DAILY_DESC")
end

function RegressionDailyTaskContent:Dispose()
	RegressionDailyTaskContent.super.Dispose(self)
end

return RegressionDailyTaskContent
