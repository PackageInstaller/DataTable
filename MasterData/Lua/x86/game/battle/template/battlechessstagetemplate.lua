local BattleChessStageTemplate = class("BattleChessStageTemplate", BattleBaseStageTemplate)

function BattleChessStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleChessStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleChessStageCfg[arg_1_1]
	self.nextBattleStage_ = nil
end

function BattleChessStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleChessStageTemplate:GetDest()
	return self.id
end

function BattleChessStageTemplate:GetStageId()
	return self.id
end

function BattleChessStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS
end

function BattleChessStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleChessStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleChessStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleChessStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleChessStageTemplate:UpdateRoleDatas(arg_10_1)
	self.serverTeamPlayer = arg_10_1
	self.roleDataInLua = {}

	local var_10_0 = self:GetSystemHeroTeam()

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.heroList) do
		table.insert(self.roleDataInLua, (BattleController.GetInstance():SetChessHeroData(iter_10_1, (iter_10_1.trialID ~= 0 or nil) and (iter_10_1.trialID or var_10_0[iter_10_0] or 0), arg_10_1.playerID, arg_10_1.level)))
	end

	self:SetMaxRaceData()
end

function BattleChessStageTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in pairs((WarChessData:GetArtifactData())) do
		if not WarchessItemCfg[iter_11_0] then
			CustomLog.Log("不存在的战棋神器:" .. iter_11_0)
		end

		for iter_11_2, iter_11_3 in ipairs(WarchessItemCfg[iter_11_0].params) do
			table.insert(var_11_0, iter_11_3[1])
			table.insert(var_11_1, iter_11_3[2])
			table.insert(var_11_2, WarchessItemCfg[iter_11_0].sub_affix_type)
		end
	end

	for iter_11_4, iter_11_5 in ipairs((TalentTreeData:GetTalentListByTheme((ActivityTools.GetActivityTheme(self.activityID_))))) do
		table.insert(var_11_0, iter_11_5[1])
		table.insert(var_11_1, iter_11_5[2])
		table.insert(var_11_2, iter_11_5[3])
	end

	return var_11_0, var_11_1, var_11_2
end

function BattleChessStageTemplate:GetServerExtant()
	return WarChessData:GetBattleIndex()
end

function BattleChessStageTemplate:GetNextStage()
	return self.nextBattleStage_
end

function BattleChessStageTemplate:SetNextStage(arg_14_1)
	self.nextBattleStage_ = arg_14_1
end

return BattleChessStageTemplate
