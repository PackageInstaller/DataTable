local var_0_0 = class("ChallengeRogueTeamOverStatisticsSummaryView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.firstPlayFlag_ = true
	arg_1_0.resultController_ = arg_1_0.controllerEx_:GetController("result")
	arg_1_0.mutiController_ = arg_1_0.controllerEx_:GetController("muti")
	arg_1_0.selectedList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.selectedListGo_, ChallengeRogueTeamSelectedItem)

	arg_1_0:RefreshUI()
end

function var_0_0.IndexItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2:RefreshData(arg_2_0.selectedAffixList_[arg_2_1])
end

function var_0_0.Dispose(arg_3_0)
	if arg_3_0.selectedList_ then
		arg_3_0.selectedList_:Dispose()

		arg_3_0.selectedList_ = nil
	end

	arg_3_0.suitSkillView_:Dispose()

	arg_3_0.suitSkillView_ = nil

	arg_3_0.relicView_:Dispose()

	arg_3_0.relicView_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.suitSkillView_ = ChallengeRogueTeamOverStatisticsSummarySuitSkillView.New(arg_5_0.suitSkillGo_)
	arg_5_0.relicView_ = ChallengeRogueTeamOverStatisticsSummaryRelicView.New(arg_5_0.relicGo_)
	arg_5_0.teamView_ = ChallengeRogueTeamOverStatisticsSummaryTeamView.New(arg_5_0.teamGo_)

	if ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.OVER then
		arg_5_0.resultController_:SetSelectedState("win")
	else
		arg_5_0.resultController_:SetSelectedState("defeat")
	end

	arg_5_0.timeText_.text = manager.time:DescCdTime2(ChallengeRogueTeamData:GetTotalTime())

	local var_5_0 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_5_1 = ChallengeRogueTeamData:GetLastDifficultyID(var_5_0) or 1
	local var_5_2 = RogueTeamDifficultyCfg[var_5_1]

	arg_5_0.mutiText_.text = "x" .. GameSetting.rogue_team_multi_reward.value[1]

	local var_5_3 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUE_DOUBLE_REWARD_4_4)

	arg_5_0.mutiController_:SetSelectedState(tostring(var_5_3:IsActivitying()))

	arg_5_0.gradeText_.text = NumberTools.IntToRomam(table.keyof(RogueTeamDifficultyCfg.get_id_list_by_template_id[var_5_2.template_id], var_5_1))

	if #var_5_2.affix_pool > 0 then
		local var_5_4, var_5_5 = ChallengeRogueTeamData:GetOptionalAffix()
		local var_5_6 = var_5_2.score + var_5_4 * ChallengeRogueTeamConst.OPTIONAL_AFFIX_MULTIPLE
		local var_5_7 = ChallengeRogueTeamConst.OPTIONAL_AFFIX_MAX_MULTIPLE

		arg_5_0.difficultMultiple_.text = math.min(var_5_6, var_5_7) .. "%"
	else
		arg_5_0.difficultMultiple_.text = var_5_2.score .. "%"
	end

	local var_5_8 = ChallengeRogueTeamData:GetOverStatisticsData() or {}
	local var_5_9 = var_5_8[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.TOTAL_POINT]

	arg_5_0.originPointText_.text = string.format("+%s", var_5_8[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.ORIGIN_POINT])
	arg_5_0.totalPointText_.text = string.format("+%s", math.floor(var_5_9 * ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_TIMES) / 1000))
	arg_5_0.skillPointText_.text = string.format("+%s", math.floor(var_5_9 * ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.SKILL_POINT_TIMES) / 1000))

	local var_5_10
	local var_5_11 = ChallengeRogueTeamData:PlotGetEndingID()
	local var_5_12 = RogueTeamCfg[var_5_0].ending_temp

	if not ChallengeRogueTeamData:GetGuideStatisticsFlag() then
		local var_5_13 = RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[var_5_12][99][1]

		var_5_10 = RogueTeamEndingCfg[var_5_13]
	elseif ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.FAIL or var_5_11 == 0 then
		local var_5_14 = RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[var_5_12][0][1]

		var_5_10 = RogueTeamEndingCfg[var_5_14]
	else
		var_5_10 = RogueTeamEndingCfg[var_5_11]
	end

	if not string.isNullOrEmpty(var_5_10.image) then
		arg_5_0.endingImg_.sprite = getSpriteWithoutAtlas(var_5_10.image)
	end

	arg_5_0.floorText_.text = ChallengeRogueTeamTools.GetFloorName()
	arg_5_0.titleText_1.text = var_5_10.story_name
	arg_5_0.titleText_2.text = var_5_10.story_name
	arg_5_0.totalHeight_ = 0

	arg_5_0.suitSkillView_:Show(true)
	arg_5_0.relicView_:Show(true)
	arg_5_0.teamView_:Show(true)

	arg_5_0.selectedLevelNum_, arg_5_0.selectedAffixList_ = ChallengeRogueTeamData:GetOptionalAffix()

	SetActive(arg_5_0.optionalAffixGo_, #arg_5_0.selectedAffixList_ > 0)

	if #arg_5_0.selectedAffixList_ > 0 then
		arg_5_0.selectedLevelText_.text = arg_5_0.selectedLevelNum_

		arg_5_0.selectedList_:StartScroll(#arg_5_0.selectedAffixList_)
	end
end

function var_0_0.StopAnimator(arg_6_0)
	if arg_6_0.firstPlayFlag_ == false then
		return
	end

	arg_6_0.firstPlayFlag_ = false
	arg_6_0.scrollView_.enabled = true

	arg_6_0:StopTimer()
	arg_6_0:StopMoveTimer()
	arg_6_0.suitSkillView_:Show(true)
	arg_6_0.relicView_:Show(true)
	arg_6_0.teamView_:Show(true)

	arg_6_0.scrollView_.normalizedPosition = Vector2(0, 0)

	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_STATISTICS_SUMMARY_ANIMATOR_OVER)
end

function var_0_0.GetFirstPalyFlag(arg_7_0)
	return arg_7_0.firstPlayFlag_
end

function var_0_0.PlayDescAnimator(arg_8_0)
	arg_8_0.scrollView_.enabled = false

	arg_8_0:PauseAnimator(GameSetting.rogue_team_statistics_mode_pause_time.value[1], function()
		local var_9_0 = arg_8_0.suitSkillView_:GetHeight()

		arg_8_0.totalHeight_ = var_9_0

		arg_8_0:PlaySuitSkillAnimator()
	end)
end

function var_0_0.PlaySuitSkillAnimator(arg_10_0)
	arg_10_0.suitSkillView_:Show(true)
	arg_10_0:PauseAnimator(GameSetting.rogue_team_statistics_mode_pause_time.value[1], function()
		local var_11_0 = arg_10_0.suitSkillView_:GetHeight()
		local var_11_1 = arg_10_0.relicView_:GetHeight()

		if var_11_1 >= arg_10_0.viewPortHeight_ then
			arg_10_0:MoveContent(var_11_0, function()
				arg_10_0:PlayRelicAnimator()
			end)
		else
			arg_10_0.totalHeight_ = arg_10_0.totalHeight_ + arg_10_0.layoutSpace_ + var_11_1

			if arg_10_0.totalHeight_ > arg_10_0.viewPortHeight_ then
				arg_10_0:MoveContent(arg_10_0.totalHeight_ - arg_10_0.viewPortHeight_, function()
					arg_10_0:PlayRelicAnimator()
				end)
			else
				arg_10_0:PlayRelicAnimator()
			end
		end
	end)
end

function var_0_0.PlayRelicAnimator(arg_14_0, arg_14_1)
	arg_14_0.relicView_:Show(true)
	arg_14_0:PauseAnimator(GameSetting.rogue_team_statistics_mode_pause_time.value[1], function()
		local var_15_0 = arg_14_0.suitSkillView_:GetHeight()
		local var_15_1 = arg_14_0.relicView_:GetHeight()
		local var_15_2 = arg_14_0.teamView_:GetHeight()

		if var_15_2 >= arg_14_0.viewPortHeight_ then
			arg_14_0:MoveContent(arg_14_0.totalHeight_ + arg_14_0.layoutSpace_ - arg_14_0.viewPortHeight_, function()
				arg_14_0:PlayTeamAnimator()
			end)
		else
			arg_14_0.totalHeight_ = arg_14_0.totalHeight_ + arg_14_0.layoutSpace_ + var_15_2

			if arg_14_0.totalHeight_ > arg_14_0.viewPortHeight_ then
				arg_14_0:MoveContent(arg_14_0.totalHeight_ - arg_14_0.viewPortHeight_, function()
					arg_14_0:PlayTeamAnimator()
				end)
			else
				arg_14_0:PlayTeamAnimator()
			end
		end
	end)
end

function var_0_0.PlayTeamAnimator(arg_18_0)
	arg_18_0.teamView_:Show(true)
	arg_18_0:PauseAnimator(GameSetting.rogue_team_statistics_mode_pause_time.value[1], function()
		local var_19_0 = arg_18_0.teamView_:GetHeight()

		arg_18_0:MoveContent(arg_18_0.totalHeight_ - arg_18_0.viewPortHeight_, function()
			arg_18_0:StopAnimator()
		end)
	end)
end

function var_0_0.MoveContent(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:StopMoveTimer()

	arg_21_0.moveTimer_ = FrameTimer.New(function()
		local var_22_0 = arg_21_0.contentTf_.localPosition

		var_22_0.y = var_22_0.y + GameSetting.rogue_team_statistics_scroll_y_value.value[1]

		if var_22_0.y >= arg_21_1 then
			var_22_0.y = arg_21_1
			arg_21_0.contentTf_.localPosition = var_22_0

			arg_21_0:StopMoveTimer()
			arg_21_2()
		end

		arg_21_0.contentTf_.localPosition = var_22_0
	end, 1, -1)

	arg_21_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_23_0)
	if arg_23_0.moveTimer_ then
		arg_23_0.moveTimer_:Stop()

		arg_23_0.moveTimer_ = nil
	end
end

function var_0_0.PauseAnimator(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.timer_ = Timer.New(function()
		arg_24_0:StopTimer()
		arg_24_2()
	end, arg_24_1, 1)

	arg_24_0.timer_:Start()
end

function var_0_0.StopTimer(arg_26_0)
	if arg_26_0.timer_ then
		arg_26_0.timer_:Stop()

		arg_26_0.timer_ = nil
	end
end

return var_0_0
