local ChallengeRogueTeamOverStatisticsSummaryView = class("ChallengeRogueTeamOverStatisticsSummaryView", ReduxView)

function ChallengeRogueTeamOverStatisticsSummaryView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.firstPlayFlag_ = true
	self.resultController_ = self.controllerEx_:GetController("result")
	self.mutiController_ = self.controllerEx_:GetController("muti")
	self.selectedList_ = LuaList.New(handler(self, self.IndexItem), self.selectedListGo_, ChallengeRogueTeamSelectedItem)

	self:RefreshUI()
end

function ChallengeRogueTeamOverStatisticsSummaryView:IndexItem(arg_2_1, arg_2_2)
	arg_2_2:RefreshData(self.selectedAffixList_[arg_2_1])
end

function ChallengeRogueTeamOverStatisticsSummaryView:Dispose()
	if self.selectedList_ then
		self.selectedList_:Dispose()

		self.selectedList_ = nil
	end

	self.suitSkillView_:Dispose()

	self.suitSkillView_ = nil

	self.relicView_:Dispose()

	self.relicView_ = nil

	ChallengeRogueTeamOverStatisticsSummaryView.super.Dispose(self)
end

function ChallengeRogueTeamOverStatisticsSummaryView:AddListeners()
	return
end

function ChallengeRogueTeamOverStatisticsSummaryView:RefreshUI()
	self.suitSkillView_ = ChallengeRogueTeamOverStatisticsSummarySuitSkillView.New(self.suitSkillGo_)
	self.relicView_ = ChallengeRogueTeamOverStatisticsSummaryRelicView.New(self.relicGo_)
	self.teamView_ = ChallengeRogueTeamOverStatisticsSummaryTeamView.New(self.teamGo_)

	if ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.OVER then
		self.resultController_:SetSelectedState("win")
	else
		self.resultController_:SetSelectedState("defeat")
	end

	self.timeText_.text = manager.time:DescCdTime2(ChallengeRogueTeamData:GetTotalTime())

	local var_5_0 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_5_1 = ChallengeRogueTeamData:GetLastDifficultyID(var_5_0) or 1
	local var_5_2 = RogueTeamDifficultyCfg[var_5_1]

	self.mutiText_.text = "x" .. GameSetting.rogue_team_multi_reward.value[1]

	self.mutiController_:SetSelectedState(tostring(ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUE_DOUBLE_REWARD_4_4):IsActivitying()))

	self.gradeText_.text = NumberTools.IntToRomam(table.keyof(RogueTeamDifficultyCfg.get_id_list_by_template_id[var_5_2.template_id], var_5_1))

	if #var_5_2.affix_pool > 0 then
		local var_5_3, var_5_4 = ChallengeRogueTeamData:GetOptionalAffix()

		self.difficultMultiple_.text = math.min(var_5_2.score + var_5_3 * ChallengeRogueTeamConst.OPTIONAL_AFFIX_MULTIPLE, ChallengeRogueTeamConst.OPTIONAL_AFFIX_MAX_MULTIPLE) .. "%"
	else
		self.difficultMultiple_.text = var_5_2.score .. "%"
	end

	local var_5_5 = ChallengeRogueTeamData:GetOverStatisticsData() or {}
	local var_5_6 = var_5_5[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.TOTAL_POINT]

	self.originPointText_.text = string.format("+%s", var_5_5[ChallengeRogueTeamConst.OVER_STATISTICS_TYPE.ORIGIN_POINT])
	self.totalPointText_.text = string.format("+%s", math.floor(var_5_6 * ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_TIMES) / 1000))
	self.skillPointText_.text = string.format("+%s", math.floor(var_5_6 * ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.SKILL_POINT_TIMES) / 1000))

	local var_5_7
	local var_5_8 = ChallengeRogueTeamData:PlotGetEndingID()

	var_5_7 = not ChallengeRogueTeamData:GetGuideStatisticsFlag() and RogueTeamEndingCfg[RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[RogueTeamCfg[var_5_0].ending_temp][99][1]] or (ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.FAIL or var_5_8 == 0) and RogueTeamEndingCfg[RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[RogueTeamCfg[var_5_0].ending_temp][0][1]] or RogueTeamEndingCfg[var_5_8]

	if not string.isNullOrEmpty(var_5_7.image) then
		self.endingImg_.sprite = getSpriteWithoutAtlas(var_5_7.image)
	end

	self.floorText_.text = ChallengeRogueTeamTools.GetFloorName()
	self.titleText_1.text = var_5_7.story_name
	self.titleText_2.text = var_5_7.story_name
	self.totalHeight_ = 0

	self.suitSkillView_:Show(true)
	self.relicView_:Show(true)
	self.teamView_:Show(true)

	self.selectedLevelNum_, self.selectedAffixList_ = ChallengeRogueTeamData:GetOptionalAffix()

	SetActive(self.optionalAffixGo_, #self.selectedAffixList_ > 0)

	if #self.selectedAffixList_ > 0 then
		self.selectedLevelText_.text = self.selectedLevelNum_

		self.selectedList_:StartScroll(#self.selectedAffixList_)
	end
end

function ChallengeRogueTeamOverStatisticsSummaryView:StopAnimator()
	if self.firstPlayFlag_ == false then
		return
	end

	self.firstPlayFlag_ = false
	self.scrollView_.enabled = true

	self:StopTimer()
	self:StopMoveTimer()
	self.suitSkillView_:Show(true)
	self.relicView_:Show(true)
	self.teamView_:Show(true)

	self.scrollView_.normalizedPosition = Vector2(0, 0)

	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_STATISTICS_SUMMARY_ANIMATOR_OVER)
end

function ChallengeRogueTeamOverStatisticsSummaryView:GetFirstPalyFlag()
	return self.firstPlayFlag_
end

function ChallengeRogueTeamOverStatisticsSummaryView:PlayDescAnimator()
	self.scrollView_.enabled = false

	self:PauseAnimator(GameSetting.rogue_team_statistics_mode_pause_time.value[1], function()
		self.totalHeight_ = self.suitSkillView_:GetHeight()

		self:PlaySuitSkillAnimator()
	end)
end

function ChallengeRogueTeamOverStatisticsSummaryView:PlaySuitSkillAnimator()
	self.suitSkillView_:Show(true)
	self:PauseAnimator(GameSetting.rogue_team_statistics_mode_pause_time.value[1], function()
		local var_11_0 = self.relicView_:GetHeight()

		if var_11_0 >= self.viewPortHeight_ then
			self:MoveContent(self.suitSkillView_:GetHeight(), function()
				self:PlayRelicAnimator()
			end)
		else
			self.totalHeight_ = self.totalHeight_ + self.layoutSpace_ + var_11_0

			if self.totalHeight_ > self.viewPortHeight_ then
				self:MoveContent(self.totalHeight_ - self.viewPortHeight_, function()
					self:PlayRelicAnimator()
				end)
			else
				self:PlayRelicAnimator()
			end
		end
	end)
end

function ChallengeRogueTeamOverStatisticsSummaryView:PlayRelicAnimator(arg_14_1)
	self.relicView_:Show(true)
	self:PauseAnimator(GameSetting.rogue_team_statistics_mode_pause_time.value[1], function()
		local var_15_0 = self.suitSkillView_:GetHeight()
		local var_15_1 = self.relicView_:GetHeight()
		local var_15_2 = self.teamView_:GetHeight()

		if var_15_2 >= self.viewPortHeight_ then
			self:MoveContent(self.totalHeight_ + self.layoutSpace_ - self.viewPortHeight_, function()
				self:PlayTeamAnimator()
			end)
		else
			self.totalHeight_ = self.totalHeight_ + self.layoutSpace_ + var_15_2

			if self.totalHeight_ > self.viewPortHeight_ then
				self:MoveContent(self.totalHeight_ - self.viewPortHeight_, function()
					self:PlayTeamAnimator()
				end)
			else
				self:PlayTeamAnimator()
			end
		end
	end)
end

function ChallengeRogueTeamOverStatisticsSummaryView:PlayTeamAnimator()
	self.teamView_:Show(true)
	self:PauseAnimator(GameSetting.rogue_team_statistics_mode_pause_time.value[1], function()
		local var_19_0 = self.teamView_:GetHeight()

		self:MoveContent(self.totalHeight_ - self.viewPortHeight_, function()
			self:StopAnimator()
		end)
	end)
end

function ChallengeRogueTeamOverStatisticsSummaryView:MoveContent(arg_21_1, arg_21_2)
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		self.contentTf_.localPosition.y = self.contentTf_.localPosition.y + GameSetting.rogue_team_statistics_scroll_y_value.value[1]

		if self.contentTf_.localPosition.y >= arg_21_1 then
			self.contentTf_.localPosition.y = arg_21_1
			self.contentTf_.localPosition = self.contentTf_.localPosition

			self:StopMoveTimer()
			arg_21_2()
		end

		self.contentTf_.localPosition = self.contentTf_.localPosition
	end, 1, -1)

	self.moveTimer_:Start()
end

function ChallengeRogueTeamOverStatisticsSummaryView:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

function ChallengeRogueTeamOverStatisticsSummaryView:PauseAnimator(arg_24_1, arg_24_2)
	self.timer_ = Timer.New(function()
		self:StopTimer()
		arg_24_2()
	end, arg_24_1, 1)

	self.timer_:Start()
end

function ChallengeRogueTeamOverStatisticsSummaryView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ChallengeRogueTeamOverStatisticsSummaryView
