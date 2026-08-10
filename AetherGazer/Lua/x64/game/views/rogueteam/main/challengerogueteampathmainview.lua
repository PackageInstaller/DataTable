local var_0_0 = class("ChallengeRogueTeamPathMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikePanelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.onInitMapHandler_ = handler(arg_3_0, arg_3_0.OnInitMap)
	arg_3_0.exitPlayingHandler_ = handler(arg_3_0, arg_3_0.ExitPlaying)
	arg_3_0.finishNodeHandler_ = handler(arg_3_0, arg_3_0.OnFinishNode)
	arg_3_0.onWindowUpdateHandler_ = handler(arg_3_0, arg_3_0.OnWindowUpdate)
	arg_3_0.onCheckEndingProcessHandler_ = handler(arg_3_0, arg_3_0.CheckEndingProcess)
	arg_3_0.overStaticHandler_ = handler(arg_3_0, arg_3_0.GameOverStatic)
	arg_3_0.mapView_ = ChallengeRogueTeamMapBaseView.New(arg_3_0.scrollViewGo_)

	local var_3_0 = arg_3_0.ringTf_.localEulerAngles

	arg_3_0.tempEulerAngles_ = Vector3(var_3_0.x, var_3_0.y, var_3_0.z)
	arg_3_0.mapController_ = arg_3_0.mapCon_:GetController("bg")

	arg_3_0.mapController_:SetSelectedState("normal")

	arg_3_0.refreshAtmosphereHandler_ = handler(arg_3_0, arg_3_0.RefreshAtmosphere)
end

function var_0_0.OnEnter(arg_4_0)
	ChallengeRogueTeamData:UISetEventIDAnimator()
	arg_4_0:RefreshBGM()

	local var_4_0 = GameSetting.rogue_team_map_help.value

	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			hideHomeBtn = 1,
			isPrefab = true,
			pages = var_4_0
		}
	})
	ChallengeRogueTeamTools.RegistWindowBarClick()
	ChallengeRogueTeamTools.ShowBarList()
	arg_4_0.mapView_:OnEnter()
	arg_4_0:RefreshUI()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_MAP_INIT, arg_4_0.onInitMapHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_EXIT, arg_4_0.exitPlayingHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_MAP_CLEAR, arg_4_0.onCheckEndingProcessHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_GAME_OVER_STATIC, arg_4_0.overStaticHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_PATH_FINISH_NODE, arg_4_0.finishNodeHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, arg_4_0.onWindowUpdateHandler_)
	manager.notify:RegistListener(CHALLENGE_SPECIAL_ENDING, arg_4_0.refreshAtmosphereHandler_)
	arg_4_0:AddRingTimer()
end

function var_0_0.OnEnterOver(arg_5_0)
	arg_5_0.mapView_:OnEnterOver()
	arg_5_0:CheckEndingProcess()
end

function var_0_0.GameOverStatic(arg_6_0)
	if table.length(ChallengeRogueTeamData:GetOverStatisticsData()) > 0 then
		JumpTools.OpenPageByJump("challengeRogueTeamOverStatistics")
	end
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.MAIN)
	ChallengeRogueTeamData:UISetSelectNodeID()

	if table.length(ChallengeRogueTeamData:GetOverStatisticsData()) > 0 then
		JumpTools.OpenPageByJump("challengeRogueTeamOverStatistics")

		return
	end

	if table.length(ChallengeRogueTeamData:PathGetNodeList()) <= 0 then
		arg_7_0:ExitPlaying()
	elseif arg_7_0.params_.isBattleBack then
		FrameTimer.New(function()
			arg_7_0:PopWindowProcess()
		end, 30, 1):Start()
	else
		arg_7_0:PopWindowProcess()
	end

	arg_7_0.mapView_:OnTop()
end

function var_0_0.OnBehind(arg_9_0)
	if arg_9_0:IsOpenRoute("challengeRogueTeamSectionInfo") then
		-- block empty
	else
		manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.OTHER)
	end
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.mapView_:OnExit()
	manager.windowBar:HideBar()
	ChallengeRogueTeamTools.HideBarList()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_MAP_INIT, arg_10_0.onInitMapHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_EXIT, arg_10_0.exitPlayingHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_PATH_FINISH_NODE, arg_10_0.finishNodeHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_MAP_CLEAR, arg_10_0.onCheckEndingProcessHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_GAME_OVER_STATIC, arg_10_0.overStaticHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, arg_10_0.onWindowUpdateHandler_)
	manager.notify:RemoveListener(CHALLENGE_SPECIAL_ENDING, arg_10_0.refreshAtmosphereHandler_)
	arg_10_0:StopRingTimer()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.onInitMapHandler_ = nil
	arg_11_0.exitPlayingHandler_ = nil
	arg_11_0.finishNodeHandler_ = nil
	arg_11_0.onWindowUpdateHandler_ = nil
	arg_11_0.onCheckEndingProcessHandler_ = nil
	arg_11_0.overStaticHandler_ = nil

	arg_11_0.mapView_:Dispose()

	arg_11_0.mapView_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.AddListeners(arg_12_0)
	return
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshAtmosphere()
	arg_13_0:RefreshInGameInfo()
end

function var_0_0.RefreshInGameInfo(arg_14_0)
	manager.rogueTeamInGameInfoBox:Refresh()
end

function var_0_0.OnInitMap(arg_15_0)
	arg_15_0.mapView_:OnReset()
end

function var_0_0.OnWindowUpdate(arg_16_0)
	if not arg_16_0:IsTop() then
		return
	end

	arg_16_0:PopWindowProcess()
end

function var_0_0.PopWindowProcess(arg_17_0)
	if ChallengeRogueTeamData:PathGetFloorState() ~= ChallengeRogueTeamConst.FLOOR_STATE.NORMAL then
		return
	end

	if ChallengeRogueTeamAction.PopWindowProcessSystem() == false and ChallengeRogueTeamAction.PopOperateWindowProcessSystem() == false then
		if not ChallengeRogueTeamTools.HasMapNodeEffect() then
			arg_17_0.mapView_:PalyNodeEffect()
		end

		local var_17_0 = ChallengeRogueTeamData:PlotGetOptionEndID() ~= 0

		SetActive(arg_17_0.endAnim_.gameObject, var_17_0)

		if var_17_0 then
			if ChallengeRogueTeamData:PlotGetOptionEndID() == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_ID then
				arg_17_0.endAnim_:Play("UI_chenggong", 0, 0)
			else
				arg_17_0.endAnim_:Play("UI_shibai", 0, 0)
			end
		end
	end
end

function var_0_0.ExitPlaying(arg_18_0)
	ChallengeRogueTeamAction.GotoRogueTeamEntrace()
end

function var_0_0.OnFinishNode(arg_19_0)
	return
end

function var_0_0.CheckEndingProcess(arg_20_0)
	local var_20_0 = ChallengeRogueTeamData:PlotGetEndingID()

	if var_20_0 == 0 and ChallengeRogueTeamData:PathGetFloorState() ~= ChallengeRogueTeamConst.FLOOR_STATE.NORMAL then
		arg_20_0:CheckStatistic()

		return
	end

	if ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.NORMAL then
		return
	end

	if ChallengeRogueTeamData:PlotGetEndingPlayState() == ChallengeRogueTeamConst.ENDING_PLOT_STATE.UN_PLAYED and ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.OVER then
		local var_20_1 = RogueTeamEndingCfg[var_20_0].story_id

		manager.ui:UIEventEnabled(true)
		manager.story:StartStoryById(var_20_1, function(arg_21_0)
			ChallengeRogueTeamAction.PlayEndingPlot(function()
				arg_20_0:CheckStatistic()
			end)
		end)
	else
		arg_20_0:CheckStatistic()
	end
end

function var_0_0.CheckStatistic(arg_23_0)
	if ChallengeRogueTeamData:GetOverStatisticsData() == nil then
		ChallengeRogueTeamAction.RequestGameResult(function()
			ChallengeRogueTeamAction.UpdateHistoryData()
			JumpTools.OpenPageByJump("challengeRogueTeamOverStatistics")
		end)
	else
		ChallengeRogueTeamAction.UpdateHistoryData()
		JumpTools.OpenPageByJump("challengeRogueTeamOverStatistics")
	end
end

function var_0_0.AddRingTimer(arg_25_0)
	arg_25_0:StopRingTimer()

	arg_25_0.ringTimer_ = FrameTimer.New(function()
		arg_25_0.tempEulerAngles_.x = arg_25_0.contentTf_.localEulerAngles.x
		arg_25_0.ringTf_.localEulerAngles = arg_25_0.tempEulerAngles_
	end, 1, -1)

	arg_25_0.ringTimer_:Start()
end

function var_0_0.StopRingTimer(arg_27_0)
	if arg_27_0.ringTimer_ then
		arg_27_0.ringTimer_:Stop()

		arg_27_0.ringTimer_ = nil
	end
end

function var_0_0.RefreshBGM(arg_28_0)
	return
end

function var_0_0.RefreshAtmosphere(arg_29_0)
	arg_29_0.mapView_:RefreshUI()

	local var_29_0 = ChallengeRogueTeamData:GetPlotID() == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_POP_ID

	arg_29_0.mapController_:SetSelectedState(var_29_0 and "red" or "normal")
end

return var_0_0
