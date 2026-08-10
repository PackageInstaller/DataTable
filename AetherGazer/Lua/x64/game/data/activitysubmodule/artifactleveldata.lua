local var_0_0 = singletonClass("ArtifactLevelData")

function var_0_0.Init(arg_1_0)
	arg_1_0.curOpenLevelList_ = {}
	arg_1_0.curAwardedLevelList_ = {}
	arg_1_0.levelId_ = {}
	arg_1_0.selectedLevelList_ = {}
	arg_1_0.awardsList_ = {}
	arg_1_0.levelCount_ = 0
	arg_1_0.curLevelIndex_ = 1

	local var_1_0 = ActivityConst.SUMMER_ARTIFACT
	local var_1_1 = ActivityData:GetActivityData(var_1_0)

	for iter_1_0, iter_1_1 in pairs(ActivityArtifactLevelCfg.all) do
		table.insert(arg_1_0.levelId_, iter_1_1)

		arg_1_0.levelCount_ = arg_1_0.levelCount_ + 1
	end

	for iter_1_2, iter_1_3 in pairs(BattleArtifactCfg.all) do
		arg_1_0.awardsList_[iter_1_2] = BattleArtifactCfg[iter_1_3].drop_lib_id
	end

	arg_1_0:InitRedPoint(ActivityConst.SUMMER_ARTIFACT)
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.artifact

	for iter_2_0, iter_2_1 in pairs(arg_2_0.levelId_) do
		arg_2_0.curAwardedLevelList_[iter_2_0] = false
	end

	if var_2_0.already_clear_activity_id_list then
		for iter_2_2, iter_2_3 in ipairs(var_2_0.already_clear_activity_id_list) do
			if arg_2_0:GetIndexByLevelId(iter_2_3) then
				arg_2_0.curAwardedLevelList_[arg_2_0:GetIndexByLevelId(iter_2_3)] = true
			end
		end
	end

	for iter_2_4, iter_2_5 in pairs(ActivityArtifactLevelCfg.all) do
		if ActivityData:GetActivityIsOpen(iter_2_5) then
			arg_2_0.curOpenLevelList_[iter_2_4] = true
		end
	end

	arg_2_0:UpdateRedPoint()
end

function var_0_0.GetIndexByLevelId(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.levelId_) do
		if iter_3_1 == arg_3_1 then
			return iter_3_0
		end
	end

	return nil
end

function var_0_0.GetLevelCount(arg_4_0)
	return arg_4_0.levelCount_
end

function var_0_0.GetLevelIdByIndex(arg_5_0, arg_5_1)
	return arg_5_0.levelId_[arg_5_1]
end

function var_0_0.GetIsAwardedByIndex(arg_6_0, arg_6_1)
	return arg_6_0.curAwardedLevelList_[arg_6_1]
end

function var_0_0.GetLevelNameByIndex(arg_7_0, arg_7_1)
	return ActivityArtifactLevelCfg[arg_7_0.levelId_[arg_7_1]].name
end

function var_0_0.GetLevelDesc(arg_8_0, arg_8_1)
	return ActivityArtifactLevelCfg[arg_8_0.levelId_[arg_8_1]].desc
end

function var_0_0.GetIsOpenByIndex(arg_9_0, arg_9_1)
	return ActivityData:GetActivityIsOpen(arg_9_0.levelId_[arg_9_1])
end

function var_0_0.GetAwardListByIndex(arg_10_0, arg_10_1)
	return arg_10_0.awardsList_[arg_10_1]
end

function var_0_0.GetLevelIdByStageId(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.levelId_) do
		if ActivityArtifactLevelCfg[iter_11_1].stage_id == arg_11_1 then
			return iter_11_1
		end
	end

	return nil
end

function var_0_0.GetCurLevelIndex(arg_12_0)
	return arg_12_0.curLevelIndex_
end

function var_0_0.SetCurLevelIndex(arg_13_0, arg_13_1)
	arg_13_0.curLevelIndex_ = arg_13_1
end

function var_0_0.SetSelectedByIndex(arg_14_0, arg_14_1)
	arg_14_0.selectedLevelList_[arg_14_1] = true
end

function var_0_0.UpdateRedPoint(arg_15_0)
	for iter_15_0 = 1, arg_15_0.levelCount_ do
		local var_15_0 = false

		if ActivityData:GetActivityIsOpen(arg_15_0.levelId_[iter_15_0]) and arg_15_0.selectedLevelList_[iter_15_0] == nil and arg_15_0.curAwardedLevelList_[iter_15_0] == false then
			var_15_0 = true
		end

		if var_15_0 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ARTIFACT, arg_15_0.levelId_[iter_15_0]), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ARTIFACT, arg_15_0.levelId_[iter_15_0]), 0)
		end
	end
end

function var_0_0.InitRedPoint(arg_16_0, arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0.levelId_) do
		table.insert(var_16_0, string.format("%s_%s", RedPointConst.ARTIFACT, iter_16_1))
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ARTIFACT, ActivityConst.SUMMER_ARTIFACT), var_16_0)
end

return var_0_0
