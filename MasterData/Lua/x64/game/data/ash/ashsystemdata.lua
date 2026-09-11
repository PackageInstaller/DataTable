local var_0_0 = singletonClass("AshSystemData")
local var_0_1 = {
	SKILL = 2,
	STORY = 5,
	WEAPON = 1,
	PROP = 4,
	MOMOTALK = 3
}

function var_0_0:Init()
	self.stageData = {}
	self.data = nil
	self.areaCollect = {}
	self.sectionMap = {}
	self.sectionCount = 0
	self.completeActvityPoint = {}
	self.momotalkList = {}
	self.isFirstPass = false
	self.now_story = false

	self:InitData()
end

function var_0_0:InitData()
	self.data = {}

	for iter_2_0, iter_2_1 in ipairs(AshShootUnlockItemCfg.all) do
		local var_2_0 = AshShootUnlockItemCfg[iter_2_1]
		local var_2_1 = AshShootUnlockItemCfg[iter_2_1].type
		local var_2_2

		if AshShootUnlockItemCfg[iter_2_1].type == 1 then
			var_2_2 = AshShootWeaponCfg[var_2_0.correlation_id]
		elseif var_2_0.type == 2 then
			var_2_2 = AshShootEffectCfg[var_2_0.correlation_id]
		elseif var_2_0.type == 3 then
			var_2_2 = StageArchivesCollectMomoTalkCfg.get_id_list_by_momotalk_plot_id[var_2_0.correlation_id]
		elseif var_2_0.type == 4 then
			var_2_2 = StoryCfg[var_2_0.correlation_id]
		end

		if var_2_0.type == 2 and var_2_2.type == 2 then
			var_2_1 = var_0_1.PROP
		end

		if var_2_0.type == 4 then
			var_2_1 = var_0_1.STORY
		end

		self.data[var_2_1] = self.data[var_2_1] or {}

		table.insert(self.data[var_2_1], {
			id = var_2_2.id,
			activity_id = var_2_0.activity_id,
			unlockRate = var_2_0.unlock_num,
			correlation_id = var_2_0.correlation_id,
			real_type = var_2_1,
			unlock_id = iter_2_1,
			cfg = var_2_2
		})
	end

	for iter_2_2, iter_2_3 in ipairs(AshShootStageCfg.all) do
		self.areaCollect[AshShootStageCfg[iter_2_3].stage_group] = self.areaCollect[AshShootStageCfg[iter_2_3].stage_group] or {}

		table.insert(self.areaCollect[AshShootStageCfg[iter_2_3].stage_group], iter_2_3)

		self.sectionMap[iter_2_3] = iter_2_2
		self.sectionCount = self.sectionCount + 1
	end
end

function var_0_0.StartStory(arg_3_0)
	arg_3_0.now_story = true
end

function var_0_0.EndStory(arg_4_0)
	arg_4_0.now_story = false

	manager.notify:CallUpdateFunc(On_ASH_AVG_END)
end

function var_0_0:GetStoryState()
	return self.now_story
end

function var_0_0:InitActivityPointData(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.reward_list) do
		self.completeActvityPoint[iter_6_1] = true
	end
end

function var_0_0:SetMomotalkData(arg_7_1)
	self.momotalkList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(self.momotalkList, iter_7_1)
	end
end

function var_0_0:AddMomotalkData(arg_8_1)
	if table.indexof(self.momotalkList, arg_8_1) then
		return
	end

	table.insert(self.momotalkList, arg_8_1)
end

function var_0_0:IsMomotalkDone(arg_9_1)
	if table.indexof(self.momotalkList, arg_9_1) then
		return true
	end

	return false
end

function var_0_0:SetData(arg_10_1, arg_10_2)
	if not arg_10_1 then
		return
	end

	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if not arg_10_2 then
			var_10_0 = not self:IsStagePass(iter_10_1.stage_id)
		end

		if self.stageData[iter_10_1.stage_id] then
			if iter_10_1.point > self.stageData[iter_10_1.stage_id].point then
				self.stageData[iter_10_1.stage_id].point = iter_10_1.point
			end

			self.stageData[iter_10_1.stage_id].cachePoint = iter_10_1.point
		else
			self.stageData[iter_10_1.stage_id] = {
				point = iter_10_1.point,
				cachePoint = iter_10_1.point
			}
		end
	end

	for iter_10_2, iter_10_3 in ipairs(AshShootStageCfg.all) do
		self:UpdateSectionRed(iter_10_3, true)
	end

	if not arg_10_2 then
		self.isFirstPass = var_10_0

		self:UpdateSectionRed(arg_10_1[1].stage_id, false, var_10_0)
	end

	self:UpdatePointRed()
end

function var_0_0:GetFirstPass()
	if self.isFirstPass then
		self.isFirstPass = false

		return true
	end

	return false
end

function var_0_0:IsInfiniteOpen()
	return self:CheckIsOpenArea(4)
end

function var_0_0:IsStageOpen(arg_13_1)
	if self.sectionMap[arg_13_1] then
		if self.sectionMap[arg_13_1] == 1 then
			return true
		end

		local var_13_0 = 0

		for iter_13_0, iter_13_1 in pairs(self.sectionMap) do
			if iter_13_1 == self.sectionMap[arg_13_1] - 1 then
				var_13_0 = iter_13_0

				break
			end
		end

		if self:IsStagePass(var_13_0) then
			return true
		end
	end

	return false
end

function var_0_0:CheckIsOpenArea(arg_14_1)
	local var_14_0

	if arg_14_1 == 1 then
		do return true end

		var_14_0 = true
	end

	for iter_14_0, iter_14_1 in ipairs(self.areaCollect[arg_14_1 - 1]) do
		if not self.stageData[iter_14_1] then
			var_14_0 = false

			break
		end
	end

	return var_14_0
end

function var_0_0:IsStagePass(arg_15_1)
	if self.stageData[arg_15_1] then
		return true
	end

	return false
end

function var_0_0:GetStagePoint(arg_16_1)
	if self.stageData[arg_16_1] then
		return self.stageData[arg_16_1].point
	end

	return 0
end

function var_0_0:GetCacheStagePoint(arg_17_1)
	if self.stageData[arg_17_1] then
		return self.stageData[arg_17_1].cachePoint
	end

	return 0
end

function var_0_0.GetPointRewardIsGet(arg_18_0, arg_18_1)
	return AshSystemData:IsPointReceived(arg_18_1)
end

function var_0_0:IsPointReceived(arg_19_1)
	local var_19_0 = self.completeActvityPoint[arg_19_1]

	if not self.completeActvityPoint[arg_19_1] then
		var_19_0 = ActivityPointData:IsCompleteID(arg_19_1)
		var_19_0 = var_19_0 or false
	end

	return var_19_0 == true
end

function var_0_0.GetHomologyRate(arg_20_0)
	return ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)
end

function var_0_0:CacheHomologyRate()
	self.preHomology = self:GetHomologyRate()

	self:UpdatePointRed()
end

function var_0_0:GetCacheHomology()
	return self.preHomology or self:GetHomologyRate()
end

function var_0_0:GetWeaponList()
	return self.data[var_0_1.WEAPON]
end

function var_0_0:GetSkillList()
	return self.data[var_0_1.SKILL]
end

function var_0_0:GetMomoTalkList()
	return self.data[var_0_1.MOMOTALK] or {}
end

function var_0_0:GetPropList()
	return self.data[var_0_1.PROP] or {}
end

function var_0_0:GetStoryList()
	return self.data[var_0_1.STORY] or {}
end

function var_0_0.SetCacheInfo(arg_28_0, arg_28_1)
	arg_28_0.cacheInfo = arg_28_1
end

function var_0_0:GetCacheInfo()
	return self.cacheInfo
end

function var_0_0:FindPreSection(arg_30_1)
	if self.sectionMap[arg_30_1] > 1 then
		return AshShootStageCfg.all[self.sectionMap[arg_30_1] - 1]
	end

	return nil
end

function var_0_0:FindNextSection(arg_31_1)
	if self.sectionMap[arg_31_1] < self.sectionCount and AshShootStageCfg[arg_31_1].stage_group == AshShootStageCfg[AshShootStageCfg.all[self.sectionMap[arg_31_1] + 1]].stage_group then
		return AshShootStageCfg.all[self.sectionMap[arg_31_1] + 1]
	end

	return nil
end

function var_0_0:GetSkillIsUnlock(arg_32_1)
	for iter_32_0, iter_32_1 in pairs(self.data[var_0_1.SKILL]) do
		if iter_32_1.id == arg_32_1 then
			return self:GetHomologyRate() >= iter_32_1.unlockRate
		end
	end

	return false
end

function var_0_0:GetEndStoryIsUnlock()
	return self:GetHomologyRate() >= AshShootUnlockItemCfg[40413].unlock_num
end

function var_0_0:InitRedPointGroup()
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(ActivityCfg[ActivityConst.ACTIVITY_ASH_LIMITED_TASK].sub_activity_list) do
		table.insert(var_34_0, RedPointConst.ASH_ACTIVITY_LIMIT_TASK_TAG .. iter_34_1)
	end

	manager.redPoint:addGroup(RedPointConst.ASH_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_ASH_LIMITED_TASK, var_34_0)

	local var_34_1 = {}

	for iter_34_2, iter_34_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ASH_LIMITED_TASK]) do
		table.insert(var_34_1, RedPointConst.ASH_ACTIVITY_LIMIT_TASK_POINT .. iter_34_3)
	end

	manager.redPoint:addGroup(RedPointConst.ASH_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_ASH_LIMITED_TASK, var_34_1)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		self:UpdateLimitedTaskRedPoint()
	end)

	local var_34_2 = {}

	for iter_34_4 = 1, 3 do
		table.insert(var_34_2, RedPointConst.ASH_ACTIVITY_SECTION_AREA .. iter_34_4)

		local var_34_3 = {}

		for iter_34_5, iter_34_6 in ipairs(self.areaCollect[iter_34_4]) do
			table.insert(var_34_3, RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. iter_34_6)
		end

		manager.redPoint:addGroup(RedPointConst.ASH_ACTIVITY_SECTION_AREA .. iter_34_4, var_34_3)
	end

	manager.redPoint:addGroup(RedPointConst.ASH_ACTIVITY_SECTION, var_34_2)
	manager.redPoint:addGroup(RedPointConst.ASH_ACTIVITY_MAIN .. ActivityConst.ACTIVITY_ASH_MAIN, {
		RedPointConst.ASH_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_ASH_MAIN,
		RedPointConst.ASH_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_ASH_LIMITED_TASK,
		RedPointConst.ASH_ACTIVITY_SECTION
	})
end

function var_0_0.UpdateLimitedTaskRedPoint(arg_36_0)
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ASH_LIMITED_TASK) then
		for iter_36_0, iter_36_1 in pairs(ActivityCfg[ActivityConst.ACTIVITY_ASH_LIMITED_TASK].sub_activity_list) do
			local var_36_0 = ActivityData:GetActivityIsOpen(iter_36_1)

			for iter_36_2, iter_36_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_36_1]) do
				if var_36_0 then
					local var_36_1 = TaskData2:GetTaskProgress(iter_36_3)

					if TaskData2:GetTaskComplete(iter_36_3) then
						manager.redPoint:setTip(RedPointConst.ASH_ACTIVITY_LIMIT_TASK_TAG .. iter_36_1, 0)
					elseif var_36_1 >= AssignmentCfg[iter_36_3].need then
						manager.redPoint:setTip(RedPointConst.ASH_ACTIVITY_LIMIT_TASK_TAG .. iter_36_1, 1)

						break
					else
						manager.redPoint:setTip(RedPointConst.ASH_ACTIVITY_LIMIT_TASK_TAG .. iter_36_1, 0)
					end
				else
					manager.redPoint:setTip(RedPointConst.ASH_ACTIVITY_LIMIT_TASK_TAG .. iter_36_1, 0)
				end
			end
		end

		for iter_36_4, iter_36_5 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ASH_LIMITED_TASK]) do
			manager.redPoint:setTip(RedPointConst.ASH_ACTIVITY_LIMIT_TASK_POINT .. iter_36_5, (not TaskData2:GetTaskComplete(iter_36_5) and TaskData2:GetTaskProgress(iter_36_5) >= AssignmentCfg[iter_36_5].need or nil) and 1)
		end
	end
end

function var_0_0:UpdateTaskRedPoint()
	self:UpdatePointRed()
end

function var_0_0:UpdatePointRed()
	local var_38_0 = false
	local var_38_1 = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ASH_MAIN] or {}
	local var_38_2 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)

	for iter_38_0, iter_38_1 in pairs(var_38_1) do
		if var_38_2 >= ActivityPointRewardCfg[iter_38_1].need and not AshSystemData:GetPointRewardIsGet(iter_38_1) then
			var_38_0 = true

			break
		end
	end

	local var_38_3 = RedPointConst.ASH_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_ASH_MAIN

	if var_38_0 then
		manager.redPoint:setTip(var_38_3, 1)
	else
		manager.redPoint:setTip(var_38_3, 0)
	end

	self:UpdateLimitedTaskRedPoint()
end

function var_0_0:RemoveSectionRed(arg_39_1)
	if not self:IsStageOpen(arg_39_1) then
		return
	end

	local var_39_0 = RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_39_1

	if manager.redPoint:getTipBoolean(RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_39_1) then
		manager.redPoint:setTip(var_39_0, 0)
		saveData("Ash_Activity", var_39_0, manager.time:GetServerTime())
	end
end

function var_0_0:UpdateSectionRed(arg_40_1, arg_40_2, arg_40_3)
	if not self:IsStageOpen(arg_40_1) then
		return
	end

	manager.redPoint:setTip(key, 0)

	if arg_40_2 then
		if not self:IsStagePass(arg_40_1) then
			local var_40_2 = getData("Ash_Activity", RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_40_1)

			if not var_40_2 or not manager.time:IsToday(var_40_2) then
				manager.redPoint:setTip(RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_40_1, 1)
			end
		end
	elseif arg_40_3 then
		local var_40_3 = self:FindNextSection(arg_40_1)

		if var_40_3 then
			manager.redPoint:setTip(RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. var_40_3, 1)
		end

		if manager.redPoint:getTipBoolean(RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_40_1) then
			manager.redPoint:setTip(RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_40_1, 0)
		end
	end
end

return var_0_0
