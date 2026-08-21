local var_0_0 = class("BattleGuildActivityStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleClubActivityCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.SetNodeId(arg_3_0, arg_3_1)
	arg_3_0.nodeId_ = arg_3_1
end

function var_0_0.GetNodeId(arg_4_0)
	return arg_4_0.nodeId_
end

function var_0_0.GetDest(arg_5_0)
	return arg_5_0.nodeId_
end

function var_0_0.GetStageId(arg_6_0)
	return arg_6_0.id
end

function var_0_0.GetType(arg_7_0)
	return BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY
end

function var_0_0.GetMap(arg_8_0)
	return arg_8_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_9_0)
	return arg_9_0.cfg.ai_level or 0
end

function var_0_0.GetEnemyLevel(arg_10_0)
	return arg_10_0.cfg.monster_level or 0
end

function var_0_0.GetHeroTeam(arg_11_0)
	return arg_11_0.heroList_, arg_11_0.heroTrialList_
end

function var_0_0.GetAddUserExp(arg_12_0)
	return arg_12_0.cfg.user_exp or 0
end

function var_0_0.GetAddHeroExp(arg_13_0)
	return arg_13_0.cfg.hero_exp or 0
end

function var_0_0.GetCost(arg_14_0)
	return arg_14_0.cfg.cost or 0
end

function var_0_0.GetStageAffix(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = {}
	local var_15_4 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_0.roleDataInLua) do
		local var_15_5 = SkinCfg[iter_15_1.ID].hero

		if var_15_5 ~= 0 then
			local var_15_6 = HeroCfg[var_15_5].race

			var_15_4[var_15_6] = var_15_4[var_15_6] or 0
			var_15_4[var_15_6] = var_15_4[var_15_6] + 1
		end
	end

	local var_15_7 = GuildActivityData:GetUnLockAffixList()

	for iter_15_2, iter_15_3 in pairs(var_15_7) do
		local var_15_8 = TalentTreeCfg[iter_15_2].race

		if var_15_4[var_15_8] ~= nil then
			var_15_0[iter_15_2] = var_15_4[var_15_8]

			table.insert(var_15_1, TalentTreeCfg[iter_15_2].affix_id)
			table.insert(var_15_2, iter_15_3.level)
			table.insert(var_15_3, TalentTreeCfg[iter_15_2].affix_user)
		end
	end

	GuildActivityData:SetTempEffectiveAffixList(var_15_0)

	return var_15_1, var_15_2, var_15_3
end

function var_0_0.SetPathList(arg_16_0, arg_16_1)
	arg_16_0.pathList_ = arg_16_1
end

function var_0_0.GetPathList(arg_17_0)
	return arg_17_0.pathList_ or {}
end

function var_0_0.GetAttributeFactor(arg_18_0)
	local var_18_0 = ActivityClubCfg[arg_18_0.nodeId_]

	if var_18_0.attribute_factor and var_18_0.attribute_factor[3] then
		local var_18_1 = var_18_0.attribute_factor[1] / 1000
		local var_18_2 = var_18_0.attribute_factor[2] / 1000
		local var_18_3 = var_18_0.attribute_factor[3] / 1000
		local var_18_4 = 1
		local var_18_5 = 1
		local var_18_6 = 10 - GuildActivityData:GetNodeData(arg_18_0.nodeId_).history_occupied_num

		if var_18_6 < 1 then
			var_18_6 = 1
		end

		local var_18_7 = var_18_5 * var_18_6 / 10
		local var_18_8 = var_18_4 * var_18_6 / 10
		local var_18_9 = GuildActivityData:GetSelfNodeData(arg_18_0.nodeId_)

		if var_18_9 then
			local var_18_10 = var_18_9.elite_health_rate

			if var_18_10 == 0 then
				var_18_10 = 100
			end

			var_18_8 = var_18_8 * var_18_10 / 100
		end

		local var_18_11 = var_18_1 * var_18_7
		local var_18_12 = var_18_2 * var_18_7
		local var_18_13 = var_18_3 * var_18_8

		return Vector3.New(var_18_11, var_18_12, var_18_13)
	end

	return Vector3.New(1, 1, 1)
end

return var_0_0
