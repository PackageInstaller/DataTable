local var_0_0 = class("BattleMatrixStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.cfg = BattleMatrixStageCfg[arg_1_1]
	arg_1_0.heroList = MatrixData:GetMatrixBattleHeroTeam()
	arg_1_0.systemHeroList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.heroList) do
		local var_1_0 = MatrixData:GetHeroData(iter_1_1)

		if var_1_0 and var_1_0:GetStandardId() ~= 0 then
			arg_1_0.systemHeroList[iter_1_0] = var_1_0:GetStandardId()
		end
	end

	arg_1_0.roleDataInLua = {}

	arg_1_0:InitChipData()
	arg_1_0:InitComboSkill()
end

function var_0_0.GetDest(arg_2_0)
	return arg_2_0.id
end

function var_0_0.GetStageId(arg_3_0)
	return arg_3_0.id
end

function var_0_0.GetType(arg_4_0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX
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
	local var_8_3 = MatrixData:GetTotalAffix()

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
	local var_11_0 = MatrixData:GetTierID()
	local var_11_1 = MatrixData:GetDifficulty()
	local var_11_2 = MatrixTierCfg[var_11_0]

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

	local var_12_0 = MatrixData:GetMatrixBattleHeroTeam()

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		local var_12_1 = MatrixData:GetHeroData(iter_12_1)

		if not var_12_1:IsDead() then
			local var_12_2 = BattleController.GetInstance():SetMatrixHeroData(var_12_1, arg_12_1.playerID, arg_12_1.level, arg_12_0.matrix_activity_id)

			table.insert(arg_12_0.roleDataInLua, var_12_2)
		end
	end

	arg_12_0:SetMaxRaceData()
end

function var_0_0.GetRoleDatas(arg_13_0)
	return arg_13_0.roleDataInLua
end

function var_0_0.InitChipData(arg_14_0)
	arg_14_0.chipManagerID_ = MatrixData:GetChipManagerID()
	arg_14_0.chipList_ = MatrixData:GetChipList()
end

function var_0_0.InitComboSkill(arg_15_0)
	arg_15_0.comboSkillID_ = ComboSkillData:GetComboSkillID(arg_15_0:GetType(), arg_15_0:GetActivityID(), 1)
end

return var_0_0
