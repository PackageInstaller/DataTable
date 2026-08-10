local var_0_0 = {}

manager.net:Bind(62001, function(arg_1_0)
	RegressionData:InitData(arg_1_0)
	var_0_0.CheckTaskRedPoint()
	var_0_0.CheckSignRedPoint()
	var_0_0.ChcekSurveyRedPoint()
	var_0_0.CheckBPRedPoint()
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	var_0_0.CheckTaskRedPoint()
end)

function var_0_0.QuerySign(arg_3_0)
	manager.net:SendWithLoadingNew(62002, {
		index = arg_3_0
	}, 62003, var_0_0.OnSignBack)
end

function var_0_0.OnSignBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		local var_4_0 = arg_4_1.index

		getReward2(arg_4_0.item_list)
		RegressionData:UpdateSign(var_4_0)
		manager.notify:CallUpdateFunc(REGRESSION_SIGN)
		var_0_0.CheckSignRedPoint()
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.QueryRegressionGift()
	manager.net:SendWithLoadingNew(62004, {}, 62005, var_0_0.OnRegressionGiftBack)
end

function var_0_0.OnRegressionGiftBack(arg_6_0)
	if isSuccess(arg_6_0.result) then
		RegressionData:UpdateRegressionGift()
		getReward2(arg_6_0.item_list, nil, function()
			gameContext:Back()
			var_0_0.CheckRegressionStory()
		end, true)
		manager.notify:CallUpdateFunc(REGRESSION_GIFT_REWAD)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.SetAccumulateCurrency(arg_8_0)
	RegressionData:SetAccumulateCurrency(arg_8_0)
	var_0_0.CheckBPRedPoint()
end

function var_0_0.SetBPTaskIsRecharge()
	RegressionData:SetBPTaskIsRecharge()
	var_0_0.CheckBPRedPoint()
end

function var_0_0.CheckTaskRedPoint()
	if not RegressionData:IsRegressionOpen() then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE), 0)

		return
	end

	var_0_0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_DAILY, string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	var_0_0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_WEEK, string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	var_0_0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_CHALLENGE, string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
end

function var_0_0.UpdateTaskRedTip(arg_11_0, arg_11_1)
	local var_11_0 = TaskData2:GetTaskIDListByType(arg_11_0)

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_1 = TaskData2:GetTask(iter_11_0)

		if var_11_1.progress >= AssignmentCfg[var_11_1.id].need and var_11_1.complete_flag < 1 then
			manager.redPoint:setTip(arg_11_1, 1)

			return true
		end
	end

	manager.redPoint:setTip(arg_11_1, 0)
end

function var_0_0.CheckSignRedPoint()
	if not RegressionData:IsRegressionOpen() then
		manager.redPoint:setTip(RedPointConst.REGRESSION_SIGN, 0)

		return
	end

	local var_12_0 = RegressionData:GetSignIndex()

	for iter_12_0 = 1, var_12_0 do
		if not RegressionData:IsSignReward(iter_12_0) then
			manager.redPoint:setTip(RedPointConst.REGRESSION_SIGN, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.REGRESSION_SIGN, 0)
end

function var_0_0.ChcekSurveyRedPoint()
	if not RegressionData:IsRegressionOpen() then
		manager.redPoint:setTip(RedPointConst.REGRESSION_SURVEY, 0)

		return
	end

	local var_13_0 = SurveyData:GetSurveyList()

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1.type == 2 then
			local var_13_1 = manager.time:GetServerTime()

			if var_13_1 >= iter_13_1.start_time and var_13_1 <= iter_13_1.stop_time and (iter_13_1.status == 0 or iter_13_1.status == 1) then
				manager.redPoint:setTip(RedPointConst.REGRESSION_SURVEY, 1)

				return
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.REGRESSION_SURVEY, 0)
end

function var_0_0.CheckBPRedPoint()
	if not RegressionData:IsRegressionOpen() then
		manager.redPoint:setTip(RedPointConst.REGRESSION_BP, 0)

		return
	end

	local var_14_0 = RegressionData:GetRegressionVersion()
	local var_14_1 = RegressionCfg[var_14_0].regression_bp
	local var_14_2 = RegressionData:GetBPTaskStatus()
	local var_14_3 = RegressionData:GetBPTaskIsRecharge()
	local var_14_4 = RegressionData:GetAccumulateCurrency()
	local var_14_5 = false

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if var_14_4 >= RegressionBPTaskCfg[iter_14_1].need and (var_14_2[iter_14_1] == nil or var_14_2[iter_14_1].is_receive_reward < 1 or var_14_3 >= 1 and var_14_2[iter_14_1].is_receive_recharge_reward < 1) then
			var_14_5 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.REGRESSION_BP, var_14_5 and 1 or 0)
end

function var_0_0.ReceiveBPReward(arg_15_0, arg_15_1)
	manager.net:SendWithLoadingNew(62008, {
		bp_submit = arg_15_0
	}, 62009, function(arg_16_0, arg_16_1)
		if isSuccess(arg_16_0.result) then
			getReward2(mergeReward2(arg_16_0.item_list))

			local var_16_0 = arg_16_1.bp_submit

			RegressionData:SetBPTaskStatus(var_16_0)
			var_0_0.CheckBPRedPoint()

			if arg_15_1 then
				arg_15_1()
			end
		else
			ShowTips(arg_16_0.result)
		end
	end)
end

function var_0_0.RegressionCapsuleToysDraw(arg_17_0, arg_17_1)
	manager.net:SendWithLoadingNew(62006, {
		times = arg_17_0
	}, 62007, function(arg_18_0, arg_18_1)
		if arg_17_1 then
			arg_17_1(arg_18_0, arg_18_1)
		end
	end)
end

function var_0_0.CheckRegressionStory(arg_19_0)
	local var_19_0 = GameSetting.regression_story.value[1]
	local var_19_1 = StoryCfg[var_19_0]
	local var_19_2 = VideoTrackCfg[var_19_0 .. ".usm"]
	local var_19_3 = IllustratedData:GetPlotInfo()[var_19_0]

	if var_19_3 and var_19_3.is_view == 1 then
		JumpTools.OpenPageByJump("/regressionNew", arg_19_0)
	else
		gameContext:Go("/blank")
		manager.story:StartStoryById(var_19_0, function(arg_20_0)
			IllustratedAction.ViewIllustration(var_19_0, CollectConst.PLOT)
			JumpTools.OpenPageByJump("/regressionNew", arg_19_0)
		end)
	end
end

return var_0_0
