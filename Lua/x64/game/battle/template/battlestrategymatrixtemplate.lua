local var_0_0 = class("BattleStrategyMatrixTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.matrix_activity_id = arg_1_2
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.tier = arg_1_3
	arg_1_0.cfg = BattleStrategyMatrixCfg[arg_1_1]
	arg_1_0.heroList = StrategyMatrixData:GetMatrixBattleHeroTeam(arg_1_2)
	arg_1_0.systemHeroList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.heroList) do
		local var_1_0 = StrategyMatrixData:GetHeroData(iter_1_1)

		if var_1_0 and var_1_0.tempID ~= 0 then
			arg_1_0.systemHeroList[iter_1_0] = var_1_0.tempID
		end
	end

	arg_1_0.roleDataInLua = {}

	arg_1_0:InitChipData()
end

function var_0_0.GetDest(arg_2_0)
	return arg_2_0.id
end

function var_0_0.GetStageId(arg_3_0)
	return arg_3_0.id
end

function var_0_0.GetType(arg_4_0)
	return BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX
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

function var_0_0.GetStageAffix(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = StrategyMatrixData:GetTotalAffix(arg_8_0.matrix_activity_id)

	for iter_8_0, iter_8_1 in pairs(var_8_3 or {}) do
		table.insert(var_8_0, iter_8_1[1])
		table.insert(var_8_1, iter_8_1[2])
		table.insert(var_8_2, iter_8_1[3])
	end

	return var_8_0, var_8_1, var_8_2
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList, {}
end

function var_0_0.GetSystemHeroTeam(arg_10_0)
	return arg_10_0.systemHeroList
end

function var_0_0.GetAttributeFactor(arg_11_0)
	local var_11_0 = StrategyMatrixData:GetTierID(arg_11_0.matrix_activity_id)
	local var_11_1 = 1
	local var_11_2 = StrategyMatrixTierTemplateCfg[var_11_0]

	if var_11_2 and var_11_2.monster_level_coefficient[var_11_1] then
		local var_11_3 = var_11_2.monster_level_coefficient[var_11_1]
		local var_11_4 = var_11_3[1] and var_11_3[1] / 1000 or 1
		local var_11_5 = var_11_3[2] and var_11_3[2] / 1000 or 1

		return Vector3.New(var_11_4, 1, var_11_5)
	end

	return Vector3.New(1, 1, 1)
end

function var_0_0.UpdateRoleDatas(arg_12_0, arg_12_1)
	arg_12_0.serverTeamPlayer = arg_12_1
	arg_12_0.roleDataInLua = {}

	local var_12_0 = StrategyMatrixData:GetMatrixBattleHeroTeam(arg_12_0.matrix_activity_id)

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		local var_12_1 = StrategyMatrixData:GetHeroDataNew(iter_12_1)

		if not var_12_1:IsDead() then
			local var_12_2 = BattleController.GetInstance():SetMatrixHeroData(var_12_1, arg_12_1.playerID, arg_12_1.level, arg_12_0.matrix_activity_id)

			table.insert(arg_12_0.roleDataInLua, var_12_2)
		end
	end

	arg_12_0:SetMaxRaceData()
	arg_12_0:SetMaxRaceData()
end

function var_0_0.GetRoleDatas(arg_13_0)
	return arg_13_0.roleDataInLua
end

function var_0_0.InitChipData(arg_14_0)
	arg_14_0.chipManagerID_ = 0
	arg_14_0.chipList_ = {}
end

return var_0_0
