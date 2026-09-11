local ChallengeRogueTeamPathMainView = class("ChallengeRogueTeamPathMainView", ReduxView)

function ChallengeRogueTeamPathMainView:UIName()
	return "Widget/System/Activity_Roulike/RoulikePanelUI"
end

function ChallengeRogueTeamPathMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamPathMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.onInitMapHandler_ = handler(self, self.OnInitMap)
	self.exitPlayingHandler_ = handler(self, self.ExitPlaying)
	self.finishNodeHandler_ = handler(self, self.OnFinishNode)
	self.onWindowUpdateHandler_ = handler(self, self.OnWindowUpdate)
	self.onCheckEndingProcessHandler_ = handler(self, self.CheckEndingProcess)
	self.overStaticHandler_ = handler(self, self.GameOverStatic)
	self.mapView_ = ChallengeRogueTeamMapBaseView.New(self.scrollViewGo_)
	self.tempEulerAngles_ = Vector3(self.ringTf_.localEulerAngles.x, self.ringTf_.localEulerAngles.y, self.ringTf_.localEulerAngles.z)
	self.mapController_ = self.mapCon_:GetController("bg")

	self.mapController_:SetSelectedState("normal")

	self.refreshAtmosphereHandler_ = handler(self, self.RefreshAtmosphere)
end

function ChallengeRogueTeamPathMainView:OnEnter()
	ChallengeRogueTeamData:UISetEventIDAnimator()
	self:RefreshBGM()
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			hideHomeBtn = 1,
			isPrefab = true,
			pages = GameSetting.rogue_team_map_help.value
		}
	})
	ChallengeRogueTeamTools.RegistWindowBarClick()
	ChallengeRogueTeamTools.ShowBarList()
	self.mapView_:OnEnter()
	self:RefreshUI()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_MAP_INIT, self.onInitMapHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_EXIT, self.exitPlayingHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_MAP_CLEAR, self.onCheckEndingProcessHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_GAME_OVER_STATIC, self.overStaticHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_PATH_FINISH_NODE, self.finishNodeHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, self.onWindowUpdateHandler_)
	manager.notify:RegistListener(CHALLENGE_SPECIAL_ENDING, self.refreshAtmosphereHandler_)
	self:AddRingTimer()
end

function ChallengeRogueTeamPathMainView:OnEnterOver()
	self.mapView_:OnEnterOver()
	self:CheckEndingProcess()
end

function ChallengeRogueTeamPathMainView:GameOverStatic()
	if table.length(ChallengeRogueTeamData:GetOverStatisticsData()) > 0 then
		JumpTools.OpenPageByJump("challengeRogueTeamOverStatistics")
	end
end

function ChallengeRogueTeamPathMainView:OnTop()
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
		self:ExitPlaying()
	elseif self.params_.isBattleBack then
		FrameTimer.New(function()
			self:PopWindowProcess()
		end, 30, 1):Start()
	else
		self:PopWindowProcess()
	end

	self.mapView_:OnTop()
end

function ChallengeRogueTeamPathMainView:OnBehind()
	if self:IsOpenRoute("challengeRogueTeamSectionInfo") then
		-- block empty
	else
		manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.OTHER)
	end
end

function ChallengeRogueTeamPathMainView:OnExit()
	self.mapView_:OnExit()
	manager.windowBar:HideBar()
	ChallengeRogueTeamTools.HideBarList()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_MAP_INIT, self.onInitMapHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_EXIT, self.exitPlayingHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_PATH_FINISH_NODE, self.finishNodeHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_MAP_CLEAR, self.onCheckEndingProcessHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_GAME_OVER_STATIC, self.overStaticHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, self.onWindowUpdateHandler_)
	manager.notify:RemoveListener(CHALLENGE_SPECIAL_ENDING, self.refreshAtmosphereHandler_)
	self:StopRingTimer()
end

function ChallengeRogueTeamPathMainView:Dispose()
	self.onInitMapHandler_ = nil
	self.exitPlayingHandler_ = nil
	self.finishNodeHandler_ = nil
	self.onWindowUpdateHandler_ = nil
	self.onCheckEndingProcessHandler_ = nil
	self.overStaticHandler_ = nil

	self.mapView_:Dispose()

	self.mapView_ = nil

	ChallengeRogueTeamPathMainView.super.Dispose(self)
end

function ChallengeRogueTeamPathMainView:AddListeners()
	return
end

function ChallengeRogueTeamPathMainView:RefreshUI()
	self:RefreshAtmosphere()
	self:RefreshInGameInfo()
end

function ChallengeRogueTeamPathMainView:RefreshInGameInfo()
	manager.rogueTeamInGameInfoBox:Refresh()
end

function ChallengeRogueTeamPathMainView:OnInitMap()
	self.mapView_:OnReset()
end

function ChallengeRogueTeamPathMainView:OnWindowUpdate()
	if not self:IsTop() then
		return
	end

	self:PopWindowProcess()
end

function ChallengeRogueTeamPathMainView:PopWindowProcess()
	if ChallengeRogueTeamData:PathGetFloorState() ~= ChallengeRogueTeamConst.FLOOR_STATE.NORMAL then
		return
	end

	if ChallengeRogueTeamAction.PopWindowProcessSystem() == false and ChallengeRogueTeamAction.PopOperateWindowProcessSystem() == false then
		if not ChallengeRogueTeamTools.HasMapNodeEffect() then
			self.mapView_:PalyNodeEffect()
		end

		local var_17_0 = ChallengeRogueTeamData:PlotGetOptionEndID() ~= 0

		SetActive(self.endAnim_.gameObject, var_17_0)

		if var_17_0 then
			if ChallengeRogueTeamData:PlotGetOptionEndID() == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_ID then
				self.endAnim_:Play("UI_chenggong", 0, 0)
			else
				self.endAnim_:Play("UI_shibai", 0, 0)
			end
		end
	end
end

function ChallengeRogueTeamPathMainView:ExitPlaying()
	ChallengeRogueTeamAction.GotoRogueTeamEntrace()
end

function ChallengeRogueTeamPathMainView:OnFinishNode()
	return
end

function ChallengeRogueTeamPathMainView:CheckEndingProcess()
	local var_20_0 = ChallengeRogueTeamData:PlotGetEndingID()

	if var_20_0 == 0 and ChallengeRogueTeamData:PathGetFloorState() ~= ChallengeRogueTeamConst.FLOOR_STATE.NORMAL then
		self:CheckStatistic()

		return
	end

	if ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.NORMAL then
		return
	end

	if ChallengeRogueTeamData:PlotGetEndingPlayState() == ChallengeRogueTeamConst.ENDING_PLOT_STATE.UN_PLAYED and ChallengeRogueTeamData:PathGetFloorState() == ChallengeRogueTeamConst.FLOOR_STATE.OVER then
		manager.ui:UIEventEnabled(true)
		manager.story:StartStoryById(RogueTeamEndingCfg[var_20_0].story_id, function(arg_21_0)
			ChallengeRogueTeamAction.PlayEndingPlot(function()
				self:CheckStatistic()
			end)
		end)
	else
		self:CheckStatistic()
	end
end

function ChallengeRogueTeamPathMainView:CheckStatistic()
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

function ChallengeRogueTeamPathMainView:AddRingTimer()
	self:StopRingTimer()

	self.ringTimer_ = FrameTimer.New(function()
		self.tempEulerAngles_.x = self.contentTf_.localEulerAngles.x
		self.ringTf_.localEulerAngles = self.tempEulerAngles_
	end, 1, -1)

	self.ringTimer_:Start()
end

function ChallengeRogueTeamPathMainView:StopRingTimer()
	if self.ringTimer_ then
		self.ringTimer_:Stop()

		self.ringTimer_ = nil
	end
end

function ChallengeRogueTeamPathMainView:RefreshBGM()
	return
end

function ChallengeRogueTeamPathMainView:RefreshAtmosphere()
	self.mapView_:RefreshUI()
	self.mapController_:SetSelectedState(ChallengeRogueTeamData:GetPlotID() == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_POP_ID and "red" or "normal")
end

return ChallengeRogueTeamPathMainView
