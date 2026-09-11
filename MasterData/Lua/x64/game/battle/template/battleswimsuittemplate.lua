local BattleSwimsuitTemplate = class("BattleSwimsuitTemplate", BattleBaseStageTemplate)

function BattleSwimsuitTemplate:Ctor(arg_1_1, arg_1_2)
	BattleSwimsuitTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleSwimsuitCfg[self.id]
end

function BattleSwimsuitTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSwimsuitTemplate:GetDest()
	return self.id
end

function BattleSwimsuitTemplate:GetStageId()
	return self.id
end

function BattleSwimsuitTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE
end

function BattleSwimsuitTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSwimsuitTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleSwimsuitTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleSwimsuitTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSwimsuitTemplate:UpdateRoleDatas(arg_10_1)
	self.serverTeamPlayer = arg_10_1
	self.roleDataInLua = {}

	local var_10_0 = self:GetSystemHeroTeam()

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.heroList) do
		local var_10_1

		if iter_10_1.trialID ~= 0 then
			var_10_1 = iter_10_1.trialID or var_10_0[iter_10_0] or 0
		end

		local var_10_2 = SwimsuitBattleData:GetSkinByHeroID(iter_10_1.id)

		if var_10_2 then
			iter_10_1.skin = var_10_2
		end

		table.insert(self.roleDataInLua, (BattleController.GetInstance():SetHeroData(iter_10_1, var_10_1, arg_10_1.playerID, arg_10_1.level)))
	end

	self:SetMaxRaceData()
end

return BattleSwimsuitTemplate
