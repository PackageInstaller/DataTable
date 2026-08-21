local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	ActivityPtScrollData:Init()

	if var_0_1 then
		return
	end

	manager.net:Bind(76151, function(arg_2_0)
		ActivityPtScrollData:SetData(arg_2_0)
		ActivityPtScrollAction.RefreshRedPoint(arg_2_0.activity_id)
	end)

	var_0_1 = true
end

function var_0_0.SetSelectSuit(arg_3_0, arg_3_1)
	local var_3_0 = {
		activity_id = arg_3_0,
		up_select = arg_3_1
	}

	manager.net:SendWithLoadingNew(76152, var_3_0, 76153, var_0_0.OnSetSelectSuit)
end

function var_0_0.OnSetSelectSuit(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		ActivityPtScrollData:SetUpSelect(arg_4_1.activity_id, arg_4_1.up_select)
		manager.notify:CallUpdateFunc(ACTIVITY_PT_SCROLL_SELECT_SUIT)
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.TryToSubmitScrollTask(arg_5_0, arg_5_1)
	if ActivityTools.CheckActivityIsSuspended(arg_5_0) then
		return
	end

	local var_5_0 = ActivityPtScrollData:GetClearTime(arg_5_0)
	local var_5_1 = GameSetting.activity_pt_roulette_task_times.value[1]
	local var_5_2 = math.floor(var_5_0 / var_5_1)
	local var_5_3 = {
		activity_id = arg_5_0,
		times = var_5_2,
		assignment_id_list = arg_5_1 or {}
	}

	manager.net:SendWithLoadingNew(76154, var_5_3, 76155, var_0_0.OnTryToSubmitScrollTask)
end

function var_0_0.OnTryToSubmitScrollTask(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_6_0.reward_list) do
			table.insert(var_6_0, {
				iter_6_1.id,
				iter_6_1.num
			})
		end

		local var_6_1 = arg_6_1.activity_id
		local var_6_2 = ActivityPtScrollData:GetClearTime(var_6_1)
		local var_6_3 = GameSetting.activity_pt_roulette_task_times.value[1]

		ActivityPtScrollData:ModifyClearTime(var_6_1, var_6_2 % var_6_3)

		for iter_6_2, iter_6_3 in ipairs(arg_6_1.assignment_id_list) do
			local var_6_4 = AssignmentCfg[iter_6_3]

			TaskData2:SubmitTask(iter_6_3)
			table.insertto(var_6_0, var_6_4.reward or {})
		end

		local var_6_5 = formatRewardCfgList(var_6_0)
		local var_6_6 = mergeReward(var_6_5)

		if #var_6_6 > 0 then
			getReward(var_6_6)
		end

		local var_6_7 = TaskAction:PackTaskIdListToTaskList(arg_6_1.assignment_id_list)

		TaskAction:OnTaskChange(var_6_7)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.InitRedPointKey(arg_7_0)
	local var_7_0 = ActivityData:GetActivityData(arg_7_0)

	if not var_7_0 or not var_7_0:IsActivitying() then
		return
	end

	local var_7_1 = ActivityPtScrollTools.GetTaskActivityID(arg_7_0)

	if not var_7_1 then
		return
	end

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_PT_SCROLL .. "_" .. arg_7_0, {
		RedPointConst.ACTIVITY_PT_SCROLL_INFINITY_TASK .. "_" .. arg_7_0,
		RedPointConst.ACTIVITY_PT_SCROLL_OPEN .. "_" .. arg_7_0,
		RedPointConst.ACTIVITY_TASK .. "_" .. var_7_1,
		RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. arg_7_0
	})
end

function var_0_0.RefreshRedPoint(arg_8_0)
	local var_8_0 = ActivityData:GetActivityData(arg_8_0)

	if not var_8_0 or not var_8_0:IsActivitying() then
		ActivityPtScrollAction.ClearRed(arg_8_0)

		return
	end

	if not ActivityPtScrollTools.GetTaskActivityID(arg_8_0) then
		return
	end

	local var_8_1 = false
	local var_8_2 = getData(RedPointConst.ACTIVITY_PT_SCROLL_OPEN, tostring(arg_8_0)) or false

	if ActivityTools.IsUnlockActivity(arg_8_0) and not var_8_2 then
		var_8_1 = true
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_OPEN .. "_" .. arg_8_0, var_8_1 and 1 or 0)
end

function var_0_0.ClearRed(arg_9_0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_OPEN .. "_" .. arg_9_0, 0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_INFINITY_TASK .. "_" .. arg_9_0, 0)
end

return var_0_0
