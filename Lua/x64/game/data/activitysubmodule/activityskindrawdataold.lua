local var_0_0 = singletonClass("ActivitySkinDrawDataOld")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	arg_1_0.nowStoryActivityId_ = nil
end

function var_0_0.InitDrawData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	var_0_1[var_2_0] = {}
	arg_2_0.mainActivityId_ = ActivityCfg.get_id_list_by_sub_activity_list[var_2_0][1]
	arg_2_0.sceneList_, arg_2_0.skinId_ = ActivitySkinDrawTools.GetAllReward(arg_2_0.mainActivityId_)

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.info) do
		local var_2_1 = iter_2_1.drop_id

		var_0_1[var_2_0][var_2_1] = {
			id = var_2_1,
			num = iter_2_1.num
		}
	end

	arg_2_0:RefreshSkinDrawEntrace()
end

function var_0_0.RefreshData(arg_3_0, arg_3_1, arg_3_2)
	if var_0_1[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
			local var_3_0 = var_0_1[arg_3_1][iter_3_1].num
			local var_3_1

			var_3_1 = var_3_0 - 1 >= 0 and var_3_0 - 1 or 0
			var_0_1[arg_3_1][iter_3_1].num = var_3_1
		end
	end
end

function var_0_0.InitStoryData(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.activity_id
	local var_4_1 = ActivityLimitedSkinStoryCfg.get_id_list_by_activity_id[var_4_0][1]
	local var_4_2 = ActivityLimitedSkinStoryCfg[var_4_1].main_activity_id
	local var_4_3 = ActivityLimitedSkinStoryCfg[var_4_1].story_id

	arg_4_0.nowStoryActivityId_ = var_4_0

	arg_4_0:RefreshSkinDrawEntrace()
end

function var_0_0.RefreshSkinDrawEntrace(arg_5_0)
	manager.notify:Invoke(ACTIVITY_SKIN_DRAW_UPDATE, arg_5_0.mainActivityId_)
end

function var_0_0.GetActivityList(arg_6_0)
	local var_6_0 = {}

	if arg_6_0.mainActivityId_ and ActivityData:GetActivityData(arg_6_0.mainActivityId_):IsActivitying() then
		table.insert(var_6_0, arg_6_0.mainActivityId_)
	end

	return var_6_0
end

function var_0_0.GetStartStoryId(arg_7_0)
	local var_7_0 = ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[arg_7_0.mainActivityId_][1]

	if var_7_0 and ActivityLimitedSkinStoryCfg[var_7_0] then
		return ActivityLimitedSkinStoryCfg[var_7_0].story_id
	end
end

function var_0_0.GetDrawInfo(arg_8_0, arg_8_1, arg_8_2)
	return var_0_1[arg_8_1] and var_0_1[arg_8_1][arg_8_2] or nil
end

function var_0_0.GetCurDrawPool(arg_9_0, arg_9_1)
	return var_0_2[arg_9_1]
end

function var_0_0.SetCurDrawPool(arg_10_0, arg_10_1, arg_10_2)
	var_0_2[arg_10_1] = arg_10_2
end

function var_0_0.GetLastFile(arg_11_0, arg_11_1)
	return var_0_3[arg_11_1]
end

function var_0_0.SetLastFile(arg_12_0, arg_12_1, arg_12_2)
	var_0_3[arg_12_1] = arg_12_2
end

return var_0_0
