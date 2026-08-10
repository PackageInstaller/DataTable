local var_0_0 = class("BattleHodurStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.chapterID = arg_1_2.chapterID
	arg_1_0.activityID_ = arg_1_2.activityID
	arg_1_0.isRestart = arg_1_2.isRestart or false
	arg_1_0.cfg = BattleHodurStageCfg[arg_1_0.id]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.InitHeroList(arg_3_0)
	arg_3_0.heroList_ = {}
	arg_3_0.heroTrialList_ = {}

	local var_3_0, var_3_1, var_3_2, var_3_3 = ReserveTools.GetHeroList(arg_3_0:GetReserveParams())

	arg_3_0.heroList_ = clone(var_3_0)
	arg_3_0.heroTrialList_ = clone(var_3_3)

	for iter_3_0 = #var_3_0, 1, -1 do
		if var_3_0[iter_3_0] == 0 then
			table.remove(arg_3_0.heroList_, iter_3_0)
			table.remove(arg_3_0.heroTrialList_, iter_3_0)
		end
	end
end

function var_0_0.GetAILevel(arg_4_0)
	return arg_4_0.cfg.ai_level
end

function var_0_0.GetDest(arg_5_0)
	return arg_5_0.id
end

function var_0_0.GetStageId(arg_6_0)
	return arg_6_0.id
end

function var_0_0.GetType(arg_7_0)
	return BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE
end

function var_0_0.GetMap(arg_8_0)
	return arg_8_0.cfg.map, false
end

function var_0_0.GetEnemyLevel(arg_9_0)
	return arg_9_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetChapterID(arg_11_0)
	return arg_11_0.chapterID
end

function var_0_0.GetStageAffix(arg_12_0)
	local var_12_0 = {}

	if HodurTools.IsChallenge(arg_12_0.chapterID) then
		var_12_0 = HodurTools.GetChallengeAffix()
	else
		var_12_0 = HodurTools.GetAffix(arg_12_0.chapterID)
	end

	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_4 = 1
		local var_12_5 = 3
		local var_12_6 = PublicBuffCfg[iter_12_1]

		if var_12_6 then
			local var_12_7 = ActivityAffixPoolCfg[var_12_6.buff_class_id]

			if var_12_7 then
				var_12_4 = var_12_7.affix[2]
				var_12_5 = var_12_7.affix[3]
			end
		end

		table.insert(var_12_1, iter_12_1)
		table.insert(var_12_2, var_12_4)
		table.insert(var_12_3, var_12_5)
	end

	return var_12_1, var_12_2, var_12_3
end

function var_0_0.GetOpts(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}

	if HodurTools.IsChallenge(arg_13_0.chapterID) then
		var_13_1 = HodurTools.GetChallengeAffix()
	else
		var_13_1 = HodurTools.GetAffix(arg_13_0.chapterID)
	end

	local var_13_2 = {
		key = 1,
		value = var_13_1
	}

	table.insert(var_13_0, var_13_2)

	return var_13_0
end

function var_0_0.GetCharChipBaseID(arg_14_0)
	return 0
end

function var_0_0.GetCharChipIDList(arg_15_0)
	return {}
end

function var_0_0.GetCharChipExtraIDList(arg_16_0)
	return {}
end

function var_0_0.UpdateRoleDatas(arg_17_0, arg_17_1)
	arg_17_0.serverTeamPlayer = arg_17_1
	arg_17_0.roleDataInLua = {}

	local var_17_0 = arg_17_0:GetSystemHeroTeam()

	for iter_17_0, iter_17_1 in ipairs(arg_17_1.heroList) do
		local var_17_1 = iter_17_1.trialID ~= 0 and iter_17_1.trialID or var_17_0[iter_17_0] or 0
		local var_17_2 = BattleController.GetInstance():SetHeroDataWithHP(iter_17_1, var_17_1, arg_17_1.playerID, arg_17_1.level, arg_17_0.chapterID, arg_17_0.isRestart)

		table.insert(arg_17_0.roleDataInLua, var_17_2)
	end

	HodurSystemData:ClearChallengeTeamCache()
	arg_17_0:SetMaxRaceData()
end

function var_0_0.GetNextStage(arg_18_0)
	local var_18_0 = HodurTools.GetChallengeNextStage(arg_18_0.id)

	return BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE, var_18_0, {
		activityID = arg_18_0.activityID_,
		chapterID = arg_18_0.chapterID
	}, arg_18_0:GetReserveParams())
end

return var_0_0
