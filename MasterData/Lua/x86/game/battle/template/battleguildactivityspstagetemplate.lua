local BattleGuildActivitySPStageTemplate = class("BattleGuildActivitySPStageTemplate", BattleBaseStageTemplate)

function BattleGuildActivitySPStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleGuildActivitySPStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleClubActivitySPCfg[arg_1_1]
end

function BattleGuildActivitySPStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleGuildActivitySPStageTemplate:SetNodeId(arg_3_1)
	self.nodeId_ = arg_3_1
end

function BattleGuildActivitySPStageTemplate:GetNodeId()
	return self.nodeId_
end

function BattleGuildActivitySPStageTemplate:GetDest()
	return self.nodeId_
end

function BattleGuildActivitySPStageTemplate:GetStageId()
	return self.id
end

function BattleGuildActivitySPStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP
end

function BattleGuildActivitySPStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleGuildActivitySPStageTemplate:GetAILevel()
	return self.cfg.ai_level or 0
end

function BattleGuildActivitySPStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level or 0
end

function BattleGuildActivitySPStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleGuildActivitySPStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleGuildActivitySPStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleGuildActivitySPStageTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleGuildActivitySPStageTemplate:GetStageAffix()
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

	for iter_15_2, iter_15_3 in pairs((GuildActivitySPData:GetUnLockAffixList())) do
		if var_15_4[TalentTreeCfg[iter_15_2].race] ~= nil then
			var_15_0[iter_15_2] = var_15_4[TalentTreeCfg[iter_15_2].race]

			table.insert(var_15_1, TalentTreeCfg[iter_15_2].affix_id)
			table.insert(var_15_2, iter_15_3.level)
			table.insert(var_15_3, TalentTreeCfg[iter_15_2].affix_user)
		end
	end

	self.nodeCfg_ = ActivityClubSPCfg[self.nodeId_]

	if self.nodeCfg_.id == GuildActivitySPData:GetMaxNodeId() and GuildActivitySPData:GetNowStage() == 1 then
		if BattleClubActivitySPCfg[self.nodeCfg_.stage_id].affix_type ~= nil and BattleClubActivitySPCfg[self.nodeCfg_.stage_id].affix_type ~= "" then
			for iter_15_4, iter_15_5 in ipairs(BattleClubActivitySPCfg[self.nodeCfg_.stage_id].affix_type) do
				table.insert(var_15_1, iter_15_5[1])
				table.insert(var_15_2, iter_15_5[2])
				table.insert(var_15_3, iter_15_5[3])
			end
		end
	end

	GuildActivitySPData:SetTempEffectiveAffixList(var_15_0)

	return var_15_1, var_15_2, var_15_3
end

function BattleGuildActivitySPStageTemplate:SetPathList(arg_16_1)
	self.pathList_ = arg_16_1
end

function BattleGuildActivitySPStageTemplate:GetPathList()
	return self.pathList_ or {}
end

function BattleGuildActivitySPStageTemplate:GetAttributeFactor()
	if BattleClubActivitySPCfg[ActivityClubSPCfg[self.nodeId_].stage_id] then
		local var_18_0 = 10 - GuildActivitySPData:GetNodeData(self.nodeId_).occupied_num

		if var_18_0 < 1 then
			var_18_0 = 1
		end

		local var_18_1 = 1 * var_18_0 / 10
		local var_18_2 = 1 * var_18_0 / 10
		local var_18_3 = GuildActivitySPData:GetSelfNodeData(self.nodeId_)

		if var_18_3 then
			var_18_2 = var_18_2 * ((var_18_3.elite_health_rate == 0 or nil) and 100) / 100
		end

		return Vector3.New(ActivityClubSPCfg[self.nodeId_].attribute_factor[1] / 1000 * var_18_1, ActivityClubSPCfg[self.nodeId_].attribute_factor[2] / 1000 * var_18_1, ActivityClubSPCfg[self.nodeId_].attribute_factor[3] / 1000 * var_18_2)
	end

	return Vector3.New(1, 1, 1)
end

return BattleGuildActivitySPStageTemplate
