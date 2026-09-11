local BattleGuildBossPrepareTemplate = class("BattleGuildBossPrepareTemplate", BattleBaseStageTemplate)

function BattleGuildBossPrepareTemplate:Ctor(arg_1_1)
	self.cfg = BattleClubBossPreposeCfg[arg_1_1]

	BattleGuildBossPrepareTemplate.super.Ctor(self, arg_1_1)
end

function BattleGuildBossPrepareTemplate:Init()
	self:InitComboSkillID()
end

function BattleGuildBossPrepareTemplate:GetDest()
	return self.dest_
end

function BattleGuildBossPrepareTemplate:SetDest(arg_4_1)
	self.dest_ = arg_4_1
end

function BattleGuildBossPrepareTemplate:GetStageId()
	return self.cfg.id
end

function BattleGuildBossPrepareTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE
end

function BattleGuildBossPrepareTemplate:GetMap()
	return self.cfg.map, false
end

function BattleGuildBossPrepareTemplate:GetHeroTeam()
	return self.heroDataList_, {}
end

function BattleGuildBossPrepareTemplate:Get()
	return
end

function BattleGuildBossPrepareTemplate:GetActivityID()
	return BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE
end

function BattleGuildBossPrepareTemplate:GetThreeStar()
	return {}
end

function BattleGuildBossPrepareTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleGuildBossPrepareTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleGuildBossPrepareTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleGuildBossPrepareTemplate:GetEnemyLevel()
	return self.cfg.monster_level or 0
end

function BattleGuildBossPrepareTemplate:SetGuildBossTeam(arg_16_1, arg_16_2)
	self.heroDataList_ = arg_16_1
	self.ownerList_ = arg_16_2
end

function BattleGuildBossPrepareTemplate:GetAssistHeroOwnerList()
	return self.ownerList_
end

function BattleGuildBossPrepareTemplate:SetChipDic(arg_18_1)
	self.chipOfHeroDic_ = arg_18_1
end

function BattleGuildBossPrepareTemplate:GetChipOfHeroDic()
	return self.chipOfHeroDic_ or {}
end

function BattleGuildBossPrepareTemplate:GetHeroChipData(arg_20_1)
	local var_20_0, var_20_1 = self:GetHeroTeam()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1 ~= 0 then
			if var_20_1[iter_20_0] and var_20_1[iter_20_0] ~= 0 then
				table.insertto(arg_20_1, HeroStandardSystemCfg[var_20_1[iter_20_0]].using_hero_chip)
			else
				local var_20_2 = self:GetChipOfHeroDic()[iter_20_1]

				if var_20_2 then
					for iter_20_2, iter_20_3 in pairs(var_20_2) do
						if iter_20_3 > 0 then
							table.insert(arg_20_1, iter_20_3)
						end
					end
				else
					for iter_20_4, iter_20_5 in pairs(ChipData:GetEnableHeroChipIdByHeroId(iter_20_1) or {}) do
						if iter_20_5 > 0 then
							table.insert(arg_20_1, iter_20_5)
						end
					end
				end
			end
		end
	end

	return arg_20_1
end

return BattleGuildBossPrepareTemplate
