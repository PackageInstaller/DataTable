local var_0_0 = singletonClass("AshSystemData")
local var_0_1 = {
	SKILL = 2,
	STORY = 5,
	WEAPON = 1,
	PROP = 4,
	MOMOTALK = 3
}

function var_0_0.Init(arg_1_0)
	arg_1_0.stageData = {}
	arg_1_0.data = nil
	arg_1_0.areaCollect = {}
	arg_1_0.sectionMap = {}
	arg_1_0.sectionCount = 0
	arg_1_0.completeActvityPoint = {}
	arg_1_0.momotalkList = {}
	arg_1_0.isFirstPass = false
	arg_1_0.now_story = false

	arg_1_0:InitData()
end

function var_0_0.InitData(arg_2_0)
	arg_2_0.data = {}

	for iter_2_0, iter_2_1 in ipairs(AshShootUnlockItemCfg.all) do
		local var_2_0 = AshShootUnlockItemCfg[iter_2_1]
		local var_2_1 = var_2_0.type
		local var_2_2

		if var_2_0.type == 1 then
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

		arg_2_0.data[var_2_1] = arg_2_0.data[var_2_1] or {}

		table.insert(arg_2_0.data[var_2_1], {
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
		local var_2_3 = AshShootStageCfg[iter_2_3]

		arg_2_0.areaCollect[var_2_3.stage_group] = arg_2_0.areaCollect[var_2_3.stage_group] or {}

		table.insert(arg_2_0.areaCollect[var_2_3.stage_group], iter_2_3)

		arg_2_0.sectionMap[iter_2_3] = iter_2_2
		arg_2_0.sectionCount = arg_2_0.sectionCount + 1
	end
end

function var_0_0.StartStory(arg_3_0)
	arg_3_0.now_story = true
end

function var_0_0.EndStory(arg_4_0)
	arg_4_0.now_story = false

	manager.notify:CallUpdateFunc(On_ASH_AVG_END)
end

function var_0_0.GetStoryState(arg_5_0)
	return arg_5_0.now_story
end

function var_0_0.InitActivityPointData(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.reward_list) do
		arg_6_0.completeActvityPoint[iter_6_1] = true
	end
end

function var_0_0.SetMomotalkData(arg_7_0, arg_7_1)
	arg_7_0.momotalkList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(arg_7_0.momotalkList, iter_7_1)
	end
end

function var_0_0.AddMomotalkData(arg_8_0, arg_8_1)
	if table.indexof(arg_8_0.momotalkList, arg_8_1) then
		return
	end

	table.insert(arg_8_0.momotalkList, arg_8_1)
end

function var_0_0.IsMomotalkDone(arg_9_0, arg_9_1)
	if table.indexof(arg_9_0.momotalkList, arg_9_1) then
		return true
	end

	return false
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		return
	end

	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if not arg_10_2 then
			var_10_0 = not arg_10_0:IsStagePass(iter_10_1.stage_id)
		end

		if arg_10_0.stageData[iter_10_1.stage_id] then
			if iter_10_1.point > arg_10_0.stageData[iter_10_1.stage_id].point then
				arg_10_0.stageData[iter_10_1.stage_id].point = iter_10_1.point
			end

			arg_10_0.stageData[iter_10_1.stage_id].cachePoint = iter_10_1.point
		else
			arg_10_0.stageData[iter_10_1.stage_id] = {
				point = iter_10_1.point,
				cachePoint = iter_10_1.point
			}
		end
	end

	for iter_10_2, iter_10_3 in ipairs(AshShootStageCfg.all) do
		arg_10_0:UpdateSectionRed(iter_10_3, true)
	end

	if not arg_10_2 then
		arg_10_0.isFirstPass = var_10_0

		arg_10_0:UpdateSectionRed(arg_10_1[1].stage_id, false, var_10_0)
	end

	arg_10_0:UpdatePointRed()
end

function var_0_0.GetFirstPass(arg_11_0)
	if arg_11_0.isFirstPass then
		arg_11_0.isFirstPass = false

		return true
	end

	return false
end

function var_0_0.IsInfiniteOpen(arg_12_0)
	return arg_12_0:CheckIsOpenArea(4)
end

function var_0_0.IsStageOpen(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.sectionMap[arg_13_1]

	if var_13_0 then
		if var_13_0 == 1 then
			return true
		end

		local var_13_1 = 0

		for iter_13_0, iter_13_1 in pairs(arg_13_0.sectionMap) do
			if iter_13_1 == var_13_0 - 1 then
				var_13_1 = iter_13_0

				break
			end
		end

		if arg_13_0:IsStagePass(var_13_1) then
			return true
		end
	end

	return false
end

function var_0_0.CheckIsOpenArea(arg_14_0, arg_14_1)
	if arg_14_1 == 1 then
		return true
	end

	local var_14_0 = arg_14_1 - 1
	local var_14_1 = true

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.areaCollect[var_14_0]) do
		if not arg_14_0.stageData[iter_14_1] then
			var_14_1 = false

			break
		end
	end

	return var_14_1
end

function var_0_0.IsStagePass(arg_15_0, arg_15_1)
	if arg_15_0.stageData[arg_15_1] then
		return true
	end

	return false
end

function var_0_0.GetStagePoint(arg_16_0, arg_16_1)
	if arg_16_0.stageData[arg_16_1] then
		return arg_16_0.stageData[arg_16_1].point
	end

	return 0
end

function var_0_0.GetCacheStagePoint(arg_17_0, arg_17_1)
	if arg_17_0.stageData[arg_17_1] then
		return arg_17_0.stageData[arg_17_1].cachePoint
	end

	return 0
end

function var_0_0.GetPointRewardIsGet(arg_18_0, arg_18_1)
	return AshSystemData:IsPointReceived(arg_18_1)
end

function var_0_0.IsPointReceived(arg_19_0, arg_19_1)
	return (arg_19_0.completeActvityPoint[arg_19_1] or ActivityPointData:IsCompleteID(arg_19_1) or false) == true
end

function var_0_0.GetHomologyRate(arg_20_0)
	return ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)
end

function var_0_0.CacheHomologyRate(arg_21_0)
	arg_21_0.preHomology = arg_21_0:GetHomologyRate()

	arg_21_0:UpdatePointRed()
end

function var_0_0.GetCacheHomology(arg_22_0)
	return arg_22_0.preHomology or arg_22_0:GetHomologyRate()
end

function var_0_0.GetWeaponList(arg_23_0)
	return arg_23_0.data[var_0_1.WEAPON]
end

function var_0_0.GetSkillList(arg_24_0)
	return arg_24_0.data[var_0_1.SKILL]
end

function var_0_0.GetMomoTalkList(arg_25_0)
	return arg_25_0.data[var_0_1.MOMOTALK] or {}
end

function var_0_0.GetPropList(arg_26_0)
	return arg_26_0.data[var_0_1.PROP] or {}
end

function var_0_0.GetStoryList(arg_27_0)
	return arg_27_0.data[var_0_1.STORY] or {}
end

function var_0_0.SetCacheInfo(arg_28_0, arg_28_1)
	arg_28_0.cacheInfo = arg_28_1
end

function var_0_0.GetCacheInfo(arg_29_0)
	return arg_29_0.cacheInfo
end

function var_0_0.FindPreSection(arg_30_0, arg_30_1)
	local var_30_0
	local var_30_1 = arg_30_0.sectionMap[arg_30_1]

	if var_30_1 > 1 then
		return AshShootStageCfg.all[var_30_1 - 1]
	end

	return var_30_0
end

function var_0_0.FindNextSection(arg_31_0, arg_31_1)
	local var_31_0
	local var_31_1 = arg_31_0.sectionMap[arg_31_1]

	if var_31_1 < arg_31_0.sectionCount then
		local var_31_2 = AshShootStageCfg.all[var_31_1 + 1]

		if AshShootStageCfg[arg_31_1].stage_group == AshShootStageCfg[var_31_2].stage_group then
			return AshShootStageCfg.all[var_31_1 + 1]
		end
	end

	return var_31_0
end

function var_0_0.GetSkillIsUnlock(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.data[var_0_1.SKILL]) do
		if iter_32_1.id == arg_32_1 then
			return arg_32_0:GetHomologyRate() >= iter_32_1.unlockRate
		end
	end

	return false
end

function var_0_0.GetEndStoryIsUnlock(arg_33_0)
	local var_33_0 = AshShootUnlockItemCfg[40413]

	return arg_33_0:GetHomologyRate() >= var_33_0.unlock_num
end

function var_0_0.InitRedPointGroup(arg_34_0)
	local var_34_0 = RedPointConst.ASH_ACTIVITY_MAIN .. ActivityConst.ACTIVITY_ASH_MAIN
	local var_34_1 = RedPointConst.ASH_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_ASH_MAIN
	local var_34_2 = RedPointConst.ASH_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_ASH_LIMITED_TASK
	local var_34_3 = ActivityCfg[ActivityConst.ACTIVITY_ASH_LIMITED_TASK]
	local var_34_4 = {}

	for iter_34_0, iter_34_1 in pairs(var_34_3.sub_activity_list) do
		local var_34_5 = RedPointConst.ASH_ACTIVITY_LIMIT_TASK_TAG .. iter_34_1

		table.insert(var_34_4, var_34_5)
	end

	manager.redPoint:addGroup(var_34_2, var_34_4)

	local var_34_6 = {}

	for iter_34_2, iter_34_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ASH_LIMITED_TASK]) do
		local var_34_7 = RedPointConst.ASH_ACTIVITY_LIMIT_TASK_POINT .. iter_34_3

		table.insert(var_34_6, var_34_7)
	end

	manager.redPoint:addGroup(var_34_2, var_34_6)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		arg_34_0:UpdateLimitedTaskRedPoint()
	end)

	local var_34_8 = RedPointConst.ASH_ACTIVITY_SECTION
	local var_34_9 = {}

	for iter_34_4 = 1, 3 do
		local var_34_10 = RedPointConst.ASH_ACTIVITY_SECTION_AREA .. iter_34_4

		table.insert(var_34_9, var_34_10)

		local var_34_11 = {}
		local var_34_12 = arg_34_0.areaCollect[iter_34_4]

		for iter_34_5, iter_34_6 in ipairs(var_34_12) do
			table.insert(var_34_11, RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. iter_34_6)
		end

		manager.redPoint:addGroup(var_34_10, var_34_11)
	end

	manager.redPoint:addGroup(var_34_8, var_34_9)
	manager.redPoint:addGroup(var_34_0, {
		var_34_1,
		var_34_2,
		var_34_8
	})
end

function var_0_0.UpdateLimitedTaskRedPoint(arg_36_0)
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ASH_LIMITED_TASK) then
		local var_36_0 = ActivityCfg[ActivityConst.ACTIVITY_ASH_LIMITED_TASK].sub_activity_list

		for iter_36_0, iter_36_1 in pairs(var_36_0) do
			local var_36_1 = ActivityData:GetActivityIsOpen(iter_36_1)

			for iter_36_2, iter_36_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_36_1]) do
				local var_36_2 = RedPointConst.ASH_ACTIVITY_LIMIT_TASK_TAG .. iter_36_1

				if var_36_1 then
					local var_36_3 = TaskData2:GetTaskProgress(iter_36_3)
					local var_36_4 = AssignmentCfg[iter_36_3]

					if TaskData2:GetTaskComplete(iter_36_3) then
						manager.redPoint:setTip(var_36_2, 0)
					elseif var_36_3 >= var_36_4.need then
						manager.redPoint:setTip(var_36_2, 1)

						break
					else
						manager.redPoint:setTip(var_36_2, 0)
					end
				else
					manager.redPoint:setTip(var_36_2, 0)
				end
			end
		end

		for iter_36_4, iter_36_5 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ASH_LIMITED_TASK]) do
			local var_36_5 = 0
			local var_36_6 = TaskData2:GetTaskProgress(iter_36_5)
			local var_36_7 = AssignmentCfg[iter_36_5]

			if not TaskData2:GetTaskComplete(iter_36_5) and var_36_6 >= var_36_7.need then
				var_36_5 = 1
			end

			manager.redPoint:setTip(RedPointConst.ASH_ACTIVITY_LIMIT_TASK_POINT .. iter_36_5, var_36_5)
		end
	end
end

function var_0_0.UpdateTaskRedPoint(arg_37_0)
	arg_37_0:UpdatePointRed()
end

function var_0_0.UpdatePointRed(arg_38_0)
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

	arg_38_0:UpdateLimitedTaskRedPoint()
end

function var_0_0.RemoveSectionRed(arg_39_0, arg_39_1)
	if not arg_39_0:IsStageOpen(arg_39_1) then
		return
	end

	local var_39_0 = RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_39_1

	if manager.redPoint:getTipBoolean(var_39_0) then
		manager.redPoint:setTip(var_39_0, 0)
		saveData("Ash_Activity", var_39_0, manager.time:GetServerTime())
	end
end

function var_0_0.UpdateSectionRed(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if not arg_40_0:IsStageOpen(arg_40_1) then
		return
	end

	local var_40_0 = AshShootStageCfg[arg_40_1]
	local var_40_1 = false

	manager.redPoint:setTip(key, 0)

	if arg_40_2 then
		if not arg_40_0:IsStagePass(arg_40_1) then
			local var_40_2 = RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_40_1
			local var_40_3 = getData("Ash_Activity", var_40_2)

			if not var_40_3 or not manager.time:IsToday(var_40_3) then
				manager.redPoint:setTip(var_40_2, 1)
			end
		end
	elseif arg_40_3 then
		local var_40_4 = arg_40_0:FindNextSection(arg_40_1)

		if var_40_4 then
			local var_40_5 = RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. var_40_4

			manager.redPoint:setTip(var_40_5, 1)
		end

		local var_40_6 = RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_40_1

		if manager.redPoint:getTipBoolean(var_40_6) then
			manager.redPoint:setTip(var_40_6, 0)
		end
	end
end

return var_0_0
