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
		local var_2_1 = {}

		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			table.insert(var_2_1, RedPointConst.TRAVEL_SKULD_TRAVELITEM .. iter_2_3)
		end

		manager.redPoint:addGroup(RedPointConst.TRAVEL_SKULD_TRAVELMAP .. iter_2_0, var_2_1)
		table.insert(var_2_0, RedPointConst.TRAVEL_SKULD_TRAVELMAP .. iter_2_0)
	end

	manager.redPoint:addGroup(RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, var_2_0)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_1_6) then
		manager.redPoint:addGroup(RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, {
			RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL,
			RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL,
			RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
		})
	end

	manager.redPoint:addGroup(RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, {
		RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL,
		RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL,
		RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	})

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_1_6) then
		manager.redPoint:addGroup(RedPointConst.TRAVEL_SKULD_CHAPTER .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, {
			RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
		})
	elseif ChapterTools.IsFinishPreChapter(var_0_1) then
		manager.redPoint:addGroup(RedPointConst.TRAVEL_SKULD_CHAPTER .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, {
			RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
		})
	end
end

function var_0_0:SetData(arg_3_1)
	self.attrib_[1] = arg_3_1.memory
	self.attrib_[2] = arg_3_1.favorite
	self.attrib_[3] = arg_3_1.trust
	self.attrib_[4] = arg_3_1.mood
	self.statu_ = arg_3_1.travel_state
	self.curplotid_ = arg_3_1.plot_id
	self.getplotlist_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.plot_list) do
		table.insert(self.getplotlist_, iter_3_1)
	end

	self.getendinglist_ = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.complete_ending) do
		table.insert(self.getendinglist_, iter_3_3)
	end

	self.gettasklist_ = {}

	for iter_3_4, iter_3_5 in ipairs(arg_3_1.complete_task) do
		table.insert(self.gettasklist_, iter_3_5)
	end

	self:UpdateAllRedPoint()
end

function var_0_0:SetTravelStatu(arg_4_1)
	self.statu_ = arg_4_1

	self:UpdateEndingUnLockRedPoint()
	self:UpdateTravelItemRedPoint()
	self:UpdateSkuldStatuRedPoint()
end

function var_0_0:GetSkuldIsCanTravel()
	if self.statu_ == 0 then
		return true
	end

	return false
end

function var_0_0:GetAttrib()
	return self.attrib_
end

function var_0_0:GetSkuldStatu()
	return self.statu_
end

function var_0_0:GetCurPlotId()
	return self.curplotid_
end

function var_0_0:GetEndingStatu(arg_9_1)
	if table.keyof(self.getendinglist_, arg_9_1) then
		return "get"
	elseif self:GetEndingIsCanOpen(arg_9_1) then
		return "canopen"
	else
		return "lock"
	end
end

function var_0_0:GetEndingIsOpened(arg_10_1)
	if table.keyof(self.getendinglist_, arg_10_1) then
		return true
	else
		return false
	end
end

function var_0_0:GetEndingIsCanOpen(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(TravelSkuldEndingCfg[arg_11_1].unlock_attrib) do
		if iter_11_1 > self.attrib_[iter_11_0] then
			return false
		end
	end

	for iter_11_2, iter_11_3 in pairs(TravelSkuldEndingCfg[arg_11_1].unlock_story_collect) do
		if table.keyof(self.getplotlist_, iter_11_3) == nil then
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

function var_0_0:GetPlotIsGeted(arg_13_1)
	return table.indexof(self.getplotlist_, arg_13_1)
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

function var_0_0:GetPlotIsGetByMapIdAndItemId(arg_15_1, arg_15_2)
	for iter_15_0, iter_15_1 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id[arg_15_1]) do
		if TravelSkuldStoryCfg[iter_15_1].item_id == arg_15_2 then
			if table.indexof(self.getplotlist_, iter_15_1) then
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
	if TravelSkuldRewardCfg[arg_16_1].condition[1] == 1 then
		return string.format(GetTips("TRAVEL_SKULD_STORY_GET"), TravelSkuldRewardCfg[arg_16_1].condition[2])
	elseif TravelSkuldRewardCfg[arg_16_1].condition[1] == 2 then
		return string.format(GetTips("TRAVEL_SKULD_ENDING_OPEN"), TravelSkuldRewardCfg[arg_16_1].condition[2])
	end
end

function var_0_0:GetTaskStatuByTaskId(arg_17_1)
	if table.indexof(self.gettasklist_, arg_17_1) then
		return 3
	else
		local var_17_0 = TravelSkuldRewardCfg[arg_17_1]

		if TravelSkuldRewardCfg[arg_17_1].condition[1] == 1 then
			if #self.getplotlist_ < var_17_0.condition[2] then
				return 2
			else
				return 1
			end
		elseif TravelSkuldRewardCfg[arg_17_1].condition[1] == 2 then
			if #self.getendinglist_ < var_17_0.condition[2] then
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

function var_0_0:GetedTaskReward(arg_19_1)
	table.insert(self.gettasklist_, arg_19_1)
	self:UpdateRewardRedPoint()
end

function var_0_0:OpenEnding(arg_20_1)
	table.insert(self.getendinglist_, arg_20_1)
	self:UpdateEndingOpenRedPoint()
	self:UpdateRewardRedPoint()
end

function var_0_0:GetSkuldBtnIsBreach()
	if self:IsPassNewEnding() then
		return false
	end

	local var_21_0 = BattleStageData:GetStageData()[GameSetting.travel_skuld_destroy.value[1]]

	return (var_21_0 and var_21_0.clear_times > 0 and 1 or 0) >= 1
end

function var_0_0.GetSkuldTravelIsOpen(arg_22_0)
	local var_22_0 = BattleStageData:GetStageData()[GameSetting.travel_skuld_unlock.value[1]]

	return (var_22_0 and var_22_0.clear_times > 0 and 1 or 0) >= 1
end

function var_0_0:UpdateAllRedPoint()
	if not self:GetSkuldTravelIsOpen() then
		return
	end

	self:UpdateEndingUnLockRedPoint()
	self:UpdateEndingOpenRedPoint()
	self:UpdateTravelItemRedPoint()
	self:UpdateSkuldStatuRedPoint()
	self:UpdateRewardRedPoint()
end

function var_0_0:UpdateEndingUnLockRedPoint()
	if self.statu_ == 0 then
		for iter_24_0 = 1, #TravelSkuldEndingCfg.all - 1 do
			if not self:GetEndingIsOpened(TravelSkuldEndingCfg.all[iter_24_0]) and not self:GetEndingIsCanOpen(TravelSkuldEndingCfg.all[iter_24_0]) then
				manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 0)
	else
		manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 0)
	end
end

function var_0_0:UpdateEndingOpenRedPoint()
	for iter_25_0, iter_25_1 in pairs(TravelSkuldEndingCfg.all) do
		if iter_25_0 > 3 then
			if not table.indexof(self.getendinglist_, iter_25_1) and self:IsOpenNewEnding() then
				manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 1)

				return
			end
		elseif not table.indexof(self.getendinglist_, iter_25_1) and self:GetEndingIsCanOpen(iter_25_1) then
			manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 0)
end

function var_0_0:UpdateTravelItemRedPoint()
	for iter_26_0, iter_26_1 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		for iter_26_2, iter_26_3 in pairs(iter_26_1) do
			if self.statu_ == 0 then
				local var_26_0 = false

				for iter_26_4, iter_26_5 in pairs(TravelSkuldItemCfg[TravelSkuldStoryCfg[iter_26_3].item_id].unlock) do
					if iter_26_5 > self.attrib_[iter_26_4] then
						var_26_0 = true
					end
				end

				if var_26_0 or table.indexof(self.getplotlist_, iter_26_3) then
					manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_TRAVELITEM .. iter_26_3, 0)
				else
					manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_TRAVELITEM .. iter_26_3, 1)
				end
			else
				manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_TRAVELITEM .. iter_26_3, 0)
			end
		end
	end
end

function var_0_0:UpdateSkuldStatuRedPoint()
	if self.statu_ == 2 then
		manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 1)
		manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 1)
	else
		manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 0)
		manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 0)
	end
end

function var_0_0:UpdateRewardRedPoint()
	for iter_28_0, iter_28_1 in pairs(TravelSkuldRewardCfg.all) do
		if self:GetTaskStatuByTaskId(iter_28_1) == 1 then
			manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL, 0)
end

function var_0_0:IsCollectAllPhoto()
	if #self.getendinglist_ < #TravelSkuldEndingCfg.all - 1 then
		return false
	else
		return true
	end
end

function var_0_0.IsOpenNewEnding(arg_30_0)
	local var_30_0 = BattleStageData:GetStageData()[GameSetting.travel_skuld_new_ending.value[1]]

	return (var_30_0 and var_30_0.clear_times > 0 and 1 or 0) >= 1
end

function var_0_0.IsPassNewEnding(arg_31_0)
	local var_31_0 = BattleStageData:GetStageData()[GameSetting.travel_skuld_new_ending_stage_id.value[1]]

	return (var_31_0 and var_31_0.clear_times > 0 and 1 or 0) >= 1
end

function var_0_0.GetChapterID(arg_32_0)
	return var_0_1
end

return var_0_0
