local BattleHellaPinBallTemplate = class("BattleHellaPinBallTemplate", BattleBaseStageTemplate)

function BattleHellaPinBallTemplate:Ctor(arg_1_1, arg_1_2)
	BattleHellaPinBallTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityId = PinballData:GetActivityID()
	self.data = arg_1_2
	self.cfg = BattleHellaPinballStageCfg[arg_1_1]
	self.roleDataInLua = {}
end

function BattleHellaPinBallTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleHellaPinBallTemplate:GetChipManagerID()
	return 0
end

function BattleHellaPinBallTemplate:InitChipData()
	self.charChipBaseID_ = nil
	self.charChipExtraIDList_ = nil
	self.chipList_ = {}
end

function BattleHellaPinBallTemplate:GetDest()
	return self.id
end

function BattleHellaPinBallTemplate:GetStageId()
	return self.id
end

function BattleHellaPinBallTemplate:GetActivityID()
	return self.activityId
end

function BattleHellaPinBallTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.HELLA_PINBALL_BATTLE
end

function BattleHellaPinBallTemplate:GetMap()
	return self.cfg.map, false
end

function BattleHellaPinBallTemplate:GetName()
	return self.cfg.name
end

function BattleHellaPinBallTemplate:GetAILevel()
	return self.cfg.ai_level or 0
end

function BattleHellaPinBallTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleHellaPinBallTemplate:GetRevive()
	if type(self.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_13_0 = self.cfg.is_revive

	return not not self.cfg.is_revive[1], self.cfg.is_revive[1] or 0, var_13_0[1] and ItemTools.getItemNum(var_13_0[1]) or 0, var_13_0[2] or 0
end

function BattleHellaPinBallTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

return BattleHellaPinBallTemplate
