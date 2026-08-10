local var_0_0 = class("ChallengeRogueTeamIllustratedData")

function var_0_0.ExportMethod(arg_1_0)
	return {
		"UpdateIllustrated",
		"UpdateUnlockIllustrated",
		"GetIllustratedDataByType",
		"GetAllItemIDByTempAndType",
		"GetUnlockIllustratedTreasureDataByCamp",
		"IsIllustratedUnlock",
		"IsIllustratedObtained",
		"GetAllCollectionTaskByType",
		"GetTreasureCollectionTaskByCamp",
		"UpdateViewedIllustrated",
		"IsIllustratedViewd"
	}
end

function var_0_0.Init(arg_2_0)
	arg_2_0.obtainedIllustratedDataList_ = {}
	arg_2_0.unlockIllustratedDataList_ = {}
	arg_2_0.viewdIllustratedDataList_ = {}
end

function var_0_0.UpdateIllustrated(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0.obtainedIllustratedDataList_[arg_3_1] then
		arg_3_0.obtainedIllustratedDataList_[arg_3_1] = {}
	end

	local var_3_0 = arg_3_0.obtainedIllustratedDataList_[arg_3_1]

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		if not var_3_0[iter_3_1.type] then
			var_3_0[iter_3_1.type] = {}
		end

		local var_3_1 = var_3_0[iter_3_1.type]

		for iter_3_2, iter_3_3 in ipairs(iter_3_1.item_list) do
			if not table.indexof(var_3_1, iter_3_3) then
				table.insert(var_3_1, iter_3_3)
			end
		end
	end
end

function var_0_0.UpdateUnlockIllustrated(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.unlockIllustratedDataList_[arg_4_1] then
		arg_4_0.unlockIllustratedDataList_[arg_4_1] = {}
	end

	local var_4_0 = arg_4_0.unlockIllustratedDataList_[arg_4_1]

	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		local var_4_1 = RogueTeamItemCfg[iter_4_1]

		if not var_4_0[var_4_1.type] then
			var_4_0[var_4_1.type] = {}
		end

		local var_4_2 = var_4_0[var_4_1.type]

		if not table.indexof(var_4_2, iter_4_1) then
			table.insert(var_4_2, iter_4_1)
		end
	end
end

function var_0_0.UpdateViewedIllustrated(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.viewdIllustratedDataList_[arg_5_1] then
		arg_5_0.viewdIllustratedDataList_[arg_5_1] = {}
	end

	local var_5_0 = arg_5_0.viewdIllustratedDataList_[arg_5_1]

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_1 = RogueTeamItemCfg[iter_5_1]

		if not var_5_0[var_5_1.type] then
			var_5_0[var_5_1.type] = {}
		end

		local var_5_2 = var_5_0[var_5_1.type]

		if not table.indexof(var_5_2, iter_5_1) then
			table.insert(var_5_2, iter_5_1)
		end
	end
end

function var_0_0.GetIllustratedDataByType(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	if arg_6_0.obtainedIllustratedDataList_[arg_6_1] and arg_6_0.obtainedIllustratedDataList_[arg_6_1][arg_6_2] then
		var_6_0 = arg_6_0.obtainedIllustratedDataList_[arg_6_1][arg_6_2]
	end

	return var_6_0
end

function var_0_0.GetUnlockIllustratedDataByType(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}

	if arg_7_0.unlockIllustratedDataList_[arg_7_1] and arg_7_0.unlockIllustratedDataList_[arg_7_1][arg_7_2] then
		var_7_0 = arg_7_0.unlockIllustratedDataList_[arg_7_1][arg_7_2]
	end

	return var_7_0
end

function var_0_0.GetViewedIllustratedDataByType(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	if arg_8_0.viewdIllustratedDataList_[arg_8_1] and arg_8_0.viewdIllustratedDataList_[arg_8_1][arg_8_2] then
		var_8_0 = arg_8_0.viewdIllustratedDataList_[arg_8_1][arg_8_2]
	end

	return var_8_0
end

function var_0_0.IsIllustratedUnlock(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:GetUnlockIllustratedDataByType(arg_9_1, arg_9_2)

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1 == arg_9_3 then
			return true
		end
	end

	return false
end

function var_0_0.IsIllustratedViewd(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:GetViewedIllustratedDataByType(arg_10_1, arg_10_2)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1 == arg_10_3 then
			return true
		end
	end

	return false
end

function var_0_0.IsIllustratedObtained(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:GetIllustratedDataByType(arg_11_1, arg_11_2)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1 == arg_11_3 then
			return true
		end
	end

	return false
end

function var_0_0.GetUnlockIllustratedTreasureDataByCamp(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}
	local var_12_1 = arg_12_0:GetIllustratedDataByType(arg_12_1, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP)

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = RogueTeamItemCfg[iter_12_1]

		for iter_12_2, iter_12_3 in ipairs(var_12_2.camp) do
			if iter_12_3 == arg_12_2 then
				table.insert(var_12_0, iter_12_1)

				break
			end
		end
	end

	return var_12_0
end

function var_0_0.GetAllItemIDByTempAndType(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}
	local var_13_1 = RogueTeamItemCfg.get_id_list_by_type[arg_13_2]

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		if RogueTeamItemCfg[iter_13_1].item_temp == arg_13_1 then
			table.insert(var_13_0, iter_13_1)
		end
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end)

	return var_13_0
end

function var_0_0.GetAllCollectionTaskByType(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = RogueTeamCfg[arg_15_1].activity_id
	local var_15_1 = ActivityCfg[var_15_0].sub_activity_list[#ActivityCfg[var_15_0].sub_activity_list]
	local var_15_2 = ActivityCfg[var_15_1].sub_activity_list[arg_15_2]

	return AssignmentCfg.get_id_list_by_activity_id[var_15_2] or {}
end

function var_0_0.GetTreasureCollectionTaskByCamp(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = RogueTeamCfg[arg_16_1].activity_id
	local var_16_1 = ActivityCfg[var_16_0].sub_activity_list[#ActivityCfg[var_16_0].sub_activity_list]
	local var_16_2 = ActivityCfg[var_16_1].sub_activity_list[ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.CAMP]
	local var_16_3 = ActivityCfg[var_16_2].sub_activity_list[arg_16_2]

	return AssignmentCfg.get_id_list_by_activity_id[var_16_3] or {}
end

return var_0_0
