local var_0_0 = singletonClass("DamageTestData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0:SetSelectAffix(arg_2_1, arg_2_2, arg_2_3)
	var_0_1[arg_2_1] = var_0_1[arg_2_1] or {
		[BossConst.TYPE_STAGE] = {},
		[BossConst.TYPE_AFFIX] = {}
	}

	if self:IsActiveBossCondition(arg_2_1, arg_2_2, arg_2_3) then
		table.removebyvalue(var_0_1[arg_2_1][arg_2_2], arg_2_3)

		return
	end

	if arg_2_2 == BossConst.TYPE_STAGE then
		self:SetBossConditionStage(arg_2_1, arg_2_3)
	else
		self:SetBossAffix(arg_2_1, arg_2_3)
	end
end

function var_0_0.IsActiveBossCondition(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	return table.keyof(var_0_1[arg_3_1][arg_3_2], arg_3_3) ~= nil
end

function var_0_0.SetBossConditionStage(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in pairs(var_0_1[arg_4_1][BossConst.TYPE_STAGE]) do
		if StageChallengeConditionPoolCfg[arg_4_2].condition[1] == StageChallengeConditionPoolCfg[iter_4_1].condition[1] then
			table.remove(var_0_1[arg_4_1][BossConst.TYPE_STAGE], iter_4_0)

			break
		end
	end

	table.insert(var_0_1[arg_4_1][BossConst.TYPE_STAGE], arg_4_2)
end

function var_0_0.SetBossAffix(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(var_0_1[arg_5_1][BossConst.TYPE_AFFIX]) do
		if ActivityAffixPoolCfg[arg_5_2].affix[1] == ActivityAffixPoolCfg[iter_5_1].affix[1] then
			table.remove(var_0_1[arg_5_1][BossConst.TYPE_AFFIX], iter_5_0)

			break
		end
	end

	table.insert(var_0_1[arg_5_1][BossConst.TYPE_AFFIX], arg_5_2)
end

function var_0_0.GetAffixList(arg_6_0, arg_6_1, arg_6_2)
	if var_0_1[arg_6_1] and var_0_1[arg_6_1][arg_6_2] then
		return var_0_1[arg_6_1][arg_6_2]
	end

	return {}
end

return var_0_0
