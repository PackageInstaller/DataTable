local var_0_0 = singletonClass("KagutsuchiTalentData")
local var_0_1 = {}

function var_0_0.InitData(arg_1_0, arg_1_1)
	var_0_1 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.talent_list) do
		var_0_1[iter_1_1.id] = iter_1_1.level
	end
end

function var_0_0.UpgradeTalent(arg_2_0, arg_2_1)
	var_0_1[arg_2_1] = (var_0_1[arg_2_1] or 0) + 1
end

function var_0_0.GetUnlockTalentIdList(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(var_0_1) do
		table.insert(var_3_0, iter_3_0)
	end

	return var_3_0
end

function var_0_0.GetTalentIdList(arg_4_0)
	return TalentTreeCfg.get_id_list_by_activity_id[arg_4_0:GetActivityId()]
end

function var_0_0.GetTalentLevel(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1] or 0
end

function var_0_0.GetTalentMaxLevel(arg_6_0, arg_6_1)
	if TalentTreeCfg[arg_6_1].activity_id ~= arg_6_0:GetActivityId() then
		return 0
	end

	return TalentTreeCfg[arg_6_1].max_level
end

function var_0_0.IsTalentMaxLevel(arg_7_0, arg_7_1)
	return arg_7_0:GetTalentLevel(arg_7_1) >= arg_7_0:GetTalentMaxLevel(arg_7_1)
end

function var_0_0.IsTalentLocked(arg_8_0, arg_8_1)
	return arg_8_0:GetTalentLevel(arg_8_1) == 0
end

function var_0_0.CanUpgrade(arg_9_0, arg_9_1)
	if TalentTreeCfg[arg_9_1].activity_id ~= arg_9_0:GetActivityId() then
		return false
	end

	local var_9_0 = arg_9_0:GetTalentLevel(arg_9_1)

	if var_9_0 >= arg_9_0:GetTalentMaxLevel(arg_9_1) then
		return false
	end

	local var_9_1 = arg_9_0:GetTalentConditionId(arg_9_1, var_9_0 + 1)

	return arg_9_0:IsConditionAchieved(var_9_1)
end

function var_0_0.GetTalentConditionId(arg_10_0, arg_10_1, arg_10_2)
	return TalentTreeCfg[arg_10_1].unlock_condition[arg_10_2]
end

function var_0_0.IsConditionAchieved(arg_11_0, arg_11_1)
	local var_11_0 = ConditionCfg[arg_11_1]
	local var_11_1 = var_11_0.type
	local var_11_2 = var_11_0.params

	if var_11_1 == 1020 then
		local var_11_3 = HeroData:GetHeroData(var_11_2[1])

		if var_11_3.unlock == 0 then
			return false
		end

		return var_11_3.star / 100 >= var_11_2[2]
	elseif var_11_1 == 2510 then
		return KagutsuchiWorkData:GetTotalCoins() >= var_11_2[1]
	end

	return false
end

function var_0_0.GetActivityId(arg_12_0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

return var_0_0
