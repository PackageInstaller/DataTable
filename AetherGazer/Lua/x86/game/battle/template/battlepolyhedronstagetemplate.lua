local var_0_0 = class("BattlePolyhedronStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.cfg = BattlePolyhedronStageCfg[arg_1_0.id]

	if not arg_1_0.cfg then
		error(string.format("找不到stageId为 %s 的关卡，请检查配置！！！！！！！", tostring(arg_1_0.id)))
	end

	arg_1_0.heroList = {}
	arg_1_0.systemHeroList = {}
	arg_1_0.heroTrialList_ = {}

	arg_1_0:InitComboSkillID()
	arg_1_0:InitChipData()
	arg_1_0:InitSystemHeroList()

	arg_1_0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
end

function var_0_0.GetDest(arg_2_0)
	return arg_2_0.id
end

function var_0_0.GetStageId(arg_3_0)
	return arg_3_0.id
end

function var_0_0.GetType(arg_4_0)
	return BattleConst.STAGE_TYPE_NEW.POLYHEDRON
end

function var_0_0.GetMap(arg_5_0)
	return arg_5_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_6_0)
	return arg_6_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_7_0)
	return arg_7_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_8_0)
	return arg_8_0.heroList, arg_8_0.heroTrialList_
end

function var_0_0.GetSystemHeroTeam(arg_9_0)
	return arg_9_0.systemHeroList
end

function var_0_0.GetRevive(arg_10_0)
	local var_10_0, var_10_1 = arg_10_0.polyhedronInfo:GetReviveCount()

	return true, 0, var_10_0, 1, var_10_1
end

function var_0_0.GetAttributeFactor(arg_11_0)
	local var_11_0 = arg_11_0.polyhedronInfo:GetTierId()
	local var_11_1 = PolyhedronTierCfg[var_11_0]
	local var_11_2 = 1
	local var_11_3 = 1
	local var_11_4 = 1

	if var_11_1 and var_11_1.monster_level_coefficient then
		local var_11_5 = var_11_1.monster_level_coefficient
		local var_11_6 = var_11_5[1] and var_11_5[1] / 1000 or 1

		var_11_4, var_11_2 = var_11_5[2] and var_11_5[2] / 1000 or 1, var_11_6
	end

	local var_11_7 = PolyhedronData:GetPolyhedronInfo().difficulty

	for iter_11_0 = 1, var_11_7 do
		local var_11_8 = PolyhedronDifficultyCfg[iter_11_0].params

		for iter_11_1, iter_11_2 in ipairs(var_11_8) do
			if iter_11_2[1] == 2 then
				local var_11_9 = iter_11_2[2]
				local var_11_10 = iter_11_2[3] / 1000

				if var_11_9 == 11 then
					var_11_2 = var_11_2 * (1 + var_11_10)
				elseif var_11_9 == 21 then
					var_11_3 = var_11_3 * (1 + var_11_10)
				elseif var_11_9 == 31 then
					var_11_4 = var_11_4 * (1 + var_11_10)
				end
			end
		end
	end

	return (Vector3.New(var_11_2, var_11_3, var_11_4))
end

function var_0_0.UpdateRoleDatas(arg_12_0, arg_12_1)
	arg_12_0.serverTeamPlayer = arg_12_1

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_1.heroList) do
		var_12_0[iter_12_1.id] = iter_12_1
	end

	arg_12_0.roleDataInLua = {}

	local var_12_1 = PolyhedronData:GetPolyhedronInfo()
	local var_12_2 = var_12_1:GetPolyhedronLeader()
	local var_12_3 = var_12_1:GetLeaderHeroId()
	local var_12_4 = PolyhedronHeroCfg[var_12_3]
	local var_12_5 = BattleController.GetInstance():SetPolyhedronHeroData(var_12_1, var_12_0[var_12_3], var_12_2, var_12_4.standard_id, arg_12_1.playerID, arg_12_1.level)

	table.insert(arg_12_0.roleDataInLua, var_12_5)

	local var_12_6 = var_12_1:GetFightHeroList()

	for iter_12_2, iter_12_3 in ipairs(var_12_6) do
		if not var_12_1:GetHeroPolyData(iter_12_3):IsDead() and iter_12_3 ~= var_12_3 then
			local var_12_7 = PolyhedronHeroCfg[iter_12_3]
			local var_12_8 = BattleController.GetInstance():SetPolyhedronHeroData(var_12_1, var_12_0[iter_12_3], nil, var_12_7.standard_id, arg_12_1.playerID, arg_12_1.level)

			table.insert(arg_12_0.roleDataInLua, var_12_8)
		end
	end

	arg_12_0:SetMaxRaceData()
end

function var_0_0.GetStageAffix(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = arg_13_0.polyhedronInfo:GetTotalAffix()

	for iter_13_0, iter_13_1 in pairs(var_13_3 or {}) do
		table.insert(var_13_0, iter_13_1[1])
		table.insert(var_13_1, iter_13_1[2])
		table.insert(var_13_2, iter_13_1[3])
	end

	return var_13_0, var_13_1, var_13_2
end

function var_0_0.GetResurrectHP(arg_14_0)
	return arg_14_0.polyhedronInfo:GetReviveHp()
end

function var_0_0.GetResurrectImmediately(arg_15_0)
	return true
end

function var_0_0.GetTargetEnemyID(arg_16_0)
	local var_16_0 = arg_16_0.polyhedronInfo:GetRewardType()

	if PolyhedronConst.REWARD_TYEP.TEAMMATE == var_16_0 then
		local var_16_1 = arg_16_0.polyhedronInfo:GetEnlistHeroList()

		for iter_16_0, iter_16_1 in ipairs(var_16_1) do
			if iter_16_1.enlist_type == PolyhedronConst.ENLIST_TYPE.BATTLE then
				return PolyhedronHeroCfg[iter_16_1.heroId].target_enemy
			end
		end
	end

	return 5050
end

function var_0_0.GetActivityID(arg_17_0)
	return PolyhedronData:GetActivityID() or 0
end

function var_0_0.InitComboSkillID(arg_18_0)
	arg_18_0.comboSkillID_ = BattleTeamData:GetComboInfo(arg_18_0:GetType(), arg_18_0:GetActivityID())
end

function var_0_0.InitSystemHeroList(arg_19_0)
	local var_19_0 = PolyhedronData:GetPolyhedronInfo()
	local var_19_1 = var_19_0:GetPolyhedronLeader()
	local var_19_2 = var_19_0:GetLeaderHeroId()
	local var_19_3 = PolyhedronHeroCfg[var_19_2]

	table.insert(arg_19_0.systemHeroList, var_19_3.standard_id)

	local var_19_4 = var_19_0:GetFightHeroList()

	for iter_19_0, iter_19_1 in ipairs(var_19_4) do
		if not var_19_0:GetHeroPolyData(iter_19_1):IsDead() and iter_19_1 ~= var_19_2 then
			local var_19_5 = PolyhedronHeroCfg[iter_19_1]

			table.insert(arg_19_0.systemHeroList, var_19_5.standard_id)
		end
	end
end

return var_0_0
