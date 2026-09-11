local BattleStrategyMatrixTemplate = class("BattleStrategyMatrixTemplate", BattleBaseStageTemplate)

function BattleStrategyMatrixTemplate:Ctor(arg_1_1, arg_1_2, arg_1_3)
	BattleStrategyMatrixTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.matrix_activity_id = arg_1_2
	self.activityID_ = arg_1_2
	self.tier = arg_1_3
	self.cfg = BattleStrategyMatrixCfg[arg_1_1]
	self.heroList = StrategyMatrixData:GetMatrixBattleHeroTeam(arg_1_2)
	self.systemHeroList = {}

	for iter_1_0, iter_1_1 in ipairs(self.heroList) do
		local var_1_0 = StrategyMatrixData:GetHeroData(iter_1_1)

		if var_1_0 and var_1_0.tempID ~= 0 then
			self.systemHeroList[iter_1_0] = var_1_0.tempID
		end
	end

	self.roleDataInLua = {}

	self:InitChipData()
end

function BattleStrategyMatrixTemplate:GetDest()
	return self.id
end

function BattleStrategyMatrixTemplate:GetStageId()
	return self.id
end

function BattleStrategyMatrixTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX
end

function BattleStrategyMatrixTemplate:GetMap()
	return self.cfg.map, false
end

function BattleStrategyMatrixTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleStrategyMatrixTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleStrategyMatrixTemplate:GetStageAffix()
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}

	for iter_8_0, iter_8_1 in pairs(StrategyMatrixData:GetTotalAffix(self.matrix_activity_id) or {}) do
		table.insert(var_8_0, iter_8_1[1])
		table.insert(var_8_1, iter_8_1[2])
		table.insert(var_8_2, iter_8_1[3])
	end

	return var_8_0, var_8_1, var_8_2
end

function BattleStrategyMatrixTemplate:GetHeroTeam()
	return self.heroList, {}
end

function BattleStrategyMatrixTemplate:GetSystemHeroTeam()
	return self.systemHeroList
end

function BattleStrategyMatrixTemplate:GetAttributeFactor()
	local var_11_0 = StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(self.matrix_activity_id)]

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

function BattleStrategyMatrixTemplate:UpdateRoleDatas(arg_12_1)
	self.serverTeamPlayer = arg_12_1
	self.roleDataInLua = {}

	for iter_12_0, iter_12_1 in pairs((StrategyMatrixData:GetMatrixBattleHeroTeam(self.matrix_activity_id))) do
		local var_12_0 = StrategyMatrixData:GetHeroDataNew(iter_12_1)

		if not var_12_0:IsDead() then
			table.insert(self.roleDataInLua, (BattleController.GetInstance():SetMatrixHeroData(var_12_0, arg_12_1.playerID, arg_12_1.level, self.matrix_activity_id)))
		end
	end

	self:SetMaxRaceData()
	self:SetMaxRaceData()
end

function BattleStrategyMatrixTemplate:GetRoleDatas()
	return self.roleDataInLua
end

function BattleStrategyMatrixTemplate:InitChipData()
	self.chipManagerID_ = 0
	self.chipList_ = {}
end

return BattleStrategyMatrixTemplate
