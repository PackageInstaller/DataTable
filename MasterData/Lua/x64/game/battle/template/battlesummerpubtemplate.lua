local BattleSummerPubTemplate = class("BattleSummerPubTemplate", BattleBaseStageTemplate)

function BattleSummerPubTemplate:Ctor(arg_1_1)
	BattleSummerPubTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleSummerPubStageCfg[arg_1_1]
end

function BattleSummerPubTemplate:Init()
	if BattleConst.BATTLE_TAG.STORY == self.cfg.tag then
		self.heroList_ = {}
		self.heroTrialList_ = {}
	else
		self:InitHeroList()
	end

	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSummerPubTemplate:GetDest()
	return SummerPubData:GetLevelIDByStageID(self.id)
end

function BattleSummerPubTemplate:GetStageId()
	return self.id
end

function BattleSummerPubTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SUMMER_PUB
end

function BattleSummerPubTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSummerPubTemplate:GetActivityID()
	return ActivityConst.ACTIVITY_NYA_SUMMER_PUB
end

function BattleSummerPubTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleSummerPubTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleSummerPubTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSummerPubTemplate:GetRevive()
	if type(self.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_11_0 = self.cfg.is_revive

	return not not self.cfg.is_revive[1], self.cfg.is_revive[1] or 0, var_11_0[1] and ItemTools.getItemNum(var_11_0[1]) or 0, var_11_0[2] or 0
end

return BattleSummerPubTemplate
