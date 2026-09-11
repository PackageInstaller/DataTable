local BattleWhackMoleTemplate = class("BattleWhackMoleTemplate", BattleBaseStageTemplate)

function BattleWhackMoleTemplate:Ctor(arg_1_1, arg_1_2)
	BattleWhackMoleTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.whackMoleID_ = arg_1_2
	self.cfg = BattleWhackMoleStageCfg[self.id_]

	self:InitHeroList()
end

function BattleWhackMoleTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleWhackMoleTemplate:GetDest()
	return self.whackMoleID_
end

function BattleWhackMoleTemplate:GetStageId()
	return self.id_
end

function BattleWhackMoleTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_WHACK_MOLE
end

function BattleWhackMoleTemplate:GetMap()
	return self.cfg.map, false
end

function BattleWhackMoleTemplate:SetBattleResult(arg_7_1)
	self.battleResult_ = arg_7_1
end

function BattleWhackMoleTemplate:GetBattleResult()
	return self.battleResult_
end

function BattleWhackMoleTemplate:SetScore(arg_9_1)
	self.score_ = arg_9_1
end

function BattleWhackMoleTemplate:GetScore()
	return self.score_
end

return BattleWhackMoleTemplate
