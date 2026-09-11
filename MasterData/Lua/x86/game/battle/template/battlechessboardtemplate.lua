local BattleChessBoardTemplate = class("BattleChessBoardTemplate", BattleBaseStageTemplate)

function BattleChessBoardTemplate:Ctor(arg_1_1)
	BattleChessBoardTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleChessBoardCfg[arg_1_1]
end

function BattleChessBoardTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
end

function BattleChessBoardTemplate:GetDest()
	return self.id
end

function BattleChessBoardTemplate:GetStageId()
	return self.id
end

function BattleChessBoardTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.CHESS_BOARD
end

function BattleChessBoardTemplate:GetMap()
	return self.cfg.map, false
end

function BattleChessBoardTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleChessBoardTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleChessBoardTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleChessBoardTemplate:GetRevive()
	if type(self.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_10_0 = self.cfg.is_revive

	return not not self.cfg.is_revive[1], self.cfg.is_revive[1] or 0, var_10_0[1] and ItemTools.getItemNum(var_10_0[1]) or 0, var_10_0[2] or 0
end

return BattleChessBoardTemplate
