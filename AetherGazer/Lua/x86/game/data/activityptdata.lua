local var_0_0 = singletonClass("ActivityPtData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Ctor(arg_1_0, ...)
	var_0_1 = {}

	for iter_1_0, iter_1_1 in ipairs(ActivityPtCfg) do
		var_0_1[iter_1_1.id] = {
			num = 0,
			id = iter_1_1.id
		}
	end
end

function var_0_0.ActivityPtModify(arg_2_0, arg_2_1, arg_2_2)
	var_0_1[arg_2_1].num = var_0_1[arg_2_1].num + arg_2_2
end

function var_0_0.TaskDailyGetRewardInit(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		var_0_1[iter_3_1.activity_pt_id].num = iter_3_1.active_point
		var_0_2[iter_3_1.activity_pt_id] = {}

		for iter_3_2, iter_3_3 in ipairs(iter_3_1.get_id_list) do
			var_0_2[iter_3_1.activity_pt_id][iter_3_3] = true
		end
	end

	manager.notify:Invoke(ACTIVITY_PT_UPDATE)
end

function var_0_0.TaskDailySubmit(arg_4_0, arg_4_1)
	var_0_2[arg_4_1.activityID][arg_4_1.activityPt] = true

	manager.notify:Invoke(ACTIVITY_PT_UPDATE)
end

function var_0_0.GetCurrentActivityPt(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1] and var_0_1[arg_5_1].num or 0
end

function var_0_0.GetGiftPt(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = ActivityPtCfg[arg_6_1]

	return var_6_0 and var_6_0.target[arg_6_2] or 0
end

function var_0_0.GetTotalPt(arg_7_0, arg_7_1)
	local var_7_0 = ActivityPtCfg[arg_7_1]

	return var_7_0 and var_7_0.target[#var_7_0.target] or 0
end

function var_0_0.GetDailyGetRewardList(arg_8_0)
	return var_0_2 or {}
end

return var_0_0
