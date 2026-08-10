local var_0_0 = {}

manager.net:Bind(67001, function(arg_1_0)
	AdminCatExploreData:InitExploreData(arg_1_0)
end)

function var_0_0.AdminCatSkillLevelUp(arg_2_0, arg_2_1)
	local var_2_0 = {
		mimir_id = arg_2_0,
		skill_id = arg_2_1
	}

	manager.net:SendWithLoadingNew(67002, var_2_0, 67003, var_0_0.AdminCatSkillLevelUpCallBack)
end

function var_0_0.AdminCatSkillLevelUpCallBack(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		AdminCatExploreData:UpdateSkillList(arg_3_1.skill_id)
		ShowTips("EXPLORE_SKILL_UPGRADE")
		manager.notify:CallUpdateFunc(EXPLORE_LEVEL_UP_SKILL_UPDATE)
	else
		ShowTips(GetTips(arg_3_0.result))
	end
end

function var_0_0.AdminCatExplore(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		area_id = arg_4_2,
		hour_time = arg_4_1,
		mimir_id = arg_4_0
	}

	manager.net:SendWithLoadingNew(67004, var_4_0, 67005, var_0_0.AdminCatExploreCallBack)
end

function var_0_0.AdminCatExploreCallBack(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		manager.notify:CallUpdateFunc(EXPLORE_UPDATE)
	else
		ShowTips(GetTips(arg_5_0.result))
	end
end

function var_0_0.AdminCatExploreAllExplore(arg_6_0, arg_6_1)
	var_0_0.list = arg_6_0
	var_0_0.index = arg_6_1

	local var_6_0 = {
		area_id = arg_6_0[arg_6_1].area,
		hour_time = arg_6_0[arg_6_1].hour,
		mimir_id = arg_6_0[arg_6_1].id
	}

	manager.net:SendWithLoadingNew(67004, var_6_0, 67005, var_0_0.AdminCatAllExploreCallBack)
end

function var_0_0.AdminCatAllExploreCallBack(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		manager.notify:CallUpdateFunc(EXPLORE_UPDATE)

		var_0_0.index = var_0_0.index + 1

		if #var_0_0.list < var_0_0.index then
			var_0_0.index = nil
			var_0_0.list = nil

			ShowTips("EXPLORE_BEGIN")

			return
		end

		var_0_0.AdminCatExploreAllExplore(var_0_0.list, var_0_0.index)
	else
		ShowTips(GetTips(arg_7_0.result))
	end
end

function var_0_0.AdminCatExploreAllFinish(arg_8_0, arg_8_1)
	var_0_0.list = arg_8_0
	var_0_0.index = arg_8_1

	local var_8_0 = {
		area_id = arg_8_0[arg_8_1]
	}

	manager.net:SendWithLoadingNew(67006, var_8_0, 67007, var_0_0.AdminCatExploreAllFinishCallBack)
end

function var_0_0.AdminCatExploreAllFinishCallBack(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		AdminCatExploreData:UpdateFinishExploreData(arg_9_1.area_id, arg_9_0.event_id, arg_9_0.reward_list, function()
			var_0_0.index = var_0_0.index + 1

			if #var_0_0.list < var_0_0.index then
				var_0_0.index = nil
				var_0_0.list = nil

				return
			end

			var_0_0.AdminCatExploreAllFinish(var_0_0.list, var_0_0.index)
		end)
		manager.notify:CallUpdateFunc(EXPLORE_UPDATE)
	else
		ShowTips(GetTips(arg_9_0.result))
	end
end

function var_0_0.AdminCatExploreFinish(arg_11_0)
	local var_11_0 = {
		area_id = arg_11_0
	}

	manager.net:SendWithLoadingNew(67006, var_11_0, 67007, var_0_0.AdminCatExploreFinishCallBack)
end

function var_0_0.AdminCatExploreFinishCallBack(arg_12_0, arg_12_1)
	if isSuccess(arg_12_0.result) then
		AdminCatExploreData:UpdateFinishExploreData(arg_12_1.area_id, arg_12_0.event_id, arg_12_0.reward_list)
		manager.notify:CallUpdateFunc(EXPLORE_UPDATE)
	else
		ShowTips(GetTips(arg_12_0.result))
	end
end

function var_0_0.GetWeekReward()
	manager.net:SendWithLoadingNew(67008, {}, 67009, function(arg_14_0)
		if isSuccess(arg_14_0.result) then
			AdminCatExploreData:ResetExploreDay(arg_14_0.reward_list)
			ShowTips("EXPLORE_REWARD_COLLECTION")
			manager.notify:CallUpdateFunc(EXPLORE_REWARD_UPDATE)
		else
			ShowTips(GetTips(arg_14_0.result))
		end
	end)
end

function var_0_0.UnlockAdminCat(arg_15_0)
	local var_15_0 = {
		mimir_id = arg_15_0
	}

	manager.net:SendWithLoadingNew(67010, var_15_0, 67011, var_0_0.UnlockAdminCatCallBack)
end

function var_0_0.UnlockAdminCatCallBack(arg_16_0, arg_16_1)
	if isSuccess(arg_16_0.result) then
		AdminCatExploreData:UpdateUnlockAdminCatList(arg_16_1.mimir_id)
		ShowTips("EXPLORE_MEOW_DEBLOCKING")
		manager.notify:CallUpdateFunc(EXPLORE_UNLOCK_ADMIN_CAT_UPDATE)
	else
		ShowTips(GetTips(arg_16_0.result))
	end
end

function var_0_0.WeeklyFirstOpen()
	manager.net:SendWithLoadingNew(67012, {}, 67013, var_0_0.WeeklyFirstOpenCallBack)
end

function var_0_0.WeeklyFirstOpenCallBack(arg_18_0, arg_18_1)
	if isSuccess(arg_18_0.result) then
		AdminCatExploreData:UpdateWeeklyFirst()
	else
		ShowTips(GetTips(arg_18_0.result))
	end
end

return var_0_0
