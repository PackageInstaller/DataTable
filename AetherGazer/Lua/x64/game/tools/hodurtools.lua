local var_0_0 = {
	GotoMainlineView = function()
		if getData("activity_hodur", "first_enter_home") ~= true then
			if GameSetting.hodur_home_story == nil then
				JumpTools.OpenPageByJump("/hodurHomeView")

				return
			end

			saveData("activity_hodur", "first_enter_home", true)

			local var_1_0 = GameSetting.hodur_home_story.value[1]

			manager.story:StartStoryById(var_1_0, function()
				JumpTools.OpenPageByJump("/hodurHomeView")
			end)

			return
		end

		JumpTools.OpenPageByJump("/hodurHomeView")
	end,
	GotoChallengeSettle = function(arg_3_0)
		JumpTools.OpenPageByJump("/hodurChallengeSettleView", {
			chapterID = arg_3_0
		})
	end,
	GoBattle = function(arg_4_0, arg_4_1, arg_4_2)
		HodurGameTempHeroData:ModifyAllHeroInfo()

		local var_4_0 = arg_4_0
		local var_4_1 = ReserveTools.GetReserveType(BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE, var_4_0)
		local var_4_2 = ReserveTools.GetContID(BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE, var_4_0)
		local var_4_3 = {
			stageType = BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE,
			stageID = var_4_0,
			activityID = arg_4_1 or 0,
			chapterID = arg_4_2 or 0
		}

		gameContext:Go("/sectionSelectHero", {
			sectionType = BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE,
			section = var_4_0,
			activityID = arg_4_1,
			chapterID = arg_4_2,
			heroDataType = HeroConst.HERO_DATA_TYPE.HODURGAME,
			reserveParams = ReserveParams.New(var_4_1, var_4_2, nil, var_4_3)
		})
	end
}

function var_0_0.GotoChallengeBattle(arg_5_0, arg_5_1, arg_5_2)
	HodurGameTempHeroData:ModifyAllHeroInfo()

	local var_5_0 = var_0_0.GetChallengeCurIndex()
	local var_5_1 = ActivityHodurChapterCfg[arg_5_0].stage_list[var_5_0][1]
	local var_5_2 = ActivityHodurChapterCfg[arg_5_0]
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_2.stage_list) do
		table.insert(var_5_3, iter_5_1[1])
	end

	local var_5_4 = ReserveTools.GetReserveType(BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE, var_5_1)
	local var_5_5 = ReserveTools.GetContID(BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE, var_5_1)
	local var_5_6 = {
		stageType = BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE,
		stageID = var_5_1,
		activityID = arg_5_1 or 0,
		chapterID = arg_5_0 or 0
	}

	gameContext:Go("/hodurChallengeSelectHeroBaseView", {
		sectionType = BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE,
		section = var_5_1,
		activityID = arg_5_1,
		chapterID = arg_5_0,
		heroDataType = HeroConst.HERO_DATA_TYPE.HODURGAME,
		reserveParams = ReserveParams.New(var_5_4, var_5_5, nil, var_5_6)
	})
end

function var_0_0.IsChallenge(arg_6_0)
	if ActivityHodurChapterCfg[arg_6_0].chapter_type == HodurConst.CHAPTER_TYPE.CHALLENGE then
		return true
	end

	return false
end

function var_0_0.GetChapterStateEmpty(arg_7_0)
	local var_7_0 = HodurSystemData:GetMainlineChapterData(arg_7_0)

	if not var_7_0 then
		return true
	end

	if #var_7_0.cur_complete_stage_list == 0 and #var_7_0.option_list == 0 then
		return true
	end

	return false
end

function var_0_0.GetStagePass(arg_8_0, arg_8_1)
	local var_8_0 = HodurSystemData:GetMainlineChapterData(arg_8_1)

	if not var_8_0 then
		return false
	end

	local var_8_1 = var_8_0.cur_complete_stage_list

	if table.indexof(var_8_1, arg_8_0) then
		return true
	end

	return false
end

function var_0_0.GetStageUnlock(arg_9_0, arg_9_1)
	local var_9_0 = false
	local var_9_1 = false
	local var_9_2 = ActivityHodurCfg[arg_9_0]
	local var_9_3 = var_9_2.previous_stage

	if var_9_3 == 0 then
		var_9_0 = true
	end

	if var_0_0.GetStagePass(var_9_3, arg_9_1) then
		var_9_0 = true
	end

	local var_9_4 = var_9_2.event_lock

	if var_9_4 == 0 then
		var_9_1 = true
	end

	if var_0_0.GetEventComplete(var_9_4, arg_9_1) then
		var_9_1 = true
	end

	return var_9_0 and var_9_1, var_9_0, var_9_1
end

function var_0_0.GetEventUnlock(arg_10_0, arg_10_1)
	local var_10_0 = ActivityHodurEventCfg[arg_10_0].condition

	if var_10_0 == 0 then
		return true
	end

	if var_0_0.GetStagePass(var_10_0, arg_10_1) then
		return true
	end

	return false
end

function var_0_0.GetEventComplete(arg_11_0, arg_11_1)
	local var_11_0 = HodurSystemData:GetMainlineChapterData(arg_11_1)

	if not var_11_0 then
		return false
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_0.option_list) do
		if ActivityHodurEventCfg.get_id_list_by_event_option[iter_11_1][1] == arg_11_0 then
			return true, iter_11_1
		end
	end

	return false, nil
end

function var_0_0.GetAffix(arg_12_0)
	local var_12_0 = HodurSystemData:GetMainlineChapterData(arg_12_0)

	if not var_12_0 then
		return {}
	end

	return var_12_0:GetAffixList()
end

function var_0_0.GetChapterState(arg_13_0)
	if var_0_0.IsChallenge(arg_13_0) then
		local var_13_0 = ActivityHodurChapterCfg[arg_13_0].previous_chapter

		if var_13_0 == 0 or var_0_0.GetChapterState(var_13_0) == HodurConst.COMMON_STATE.PASS then
			return HodurConst.COMMON_STATE.UNLOCK
		else
			return HodurConst.COMMON_STATE.LOCK
		end
	else
		local var_13_1 = HodurSystemData:GetMainlineChapterData(arg_13_0)
		local var_13_2 = ActivityHodurChapterCfg[arg_13_0].previous_chapter

		if var_13_2 == 0 or var_0_0.GetChapterState(var_13_2) == HodurConst.COMMON_STATE.PASS then
			if not var_13_1 then
				return HodurConst.COMMON_STATE.UNLOCK
			end

			local var_13_3, var_13_4 = var_13_1:GetPassNum()

			if var_13_3 >= #ActivityHodurChapterCfg[arg_13_0].stage_list then
				return HodurConst.COMMON_STATE.PASS
			else
				return HodurConst.COMMON_STATE.UNLOCK
			end
		end

		return HodurConst.COMMON_STATE.LOCK
	end
end

function var_0_0.GetCurChapterPass(arg_14_0)
	local var_14_0 = HodurSystemData:GetMainlineChapterData(arg_14_0)

	if not var_14_0 then
		return false
	end

	local var_14_1, var_14_2 = var_14_0:GetPassNum()

	if var_14_2 >= #ActivityHodurChapterCfg[arg_14_0].stage_list then
		return true
	else
		return false
	end
end

function var_0_0.GetChapterProgress(arg_15_0)
	local var_15_0 = HodurSystemData:GetMainlineChapterData(arg_15_0)

	if not var_15_0 then
		return 0, #ActivityHodurChapterCfg[arg_15_0].stage_list
	end

	local var_15_1, var_15_2 = var_15_0:GetPassNum()

	return var_15_2, #ActivityHodurChapterCfg[arg_15_0].stage_list
end

function var_0_0.GetChapterHeroHP(arg_16_0, arg_16_1, arg_16_2)
	if var_0_0.IsChallenge(arg_16_0) then
		local var_16_0 = HodurSystemData:GetChallengeData()

		if not var_16_0 then
			return -1, -1
		end

		return var_16_0:GetHeroHP(arg_16_1, arg_16_2)
	else
		local var_16_1 = HodurSystemData:GetMainlineChapterData(arg_16_0)

		if not var_16_1 then
			return -1, -1
		end

		return var_16_1:GetHeroHP(arg_16_1)
	end
end

function var_0_0.GetMainlineHeroID(arg_17_0)
	local var_17_0 = HodurSystemData:GetMainlineChapterData(arg_17_0)

	if not var_17_0 then
		return nil
	end

	if not var_17_0.hero_list or #var_17_0.hero_list == 0 then
		return nil
	end

	return var_17_0.hero_list[1].heroID
end

function var_0_0.GetChallengeHero()
	local var_18_0 = HodurSystemData:GetChallengeData()

	if not var_18_0 then
		return {}
	end

	return var_18_0:GetHeroList()
end

function var_0_0.GetChallengeBattleHero()
	local var_19_0 = HodurSystemData:GetChallengeData()

	if not var_19_0 then
		return {}
	end

	return var_19_0:GetHeroBattleList()
end

function var_0_0.GetChallengeHeroHP(arg_20_0)
	local var_20_0 = HodurSystemData:GetChallengeData()

	if not var_20_0 then
		return -1, -1
	end

	return var_20_0:GetHeroHP(arg_20_0)
end

function var_0_0.GetChallengeCurIndex()
	local var_21_0 = HodurSystemData:GetChallengeData()

	if not var_21_0 then
		return 1
	end

	local var_21_1 = var_21_0.complete_stage_list or {}

	if #(ActivityHodurChapterCfg[var_21_0.chapter_id].stage_list or {}) <= #var_21_1 then
		return #var_21_1
	end

	return #var_21_1 + 1
end

function var_0_0.GetChallengeStageUnlock(arg_22_0)
	if arg_22_0 == 1 then
		return true
	end

	local var_22_0 = HodurSystemData:GetChallengeData()

	if not var_22_0 then
		return false
	end

	return arg_22_0 <= #(var_22_0.cur_score_list or {}) + 1
end

function var_0_0.GetChallengeStageFinish(arg_23_0)
	local var_23_0 = HodurSystemData:GetChallengeData()

	if not var_23_0 then
		return false
	end

	return arg_23_0 <= #(var_23_0.cur_score_list or {})
end

function var_0_0.GetChallengeAffix()
	local var_24_0 = HodurSystemData:GetChallengeData()

	if var_24_0 and #var_24_0.buff_list > 0 then
		return var_24_0.buff_list
	end

	local var_24_1 = {}
	local var_24_2 = HodurSystemData:GetAffixCache()

	for iter_24_0, iter_24_1 in ipairs(var_24_2) do
		table.insert(var_24_1, iter_24_1)
	end

	return var_24_1
end

function var_0_0.CheckSpecialAffix()
	local var_25_0 = var_0_0.GetChallengeAffix()

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if iter_25_1 == HodurConst.SPECIAL_AFFIX_ID then
			return true
		end
	end

	return false
end

function var_0_0.GetChallengeStageMaxScore(arg_26_0)
	local var_26_0 = HodurSystemData:GetChallengeData()

	if not var_26_0 then
		return 0
	end

	if var_26_0.boss_max_score and var_26_0.boss_max_score[arg_26_0] then
		return var_26_0.boss_max_score[arg_26_0]
	end

	return 0
end

function var_0_0.GetChallengeCurScore()
	local var_27_0 = HodurSystemData:GetChallengeData()

	if not var_27_0 then
		return 0
	end

	return var_27_0:GetCurTotalScore()
end

function var_0_0.GetChallengeMaxScore()
	local var_28_0 = HodurSystemData:GetChallengeData()

	if not var_28_0 then
		return 0
	end

	return var_28_0:GetMaxScore()
end

function var_0_0.GetChallengeStageCurScore(arg_29_0)
	local var_29_0 = HodurSystemData:GetChallengeData()

	if not var_29_0 then
		return 0
	end

	if var_29_0.cur_score_list and var_29_0.cur_score_list[arg_29_0] then
		return var_29_0.cur_score_list[arg_29_0]
	end

	return 0
end

function var_0_0.GetChallengeComplete()
	local var_30_0 = HodurSystemData:GetChallengeData()

	if not var_30_0 then
		return false
	end

	local var_30_1 = var_30_0.complete_stage_list or {}
	local var_30_2 = ActivityHodurChapterCfg[var_30_0.chapter_id].stage_list or {}

	return #var_30_1 >= #var_30_2
end

function var_0_0.SettleChallenge()
	HodurSystemData:CacheChallengeData()
	HodurAction.SettleChallenge()
end

function var_0_0.GetChallengeNextStage(arg_32_0)
	local var_32_0 = ActivityHodurChapterCfg[HodurConst.CHALLENGE_CHAPTER_ID].stage_list or {}

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		if iter_32_1[1] == arg_32_0 then
			if iter_32_0 < #var_32_0 then
				return var_32_0[iter_32_0 + 1][1]
			else
				return nil
			end
		end
	end
end

function var_0_0.GetChapterIDByStageID(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(ActivityHodurChapterCfg.all) do
		local var_33_0 = ActivityHodurChapterCfg[iter_33_1]

		for iter_33_2, iter_33_3 in ipairs(var_33_0.stage_list) do
			if iter_33_3[1] == arg_33_0 then
				return iter_33_1
			end
		end
	end

	return nil
end

function var_0_0.GetChallengeScoreList()
	local var_34_0 = HodurSystemData:GetChallengeData()

	if not var_34_0 then
		return {}
	end

	return var_34_0.detail_score_list
end

return var_0_0
