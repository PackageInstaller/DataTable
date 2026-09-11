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

function var_0_0:InitDrawData(arg_3_1)
	var_0_1[arg_3_1.activity_id] = {}
	self.mainActivityId_ = ActivityCfg.get_id_list_by_sub_activity_list[arg_3_1.activity_id][1]
	self.sceneList_, self.skinId_ = ActivitySkinDrawTools.GetAllReward(self.mainActivityId_)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.info) do
		var_0_1[arg_3_1.activity_id][iter_3_1.drop_id] = {
			id = iter_3_1.drop_id,
			num = iter_3_1.num
		}
	end

	self:RefreshSkinDrawEntrace()
end

function var_0_0.RefreshData(arg_4_0, arg_4_1, arg_4_2)
	if var_0_1[arg_4_1] then
		for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
			var_0_1[arg_4_1][iter_4_1].num = var_0_1[arg_4_1][iter_4_1].num - 1 >= 0 and var_0_1[arg_4_1][iter_4_1].num - 1 or 0
		end
	end
end

function var_0_0:InitStoryData(arg_5_1)
	self.nowStoryActivityId_ = arg_5_1.activity_id
	self.finishedStory_ = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.finished_story) do
		table.insert(self.finishedStory_, iter_5_1)
	end

	self:RefreshSkinDrawEntrace()
end

function var_0_0:RefreshSkinDrawEntrace()
	manager.notify:Invoke(ACTIVITY_SKIN_DRAW_UPDATE, self.mainActivityId_)
end

function var_0_0:GetActivityList()
	local var_7_0 = {}

	if self.mainActivityId_ then
		if ActivityData:GetActivityData(self.mainActivityId_):IsActivitying() and T0SkinDrawCfg[self.mainActivityId_].enter_type == 0 then
			table.insert(var_7_0, self.mainActivityId_)
		end
	end

	return var_7_0
end

function var_0_0:GetStartStoryId()
	if ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.mainActivityId_][1] and ActivityLimitedSkinStoryCfg[ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.mainActivityId_][1]] then
		return ActivityLimitedSkinStoryCfg[ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.mainActivityId_][1]].story_id
	end
end

function var_0_0.GetDrawInfo(arg_9_0, arg_9_1, arg_9_2)
	return (var_0_1[arg_9_1] or nil) and (var_0_1[arg_9_1][arg_9_2] or nil)
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

function var_0_0:GetSceneId(arg_14_1)
	return self.sceneList_[arg_14_1]
end

function var_0_0:GetSkinId()
	return self.skinId_
end

function var_0_0:GetStoryActivityId()
	return self.nowStoryActivityId_
end

function var_0_0:FinishedStory(arg_17_1)
	if not table.indexof(self.finishedStory_, arg_17_1) then
		table.insert(self.finishedStory_, arg_17_1)
	end
end

function var_0_0:GetFinishedStory()
	for iter_18_0, iter_18_1 in ipairs(ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.mainActivityId_]) do
		if manager.story:IsStoryPlayed(iter_18_1) then
			self:FinishedStory(iter_18_1)
		end
	end

	return self.finishedStory_
end

function var_0_0.UpdatePopListData(arg_19_0, arg_19_1, arg_19_2)
	var_0_4 = var_0_4 or {}
	var_0_4[arg_19_1] = arg_19_2
end

function var_0_0.ShowGetMemoryCoin(arg_20_0, arg_20_1)
	if not var_0_4[arg_20_1] then
		return
	end

	ActivitySkinDrawAction:SendFinishPop(arg_20_1)
end

return var_0_0
