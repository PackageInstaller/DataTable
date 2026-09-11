local BattleMatrixStageTemplate = class("BattleMatrixStageTemplate", BattleBaseStageTemplate)

function BattleMatrixStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleMatrixStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.matrix_activity_id = arg_1_2
	self.activityID_ = arg_1_2
	self.cfg = BattleActivityMatrixCfg[arg_1_1] or BattleMatrixStageCfg[arg_1_1]
	self.heroList = ActivityMatrixData:GetMatrixBattleHeroTeam(arg_1_2)
	self.systemHeroList = {}

	for iter_1_0, iter_1_1 in ipairs(self.heroList) do
		local var_1_0 = ActivityMatrixData:GetHeroData(arg_1_2, iter_1_1)

		if var_1_0 and var_1_0:GetStandardId() ~= 0 then
			self.systemHeroList[iter_1_0] = var_1_0:GetStandardId()
		end
	end

	self.roleDataInLua = {}

	self:InitChipData()
end

function BattleMatrixStageTemplate:GetDest()
	return self.id
end

function BattleMatrixStageTemplate:GetStageId()
	return self.id
end

function BattleMatrixStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX
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

	for iter_8_0, iter_8_1 in pairs(ActivityMatrixData:GetTotalAffix(self.matrix_activity_id) or {}) do
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
	local var_11_0 = ActivityMatrixTierTemplateCfg[ActivityMatrixData:GetTierID(self.matrix_activity_id)]

	if var_11_0 and var_11_0.monster_level_coefficient[1] then
		local var_11_1 = var_11_0.monster_level_coefficient[1]
		local var_11_2

		if var_11_0.monster_level_coefficient[1][1] then
			var_11_2 = var_11_1[1] / 1000 or 1

			local var_11_3

			if var_11_1[2] then
				var_11_3 = var_11_1[2] / 1000 or 1
			end
		end

		return Vector3.New(var_11_2, 1, var_11_3)
	end

	return Vector3.New(1, 1, 1)
end

function BattleMatrixStageTemplate:UpdateRoleDatas(arg_12_1)
	self.serverTeamPlayer = arg_12_1
	self.roleDataInLua = {}

	for iter_12_0, iter_12_1 in pairs((ActivityMatrixData:GetMatrixBattleHeroTeam(self.matrix_activity_id))) do
		local var_12_0 = ActivityMatrixData:GetHeroData(self.matrix_activity_id, iter_12_1)

		if not var_12_0:IsDead() then
			table.insert(self.roleDataInLua, (BattleController.GetInstance():SetMatrixHeroData(var_12_0, arg_12_1.playerID, arg_12_1.level)))
		end
	end

	self:SetMaxRaceData()
end

function BattleMatrixStageTemplate:GetRoleDatas()
	return self.roleDataInLua
end

return BattleMatrixStageTemplate
