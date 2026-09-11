local BattleGuildActivityStageTemplate = class("BattleGuildActivityStageTemplate", BattleBaseStageTemplate)

function BattleGuildActivityStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleGuildActivityStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleClubActivityCfg[arg_1_1]
end

function BattleGuildActivityStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleGuildActivityStageTemplate:SetNodeId(arg_3_1)
	self.nodeId_ = arg_3_1
end

function BattleGuildActivityStageTemplate:GetNodeId()
	return self.nodeId_
end

function BattleGuildActivityStageTemplate:GetDest()
	return self.nodeId_
end

function BattleGuildActivityStageTemplate:GetStageId()
	return self.id
end

function BattleGuildActivityStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY
end

function BattleGuildActivityStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleGuildActivityStageTemplate:GetAILevel()
	return self.cfg.ai_level or 0
end

function BattleGuildActivityStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level or 0
end

function BattleGuildActivityStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleGuildActivityStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleGuildActivityStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleGuildActivityStageTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleGuildActivityStageTemplate:GetStageAffix()
	local var_15_0 = {}
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = {}
	local var_15_4 = {}

	for iter_15_0, iter_15_1 in pairs(self.roleDataInLua) do
		if SkinCfg[iter_15_1.ID].hero ~= 0 then
			var_15_4[HeroCfg[SkinCfg[iter_15_1.ID].hero].race] = var_15_4[HeroCfg[SkinCfg[iter_15_1.ID].hero].race] or 0
			var_15_4[HeroCfg[SkinCfg[iter_15_1.ID].hero].race] = var_15_4[HeroCfg[SkinCfg[iter_15_1.ID].hero].race] + 1
		end
	end

	for iter_15_2, iter_15_3 in pairs((GuildActivityData:GetUnLockAffixList())) do
		if var_15_4[TalentTreeCfg[iter_15_2].race] ~= nil then
			var_15_0[iter_15_2] = var_15_4[TalentTreeCfg[iter_15_2].race]

			table.insert(var_15_1, TalentTreeCfg[iter_15_2].affix_id)
			table.insert(var_15_2, iter_15_3.level)
			table.insert(var_15_3, TalentTreeCfg[iter_15_2].affix_user)
		end
	end

	GuildActivityData:SetTempEffectiveAffixList(var_15_0)

	return var_15_1, var_15_2, var_15_3
end

function BattleGuildActivityStageTemplate:SetPathList(arg_16_1)
	self.pathList_ = arg_16_1
end

function BattleGuildActivityStageTemplate:GetPathList()
	return self.pathList_ or {}
end

function BattleGuildActivityStageTemplate:GetAttributeFactor()
	if ActivityClubCfg[self.nodeId_].attribute_factor and ActivityClubCfg[self.nodeId_].attribute_factor[3] then
		local var_18_0 = 10 - GuildActivityData:GetNodeData(self.nodeId_).history_occupied_num

		if var_18_0 < 1 then
			var_18_0 = 1
		end

		local var_18_1 = 1 * var_18_0 / 10
		local var_18_2 = 1 * var_18_0 / 10
		local var_18_3 = GuildActivityData:GetSelfNodeData(self.nodeId_)

		if var_18_3 then
			var_18_2 = var_18_2 * ((var_18_3.elite_health_rate == 0 or nil) and 100) / 100
		end

		return Vector3.New(ActivityClubCfg[self.nodeId_].attribute_factor[1] / 1000 * var_18_1, ActivityClubCfg[self.nodeId_].attribute_factor[2] / 1000 * var_18_1, ActivityClubCfg[self.nodeId_].attribute_factor[3] / 1000 * var_18_2)
	end

	return Vector3.New(1, 1, 1)
end

return BattleGuildActivityStageTemplate
