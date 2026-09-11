local BattleLeviathanLittleGameTemplate = class("BattleLeviathanLittleGameTemplate", BattleBaseStageTemplate)

function BattleLeviathanLittleGameTemplate:Ctor(arg_1_1, arg_1_2)
	BattleLeviathanLittleGameTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.stageID_ = ActivityBubblesCfg[arg_1_1].stage_id
	self.cfg = BattleLeviathanGamesCfg[self.stageID_]
	self.heroList_, _, _, self.heroTrialList_ = GetLocalHeroTeam(self:GetType(), self.stageID_, arg_1_2)

	self:InitComboSkillID()
	self:InitChipData()
end

function BattleLeviathanLittleGameTemplate:GetDest()
	return self.id_
end

function BattleLeviathanLittleGameTemplate:GetStageId()
	return self.stageID_
end

function BattleLeviathanLittleGameTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME
end

function BattleLeviathanLittleGameTemplate:GetMap()
	return self.cfg.map, false
end

function BattleLeviathanLittleGameTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleLeviathanLittleGameTemplate:GetStageAffix()
	return {}, {}, {}
end

function BattleLeviathanLittleGameTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleLeviathanLittleGameTemplate:GetActivityID()
	return self.activityID_
end

function BattleLeviathanLittleGameTemplate:SetMaxRaceData()
	local var_10_0 = {}
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in pairs(self.roleDataInLua) do
		if iter_10_1.ID ~= 0 then
			var_10_0[HeroCfg[iter_10_1.ID].race] = (var_10_0[HeroCfg[iter_10_1.ID].race] or 0) + 1

			if var_10_0[HeroCfg[iter_10_1.ID].race] == 2 then
				var_10_1 = HeroCfg[iter_10_1.ID].race
			elseif var_10_0[HeroCfg[iter_10_1.ID].race] == 3 then
				-- block empty
			end
		end
	end

	self.maxRaceID_ = var_10_1
	self.maxRacePlayerCount_ = var_10_0[var_10_1] or 1
end

return BattleLeviathanLittleGameTemplate
