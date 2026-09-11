local BattleMatrixStageTemplate = class("BattleMatrixStageTemplate", BattleBaseStageTemplate)

function BattleMatrixStageTemplate:Ctor(arg_1_1)
	BattleMatrixStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleMatrixStageCfg[arg_1_1]
	self.heroList = MatrixData:GetMatrixBattleHeroTeam()
	self.systemHeroList = {}

	for iter_1_0, iter_1_1 in ipairs(self.heroList) do
		local var_1_0 = MatrixData:GetHeroData(iter_1_1)

		if var_1_0 and var_1_0:GetStandardId() ~= 0 then
			self.systemHeroList[iter_1_0] = var_1_0:GetStandardId()
		end
	end

	self.roleDataInLua = {}

	self:InitChipData()
	self:InitComboSkill()
end

function BattleMatrixStageTemplate:GetDest()
	return self.id
end

function BattleMatrixStageTemplate:GetStageId()
	return self.id
end

function BattleMatrixStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX
end

function BattleMatrixStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleMatrixStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleMatrixStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleMatrixStageTemplate:GetStageAffix()
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}

	for iter_8_0, iter_8_1 in pairs(MatrixData:GetTotalAffix() or {}) do
		table.insert(var_8_0, iter_8_1[1])
		table.insert(var_8_1, iter_8_1[2])
		table.insert(var_8_2, iter_8_1[3])
	end

	return var_8_0, var_8_1, var_8_2
end

function BattleMatrixStageTemplate:GetHeroTeam()
	return self.heroList, {}
end

function BattleMatrixStageTemplate:GetSystemHeroTeam()
	return self.systemHeroList
end

function BattleMatrixStageTemplate:GetAttributeFactor()
	local var_11_0 = MatrixData:GetDifficulty()
	local var_11_1 = MatrixTierCfg[MatrixData:GetTierID()]

	if var_11_1 and var_11_1.monster_level_coefficient[var_11_0] then
		local var_11_2 = var_11_1.monster_level_coefficient[var_11_0]
		local var_11_3

		if var_11_1.monster_level_coefficient[var_11_0][1] then
			var_11_3 = var_11_2[1] / 1000 or 1

			local var_11_4

			if var_11_2[2] then
				var_11_4 = var_11_2[2] / 1000 or 1
			end
		end

		return Vector3.New(var_11_3, 1, var_11_4)
	end

	return Vector3.New(1, 1, 1)
end

function BattleMatrixStageTemplate:UpdateRoleDatas(arg_12_1)
	self.serverTeamPlayer = arg_12_1
	self.roleDataInLua = {}

	for iter_12_0, iter_12_1 in pairs((MatrixData:GetMatrixBattleHeroTeam())) do
		local var_12_0 = MatrixData:GetHeroData(iter_12_1)

		if not var_12_0:IsDead() then
			table.insert(self.roleDataInLua, (BattleController.GetInstance():SetMatrixHeroData(var_12_0, arg_12_1.playerID, arg_12_1.level, self.matrix_activity_id)))
		end
	end

	self:SetMaxRaceData()
end

function BattleMatrixStageTemplate:GetRoleDatas()
	return self.roleDataInLua
end

function BattleMatrixStageTemplate:InitChipData()
	self.chipManagerID_ = MatrixData:GetChipManagerID()
	self.chipList_ = MatrixData:GetChipList()
end

function BattleMatrixStageTemplate:InitComboSkill()
	self.comboSkillID_ = ComboSkillData:GetComboSkillID(self:GetType(), self:GetActivityID(), 1)
end

return BattleMatrixStageTemplate
