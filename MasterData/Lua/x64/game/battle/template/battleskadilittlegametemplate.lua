local BattleSkadiLittleGameTemplate = class("BattleSkadiLittleGameTemplate", BattleBaseStageTemplate)

function BattleSkadiLittleGameTemplate:Ctor(arg_1_1, arg_1_2)
	BattleSkadiLittleGameTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.stageID_ = ActivityCrossWaveCfg[arg_1_1].stage_id
	self.cfg = BattleCrosswaveCfg[self.stageID_]
end

function BattleSkadiLittleGameTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSkadiLittleGameTemplate:GetDest()
	return self.id_
end

function BattleSkadiLittleGameTemplate:GetStageId()
	return self.stageID_
end

function BattleSkadiLittleGameTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SKADI_GAME
end

function BattleSkadiLittleGameTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSkadiLittleGameTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleSkadiLittleGameTemplate:GetStageAffix()
	return {}, {}, {}
end

function BattleSkadiLittleGameTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSkadiLittleGameTemplate:GetActivityID()
	return self.activityID_
end

function BattleSkadiLittleGameTemplate:GetThreeStar()
	return self.cfg.three_star_need
end

function BattleSkadiLittleGameTemplate:SetMaxRaceData()
	local var_12_0 = {}
	local var_12_1 = 0

	for iter_12_0, iter_12_1 in pairs(self.roleDataInLua) do
		if iter_12_1.ID ~= 0 then
			var_12_0[HeroCfg[iter_12_1.ID].race] = (var_12_0[HeroCfg[iter_12_1.ID].race] or 0) + 1

			if var_12_0[HeroCfg[iter_12_1.ID].race] == 2 then
				var_12_1 = HeroCfg[iter_12_1.ID].race
			elseif var_12_0[HeroCfg[iter_12_1.ID].race] == 3 then
				-- block empty
			end
		end
	end

	self.maxRaceID_ = var_12_1
	self.maxRacePlayerCount_ = var_12_0[var_12_1] or 1
end

return BattleSkadiLittleGameTemplate
