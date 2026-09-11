local ChallengeRogueTeamOverView = class("ChallengeRogueTeamOverView", ReduxView)

function ChallengeRogueTeamOverView:UIName()
	return "Widget/System/Activity_Roulike/RogueTeamStatisticsUI"
end

function ChallengeRogueTeamOverView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamOverView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.contentController_ = self.controller_:GetController("content")
	self.btnController_ = self.controller_:GetController("btn")
	self.bgController_ = self.controller_:GetController("bgstate")
end

function ChallengeRogueTeamOverView:OnEnter()
	self.contentIndex_ = ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.POINT
	self.btnText2_.text = GetTips("ROGUE_TEAM_NEXT_PAGE")

	TimelineTools.PlayTimelineWithCallback(self.phaseTimeLine_1, self.phaseTimeLine_1.playableAsset, function()
		self.phaseTimeLine_1.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
		self.phaseTimeLine_1.time = self.phaseTimeLine_1.duration

		self.phaseTimeLine_1:Evaluate()

		self.timeline1Complete_ = true
	end)
	self:RefreshUI()
end

function ChallengeRogueTeamOverView:OnExit()
	ChallengeRogueTeamData:ExitPlaying()
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_EXIT)
end

function ChallengeRogueTeamOverView:Dispose()
	if self.summaryView_ then
		self.summaryView_:Dispose()

		self.summaryView_ = nil
	end

	if self.statisticsView_ then
		self.statisticsView_:Dispose()

		self.statisticsView_ = nil
	end

	if self.newRelicView_ then
		self.newRelicView_:Dispose()

		self.newRelicView_ = nil
	end

	ChallengeRogueTeamOverView.super.Dispose(self)
end

function ChallengeRogueTeamOverView:AddListeners()
	self:AddBtnListener(self.nextBtn_, nil, function()
		if not self.timeline1Complete_ then
			return
		end

		if self.contentIndex_ == ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.POINT then
			self.contentIndex_ = ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.SUMMARY

			TimelineTools.PlayTimelineWithCallback(self.phaseTimeLine_2, self.phaseTimeLine_2.playableAsset, function()
				self.phaseTimeLine_2.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
				self.phaseTimeLine_2.time = self.phaseTimeLine_2.duration

				self.phaseTimeLine_2:Evaluate()

				self.timeline2Complete_ = true
			end)
			self:RefreshUI()
		elseif self.contentIndex_ == ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.RELIC then
			ChallengeRogueTeamAction.GotoRogueTeamEntrace()
		end
	end)
	self:AddBtnListener(self.nextBtn_2, nil, function()
		if not self.timeline1Complete_ then
			return
		end

		self.contentIndex_ = ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.SUMMARY

		TimelineTools.PlayTimelineWithCallback(self.phaseTimeLine_2, self.phaseTimeLine_2.playableAsset, function()
			self.phaseTimeLine_2.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
			self.phaseTimeLine_2.time = self.phaseTimeLine_2.duration

			self.phaseTimeLine_2:Evaluate()

			self.timeline2Complete_ = true
		end)
		self:RefreshUI()
	end)
	self:AddBtnListener(self.btn2_, nil, function()
		if not self.timeline2Complete_ then
			return
		end

		if self.contentIndex_ == ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.SUMMARY then
			local var_13_0 = ChallengeRogueTeamData:GetOverStaticUnlockRelicDataList()

			if var_13_0 and not table.isEmpty(var_13_0) then
				self.contentIndex_ = ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.RELIC

				self:RefreshUI()
			else
				ChallengeRogueTeamAction.GotoRogueTeamEntrace()
			end
		end
	end)
end

function ChallengeRogueTeamOverView:RefreshUI()
	if self.contentIndex_ == ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.SUMMARY then
		if self.summaryView_ == nil then
			self.summaryView_ = ChallengeRogueTeamOverStatisticsSummaryView.New(self.summaryGo_)

			local var_14_0 = ChallengeRogueTeamData:GetOverStaticUnlockRelicDataList()

			self.isHaveNewRelic_ = var_14_0 and not table.isEmpty(var_14_0)

			self.btnController_:SetSelectedState("show")

			self.btnText2_.text = self.isHaveNewRelic_ and GetTips("ROGUE_TEAM_NEXT_PAGE") or GetTips("ROGUE_TEAM_SURE")
		end
	elseif self.contentIndex_ == ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.POINT then
		if self.statisticsView_ == nil then
			self.statisticsView_ = ChallengeRogueTeamOverStatisticsPointView.New(self.pointGo_)
		end

		self.contentController_:SetSelectedState("normal")
		self.btnController_:SetSelectedState("hide")
	else
		if self.newRelicView_ == nil then
			self.newRelicView_ = ChallengeRogueTeamOverStatisticsNewRelicView.New(self.newRelicGo_)
		end

		self.contentController_:SetSelectedState("relic")
	end

	if ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.OVER then
		self.bgController_:SetSelectedState("win")
	else
		self.bgController_:SetSelectedState("defeat")
	end
end

function ChallengeRogueTeamOverView:Cacheable()
	return false
end

return ChallengeRogueTeamOverView
