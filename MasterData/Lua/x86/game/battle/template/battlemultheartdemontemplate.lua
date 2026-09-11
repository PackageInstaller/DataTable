local BattleMultHeartDemonTemplate = class("BattleMultHeartDemonTemplate", BattleBaseStageTemplate)

function BattleMultHeartDemonTemplate:Ctor(arg_1_1, arg_1_2)
	BattleMultHeartDemonTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2.activityID
	self.levelID_ = 1
	self.cfg = BattleMultiHeartDemonCfg[arg_1_1]
	self.heroID = arg_1_2.heroID
	self.difficult = arg_1_2.difficult
	self.data = MultHeartDemonData:GetDataByPara("difficultyData")

	if self.data then
		self.data = self.data[self.difficult] or {}
	end

	self.heroHPList = self.data.heroHPList or {}
end

function BattleMultHeartDemonTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleMultHeartDemonTemplate:InitChipData()
	self.chipList_ = {}
end

function BattleMultHeartDemonTemplate:GetDest()
	return self.id
end

function BattleMultHeartDemonTemplate:GetStageId()
	return self.id
end

function BattleMultHeartDemonTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.MULT_HEART_DEMON
end

function BattleMultHeartDemonTemplate:GetMap()
	return self.cfg.map, false
end

function BattleMultHeartDemonTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleMultHeartDemonTemplate:GetDifficult()
	return self.difficult
end

function BattleMultHeartDemonTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleMultHeartDemonTemplate:GetHeroTeam()
	self.heroList_ = {
		self.heroID,
		[2] = 0,
		[3] = 0
	}

	if self.heroID >= 10000 then
		self.heroTrialList_ = {
			self.heroID,
			[2] = 0,
			[3] = 0
		}
	end

	return self.heroList_, self.heroTrialList_
end

function BattleMultHeartDemonTemplate:GetLevelID()
	return self.cfg.level
end

function BattleMultHeartDemonTemplate:GetMainActivityID()
	return self.activityID_
end

function BattleMultHeartDemonTemplate:UpdateRoleDatas(arg_14_1)
	self.serverTeamPlayer = arg_14_1
	self.roleDataInLua = {}

	local var_14_0 = self:GetSystemHeroTeam()

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.heroList) do
		table.insert(self.roleDataInLua, (BattleController.GetInstance():MultiHeartDemonSetHeroData(iter_14_1, (iter_14_1.trialID ~= 0 or nil) and (iter_14_1.trialID or var_14_0[iter_14_0] or 0), arg_14_1.playerID, arg_14_1.level, (self.heroHPList[self.heroList_[1]] or 100) / 100)))
	end

	self:SetMaxRaceData()
end

function BattleMultHeartDemonTemplate:GetAttributeFactor()
	local var_15_0 = MultHeartDemonData:GetDataByPara("difficultyData")

	var_15_0 = var_15_0 and (var_15_0[self.difficult] or {})

	local var_15_1 = var_15_0.heroHPList or {}
	local var_15_2 = MultHeartDemonData:GetBossIdByStageId(self.id)

	return Vector3.New(self.cfg.attribute_factor[1] / 1000, self.cfg.attribute_factor[2] / 1000, self.cfg.attribute_factor[3] / 1000 * ((var_15_1[var_15_2] or nil) and (var_15_1[var_15_2] / 100 or 1)))
end

return BattleMultHeartDemonTemplate
