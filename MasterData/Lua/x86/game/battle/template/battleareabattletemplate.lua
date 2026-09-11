local BattleAreaBattleTemplate = class("BattleAreaBattleTemplate", BattleBaseStageTemplate)

function BattleAreaBattleTemplate:Ctor(arg_1_1, arg_1_2)
	BattleAreaBattleTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleAreaBattleCfg[arg_1_1]
end

function BattleAreaBattleTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleAreaBattleTemplate:GetDest()
	return self.id
end

function BattleAreaBattleTemplate:GetStageId()
	return self.id
end

function BattleAreaBattleTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.AREA_BATTLE
end

function BattleAreaBattleTemplate:GetMap()
	return self.cfg.map, false
end

function BattleAreaBattleTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleAreaBattleTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleAreaBattleTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleAreaBattleTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleAreaBattleTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleAreaBattleTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleAreaBattleTemplate:GetStageAffix()
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in ipairs(ActivityAreaBattleCfg[self.activityID_].debuff_list) do
		table.insert(var_13_0, TalentTreeCfg[iter_13_1].affix_id)
		table.insert(var_13_1, TalentTreeCfg[iter_13_1].max_level)
		table.insert(var_13_2, TalentTreeCfg[iter_13_1].affix_user)
	end

	local var_13_3 = getData("AreaBattle", tostring(self.id)) or ""

	if var_13_3 ~= "" then
		for iter_13_2, iter_13_3 in pairs((string.split(var_13_3, "."))) do
			if iter_13_3 ~= "" then
				local var_13_4 = TalentTreeCfg[tonumber(string.split(iter_13_3, ",")[1])]

				table.insert(var_13_0, var_13_4.affix_id)
				table.insert(var_13_1, var_13_4.max_level)
				table.insert(var_13_2, var_13_4.affix_user)
			end
		end
	end

	return var_13_0, var_13_1, var_13_2
end

function BattleAreaBattleTemplate:SetReserveParams(arg_14_1)
	self.reserveParams_ = BattleAreaBattleTemplate.GetCustomReserveParams(self:GetType(), self:GetStageId(), self:GetActivityID())
	self.contID_ = self.reserveParams_.contID
	self.teamIndex_ = self.reserveParams_.teamIndex
	self.customReserveParams_ = self.reserveParams_.customData
end

function BattleAreaBattleTemplate:GetReserveParams()
	self.reserveParams_ = self.reserveParams_ or BattleAreaBattleTemplate.GetCustomReserveParams(self:GetType(), self:GetStageId(), self:GetActivityID())

	return self.reserveParams_
end

function BattleAreaBattleTemplate:GetCustomReserveParams(arg_16_1, arg_16_2)
	local var_16_0 = 1

	for iter_16_0, iter_16_1 in pairs(ActivityAreaBattleCfg[arg_16_2].stage_id) do
		for iter_16_2, iter_16_3 in pairs(iter_16_1) do
			if iter_16_3 == arg_16_1 then
				var_16_0 = iter_16_0
			end
		end
	end

	return ReserveParams.New(ReserveTools.GetReserveType(self, arg_16_1), ReserveTools.GetContID(self, arg_16_1), nil, {
		stageType = self,
		stageID = arg_16_1,
		activityID = arg_16_2 or 0,
		data = ActivityAreaBattleData:GetDataByActivityID(ActivityCfg.get_id_list_by_sub_activity_list[arg_16_2][1])[arg_16_2],
		difficult = var_16_0
	})
end

return BattleAreaBattleTemplate
