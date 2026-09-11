local var_0_0 = {}

manager.net:Bind(79510, function(arg_1_0)
	EatSnakeData:InitData(arg_1_0)
	var_0_0.InitRedPointKey(arg_1_0)
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(EatSnakeData:GetDataByPara("activityID")), {
		RedPointConst.EAT_SNAKE_TASK,
		RedPointConst.EAT_SNAKE_VIEW
	})
end)

function var_0_0.GetReward(arg_2_0)
	manager.net:SendWithLoadingNew(79511, arg_2_0, 79512, var_0_0.OnGetRewardCallback)
end

function var_0_0:OnGetRewardCallback(arg_3_1)
	if isSuccess(self.result) then
		EatSnakeData:UpdateStageData(arg_3_1)
		var_0_0.UpdateRewardRedPoint()
	else
		ShowTips(self.result)
	end
end

function var_0_0:InitRedPointKey()
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(self.activity_id) .. self.activity_id, {
		RedPointConst.ACTIVITY_EAT_SNAKE_STAGE .. "_" .. self.activity_id,
		RedPointConst.EAT_SNAKE_TASK
	})

	for iter_4_0 = 1, #ActivityEatSnakeCfg.all do
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_EAT_SNAKE_STAGE .. "_" .. self.activity_id, {
			RedPointConst.EAT_SNAKE_STAGE .. "_" .. iter_4_0
		})
	end

	var_0_0.UpdateStageRedPoint(self)
	var_0_0.UpdateRewardRedPoint()
end

function var_0_0:UpdateStageRedPoint()
	if #self.stage_list < #ActivityEatSnakeCfg.all then
		manager.redPoint:setTip(RedPointConst.EAT_SNAKE_STAGE .. "_" .. #self.stage_list + 1, 1)
	end
end

function var_0_0.UpdateRewardRedPoint()
	manager.redPoint:setTip(RedPointConst.EAT_SNAKE_TASK, 0)

	for iter_6_0, iter_6_1 in pairs((TaskTools:GetActivityTaskList((EatSnakeData:GetDataByPara("activityID"))))) do
		if TaskData2:GetTaskProgress(iter_6_0) >= AssignmentCfg[iter_6_0].need and not TaskData2:GetTaskComplete(iter_6_0) then
			manager.redPoint:setTip(RedPointConst.EAT_SNAKE_TASK, 1)
		end
	end
end

function var_0_0.PlayEatSnakeGame(arg_7_0)
	EatSnakeData:SetSelecId(arg_7_0)
	DestroyLua()
	EatSnakesBridge.Launcher()
end

return var_0_0
