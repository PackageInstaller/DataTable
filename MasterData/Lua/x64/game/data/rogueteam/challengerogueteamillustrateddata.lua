local ChallengeRogueTeamIllustratedData = class("ChallengeRogueTeamIllustratedData")

function ChallengeRogueTeamIllustratedData:ExportMethod()
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

function ChallengeRogueTeamIllustratedData:Init()
	self.obtainedIllustratedDataList_ = {}
	self.unlockIllustratedDataList_ = {}
	self.viewdIllustratedDataList_ = {}
end

function ChallengeRogueTeamIllustratedData:UpdateIllustrated(arg_3_1, arg_3_2)
	self.obtainedIllustratedDataList_[arg_3_1] = self.obtainedIllustratedDataList_[arg_3_1] or {}

	local var_3_0 = self.obtainedIllustratedDataList_[arg_3_1]

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		var_3_0[iter_3_1.type] = var_3_0[iter_3_1.type] or {}

		local var_3_1 = var_3_0[iter_3_1.type]

		for iter_3_2, iter_3_3 in ipairs(iter_3_1.item_list) do
			if not table.indexof(var_3_1, iter_3_3) then
				table.insert(var_3_1, iter_3_3)
			end
		end
	end
end

function ChallengeRogueTeamIllustratedData:UpdateUnlockIllustrated(arg_4_1, arg_4_2)
	self.unlockIllustratedDataList_[arg_4_1] = self.unlockIllustratedDataList_[arg_4_1] or {}

	local var_4_0 = self.unlockIllustratedDataList_[arg_4_1]

	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		var_4_0[RogueTeamItemCfg[iter_4_1].type] = var_4_0[RogueTeamItemCfg[iter_4_1].type] or {}

		if not table.indexof(var_4_0[RogueTeamItemCfg[iter_4_1].type], iter_4_1) then
			table.insert(var_4_0[RogueTeamItemCfg[iter_4_1].type], iter_4_1)
		end
	end
end

function ChallengeRogueTeamIllustratedData:UpdateViewedIllustrated(arg_5_1, arg_5_2)
	self.viewdIllustratedDataList_[arg_5_1] = self.viewdIllustratedDataList_[arg_5_1] or {}

	local var_5_0 = self.viewdIllustratedDataList_[arg_5_1]

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		var_5_0[RogueTeamItemCfg[iter_5_1].type] = var_5_0[RogueTeamItemCfg[iter_5_1].type] or {}

		if not table.indexof(var_5_0[RogueTeamItemCfg[iter_5_1].type], iter_5_1) then
			table.insert(var_5_0[RogueTeamItemCfg[iter_5_1].type], iter_5_1)
		end
	end
end

function ChallengeRogueTeamIllustratedData:GetIllustratedDataByType(arg_6_1, arg_6_2)
	return (self.obtainedIllustratedDataList_[arg_6_1] and self.obtainedIllustratedDataList_[arg_6_1][arg_6_2] or nil) and self.obtainedIllustratedDataList_[arg_6_1][arg_6_2]
end

function ChallengeRogueTeamIllustratedData:GetUnlockIllustratedDataByType(arg_7_1, arg_7_2)
	return (self.unlockIllustratedDataList_[arg_7_1] and self.unlockIllustratedDataList_[arg_7_1][arg_7_2] or nil) and self.unlockIllustratedDataList_[arg_7_1][arg_7_2]
end

function ChallengeRogueTeamIllustratedData:GetViewedIllustratedDataByType(arg_8_1, arg_8_2)
	return (self.viewdIllustratedDataList_[arg_8_1] and self.viewdIllustratedDataList_[arg_8_1][arg_8_2] or nil) and self.viewdIllustratedDataList_[arg_8_1][arg_8_2]
end

function ChallengeRogueTeamIllustratedData:IsIllustratedUnlock(arg_9_1, arg_9_2, arg_9_3)
	for iter_9_0, iter_9_1 in ipairs((self:GetUnlockIllustratedDataByType(arg_9_1, arg_9_2))) do
		if iter_9_1 == arg_9_3 then
			return true
		end
	end

	return false
end

function ChallengeRogueTeamIllustratedData:IsIllustratedViewd(arg_10_1, arg_10_2, arg_10_3)
	for iter_10_0, iter_10_1 in ipairs((self:GetViewedIllustratedDataByType(arg_10_1, arg_10_2))) do
		if iter_10_1 == arg_10_3 then
			return true
		end
	end

	return false
end

function ChallengeRogueTeamIllustratedData:IsIllustratedObtained(arg_11_1, arg_11_2, arg_11_3)
	for iter_11_0, iter_11_1 in ipairs((self:GetIllustratedDataByType(arg_11_1, arg_11_2))) do
		if iter_11_1 == arg_11_3 then
			return true
		end
	end

	return false
end

function ChallengeRogueTeamIllustratedData:GetUnlockIllustratedTreasureDataByCamp(arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs((self:GetIllustratedDataByType(arg_12_1, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP))) do
		for iter_12_2, iter_12_3 in ipairs(RogueTeamItemCfg[iter_12_1].camp) do
			if iter_12_3 == arg_12_2 then
				table.insert(var_12_0, iter_12_1)

				break
			end
		end
	end

	return var_12_0
end

function ChallengeRogueTeamIllustratedData:GetAllItemIDByTempAndType(arg_13_1, arg_13_2)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(RogueTeamItemCfg.get_id_list_by_type[arg_13_2]) do
		if RogueTeamItemCfg[iter_13_1].item_temp == arg_13_1 then
			table.insert(var_13_0, iter_13_1)
		end
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end)

	return var_13_0
end

function ChallengeRogueTeamIllustratedData:GetAllCollectionTaskByType(arg_15_1, arg_15_2)
	return AssignmentCfg.get_id_list_by_activity_id[ActivityCfg[ActivityCfg[RogueTeamCfg[arg_15_1].activity_id].sub_activity_list[#ActivityCfg[RogueTeamCfg[arg_15_1].activity_id].sub_activity_list]].sub_activity_list[arg_15_2]] or {}
end

function ChallengeRogueTeamIllustratedData:GetTreasureCollectionTaskByCamp(arg_16_1, arg_16_2)
	return AssignmentCfg.get_id_list_by_activity_id[ActivityCfg[ActivityCfg[ActivityCfg[RogueTeamCfg[arg_16_1].activity_id].sub_activity_list[#ActivityCfg[RogueTeamCfg[arg_16_1].activity_id].sub_activity_list]].sub_activity_list[ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.CAMP]].sub_activity_list[arg_16_2]] or {}
end

return ChallengeRogueTeamIllustratedData
