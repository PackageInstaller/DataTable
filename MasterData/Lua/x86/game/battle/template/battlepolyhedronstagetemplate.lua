local BattlePolyhedronStageTemplate = class("BattlePolyhedronStageTemplate", BattleBaseStageTemplate)

function BattlePolyhedronStageTemplate:Ctor(arg_1_1)
	BattlePolyhedronStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattlePolyhedronStageCfg[self.id]

	if not self.cfg then
		error(string.format("找不到stageId为 %s 的关卡，请检查配置！！！！！！！", tostring(self.id)))
	end

	self.heroList = {}
	self.systemHeroList = {}
	self.heroTrialList_ = {}

	self:InitComboSkillID()
	self:InitChipData()
	self:InitSystemHeroList()

	self.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
end

function BattlePolyhedronStageTemplate:GetDest()
	return self.id
end

function BattlePolyhedronStageTemplate:GetStageId()
	return self.id
end

function BattlePolyhedronStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.POLYHEDRON
end

function BattlePolyhedronStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattlePolyhedronStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattlePolyhedronStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattlePolyhedronStageTemplate:GetHeroTeam()
	return self.heroList, self.heroTrialList_
end

function BattlePolyhedronStageTemplate:GetSystemHeroTeam()
	return self.systemHeroList
end

function BattlePolyhedronStageTemplate:GetRevive()
	local var_10_0, var_10_1 = self.polyhedronInfo:GetReviveCount()

	return true, 0, var_10_0, 1, var_10_1
end

function BattlePolyhedronStageTemplate:GetAttributeFactor()
	local var_11_0 = PolyhedronTierCfg[self.polyhedronInfo:GetTierId()]
	local var_11_1 = 1
	local var_11_2 = 1
	local var_11_3 = 1

	if var_11_0 and var_11_0.monster_level_coefficient then
		local var_11_4 = var_11_0.monster_level_coefficient
		local var_11_5

		if var_11_0.monster_level_coefficient[1] then
			var_11_5 = var_11_4[1] / 1000 or 1

			local var_11_6

			if var_11_4[2] then
				var_11_6 = var_11_4[2] / 1000 or 1
			end
		end

		var_11_1 = var_11_5
		var_11_3 = var_11_6
	end

	for iter_11_0 = 1, PolyhedronData:GetPolyhedronInfo().difficulty do
		for iter_11_1, iter_11_2 in ipairs(PolyhedronDifficultyCfg[iter_11_0].params) do
			if iter_11_2[1] == 2 then
				if iter_11_2[2] == 11 then
					var_11_1 = var_11_1 * (1 + iter_11_2[3] / 1000)
				elseif iter_11_2[2] == 21 then
					var_11_2 = var_11_2 * (1 + iter_11_2[3] / 1000)
				elseif iter_11_2[2] == 31 then
					var_11_3 = var_11_3 * (1 + iter_11_2[3] / 1000)
				end
			end
		end
	end

	return (Vector3.New(var_11_1, var_11_2, var_11_3))
end

function BattlePolyhedronStageTemplate:UpdateRoleDatas(arg_12_1)
	self.serverTeamPlayer = arg_12_1

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_1.heroList) do
		var_12_0[iter_12_1.id] = iter_12_1
	end

	self.roleDataInLua = {}

	local var_12_1 = PolyhedronData:GetPolyhedronInfo()
	local var_12_2 = var_12_1:GetLeaderHeroId()

	table.insert(self.roleDataInLua, (BattleController.GetInstance():SetPolyhedronHeroData(var_12_1, var_12_0[var_12_2], var_12_1:GetPolyhedronLeader(), PolyhedronHeroCfg[var_12_2].standard_id, arg_12_1.playerID, arg_12_1.level)))

	for iter_12_2, iter_12_3 in ipairs((var_12_1:GetFightHeroList())) do
		if not var_12_1:GetHeroPolyData(iter_12_3):IsDead() and iter_12_3 ~= var_12_2 then
			table.insert(self.roleDataInLua, (BattleController.GetInstance():SetPolyhedronHeroData(var_12_1, var_12_0[iter_12_3], nil, PolyhedronHeroCfg[iter_12_3].standard_id, arg_12_1.playerID, arg_12_1.level)))
		end
	end

	self:SetMaxRaceData()
end

function BattlePolyhedronStageTemplate:GetStageAffix()
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs(self.polyhedronInfo:GetTotalAffix() or {}) do
		table.insert(var_13_0, iter_13_1[1])
		table.insert(var_13_1, iter_13_1[2])
		table.insert(var_13_2, iter_13_1[3])
	end

	return var_13_0, var_13_1, var_13_2
end

function BattlePolyhedronStageTemplate:GetResurrectHP()
	return self.polyhedronInfo:GetReviveHp()
end

function BattlePolyhedronStageTemplate:GetResurrectImmediately()
	return true
end

function BattlePolyhedronStageTemplate:GetTargetEnemyID()
	if PolyhedronConst.REWARD_TYEP.TEAMMATE == self.polyhedronInfo:GetRewardType() then
		for iter_16_0, iter_16_1 in ipairs((self.polyhedronInfo:GetEnlistHeroList())) do
			if iter_16_1.enlist_type == PolyhedronConst.ENLIST_TYPE.BATTLE then
				return PolyhedronHeroCfg[iter_16_1.heroId].target_enemy
			end
		end
	end

	return 5050
end

function BattlePolyhedronStageTemplate:GetActivityID()
	return PolyhedronData:GetActivityID() or 0
end

function BattlePolyhedronStageTemplate:InitComboSkillID()
	self.comboSkillID_ = BattleTeamData:GetComboInfo(self:GetType(), self:GetActivityID())
end

function BattlePolyhedronStageTemplate:InitSystemHeroList()
	local var_19_0 = PolyhedronData:GetPolyhedronInfo()
	local var_19_1 = var_19_0:GetPolyhedronLeader()
	local var_19_2 = var_19_0:GetLeaderHeroId()

	table.insert(self.systemHeroList, PolyhedronHeroCfg[var_19_2].standard_id)

	for iter_19_0, iter_19_1 in ipairs((var_19_0:GetFightHeroList())) do
		if not var_19_0:GetHeroPolyData(iter_19_1):IsDead() and iter_19_1 ~= var_19_2 then
			table.insert(self.systemHeroList, PolyhedronHeroCfg[iter_19_1].standard_id)
		end
	end
end

return BattlePolyhedronStageTemplate
