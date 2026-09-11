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

function var_0_0:GetTalentIdList()
	return TalentTreeCfg.get_id_list_by_activity_id[self:GetActivityId()]
end

function var_0_0.GetTalentLevel(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1] or 0
end

function var_0_0:GetTalentMaxLevel(arg_6_1)
	if TalentTreeCfg[arg_6_1].activity_id ~= self:GetActivityId() then
		return 0
	end

	return TalentTreeCfg[arg_6_1].max_level
end

function var_0_0:IsTalentMaxLevel(arg_7_1)
	return self:GetTalentLevel(arg_7_1) >= self:GetTalentMaxLevel(arg_7_1)
end

function var_0_0:IsTalentLocked(arg_8_1)
	return self:GetTalentLevel(arg_8_1) == 0
end

function var_0_0:CanUpgrade(arg_9_1)
	if TalentTreeCfg[arg_9_1].activity_id ~= self:GetActivityId() then
		return false
	end

	local var_9_0 = self:GetTalentLevel(arg_9_1)

	if var_9_0 >= self:GetTalentMaxLevel(arg_9_1) then
		return false
	end

	return self:IsConditionAchieved((self:GetTalentConditionId(arg_9_1, var_9_0 + 1)))
end

function var_0_0.GetTalentConditionId(arg_10_0, arg_10_1, arg_10_2)
	return TalentTreeCfg[arg_10_1].unlock_condition[arg_10_2]
end

function var_0_0.IsConditionAchieved(arg_11_0, arg_11_1)
	local var_11_0 = ConditionCfg[arg_11_1].params

	if ConditionCfg[arg_11_1].type == 1020 then
		local var_11_1 = HeroData:GetHeroData(var_11_0[1])

		if var_11_1.unlock == 0 then
			return false
		end

		return var_11_1.star / 100 >= var_11_0[2]
	elseif ConditionCfg[arg_11_1].type == 2510 then
		return KagutsuchiWorkData:GetTotalCoins() >= var_11_0[1]
	end

	return false
end

function var_0_0.GetActivityId(arg_12_0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

return var_0_0
