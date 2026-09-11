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

function var_0_0:InitData(arg_2_1)
	self.openModeList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.unlock_difficulty) do
		table.insert(self.openModeList_, iter_2_1)
	end

	self.selectModeID_ = arg_2_1.difficulty
	self.receivedList_ = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.receive_list) do
		table.insert(self.receivedList_, iter_2_3)
	end

	self.globalAffixList_ = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.global_affix) do
		table.insert(self.globalAffixList_, {
			iter_2_5.id,
			iter_2_5.level,
			iter_2_5.type
		})
	end

	if self.selectModeID_ == 0 then
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE)
	end

	self.chipManagerID_ = arg_2_1.ai_chip_list[1] or 0
	self.chipIDList_ = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.ai_chip_list) do
		if iter_2_6 > 1 then
			table.insert(self.chipIDList_, iter_2_7)
		end
	end

	self.refreshTimestamp_ = arg_2_1.refresh_timestamp
end

function var_0_0:UpdateMapData(arg_3_1)
	self.mapID_ = arg_3_1.map_id
	self.totalPoint_ = arg_3_1.total_points
	self.finishStageList_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.progress_id_list) do
		table.insert(self.finishStageList_, iter_3_1)
	end

	self.stageList_ = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.choice_buff_list) do
		local var_3_0 = {}

		for iter_3_4, iter_3_5 in ipairs(iter_3_3.buff_id) do
			table.insert(var_3_0, iter_3_5)
		end

		self.stageList_[iter_3_3.id] = {
			buffList = var_3_0
		}
	end

	for iter_3_6, iter_3_7 in ipairs(arg_3_1.choice_stage_list) do
		self.stageList_[iter_3_7.id] = {
			stageID = iter_3_7.stage
		}
	end

	self.buffList_ = {}
	self.attributeList_ = {}

	for iter_3_8, iter_3_9 in ipairs(arg_3_1.buff_list) do
		if EquipBreakThroughMaterialItemCfg[iter_3_9].item_type == 1 then
			self.attributeList_[iter_3_9] = (self.attributeList_[iter_3_9] or 0) + 1
		else
			table.insert(self.buffList_, iter_3_9)
		end
	end

	self.taskList_ = {}

	for iter_3_10, iter_3_11 in ipairs(arg_3_1.assignment_list) do
		self.taskList_[iter_3_11.id] = {
			currentValue = iter_3_11.now_progress,
			targetValue = iter_3_11.total_progress
		}
	end

	self.heroStateList_ = {}

	for iter_3_12, iter_3_13 in ipairs(arg_3_1.hero_status) do
		self.heroStateList_[iter_3_12] = {
			heroID = iter_3_13.hero_id,
			rate = iter_3_13.health_rate
		}
	end

	self:CheckRedPoint()
	self:SortRewardList()

	self.comboSkillID_ = arg_3_1.cooperate_unique_skill

	if self.mapStageID_ and self.stageList_[self.mapStageID_] == nil then
		self.mapStageID_ = nil
	end
end

function var_0_0:GetOpenModeList()
	return self.openModeList_
end

function var_0_0:GetSelectModeID()
	return self.selectModeID_
end

function var_0_0:GetMapID()
	return self.mapID_
end

function var_0_0:GetRefreshTimestamp()
	return self.refreshTimestamp_
end

function var_0_0:GetReceivedList()
	return self.receivedList_
end

function var_0_0:GetGlobalAffixList()
	return self.globalAffixList_
end

function var_0_0:GetChipManagerID()
	return self.chipManagerID_
end

function var_0_0:GetChipList()
	return self.chipIDList_
end

function var_0_0:GetTotalPoint()
	return self.totalPoint_
end

function var_0_0:GetFinishStageList()
	return self.finishStageList_
end

function var_0_0:GetStageData()
	return self.stageList_
end

function var_0_0:GetBuffList()
	return self.buffList_
end

function var_0_0:GetAttributeList()
	return self.attributeList_
end

function var_0_0:GetTaskList()
	return self.taskList_
end

function var_0_0:GetHeroState()
	return self.heroStateList_
end

function var_0_0:GetCacheHero()
	return self.cacheHeroList_ or {
		0,
		0,
		0
	}
end

function var_0_0:SetHeroTeam(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		self.heroStateList_[iter_20_0] = {
			rate = 10000,
			heroID = iter_20_1
		}
	end

	self.cacheHeroList_ = arg_20_1
end

function var_0_0.SetChooseMapStageID(arg_21_0, arg_21_1)
	arg_21_0.mapStageID_ = arg_21_1
end

function var_0_0:GetChooseMapStageID()
	return self.mapStageID_
end

function var_0_0:SortRewardList()
	local var_23_0 = {}
	local var_23_1 = {}
	local var_23_2 = {}

	for iter_23_0, iter_23_1 in pairs(self.taskList_) do
		if table.keyof(self.receivedList_, iter_23_0) then
			table.insert(var_23_1, iter_23_0)
		elseif iter_23_1.currentValue >= iter_23_1.targetValue then
			table.insert(var_23_0, iter_23_0)
		else
			table.insert(var_23_2, iter_23_0)
		end
	end

	self.sortRewardList_ = {}

	table.insertto(self.sortRewardList_, var_23_0)
	table.insertto(self.sortRewardList_, var_23_2)
	table.insertto(self.sortRewardList_, var_23_1)
end

function var_0_0:GetSortRewardList()
	return self.sortRewardList_
end

function var_0_0:CheckRedPoint()
	for iter_25_0, iter_25_1 in pairs(self.taskList_) do
		if iter_25_1.currentValue >= iter_25_1.targetValue and not table.keyof(self.receivedList_, iter_25_0) then
			manager.redPoint:setTip(RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD, 0)
end

function var_0_0:GetCanReceiveList()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self.taskList_) do
		if not table.keyof(self.receivedList_, iter_26_0) and iter_26_1.currentValue >= iter_26_1.targetValue then
			table.insert(var_26_0, iter_26_0)
		end
	end

	return var_26_0
end

function var_0_0:ReceiveReward(arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		table.insert(self.receivedList_, iter_27_1)
	end

	self:CheckRedPoint()
	self:SortRewardList()
end

function var_0_0.SetComboSkillID(arg_28_0, arg_28_1)
	arg_28_0.comboSkillID_ = arg_28_1
end

function var_0_0:GetComboSkillID()
	return self.comboSkillID_
end

return var_0_0
