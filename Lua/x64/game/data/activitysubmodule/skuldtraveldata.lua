local var_0_0 = singletonClass("SkuldTravelData")
local var_0_1 = 10111

function var_0_0.Init(arg_1_0)
	arg_1_0.attrib_ = {
		0,
		0,
		0,
		0
	}
	arg_1_0.statu_ = 0
	arg_1_0.getplotlist_ = {}
	arg_1_0.getendinglist_ = {}
	arg_1_0.gettasklist_ = {}
end

function var_0_0.InitRedPointGroup(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		local var_2_1 = RedPointConst.TRAVEL_SKULD_TRAVELMAP .. iter_2_0
		local var_2_2 = {}

		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			local var_2_3 = RedPointConst.TRAVEL_SKULD_TRAVELITEM .. iter_2_3

			table.insert(var_2_2, var_2_3)
		end

		manager.redPoint:addGroup(var_2_1, var_2_2)
		table.insert(var_2_0, var_2_1)
	end

	local var_2_4 = RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	manager.redPoint:addGroup(var_2_4, var_2_0)

	local var_2_5 = RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_2_6 = RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_1_6) then
		local var_2_7 = RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

		manager.redPoint:addGroup(var_2_7, {
			var_2_4,
			var_2_5,
			var_2_6
		})
	end

	local var_2_8 = RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	manager.redPoint:addGroup(var_2_8, {
		var_2_4,
		var_2_5,
		var_2_6
	})

	local var_2_9 = RedPointConst.TRAVEL_SKULD_CHAPTER .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_1_6) then
		manager.redPoint:addGroup(var_2_9, {
			var_2_6
		})
	elseif ChapterTools.IsFinishPreChapter(var_0_1) then
		manager.redPoint:addGroup(var_2_9, {
			var_2_6
		})
	end
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.attrib_[1] = arg_3_1.memory
	arg_3_0.attrib_[2] = arg_3_1.favorite
	arg_3_0.attrib_[3] = arg_3_1.trust
	arg_3_0.attrib_[4] = arg_3_1.mood
	arg_3_0.statu_ = arg_3_1.travel_state
	arg_3_0.curplotid_ = arg_3_1.plot_id
	arg_3_0.getplotlist_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.plot_list) do
		table.insert(arg_3_0.getplotlist_, iter_3_1)
	end

	arg_3_0.getendinglist_ = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.complete_ending) do
		table.insert(arg_3_0.getendinglist_, iter_3_3)
	end

	arg_3_0.gettasklist_ = {}

	for iter_3_4, iter_3_5 in ipairs(arg_3_1.complete_task) do
		table.insert(arg_3_0.gettasklist_, iter_3_5)
	end

	arg_3_0:UpdateAllRedPoint()
end

function var_0_0.SetTravelStatu(arg_4_0, arg_4_1)
	arg_4_0.statu_ = arg_4_1

	arg_4_0:UpdateEndingUnLockRedPoint()
	arg_4_0:UpdateTravelItemRedPoint()
	arg_4_0:UpdateSkuldStatuRedPoint()
end

function var_0_0.GetSkuldIsCanTravel(arg_5_0)
	if arg_5_0.statu_ == 0 then
		return true
	end

	return false
end

function var_0_0.GetAttrib(arg_6_0)
	return arg_6_0.attrib_
end

function var_0_0.GetSkuldStatu(arg_7_0)
	return arg_7_0.statu_
end

function var_0_0.GetCurPlotId(arg_8_0)
	return arg_8_0.curplotid_
end

function var_0_0.GetEndingStatu(arg_9_0, arg_9_1)
	if table.keyof(arg_9_0.getendinglist_, arg_9_1) then
		return "get"
	elseif arg_9_0:GetEndingIsCanOpen(arg_9_1) then
		return "canopen"
	else
		return "lock"
	end
end

function var_0_0.GetEndingIsOpened(arg_10_0, arg_10_1)
	if table.keyof(arg_10_0.getendinglist_, arg_10_1) then
		return true
	else
		return false
	end
end

function var_0_0.GetEndingIsCanOpen(arg_11_0, arg_11_1)
	local var_11_0 = TravelSkuldEndingCfg[arg_11_1]

	for iter_11_0, iter_11_1 in pairs(var_11_0.unlock_attrib) do
		if iter_11_1 > arg_11_0.attrib_[iter_11_0] then
			return false
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_11_0.unlock_story_collect) do
		if table.keyof(arg_11_0.getplotlist_, iter_11_3) == nil then
			return false
		end
	end

	return true
end

function var_0_0.AttribIndexToString(arg_12_0, arg_12_1)
	if arg_12_1 == 1 then
		return GetTips("TIP_MEMORY")
	end

	if arg_12_1 == 2 then
		return GetTips("TIP_CURIOSITY")
	end

	if arg_12_1 == 3 then
		return GetTips("TIP_MOOD")
	end

	if arg_12_1 == 4 then
		return GetTips("TIP_COGNITION")
	end
end

function var_0_0.GetPlotIsGeted(arg_13_0, arg_13_1)
	return table.indexof(arg_13_0.getplotlist_, arg_13_1)
end

function var_0_0.GetPlotIdByMapIdAndItemId(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id[arg_14_1]) do
		if TravelSkuldStoryCfg[iter_14_1].item_id == arg_14_2 then
			return iter_14_1
		end
	end

	print("请检查配置表！！！！ ， mapid ， itemid", arg_14_1, arg_14_2)

	return nil
end

function var_0_0.GetPlotIsGetByMapIdAndItemId(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0, iter_15_1 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id[arg_15_1]) do
		if TravelSkuldStoryCfg[iter_15_1].item_id == arg_15_2 then
			if table.indexof(arg_15_0.getplotlist_, iter_15_1) then
				return true
			else
				return false
			end
		end
	end

	print("请检查配置表！！！！ ， mapid ， itemid", arg_15_1, arg_15_2)

	return nil
end

function var_0_0.GetTaskTextByTaskId(arg_16_0, arg_16_1)
	local var_16_0 = TravelSkuldRewardCfg[arg_16_1]

	if var_16_0.condition[1] == 1 then
		return string.format(GetTips("TRAVEL_SKULD_STORY_GET"), var_16_0.condition[2])
	elseif var_16_0.condition[1] == 2 then
		return string.format(GetTips("TRAVEL_SKULD_ENDING_OPEN"), var_16_0.condition[2])
	end
end

function var_0_0.GetTaskStatuByTaskId(arg_17_0, arg_17_1)
	if table.indexof(arg_17_0.gettasklist_, arg_17_1) then
		return 3
	else
		local var_17_0 = TravelSkuldRewardCfg[arg_17_1]

		if var_17_0.condition[1] == 1 then
			if #arg_17_0.getplotlist_ < var_17_0.condition[2] then
				return 2
			else
				return 1
			end
		elseif TravelSkuldRewardCfg[arg_17_1].condition[1] == 2 then
			if #arg_17_0.getendinglist_ < var_17_0.condition[2] then
				return 2
			else
				return 1
			end
		end
	end
end

function var_0_0.GetTaskControllerStatu(arg_18_0, arg_18_1)
	if arg_18_1 == 1 then
		return "complete"
	end

	if arg_18_1 == 2 then
		return "incomplete"
	end

	if arg_18_1 == 3 then
		return "received"
	end
end

function var_0_0.GetedTaskReward(arg_19_0, arg_19_1)
	table.insert(arg_19_0.gettasklist_, arg_19_1)
	arg_19_0:UpdateRewardRedPoint()
end

function var_0_0.OpenEnding(arg_20_0, arg_20_1)
	table.insert(arg_20_0.getendinglist_, arg_20_1)
	arg_20_0:UpdateEndingOpenRedPoint()
	arg_20_0:UpdateRewardRedPoint()
end

function var_0_0.GetSkuldBtnIsBreach(arg_21_0)
	if arg_21_0:IsPassNewEnding() then
		return false
	end

	local var_21_0 = GameSetting.travel_skuld_destroy.value[1]
	local var_21_1 = BattleStageData:GetStageData()[var_21_0]

	return (var_21_1 and var_21_1.clear_times > 0 and 1 or 0) >= 1
end

function var_0_0.GetSkuldTravelIsOpen(arg_22_0)
	local var_22_0 = GameSetting.travel_skuld_unlock.value[1]
	local var_22_1 = BattleStageData:GetStageData()[var_22_0]

	return (var_22_1 and var_22_1.clear_times > 0 and 1 or 0) >= 1
end

function var_0_0.UpdateAllRedPoint(arg_23_0)
	if not arg_23_0:GetSkuldTravelIsOpen() then
		return
	end

	arg_23_0:UpdateEndingUnLockRedPoint()
	arg_23_0:UpdateEndingOpenRedPoint()
	arg_23_0:UpdateTravelItemRedPoint()
	arg_23_0:UpdateSkuldStatuRedPoint()
	arg_23_0:UpdateRewardRedPoint()
end

function var_0_0.UpdateEndingUnLockRedPoint(arg_24_0)
	local var_24_0 = RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	if arg_24_0.statu_ == 0 then
		for iter_24_0 = 1, #TravelSkuldEndingCfg.all - 1 do
			local var_24_1 = TravelSkuldEndingCfg.all[iter_24_0]

			if not arg_24_0:GetEndingIsOpened(var_24_1) and not arg_24_0:GetEndingIsCanOpen(var_24_1) then
				manager.redPoint:setTip(var_24_0, 1)

				return
			end
		end

		manager.redPoint:setTip(var_24_0, 0)
	else
		manager.redPoint:setTip(var_24_0, 0)
	end
end

function var_0_0.UpdateEndingOpenRedPoint(arg_25_0)
	local var_25_0 = RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	for iter_25_0, iter_25_1 in pairs(TravelSkuldEndingCfg.all) do
		if iter_25_0 > 3 then
			if not table.indexof(arg_25_0.getendinglist_, iter_25_1) and arg_25_0:IsOpenNewEnding() then
				manager.redPoint:setTip(var_25_0, 1)

				return
			end
		elseif not table.indexof(arg_25_0.getendinglist_, iter_25_1) and arg_25_0:GetEndingIsCanOpen(iter_25_1) then
			manager.redPoint:setTip(var_25_0, 1)

			return
		end
	end

	manager.redPoint:setTip(var_25_0, 0)
end

function var_0_0.UpdateTravelItemRedPoint(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		for iter_26_2, iter_26_3 in pairs(iter_26_1) do
			local var_26_0 = TravelSkuldStoryCfg[iter_26_3].item_id
			local var_26_1 = RedPointConst.TRAVEL_SKULD_TRAVELITEM .. iter_26_3

			if arg_26_0.statu_ == 0 then
				local var_26_2 = false

				for iter_26_4, iter_26_5 in pairs(TravelSkuldItemCfg[var_26_0].unlock) do
					if iter_26_5 > arg_26_0.attrib_[iter_26_4] then
						var_26_2 = true
					end
				end

				if var_26_2 or table.indexof(arg_26_0.getplotlist_, iter_26_3) then
					manager.redPoint:setTip(var_26_1, 0)
				else
					manager.redPoint:setTip(var_26_1, 1)
				end
			else
				manager.redPoint:setTip(var_26_1, 0)
			end
		end
	end
end

function var_0_0.UpdateSkuldStatuRedPoint(arg_27_0)
	local var_27_0 = RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_27_1 = RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	if arg_27_0.statu_ == 2 then
		manager.redPoint:setTip(var_27_0, 1)
		manager.redPoint:setTip(var_27_1, 1)
	else
		manager.redPoint:setTip(var_27_0, 0)
		manager.redPoint:setTip(var_27_1, 0)
	end
end

function var_0_0.UpdateRewardRedPoint(arg_28_0)
	local var_28_0 = RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	for iter_28_0, iter_28_1 in pairs(TravelSkuldRewardCfg.all) do
		if arg_28_0:GetTaskStatuByTaskId(iter_28_1) == 1 then
			manager.redPoint:setTip(var_28_0, 1)

			return
		end
	end

	manager.redPoint:setTip(var_28_0, 0)
end

function var_0_0.IsCollectAllPhoto(arg_29_0)
	if #arg_29_0.getendinglist_ < #TravelSkuldEndingCfg.all - 1 then
		return false
	else
		return true
	end
end

function var_0_0.IsOpenNewEnding(arg_30_0)
	local var_30_0 = GameSetting.travel_skuld_new_ending.value[1]
	local var_30_1 = BattleStageData:GetStageData()[var_30_0]

	return (var_30_1 and var_30_1.clear_times > 0 and 1 or 0) >= 1
end

function var_0_0.IsPassNewEnding(arg_31_0)
	local var_31_0 = GameSetting.travel_skuld_new_ending_stage_id.value[1]
	local var_31_1 = BattleStageData:GetStageData()[var_31_0]

	return (var_31_1 and var_31_1.clear_times > 0 and 1 or 0) >= 1
end

function var_0_0.GetChapterID(arg_32_0)
	return var_0_1
end

return var_0_0
