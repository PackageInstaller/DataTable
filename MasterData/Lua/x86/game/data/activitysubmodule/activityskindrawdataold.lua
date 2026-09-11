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

function var_0_0:InitDrawData(arg_2_1)
	var_0_1[arg_2_1.activity_id] = {}
	self.mainActivityId_ = ActivityCfg.get_id_list_by_sub_activity_list[arg_2_1.activity_id][1]
	self.sceneList_, self.skinId_ = ActivitySkinDrawTools.GetAllReward(self.mainActivityId_)

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.info) do
		var_0_1[arg_2_1.activity_id][iter_2_1.drop_id] = {
			id = iter_2_1.drop_id,
			num = iter_2_1.num
		}
	end

	self:RefreshSkinDrawEntrace()
end

function var_0_0.RefreshData(arg_3_0, arg_3_1, arg_3_2)
	if var_0_1[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
			var_0_1[arg_3_1][iter_3_1].num = var_0_1[arg_3_1][iter_3_1].num - 1 >= 0 and var_0_1[arg_3_1][iter_3_1].num - 1 or 0
		end
	end
end

function var_0_0:InitStoryData(arg_4_1)
	self.nowStoryActivityId_ = arg_4_1.activity_id

	self:RefreshSkinDrawEntrace()
end

function var_0_0:RefreshSkinDrawEntrace()
	manager.notify:Invoke(ACTIVITY_SKIN_DRAW_UPDATE, self.mainActivityId_)
end

function var_0_0:GetActivityList()
	local var_6_0 = {}

	if self.mainActivityId_ then
		if ActivityData:GetActivityData(self.mainActivityId_):IsActivitying() then
			table.insert(var_6_0, self.mainActivityId_)
		end
	end

	return var_6_0
end

function var_0_0:GetStartStoryId()
	if ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.mainActivityId_][1] and ActivityLimitedSkinStoryCfg[ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.mainActivityId_][1]] then
		return ActivityLimitedSkinStoryCfg[ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.mainActivityId_][1]].story_id
	end
end

function var_0_0.GetDrawInfo(arg_8_0, arg_8_1, arg_8_2)
	return (var_0_1[arg_8_1] or nil) and (var_0_1[arg_8_1][arg_8_2] or nil)
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
