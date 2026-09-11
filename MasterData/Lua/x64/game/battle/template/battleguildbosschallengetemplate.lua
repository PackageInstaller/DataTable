local BattleGuildBossChallengeTemplate = class("BattleGuildBossChallengeTemplate", BattleBaseStageTemplate)

function BattleGuildBossChallengeTemplate:Ctor(arg_1_1)
	self.cfg = BattleClubBossCfg[arg_1_1]

	BattleGuildBossChallengeTemplate.super.Ctor(self, arg_1_1)
end

function BattleGuildBossChallengeTemplate:Init()
	self:InitComboSkillID()
end

function BattleGuildBossChallengeTemplate:GetStageId()
	return self.cfg.id
end

function BattleGuildBossChallengeTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE
end

function BattleGuildBossChallengeTemplate:GetMap()
	return self.cfg.map, false
end

function BattleGuildBossChallengeTemplate:GetHeroTeam()
	return self.heroDataList_, {}
end

function BattleGuildBossChallengeTemplate:GetActivityID()
	return BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE
end

function BattleGuildBossChallengeTemplate:GetThreeStar()
	return {}
end

function BattleGuildBossChallengeTemplate:GetStageAffix()
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in pairs(GuildData:GetHaveGetBossBuffList() or {} or {}) do
		table.insert(var_9_0, iter_9_1[1])
		table.insert(var_9_1, iter_9_1[2])
		table.insert(var_9_2, iter_9_1[3])
	end

	return var_9_0, var_9_1, var_9_2
end

function BattleGuildBossChallengeTemplate:GetAttributeFactor()
	local var_10_0 = ClubBossCfg[GuildData:GetBossDifficulty()]

	if var_10_0.attribute_factor and var_10_0.attribute_factor[3] then
		return Vector3.New(var_10_0.attribute_factor[1] / 1000, var_10_0.attribute_factor[2] / 1000, var_10_0.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function BattleGuildBossChallengeTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleGuildBossChallengeTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleGuildBossChallengeTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleGuildBossChallengeTemplate:GetDest()
	return self.dest_
end

function BattleGuildBossChallengeTemplate:SetDest(arg_15_1)
	self.dest_ = arg_15_1
end

function BattleGuildBossChallengeTemplate:GetEnemyLevel()
	return ClubBossCfg[GuildData:GetBossDifficulty()].monster_level
end

function BattleGuildBossChallengeTemplate:SetGuildBossTeam(arg_17_1, arg_17_2)
	self.heroDataList_ = arg_17_1
	self.ownerList_ = arg_17_2
end

function BattleGuildBossChallengeTemplate:GetAssistHeroOwnerList()
	return self.ownerList_
end

function BattleGuildBossChallengeTemplate:SetChipDic(arg_19_1)
	self.chipOfHeroDic_ = arg_19_1
end

function BattleGuildBossChallengeTemplate:GetChipOfHeroDic()
	return self.chipOfHeroDic_ or {}
end

function BattleGuildBossChallengeTemplate:GetHeroChipData(arg_21_1)
	local var_21_0, var_21_1 = self:GetHeroTeam()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1 ~= 0 then
			if var_21_1[iter_21_0] and var_21_1[iter_21_0] ~= 0 then
				table.insertto(arg_21_1, HeroStandardSystemCfg[var_21_1[iter_21_0]].using_hero_chip)
			else
				local var_21_2 = self:GetChipOfHeroDic()[iter_21_1]

				if var_21_2 then
					for iter_21_2, iter_21_3 in pairs(var_21_2) do
						if iter_21_3 > 0 then
							table.insert(arg_21_1, iter_21_3)
						end
					end
				else
					for iter_21_4, iter_21_5 in pairs(ChipData:GetEnableHeroChipIdByHeroId(iter_21_1) or {}) do
						if iter_21_5 > 0 then
							table.insert(arg_21_1, iter_21_5)
						end
					end
				end
			end
		end
	end

	return arg_21_1
end

return BattleGuildBossChallengeTemplate
