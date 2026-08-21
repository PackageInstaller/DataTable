local var_0_0 = class("SoloChallengeSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerSoloChallengeSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.onResetDataHandler_ = handler(arg_3_0, arg_3_0.OnResetData)

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scrollView_, SoloChallengeSelectItem)
end

function var_0_0.OnEnter(arg_5_0)
	local var_5_0 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE)
	local var_5_1 = ActivitySoloChallengeCfg[arg_5_0.params_.activityID].stage_id[arg_5_0.params_.difficultyIndex][1]
	local var_5_2 = var_5_0:GetContDataTemplateById(var_5_1)
	local var_5_3, var_5_4 = var_5_2:GetSummaryHeroList(arg_5_0.params_.activityID, arg_5_0.params_.difficultyIndex)
	local var_5_5 = false
	local var_5_6 = GetTrialHeroList(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, nil, arg_5_0.params_.activityID)

	for iter_5_0, iter_5_1 in ipairs(var_5_4) do
		if iter_5_1 ~= 0 and not table.keyof(var_5_6, iter_5_1) and not table.keyof(lockHeroList, iter_5_1) then
			var_5_5 = true
			var_5_4[iter_5_0] = 0
			var_5_3[iter_5_0] = 0
		end
	end

	if var_5_5 then
		var_5_2:SetSummaryHeroList(var_5_3, var_5_4)
		ReserveAction.SaveSoloChallengeContData(arg_5_0.params_.activityID, arg_5_0.params_.difficultyIndex, function()
			arg_5_0:OnTop()
		end)
	end
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:UpdateBar()

	arg_7_0.activityID_ = arg_7_0.params_.activityID
	arg_7_0.difficultyIndex_ = arg_7_0.params_.difficultyIndex
	arg_7_0.difficultyID_ = ActivitySoloChallengeCfg[arg_7_0.activityID_].stage_id[arg_7_0.difficultyIndex_][1]
	arg_7_0.stageList_ = ActivitySoloChallengeCfg[arg_7_0.activityID_].stage_id[arg_7_0.difficultyIndex_][2]

	arg_7_0.list_:StartScroll(#arg_7_0.stageList_)
	arg_7_0:RefreshUI()
end

function var_0_0.UpdateBar(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.activityID_, arg_9_0.stageList_[arg_9_1], arg_9_1, arg_9_0.difficultyIndex_)
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_10_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_11_0 = arg_10_0:GetNextChallengeStageID()

		if not arg_10_0:customHeroReady() then
			ShowTips("HERO_UNREADY_SOLO_CHALLENGE")

			return
		end

		if not arg_10_0:customAffixReady() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("AFFIX_UNREADY_SOLO_CHALLENGE"),
				OkCallback = function()
					arg_10_0:GoToStage(var_11_0)
				end
			})

			return
		end

		arg_10_0:GoToStage(var_11_0)
	end)
	arg_10_0:AddBtnListener(arg_10_0.giveUpBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_10_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_SOLO_CHALLENGE"),
			OkCallback = function()
				SoloChallengeAction.ResetData(arg_10_0.activityID_, arg_10_0.onResetDataHandler_)
			end
		})
	end)
end

function var_0_0.GoToStage(arg_15_0, arg_15_1)
	SoloChallengeData:SaveActivityID(arg_15_0.activityID_, arg_15_1)
	SoloChallengeData:SaveDifficultyIndex(arg_15_0.difficultyIndex_, arg_15_1)

	local var_15_0 = table.indexof(arg_15_0.stageList_, arg_15_1)
	local var_15_1 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE, arg_15_0.difficultyID_, var_15_0, {
		stageType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
		stageID = arg_15_1,
		activityID = arg_15_0.activityID_,
		difficultyIndex = arg_15_0.difficultyIndex_
	})

	arg_15_0:Go("/sectionSelectHero", {
		canChangeTeam = false,
		section = arg_15_1,
		sectionType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
		activityID = arg_15_0.activityID_,
		reserveParams = var_15_1
	})
end

function var_0_0.RefreshUI(arg_16_0)
	arg_16_0:RefreshGiveUpBtn()
end

function var_0_0.RefreshGiveUpBtn(arg_17_0)
	local var_17_0 = SoloChallengeData:GetCompletedStageList(arg_17_0.activityID_)

	if var_17_0[arg_17_0.difficultyIndex_] and #var_17_0[arg_17_0.difficultyIndex_] ~= 0 then
		arg_17_0.giveUpBtn_.interactable = true
	else
		arg_17_0.giveUpBtn_.interactable = false
	end
end

function var_0_0.GetNextChallengeStageID(arg_18_0)
	local var_18_0 = SoloChallengeData:GetCompletedStageList(arg_18_0.activityID_)

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.stageList_) do
		if table.keyof(var_18_0[arg_18_0.difficultyIndex_], iter_18_1) == nil then
			return iter_18_1
		end
	end

	return 0
end

function var_0_0.OnResetData(arg_19_0, arg_19_1, arg_19_2)
	if isSuccess(arg_19_1.result) then
		SoloChallengeData:ResetLockData(arg_19_2)
		arg_19_0:Back()
	else
		ShowTips(arg_19_1.result)
	end
end

function var_0_0.customHeroReady(arg_20_0)
	local var_20_0 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE)
	local var_20_1 = ActivitySoloChallengeCfg[arg_20_0.params_.activityID].stage_id[arg_20_0.params_.difficultyIndex][1]
	local var_20_2, var_20_3 = var_20_0:GetContDataTemplateById(var_20_1):GetSummaryHeroList(arg_20_0.params_.activityID, arg_20_0.params_.difficultyIndex)

	if var_20_2 == nil then
		return false
	else
		for iter_20_0 = 1, #arg_20_0.stageList_ do
			if var_20_2[iter_20_0] == 0 then
				return false
			end
		end
	end

	return true
end

function var_0_0.customAffixReady(arg_21_0)
	local var_21_0 = arg_21_0.activityID_
	local var_21_1 = SoloChallengeData:GetMaxAffixCount(var_21_0)
	local var_21_2 = SoloChallengeData:GetCompletedStageList(var_21_0)

	for iter_21_0, iter_21_1 in pairs(arg_21_0.stageList_) do
		if table.keyof(var_21_2[arg_21_0.difficultyIndex_], iter_21_1) == nil then
			local var_21_3 = ReserveTools.GetReserveTemplate(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, iter_21_1)
			local var_21_4 = ActivitySoloChallengeCfg[arg_21_0.activityID_].stage_id[arg_21_0.difficultyIndex_][1]
			local var_21_5 = var_21_3:GetContDataTemplateById(var_21_4):GetAffixList(iter_21_0)

			for iter_21_2 = 1, var_21_1 do
				if not var_21_5[iter_21_2] or var_21_5[iter_21_2] == 0 then
					return false
				end
			end
		end
	end

	return true
end

function var_0_0.OnExit(arg_22_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.list_ then
		arg_23_0.list_:Dispose()

		arg_23_0.list_ = nil
	end

	arg_23_0.onResetDataHandler_ = nil
	arg_23_0.onSaveCustomListHandler_ = nil

	var_0_0.super.Dispose(arg_23_0)
end

function var_0_0.OnReverTeamData(arg_24_0)
	arg_24_0.stageList_ = ActivitySoloChallengeCfg[arg_24_0.activityID_].stage_id[arg_24_0.difficultyIndex_][2]

	arg_24_0.list_:StartScroll(#arg_24_0.stageList_)
end

return var_0_0
