local var_0_0 = {}
local var_0_1 = false

manager.net:Bind(83101, function(arg_1_0)
	if not var_0_1 then
		var_0_1 = true

		var_0_0.InitRedPointConst()
	end

	NewServerData:InitData(arg_1_0)
	var_0_0.CheckTaskRedPoint()
	var_0_0.CheckSignRedPoint()
	var_0_0.CheckBPRedPoint()
end)
manager.net:Bind(83109, function(arg_2_0)
	NewServerData:SetAccumulateCurrency(arg_2_0.acc_num)
	var_0_0.CheckBPRedPoint()
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	var_0_0.CheckTaskRedPoint()
end)

function var_0_0.QuerySign(arg_4_0)
	manager.net:SendWithLoadingNew(83102, {
		index = arg_4_0,
		activity_id = ActivityConst.ACTIVITY_NEW_SERVER
	}, 83103, var_0_0.OnSignBack)
end

function var_0_0.OnSignBack(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		local var_5_0 = arg_5_1.index

		getReward2(arg_5_0.item_list)
		NewServerData:UpdateSign(var_5_0)
		manager.notify:CallUpdateFunc(NEW_SERVER_SIGN, var_5_0)
		var_0_0.CheckSignRedPoint()
	else
		ShowTips(arg_5_0.result)
	end
end

function var_0_0.SetBPTaskIsRecharge()
	NewServerData:SetBPTaskIsRecharge()
	var_0_0.CheckBPRedPoint()
end

function var_0_0.CheckTaskRedPoint()
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NEW_SERVER) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE), 0)

		return
	end

	var_0_0.UpdateTaskRedTip(TaskConst.TASK_TYPE.NEW_SERVER_DAILY, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY))
	var_0_0.UpdateTaskRedTip(TaskConst.TASK_TYPE.NEW_SERVER_WEEK, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK))
	var_0_0.UpdateTaskRedTip(TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE))
end

function var_0_0.UpdateTaskRedTip(arg_8_0, arg_8_1)
	local var_8_0 = TaskData2:GetTaskIDListByType(arg_8_0)

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		local var_8_1 = TaskData2:GetTask(iter_8_0)

		if var_8_1.progress >= AssignmentCfg[var_8_1.id].need and var_8_1.complete_flag < 1 then
			manager.redPoint:setTip(arg_8_1, 1)

			return true
		end
	end

	manager.redPoint:setTip(arg_8_1, 0)
end

function var_0_0.CheckSignRedPoint()
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NEW_SERVER) then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_SIGN, 0)

		return
	end

	local var_9_0 = NewServerData:GetSignIndex()

	for iter_9_0 = 1, var_9_0 do
		if not NewServerData:IsSignReward(iter_9_0) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_SIGN, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_SIGN, 0)
end

function var_0_0.CheckBPRedPoint()
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NEW_SERVER) then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_BP, 0)

		return
	end

	local var_10_0 = NewServerCfg[ActivityConst.ACTIVITY_NEW_SERVER].bp
	local var_10_1 = NewServerData:GetBPTaskStatus()
	local var_10_2 = NewServerData:GetBPTaskIsRecharge()
	local var_10_3 = NewServerData:GetAccumulateCurrency()
	local var_10_4 = false

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if var_10_3 >= NewServerBPTaskCfg[iter_10_1].need and (var_10_1[iter_10_1] == nil or var_10_1[iter_10_1].is_receive_reward < 1 or var_10_2 >= 1 and var_10_1[iter_10_1].is_receive_recharge_reward < 1) then
			var_10_4 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_BP, var_10_4 and 1 or 0)
end

function var_0_0.ReceiveBPReward(arg_11_0, arg_11_1)
	manager.net:SendWithLoadingNew(83106, {
		activity_id = NewServerData:GetActivityID(),
		bp_submit = arg_11_0
	}, 83107, function(arg_12_0, arg_12_1)
		if isSuccess(arg_12_0.result) then
			getReward2(mergeReward2(arg_12_0.item_list))

			local var_12_0 = arg_12_1.bp_submit

			NewServerData:SetBPTaskStatus(var_12_0)
			var_0_0.CheckBPRedPoint()

			if arg_11_1 then
				arg_11_1()
			end
		else
			ShowTips(arg_12_0.result)
		end
	end)
end

function var_0_0.CapsuleToysDraw(arg_13_0, arg_13_1)
	manager.net:SendWithLoadingNew(83104, {
		times = arg_13_0,
		activity_id = ActivityConst.ACTIVITY_NEW_SERVER
	}, 83105, function(arg_14_0, arg_14_1)
		if arg_13_1 then
			arg_13_1(arg_14_0, arg_14_1)
		end
	end)
end

function var_0_0.InitRedPointConst()
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_NEW_SERVER, {
		RedPointConst.ACTIVITY_NEW_SERVER_SIGN,
		RedPointConst.ACTIVITY_NEW_SERVER_TASK,
		RedPointConst.ACTIVITY_NEW_SERVER_BP,
		RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE
	})
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_NEW_SERVER_TASK, {
		string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY),
		string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK),
		string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE)
	})
end

return var_0_0
