local BattleSkuldTemplate = class("BattleSkuldTemplate", BattleBaseStageTemplate)

function BattleSkuldTemplate:Ctor(arg_1_1)
	BattleSkuldTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleSkuldStageCfg[arg_1_1]
	self.startNext_ = false
end

function BattleSkuldTemplate:Init()
	if BattleConst.BATTLE_TAG.STORY == self.cfg.tag then
		self.heroList_ = {}
		self.heroTrialList_ = {}
	else
		self:InitHeroList()
	end

	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSkuldTemplate:GetDest()
	return SkuldSystemData:GetLevelIDByStageID(self.id)
end

function BattleSkuldTemplate:GetStageId()
	return self.id
end

function BattleSkuldTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SKULD
end

function BattleSkuldTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSkuldTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleSkuldTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleSkuldTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSkuldTemplate:GetIsStartNext()
	return self.startNext_
end

function BattleSkuldTemplate:SetStartNext()
	self.startNext_ = true
end

function BattleSkuldTemplate:GetRevive()
	if type(self.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_12_0 = self.cfg.is_revive

	return not not self.cfg.is_revive[1], self.cfg.is_revive[1] or 0, var_12_0[1] and ItemTools.getItemNum(var_12_0[1]) or 0, var_12_0[2] or 0
end

return BattleSkuldTemplate
