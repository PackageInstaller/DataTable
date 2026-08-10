require("game.data.ActivityDataTemplate")

local var_0_0 = singletonClass("ActivityData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = ActivityTemplate.New({
	stop_time = 1,
	activity_id = 0,
	start_time = 0
})

function var_0_0.Init(arg_1_0)
	arg_1_0.activityTimeList_ = {}
	arg_1_0.activitySuspendByControl = {}
end

function var_0_0.InitActivityData(arg_2_0, arg_2_1)
	var_0_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.activity_list) do
		local var_2_0 = ActivityTemplate.New(iter_2_1)

		if var_0_1[var_2_0.id] then
			Debug.LogError("Error Duplicate activity ID")
		end

		var_0_1[var_2_0.id] = var_2_0
		var_0_2[var_2_0.id] = {
			startTime = var_2_0.startTime,
			stopTime = var_2_0.stopTime
		}

		manager.notify:Invoke(ACTIVITY_UPDATE, var_2_0.id)
	end
end

function var_0_0.UpdateActivityData(arg_3_0, arg_3_1)
	local var_3_0 = ActivityTemplate.New(arg_3_1)

	var_0_1[var_3_0.id] = var_3_0

	manager.notify:Invoke(ACTIVITY_UPDATE, var_3_0.id)

	return var_3_0
end

function var_0_0.GetAllActivityData(arg_4_0)
	return var_0_1
end

function var_0_0.GetActivityData(arg_5_0, arg_5_1)
	if var_0_1[arg_5_1] then
		return var_0_1[arg_5_1]
	else
		var_0_3.id = arg_5_1

		return var_0_3
	end
end

function var_0_0.GetActivityIsOpen(arg_6_0, arg_6_1)
	local var_6_0 = var_0_1[arg_6_1]

	if var_6_0 == nil then
		return false
	end

	return var_6_0:IsActivitying()
end

function var_0_0.RefreshActivityTime(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.refresh_time) do
		table.insert(var_7_0, iter_7_1)
	end

	arg_7_0.activityTimeList_[arg_7_1.activity_id] = var_7_0

	manager.notify:Invoke(ACTIVITY_UPDATE, arg_7_1.activity_id)
end

function var_0_0.GetActivityRefreshTime(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.activityTimeList_[arg_8_1]

	if var_8_0 then
		return var_8_0[1] or 0
	else
		return 0
	end
end

function var_0_0.GetActivityRefreshTimeList(arg_9_0, arg_9_1)
	return arg_9_0.activityTimeList_[arg_9_1] or {}
end

function var_0_0.GetActivityTime(arg_10_0, arg_10_1)
	if var_0_1[arg_10_1] then
		return var_0_1[arg_10_1].startTime, var_0_1[arg_10_1].stopTime
	end

	if var_0_2[arg_10_1] then
		return var_0_2[arg_10_1].startTime, var_0_2[arg_10_1].stopTime
	end

	return 0, 0
end

function var_0_0.SetActivitySuspendByControl(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.activitySuspendByControl[arg_11_1] = arg_11_2

	if arg_11_3 then
		local var_11_0 = nullable(ActivityCfg, arg_11_1, "sub_activity_list")

		if var_11_0 then
			for iter_11_0, iter_11_1 in ipairs(var_11_0) do
				arg_11_0:SetActivitySuspendByControl(iter_11_1, arg_11_2, arg_11_3)
			end
		end
	end
end

function var_0_0.InitActivitySuspendByControl(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 then
		arg_12_0.activitySuspendByControl = {}
	end

	if arg_12_1 and arg_12_1.id_list then
		for iter_12_0, iter_12_1 in ipairs(arg_12_1.id_list) do
			arg_12_0:SetActivitySuspendByControl(iter_12_1, true, true)
		end
	end
end

function var_0_0.IsActivitySuspendByControl(arg_13_0, arg_13_1)
	return arg_13_0.activitySuspendByControl[arg_13_1]
end

return var_0_0
