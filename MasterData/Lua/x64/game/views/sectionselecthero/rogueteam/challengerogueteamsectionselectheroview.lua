local ChallengeRogueTeamSectionSelectHeroView = class("ChallengeRogueTeamSectionSelectHeroView", (import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")))

function ChallengeRogueTeamSectionSelectHeroView:Init()
	ChallengeRogueTeamSectionSelectHeroView.super.Init(self)

	self.conditionBtnController_ = self.conditionController_:GetController("completeState")
	self.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(self.startBtn_.gameObject)
	self.fettersController_ = self.controllerExCollection_:GetController("fetters")
end

function ChallengeRogueTeamSectionSelectHeroView:UIName()
	return "Widget/System/Formation/ChallengeRogueTeam/ChallengeRogueTeamFormationMainUI"
end

function ChallengeRogueTeamSectionSelectHeroView:OnEnter()
	if self.params_.isBack then
		ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.ENTER, function()
			return
		end)
	end

	self.isDemonBattle_ = ChallengeRogueTeamTools.IsDemonBattle()

	self.super.OnEnter(self)

	self.heroModify_ = self.params_.heroModify

	if ChallengeRogueTeamData:GetSelectDifficultyID((ChallengeRogueTeamData:GetCacheTemplateID())) == 0 then
		local var_3_0, var_3_1, var_3_2, var_3_3 = self.sectionProxy_:GetHeroTeam()

		if var_3_0[1] ~= 0 then
			self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
		else
			self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK)
		end
	else
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
	end

	self.hideEffect_ = getData("challenge_rogue_team", "hide_effect") or false

	self.conditionBtnController_:SetSelectedState(tostring(self.hideEffect_))
	self:RefreshWeekFetters()
end

function ChallengeRogueTeamSectionSelectHeroView:AddListener()
	self:AddBtnListener(self.conditionBtn_, nil, function()
		self.hideEffect_ = not self.hideEffect_

		saveData("challenge_rogue_team", "hide_effect", self.hideEffect_)
		self.conditionBtnController_:SetSelectedState(tostring(self.hideEffect_))
	end)
end

function ChallengeRogueTeamSectionSelectHeroView:OnExit()
	if self.fettersTimer ~= nil then
		self.fettersTimer:Stop()

		self.fettersTimer = nil
	end

	self.super.OnExit(self)
end

function ChallengeRogueTeamSectionSelectHeroView:ProcessBaseParams()
	self.multiple_ = self.params_.multiple or 1
	self.params_.section = self.isDemonBattle_ and (self.sectionProxy_ and self.params_.isBack and ChallengeRogueTeamTools.GetDemonStageByHeroId(self.sectionProxy_:CustomGetTeamData()[1]) or ChallengeRogueTeamTools.GetDemonStageByHeroId()) or self.params_.section or 0
	self.stageID_ = self.params_.section
	self.stageType_ = self.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	self.activityID_ = self.params_.activityID
end

function ChallengeRogueTeamSectionSelectHeroView:ProcessProxyParams()
	ChallengeRogueTeamSectionSelectHeroView.super.ProcessProxyParams(self)

	self.sectionProxy_.stageID = self.params_.section

	ChallengeRogueTeamData:SetHeroTeamProxy(self.sectionProxy_)
end

function ChallengeRogueTeamSectionSelectHeroView:RefresgStageInfoActive()
	return
end

function ChallengeRogueTeamSectionSelectHeroView:Dispose()
	self.rogueTeamSureBtnView_:Dispose()

	self.rogueTeamSureBtnView_ = nil
	self.OnChangeTeamHandler_ = nil

	ChallengeRogueTeamSectionSelectHeroView.super.Dispose(self)
end

function ChallengeRogueTeamSectionSelectHeroView:UpdateBar()
	self.sectionProxy_:UpdateBar()
	manager.windowBar:RegistBackCallBack(function()
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)

		if self.params_.exit2Entrace then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CHALLENGE_ROGUE_EXIT_GAME"),
				OkCallback = function()
					ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
						ChallengeRogueTeamAction.GotoRogueTeamEntrace()
					end)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			self:Back()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end)
end

function ChallengeRogueTeamSectionSelectHeroView:StartBattle()
	local var_19_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	if self.heroModify_ then
		self:SaveReserveTeam()
		self:Back()

		return
	end

	if ChallengeRogueTeamData:GetSelectDifficultyID(var_19_0) == 0 then
		local var_19_1, var_19_2, var_19_3, var_19_4 = self.sectionProxy_:GetHeroTeam()

		if var_19_1[3] == 0 then
			ShowMessageBox({
				isTop = true,
				content = GetTips("ROGUE_TEAM_MEMBER_TIPS"),
				OkCallback = function()
					self:EnterRogueMain(var_19_0, var_19_1, var_19_4)
				end,
				CancelCallback = function()
					return
				end
			})

			return
		end

		self:EnterRogueMain(var_19_0, var_19_1, var_19_4)
	else
		self:SaveReserveTeam(function()
			self.sectionProxy_:StartBattle()
		end)
	end
end

function ChallengeRogueTeamSectionSelectHeroView:SaveReserveTeam(arg_23_1)
	local var_23_0, var_23_1, var_23_2, var_23_3 = self.sectionProxy_:GetHeroTeam()

	ReserveTools.SetHeroList(self.sectionProxy_:GetReserveParams(), var_23_0, var_23_3)
	ReserveAction.SaveContData(ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM, ReserveTools.GetContID(BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM), arg_23_1)
end

function ChallengeRogueTeamSectionSelectHeroView:EnterRogueMain(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_2) do
		var_24_0[iter_24_0] = {
			hp_ratio = 10000,
			hero_id = iter_24_1,
			temp_id = arg_24_3[iter_24_0]
		}
	end

	self:SaveReserveTeam()

	local var_24_1, var_24_2 = ChallengeRogueTeamData:GetOptionalAffix()

	trace("affixList%o", var_24_2)
	ChallengeRogueTeamAction.SelectedDifficulty(arg_24_1, ChallengeRogueTeamData:GetUIDifficultyID(), var_24_0, var_24_2, function()
		ChallengeRogueTeamData:UISetNeedPlayStartAnimator(true)
		gameContext:OverrideUrl("/challengeRogueTeamEntraceDifficulty", "/challengeRogueTeamPathMain", nil, "home")
		ChallengeRogueTeamStartAnimatorView.New()
	end)
end

function ChallengeRogueTeamSectionSelectHeroView:GotoReservesProposalUI()
	ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
		ChallengeRogueTeamSectionSelectHeroView.super.GotoReservesProposalUI(self)
	end)
end

function ChallengeRogueTeamSectionSelectHeroView:OnSectionClickHero(arg_28_1)
	ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
		ChallengeRogueTeamSectionSelectHeroView.super.OnSectionClickHero(self, arg_28_1)
	end)
end

function ChallengeRogueTeamSectionSelectHeroView:RefreshWeekFetters()
	local var_30_0 = ChallengeRogueTeamData:GetActiveFetters()

	if RogueTeamFettersCfg[var_30_0.fettersId] then
		self.fettersDesc_.text = getAffixDesc(RogueTeamFettersCfg[var_30_0.fettersId].affix_id)

		local var_30_1 = IsConditionAchieved(RogueTeamFettersCfg[var_30_0.fettersId].condition)

		self.fettersController_:SetSelectedState(tostring(var_30_1))

		self.fettersActive_.text = var_30_1 and GetTips("ROUGE_TEAM_FETTER_TAKE_EFFECT") or ConditionCfg[RogueTeamFettersCfg[var_30_0.fettersId].condition].desc

		self:RefreshFettersTimer(var_30_0)
	else
		self.fettersController_:SetSelectedState("false")
	end
end

function ChallengeRogueTeamSectionSelectHeroView:RefreshFettersTimer(arg_31_1)
	if self.fettersTimer ~= nil then
		self.fettersTimer:Stop()

		self.fettersTimer = nil
	end

	local var_31_0 = arg_31_1.nextTimestamps

	if arg_31_1.nextTimestamps and var_31_0 > 0 then
		self.fettersTime_.text = manager.time:GetLostTimeStr2(var_31_0)
		self.fettersTimer = Timer.New(function()
			self.fettersTime_.text = manager.time:GetLostTimeStr2(var_31_0)
		end, 1, -1)
	end
end

return ChallengeRogueTeamSectionSelectHeroView
