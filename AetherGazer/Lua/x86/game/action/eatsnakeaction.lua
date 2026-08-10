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

function var_0_0.OnGetRewardCallback(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		EatSnakeData:UpdateStageData(arg_3_1)
		var_0_0.UpdateRewardRedPoint()
	else
		ShowTips(arg_3_0.result)
	end
end

function var_0_0.InitRedPointKey(arg_4_0)
	local var_4_0 = arg_4_0.activity_id
	local var_4_1 = ActivityTools.GetRedPointKey(var_4_0) .. var_4_0

	manager.redPoint:addGroup(var_4_1, {
		RedPointConst.ACTIVITY_EAT_SNAKE_STAGE .. "_" .. var_4_0,
		RedPointConst.EAT_SNAKE_TASK
	})

	for iter_4_0 = 1, #ActivityEatSnakeCfg.all do
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_EAT_SNAKE_STAGE .. "_" .. var_4_0, {
			RedPointConst.EAT_SNAKE_STAGE .. "_" .. iter_4_0
		})
	end

	var_0_0.UpdateStageRedPoint(arg_4_0)
	var_0_0.UpdateRewardRedPoint()
end

function var_0_0.UpdateStageRedPoint(arg_5_0)
	if #arg_5_0.stage_list < #ActivityEatSnakeCfg.all then
		local var_5_0 = RedPointConst.EAT_SNAKE_STAGE .. "_" .. #arg_5_0.stage_list + 1

		manager.redPoint:setTip(var_5_0, 1)
	end
end

function var_0_0.UpdateRewardRedPoint()
	manager.redPoint:setTip(RedPointConst.EAT_SNAKE_TASK, 0)

	local var_6_0 = EatSnakeData:GetDataByPara("activityID")
	local var_6_1 = TaskTools:GetActivityTaskList(var_6_0)

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		local var_6_2 = TaskData2:GetTaskComplete(iter_6_0)

		if TaskData2:GetTaskProgress(iter_6_0) >= AssignmentCfg[iter_6_0].need and not var_6_2 then
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
