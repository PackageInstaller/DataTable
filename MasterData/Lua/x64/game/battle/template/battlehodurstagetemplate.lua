local BattleHodurStageTemplate = class("BattleHodurStageTemplate", BattleBaseStageTemplate)

function BattleHodurStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleHodurStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.chapterID = arg_1_2.chapterID
	self.activityID_ = arg_1_2.activityID
	self.isRestart = arg_1_2.isRestart or false
	self.cfg = BattleHodurStageCfg[self.id]
end

function BattleHodurStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleHodurStageTemplate:InitHeroList()
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

function BattleHodurStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleHodurStageTemplate:GetDest()
	return self.id
end

function BattleHodurStageTemplate:GetStageId()
	return self.id
end

function BattleHodurStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE
end

function BattleHodurStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleHodurStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleHodurStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleHodurStageTemplate:GetChapterID()
	return self.chapterID
end

function BattleHodurStageTemplate:GetStageAffix()
	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3 = {}

	for iter_12_0, iter_12_1 in ipairs(HodurTools.IsChallenge(self.chapterID) and HodurTools.GetChallengeAffix() or HodurTools.GetAffix(self.chapterID)) do
		local var_12_4 = 1
		local var_12_5 = 3

		if PublicBuffCfg[iter_12_1] then
			if ActivityAffixPoolCfg[PublicBuffCfg[iter_12_1].buff_class_id] then
				var_12_4 = ActivityAffixPoolCfg[PublicBuffCfg[iter_12_1].buff_class_id].affix[2]
				var_12_5 = ActivityAffixPoolCfg[PublicBuffCfg[iter_12_1].buff_class_id].affix[3]
			end
		end

		table.insert(var_12_1, iter_12_1)
		table.insert(var_12_2, var_12_4)
		table.insert(var_12_3, var_12_5)
	end

	return var_12_1, var_12_2, var_12_3
end

function BattleHodurStageTemplate:GetOpts()
	local var_13_0 = {}
	local var_13_1 = {}

	var_13_1 = HodurTools.IsChallenge(self.chapterID) and HodurTools.GetChallengeAffix() or HodurTools.GetAffix(self.chapterID)

	table.insert(var_13_0, {
		key = 1,
		value = var_13_1
	})

	return var_13_0
end

function BattleHodurStageTemplate:GetCharChipBaseID()
	return 0
end

function BattleHodurStageTemplate:GetCharChipIDList()
	return {}
end

function BattleHodurStageTemplate:GetCharChipExtraIDList()
	return {}
end

function BattleHodurStageTemplate:UpdateRoleDatas(arg_17_1)
	self.serverTeamPlayer = arg_17_1
	self.roleDataInLua = {}

	local var_17_0 = self:GetSystemHeroTeam()

	for iter_17_0, iter_17_1 in ipairs(arg_17_1.heroList) do
		table.insert(self.roleDataInLua, (BattleController.GetInstance():SetHeroDataWithHP(iter_17_1, (iter_17_1.trialID ~= 0 or nil) and (iter_17_1.trialID or var_17_0[iter_17_0] or 0), arg_17_1.playerID, arg_17_1.level, self.chapterID, self.isRestart)))
	end

	HodurSystemData:ClearChallengeTeamCache()
	self:SetMaxRaceData()
end

function BattleHodurStageTemplate:GetNextStage()
	return BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE, HodurTools.GetChallengeNextStage(self.id), {
		activityID = self.activityID_,
		chapterID = self.chapterID
	}, self:GetReserveParams())
end

return BattleHodurStageTemplate
