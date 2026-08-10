local var_0_0 = class("ChallengeRogueTeamOverView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RogueTeamStatisticsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.contentController_ = arg_3_0.controller_:GetController("content")
	arg_3_0.btnController_ = arg_3_0.controller_:GetController("btn")
	arg_3_0.bgController_ = arg_3_0.controller_:GetController("bgstate")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.contentIndex_ = ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.POINT
	arg_4_0.btnText2_.text = GetTips("ROGUE_TEAM_NEXT_PAGE")

	TimelineTools.PlayTimelineWithCallback(arg_4_0.phaseTimeLine_1, arg_4_0.phaseTimeLine_1.playableAsset, function()
		arg_4_0.phaseTimeLine_1.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
		arg_4_0.phaseTimeLine_1.time = arg_4_0.phaseTimeLine_1.duration

		arg_4_0.phaseTimeLine_1:Evaluate()

		arg_4_0.timeline1Complete_ = true
	end)
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_6_0)
	ChallengeRogueTeamData:ExitPlaying()
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_EXIT)
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.summaryView_ then
		arg_7_0.summaryView_:Dispose()

		arg_7_0.summaryView_ = nil
	end

	if arg_7_0.statisticsView_ then
		arg_7_0.statisticsView_:Dispose()

		arg_7_0.statisticsView_ = nil
	end

	if arg_7_0.newRelicView_ then
		arg_7_0.newRelicView_:Dispose()

		arg_7_0.newRelicView_ = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.nextBtn_, nil, function()
		if not arg_8_0.timeline1Complete_ then
			return
		end

		if arg_8_0.contentIndex_ == ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.POINT then
			arg_8_0.contentIndex_ = ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.SUMMARY

			TimelineTools.PlayTimelineWithCallback(arg_8_0.phaseTimeLine_2, arg_8_0.phaseTimeLine_2.playableAsset, function()
				arg_8_0.phaseTimeLine_2.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
				arg_8_0.phaseTimeLine_2.time = arg_8_0.phaseTimeLine_2.duration

				arg_8_0.phaseTimeLine_2:Evaluate()

				arg_8_0.timeline2Complete_ = true
			end)
			arg_8_0:RefreshUI()
		elseif arg_8_0.contentIndex_ == ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.RELIC then
			ChallengeRogueTeamAction.GotoRogueTeamEntrace()
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.nextBtn_2, nil, function()
		if not arg_8_0.timeline1Complete_ then
			return
		end

		arg_8_0.contentIndex_ = ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.SUMMARY

		TimelineTools.PlayTimelineWithCallback(arg_8_0.phaseTimeLine_2, arg_8_0.phaseTimeLine_2.playableAsset, function()
			arg_8_0.phaseTimeLine_2.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
			arg_8_0.phaseTimeLine_2.time = arg_8_0.phaseTimeLine_2.duration

			arg_8_0.phaseTimeLine_2:Evaluate()

			arg_8_0.timeline2Complete_ = true
		end)
		arg_8_0:RefreshUI()
	end)
	arg_8_0:AddBtnListener(arg_8_0.btn2_, nil, function()
		if not arg_8_0.timeline2Complete_ then
			return
		end

		if arg_8_0.contentIndex_ == ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.SUMMARY then
			local var_13_0 = ChallengeRogueTeamData:GetOverStaticUnlockRelicDataList()

			if var_13_0 and not table.isEmpty(var_13_0) then
				arg_8_0.contentIndex_ = ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.RELIC

				arg_8_0:RefreshUI()
			else
				ChallengeRogueTeamAction.GotoRogueTeamEntrace()
			end
		end
	end)
end

function var_0_0.RefreshUI(arg_14_0)
	if arg_14_0.contentIndex_ == ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.SUMMARY then
		if arg_14_0.summaryView_ == nil then
			arg_14_0.summaryView_ = ChallengeRogueTeamOverStatisticsSummaryView.New(arg_14_0.summaryGo_)

			local var_14_0 = ChallengeRogueTeamData:GetOverStaticUnlockRelicDataList()

			arg_14_0.isHaveNewRelic_ = var_14_0 and not table.isEmpty(var_14_0)

			arg_14_0.btnController_:SetSelectedState("show")

			arg_14_0.btnText2_.text = arg_14_0.isHaveNewRelic_ and GetTips("ROGUE_TEAM_NEXT_PAGE") or GetTips("ROGUE_TEAM_SURE")
		end
	elseif arg_14_0.contentIndex_ == ChallengeRogueTeamConst.OVER_STATISTICS_CONTENT_TYPE.POINT then
		if arg_14_0.statisticsView_ == nil then
			arg_14_0.statisticsView_ = ChallengeRogueTeamOverStatisticsPointView.New(arg_14_0.pointGo_)
		end

		arg_14_0.contentController_:SetSelectedState("normal")
		arg_14_0.btnController_:SetSelectedState("hide")
	else
		if arg_14_0.newRelicView_ == nil then
			arg_14_0.newRelicView_ = ChallengeRogueTeamOverStatisticsNewRelicView.New(arg_14_0.newRelicGo_)
		end

		arg_14_0.contentController_:SetSelectedState("relic")
	end

	if ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.OVER then
		arg_14_0.bgController_:SetSelectedState("win")
	else
		arg_14_0.bgController_:SetSelectedState("defeat")
	end
end

function var_0_0.Cacheable(arg_15_0)
	return false
end

return var_0_0
