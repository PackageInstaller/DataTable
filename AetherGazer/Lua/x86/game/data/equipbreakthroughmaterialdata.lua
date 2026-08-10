local var_0_0 = singletonClass("EquipBreakThroughMaterialData")

function var_0_0.Init(arg_1_0)
	arg_1_0.openModeList_ = {}
	arg_1_0.selectModeID_ = 0
	arg_1_0.globalAffixList_ = {}
	arg_1_0.chipManagerID_ = 0
	arg_1_0.chipIDList_ = {}
	arg_1_0.refreshTimestamp_ = 0
	arg_1_0.mapID_ = 0
	arg_1_0.finishStageList_ = {}
	arg_1_0.stageList_ = {}
	arg_1_0.buffList_ = {}
	arg_1_0.attributeList_ = {}
	arg_1_0.taskList_ = {}
	arg_1_0.heroStateList_ = {}
	arg_1_0.receivedList_ = {}
	arg_1_0.totalPoint_ = 0
	arg_1_0.mapStageID_ = nil
	arg_1_0.sortRewardList_ = {}
	arg_1_0.comboSkillID_ = nil
	arg_1_0.cacheHeroList_ = {
		0,
		0,
		0
	}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.openModeList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.unlock_difficulty) do
		table.insert(arg_2_0.openModeList_, iter_2_1)
	end

	arg_2_0.selectModeID_ = arg_2_1.difficulty
	arg_2_0.receivedList_ = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.receive_list) do
		table.insert(arg_2_0.receivedList_, iter_2_3)
	end

	arg_2_0.globalAffixList_ = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.global_affix) do
		table.insert(arg_2_0.globalAffixList_, {
			iter_2_5.id,
			iter_2_5.level,
			iter_2_5.type
		})
	end

	if arg_2_0.selectModeID_ == 0 then
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE)
	end

	arg_2_0.chipManagerID_ = arg_2_1.ai_chip_list[1] or 0
	arg_2_0.chipIDList_ = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.ai_chip_list) do
		if iter_2_6 > 1 then
			table.insert(arg_2_0.chipIDList_, iter_2_7)
		end
	end

	arg_2_0.refreshTimestamp_ = arg_2_1.refresh_timestamp
end

function var_0_0.UpdateMapData(arg_3_0, arg_3_1)
	arg_3_0.mapID_ = arg_3_1.map_id
	arg_3_0.totalPoint_ = arg_3_1.total_points
	arg_3_0.finishStageList_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.progress_id_list) do
		table.insert(arg_3_0.finishStageList_, iter_3_1)
	end

	arg_3_0.stageList_ = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.choice_buff_list) do
		local var_3_0 = {}

		for iter_3_4, iter_3_5 in ipairs(iter_3_3.buff_id) do
			table.insert(var_3_0, iter_3_5)
		end

		arg_3_0.stageList_[iter_3_3.id] = {
			buffList = var_3_0
		}
	end

	for iter_3_6, iter_3_7 in ipairs(arg_3_1.choice_stage_list) do
		arg_3_0.stageList_[iter_3_7.id] = {
			stageID = iter_3_7.stage
		}
	end

	arg_3_0.buffList_ = {}
	arg_3_0.attributeList_ = {}

	for iter_3_8, iter_3_9 in ipairs(arg_3_1.buff_list) do
		if EquipBreakThroughMaterialItemCfg[iter_3_9].item_type == 1 then
			arg_3_0.attributeList_[iter_3_9] = (arg_3_0.attributeList_[iter_3_9] or 0) + 1
		else
			table.insert(arg_3_0.buffList_, iter_3_9)
		end
	end

	arg_3_0.taskList_ = {}

	for iter_3_10, iter_3_11 in ipairs(arg_3_1.assignment_list) do
		arg_3_0.taskList_[iter_3_11.id] = {
			currentValue = iter_3_11.now_progress,
			targetValue = iter_3_11.total_progress
		}
	end

	arg_3_0.heroStateList_ = {}

	for iter_3_12, iter_3_13 in ipairs(arg_3_1.hero_status) do
		arg_3_0.heroStateList_[iter_3_12] = {
			heroID = iter_3_13.hero_id,
			rate = iter_3_13.health_rate
		}
	end

	arg_3_0:CheckRedPoint()
	arg_3_0:SortRewardList()

	arg_3_0.comboSkillID_ = arg_3_1.cooperate_unique_skill

	if arg_3_0.mapStageID_ and arg_3_0.stageList_[arg_3_0.mapStageID_] == nil then
		arg_3_0.mapStageID_ = nil
	end
end

function var_0_0.GetOpenModeList(arg_4_0)
	return arg_4_0.openModeList_
end

function var_0_0.GetSelectModeID(arg_5_0)
	return arg_5_0.selectModeID_
end

function var_0_0.GetMapID(arg_6_0)
	return arg_6_0.mapID_
end

function var_0_0.GetRefreshTimestamp(arg_7_0)
	return arg_7_0.refreshTimestamp_
end

function var_0_0.GetReceivedList(arg_8_0)
	return arg_8_0.receivedList_
end

function var_0_0.GetGlobalAffixList(arg_9_0)
	return arg_9_0.globalAffixList_
end

function var_0_0.GetChipManagerID(arg_10_0)
	return arg_10_0.chipManagerID_
end

function var_0_0.GetChipList(arg_11_0)
	return arg_11_0.chipIDList_
end

function var_0_0.GetTotalPoint(arg_12_0)
	return arg_12_0.totalPoint_
end

function var_0_0.GetFinishStageList(arg_13_0)
	return arg_13_0.finishStageList_
end

function var_0_0.GetStageData(arg_14_0)
	return arg_14_0.stageList_
end

function var_0_0.GetBuffList(arg_15_0)
	return arg_15_0.buffList_
end

function var_0_0.GetAttributeList(arg_16_0)
	return arg_16_0.attributeList_
end

function var_0_0.GetTaskList(arg_17_0)
	return arg_17_0.taskList_
end

function var_0_0.GetHeroState(arg_18_0)
	return arg_18_0.heroStateList_
end

function var_0_0.GetCacheHero(arg_19_0)
	return arg_19_0.cacheHeroList_ or {
		0,
		0,
		0
	}
end

function var_0_0.SetHeroTeam(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		arg_20_0.heroStateList_[iter_20_0] = {
			rate = 10000,
			heroID = iter_20_1
		}
	end

	arg_20_0.cacheHeroList_ = arg_20_1
end

function var_0_0.SetChooseMapStageID(arg_21_0, arg_21_1)
	arg_21_0.mapStageID_ = arg_21_1
end

function var_0_0.GetChooseMapStageID(arg_22_0)
	return arg_22_0.mapStageID_
end

function var_0_0.SortRewardList(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = {}
	local var_23_2 = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_0.taskList_) do
		if table.keyof(arg_23_0.receivedList_, iter_23_0) then
			table.insert(var_23_1, iter_23_0)
		elseif iter_23_1.currentValue >= iter_23_1.targetValue then
			table.insert(var_23_0, iter_23_0)
		else
			table.insert(var_23_2, iter_23_0)
		end
	end

	arg_23_0.sortRewardList_ = {}

	table.insertto(arg_23_0.sortRewardList_, var_23_0)
	table.insertto(arg_23_0.sortRewardList_, var_23_2)
	table.insertto(arg_23_0.sortRewardList_, var_23_1)
end

function var_0_0.GetSortRewardList(arg_24_0)
	return arg_24_0.sortRewardList_
end

function var_0_0.CheckRedPoint(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.taskList_) do
		if iter_25_1.currentValue >= iter_25_1.targetValue and not table.keyof(arg_25_0.receivedList_, iter_25_0) then
			manager.redPoint:setTip(RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD, 0)
end

function var_0_0.GetCanReceiveList(arg_26_0)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_0.taskList_) do
		if not table.keyof(arg_26_0.receivedList_, iter_26_0) and iter_26_1.currentValue >= iter_26_1.targetValue then
			table.insert(var_26_0, iter_26_0)
		end
	end

	return var_26_0
end

function var_0_0.ReceiveReward(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		table.insert(arg_27_0.receivedList_, iter_27_1)
	end

	arg_27_0:CheckRedPoint()
	arg_27_0:SortRewardList()
end

function var_0_0.SetComboSkillID(arg_28_0, arg_28_1)
	arg_28_0.comboSkillID_ = arg_28_1
end

function var_0_0.GetComboSkillID(arg_29_0)
	return arg_29_0.comboSkillID_
end

return var_0_0
