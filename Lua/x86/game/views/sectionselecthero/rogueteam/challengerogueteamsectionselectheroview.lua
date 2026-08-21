local var_0_0 = import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")
local var_0_1 = class("ChallengeRogueTeamSectionSelectHeroView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	arg_1_0.conditionBtnController_ = arg_1_0.conditionController_:GetController("completeState")
	arg_1_0.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(arg_1_0.startBtn_.gameObject)
	arg_1_0.fettersController_ = arg_1_0.controllerExCollection_:GetController("fetters")
end

function var_0_1.UIName(arg_2_0)
	return "Widget/System/Formation/ChallengeRogueTeam/ChallengeRogueTeamFormationMainUI"
end

function var_0_1.OnEnter(arg_3_0)
	if arg_3_0.params_.isBack then
		ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.ENTER, function()
			return
		end)
	end

	arg_3_0.isDemonBattle_ = ChallengeRogueTeamTools.IsDemonBattle()

	arg_3_0.super.OnEnter(arg_3_0)

	arg_3_0.heroModify_ = arg_3_0.params_.heroModify

	local var_3_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	if ChallengeRogueTeamData:GetSelectDifficultyID(var_3_0) == 0 then
		local var_3_1, var_3_2, var_3_3, var_3_4 = arg_3_0.sectionProxy_:GetHeroTeam()

		if var_3_1[1] ~= 0 then
			arg_3_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
		else
			arg_3_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK)
		end
	else
		arg_3_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
	end

	arg_3_0.hideEffect_ = getData("challenge_rogue_team", "hide_effect") or false

	arg_3_0.conditionBtnController_:SetSelectedState(tostring(arg_3_0.hideEffect_))
	arg_3_0:RefreshWeekFetters()
end

function var_0_1.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.conditionBtn_, nil, function()
		if arg_5_0.hideEffect_ then
			arg_5_0.hideEffect_ = false
		else
			arg_5_0.hideEffect_ = true
		end

		saveData("challenge_rogue_team", "hide_effect", arg_5_0.hideEffect_)
		arg_5_0.conditionBtnController_:SetSelectedState(tostring(arg_5_0.hideEffect_))
	end)
end

function var_0_1.OnExit(arg_7_0)
	if arg_7_0.fettersTimer ~= nil then
		arg_7_0.fettersTimer:Stop()

		arg_7_0.fettersTimer = nil
	end

	arg_7_0.super.OnExit(arg_7_0)
end

function var_0_1.ProcessBaseParams(arg_8_0)
	arg_8_0.multiple_ = arg_8_0.params_.multiple or 1

	if arg_8_0.isDemonBattle_ then
		if arg_8_0.sectionProxy_ and arg_8_0.params_.isBack then
			local var_8_0 = arg_8_0.sectionProxy_:CustomGetTeamData()

			arg_8_0.params_.section = ChallengeRogueTeamTools.GetDemonStageByHeroId(var_8_0[1])
		else
			arg_8_0.params_.section = ChallengeRogueTeamTools.GetDemonStageByHeroId()
		end
	else
		arg_8_0.params_.section = arg_8_0.params_.section or 0
	end

	arg_8_0.stageID_ = arg_8_0.params_.section
	arg_8_0.stageType_ = arg_8_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	arg_8_0.activityID_ = arg_8_0.params_.activityID
end

function var_0_1.ProcessProxyParams(arg_9_0)
	var_0_1.super.ProcessProxyParams(arg_9_0)

	arg_9_0.sectionProxy_.stageID = arg_9_0.params_.section

	ChallengeRogueTeamData:SetHeroTeamProxy(arg_9_0.sectionProxy_)
end

function var_0_1.RefresgStageInfoActive(arg_10_0)
	return
end

function var_0_1.Dispose(arg_11_0)
	arg_11_0.rogueTeamSureBtnView_:Dispose()

	arg_11_0.rogueTeamSureBtnView_ = nil
	arg_11_0.OnChangeTeamHandler_ = nil

	var_0_1.super.Dispose(arg_11_0)
end

function var_0_1.UpdateBar(arg_12_0)
	arg_12_0.sectionProxy_:UpdateBar()
	manager.windowBar:RegistBackCallBack(function()
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)

		if arg_12_0.params_.exit2Entrace then
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
			arg_12_0:Back()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end)
end

function var_0_1.StartBattle(arg_19_0)
	local var_19_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	if arg_19_0.heroModify_ then
		arg_19_0:SaveReserveTeam()
		arg_19_0:Back()

		return
	end

	if ChallengeRogueTeamData:GetSelectDifficultyID(var_19_0) == 0 then
		local var_19_1, var_19_2, var_19_3, var_19_4 = arg_19_0.sectionProxy_:GetHeroTeam()

		if var_19_1[3] == 0 then
			ShowMessageBox({
				isTop = true,
				content = GetTips("ROGUE_TEAM_MEMBER_TIPS"),
				OkCallback = function()
					arg_19_0:EnterRogueMain(var_19_0, var_19_1, var_19_4)
				end,
				CancelCallback = function()
					return
				end
			})

			return
		end

		arg_19_0:EnterRogueMain(var_19_0, var_19_1, var_19_4)
	else
		arg_19_0:SaveReserveTeam(function()
			arg_19_0.sectionProxy_:StartBattle()
		end)
	end
end

function var_0_1.SaveReserveTeam(arg_23_0, arg_23_1)
	local var_23_0, var_23_1, var_23_2, var_23_3 = arg_23_0.sectionProxy_:GetHeroTeam()

	ReserveTools.SetHeroList(arg_23_0.sectionProxy_:GetReserveParams(), var_23_0, var_23_3)
	ReserveAction.SaveContData(ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM, ReserveTools.GetContID(BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM), arg_23_1)
end

function var_0_1.EnterRogueMain(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_2) do
		var_24_0[iter_24_0] = {
			hp_ratio = 10000,
			hero_id = iter_24_1,
			temp_id = arg_24_3[iter_24_0]
		}
	end

	arg_24_0:SaveReserveTeam()

	local var_24_1, var_24_2 = ChallengeRogueTeamData:GetOptionalAffix()

	trace("affixList%o", var_24_2)
	ChallengeRogueTeamAction.SelectedDifficulty(arg_24_1, ChallengeRogueTeamData:GetUIDifficultyID(), var_24_0, var_24_2, function()
		ChallengeRogueTeamData:UISetNeedPlayStartAnimator(true)
		gameContext:OverrideUrl("/challengeRogueTeamEntraceDifficulty", "/challengeRogueTeamPathMain", nil, "home")
		ChallengeRogueTeamStartAnimatorView.New()
	end)
end

function var_0_1.GotoReservesProposalUI(arg_26_0)
	ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
		var_0_1.super.GotoReservesProposalUI(arg_26_0)
	end)
end

function var_0_1.OnSectionClickHero(arg_28_0, arg_28_1)
	ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
		var_0_1.super.OnSectionClickHero(arg_28_0, arg_28_1)
	end)
end

function var_0_1.RefreshWeekFetters(arg_30_0)
	local var_30_0 = ChallengeRogueTeamData:GetActiveFetters()
	local var_30_1 = RogueTeamFettersCfg[var_30_0.fettersId]

	if var_30_1 then
		arg_30_0.fettersDesc_.text = getAffixDesc(var_30_1.affix_id)

		local var_30_2 = IsConditionAchieved(var_30_1.condition)

		arg_30_0.fettersController_:SetSelectedState(tostring(var_30_2))

		arg_30_0.fettersActive_.text = var_30_2 and GetTips("ROUGE_TEAM_FETTER_TAKE_EFFECT") or ConditionCfg[var_30_1.condition].desc

		arg_30_0:RefreshFettersTimer(var_30_0)
	else
		arg_30_0.fettersController_:SetSelectedState("false")
	end
end

function var_0_1.RefreshFettersTimer(arg_31_0, arg_31_1)
	if arg_31_0.fettersTimer ~= nil then
		arg_31_0.fettersTimer:Stop()

		arg_31_0.fettersTimer = nil
	end

	local var_31_0 = arg_31_1.nextTimestamps

	if var_31_0 and var_31_0 > 0 then
		arg_31_0.fettersTime_.text = manager.time:GetLostTimeStr2(var_31_0)
		arg_31_0.fettersTimer = Timer.New(function()
			arg_31_0.fettersTime_.text = manager.time:GetLostTimeStr2(var_31_0)
		end, 1, -1)
	end
end

return var_0_1
