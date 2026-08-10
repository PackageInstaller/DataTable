local var_0_0 = singletonClass("ActivitySkinDrawData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5

function var_0_0.GetSkinDrawMainActivityBySkinID(arg_1_0, arg_1_1)
	if var_0_5 == nil then
		var_0_5 = {}

		for iter_1_0, iter_1_1 in pairs(T0SkinDrawCfg.all) do
			local var_1_0, var_1_1 = ActivitySkinDrawTools.GetAllReward(iter_1_1)

			if var_1_1 then
				var_0_5[var_1_1] = iter_1_1
			end
		end
	end

	return var_0_5[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_4 = {}
	var_0_3 = {}
	arg_2_0.nowStoryActivityId_ = nil
	arg_2_0.sceneList_ = {}
end

function var_0_0.InitDrawData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activity_id

	var_0_1[var_3_0] = {}
	arg_3_0.mainActivityId_ = ActivityCfg.get_id_list_by_sub_activity_list[var_3_0][1]
	arg_3_0.sceneList_, arg_3_0.skinId_ = ActivitySkinDrawTools.GetAllReward(arg_3_0.mainActivityId_)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.info) do
		local var_3_1 = iter_3_1.drop_id

		var_0_1[var_3_0][var_3_1] = {
			id = var_3_1,
			num = iter_3_1.num
		}
	end

	arg_3_0:RefreshSkinDrawEntrace()
end

function var_0_0.RefreshData(arg_4_0, arg_4_1, arg_4_2)
	if var_0_1[arg_4_1] then
		for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
			local var_4_0 = var_0_1[arg_4_1][iter_4_1].num
			local var_4_1

			var_4_1 = var_4_0 - 1 >= 0 and var_4_0 - 1 or 0
			var_0_1[arg_4_1][iter_4_1].num = var_4_1
		end
	end
end

function var_0_0.InitStoryData(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.activity_id
	local var_5_1 = ActivityLimitedSkinStoryCfg.get_id_list_by_activity_id[var_5_0][1]
	local var_5_2 = ActivityLimitedSkinStoryCfg[var_5_1].main_activity_id
	local var_5_3 = ActivityLimitedSkinStoryCfg[var_5_1].story_id

	arg_5_0.nowStoryActivityId_ = var_5_0
	arg_5_0.finishedStory_ = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.finished_story) do
		table.insert(arg_5_0.finishedStory_, iter_5_1)
	end

	arg_5_0:RefreshSkinDrawEntrace()
end

function var_0_0.RefreshSkinDrawEntrace(arg_6_0)
	manager.notify:Invoke(ACTIVITY_SKIN_DRAW_UPDATE, arg_6_0.mainActivityId_)
end

function var_0_0.GetActivityList(arg_7_0)
	local var_7_0 = {}

	if arg_7_0.mainActivityId_ then
		local var_7_1 = ActivityData:GetActivityData(arg_7_0.mainActivityId_)
		local var_7_2 = T0SkinDrawCfg[arg_7_0.mainActivityId_]

		if var_7_1:IsActivitying() and var_7_2.enter_type == 0 then
			table.insert(var_7_0, arg_7_0.mainActivityId_)
		end
	end

	return var_7_0
end

function var_0_0.GetStartStoryId(arg_8_0)
	local var_8_0 = ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[arg_8_0.mainActivityId_][1]

	if var_8_0 and ActivityLimitedSkinStoryCfg[var_8_0] then
		return ActivityLimitedSkinStoryCfg[var_8_0].story_id
	end
end

function var_0_0.GetDrawInfo(arg_9_0, arg_9_1, arg_9_2)
	return var_0_1[arg_9_1] and var_0_1[arg_9_1][arg_9_2] or nil
end

function var_0_0.GetCurDrawPool(arg_10_0, arg_10_1)
	return var_0_2[arg_10_1]
end

function var_0_0.SetCurDrawPool(arg_11_0, arg_11_1, arg_11_2)
	var_0_2[arg_11_1] = arg_11_2
end

function var_0_0.GetLastFile(arg_12_0, arg_12_1)
	return var_0_3[arg_12_1]
end

function var_0_0.SetLastFile(arg_13_0, arg_13_1, arg_13_2)
	var_0_3[arg_13_1] = arg_13_2
end

function var_0_0.GetSceneId(arg_14_0, arg_14_1)
	return arg_14_0.sceneList_[arg_14_1]
end

function var_0_0.GetSkinId(arg_15_0)
	return arg_15_0.skinId_
end

function var_0_0.GetStoryActivityId(arg_16_0)
	return arg_16_0.nowStoryActivityId_
end

function var_0_0.FinishedStory(arg_17_0, arg_17_1)
	if not table.indexof(arg_17_0.finishedStory_, arg_17_1) then
		table.insert(arg_17_0.finishedStory_, arg_17_1)
	end
end

function var_0_0.GetFinishedStory(arg_18_0)
	local var_18_0 = ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[arg_18_0.mainActivityId_]

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if manager.story:IsStoryPlayed(iter_18_1) then
			arg_18_0:FinishedStory(iter_18_1)
		end
	end

	return arg_18_0.finishedStory_
end

function var_0_0.UpdatePopListData(arg_19_0, arg_19_1, arg_19_2)
	if not var_0_4 then
		var_0_4 = {}
	end

	var_0_4[arg_19_1] = arg_19_2
end

function var_0_0.ShowGetMemoryCoin(arg_20_0, arg_20_1)
	if not var_0_4[arg_20_1] then
		return
	end

	ActivitySkinDrawAction:SendFinishPop(arg_20_1)
end

return var_0_0
