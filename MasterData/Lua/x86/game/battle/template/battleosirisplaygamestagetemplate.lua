local BattleOsirisPlayGameStageTemplate = class("BattleOsirisPlayGameStageTemplate", BattleBaseStageTemplate)

function BattleOsirisPlayGameStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleOsirisPlayGameStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleOsirisGameStageCfg[self.id]
end

function BattleOsirisPlayGameStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleOsirisPlayGameStageTemplate:InitHeroList()
	self.heroList_ = {}
	self.heroTrialList_ = {}

	local var_3_0, var_3_1, var_3_2, var_3_3 = ReserveTools.GetHeroList(self:GetReserveParams())

	self.heroList_ = clone(var_3_0)
	self.heroTrialList_ = clone(var_3_3)

	for iter_3_0 = #var_3_0, 1, -1 do
		if var_3_0[iter_3_0] == 0 then
			table.remove(self.heroList_, iter_3_0)
			table.remove(self.heroTrialList_, iter_3_0)
		end
	end
end

function BattleOsirisPlayGameStageTemplate:GetDest()
	return self.id
end

function BattleOsirisPlayGameStageTemplate:GetStageId()
	return self.id
end

function BattleOsirisPlayGameStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME
end

function BattleOsirisPlayGameStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleOsirisPlayGameStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleOsirisPlayGameStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleOsirisPlayGameStageTemplate:UpdateRoleDatas(arg_10_1)
	self.serverTeamPlayer = arg_10_1
	self.roleDataInLua = {}

	local var_10_0 = self:GetSystemHeroTeam()

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.heroList) do
		table.insert(self.roleDataInLua, (BattleController.GetInstance():SetOsirisPlayGameHeroData(iter_10_1, (iter_10_1.trialID ~= 0 or nil) and (iter_10_1.trialID or var_10_0[iter_10_0] or 0), arg_10_1.playerID, arg_10_1.level)))
	end

	self:SetMaxRaceData()
end

return BattleOsirisPlayGameStageTemplate
