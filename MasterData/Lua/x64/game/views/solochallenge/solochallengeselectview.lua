local SoloChallengeSelectView = class("SoloChallengeSelectView", ReduxView)

function SoloChallengeSelectView:UIName()
	return "UI/VersionUI/SummerUI/SummerSoloChallengeSelectUI"
end

function SoloChallengeSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function SoloChallengeSelectView:Init()
	self.onResetDataHandler_ = handler(self, self.OnResetData)

	self:InitUI()
	self:AddUIListener()
end

function SoloChallengeSelectView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, SoloChallengeSelectItem)
end

function SoloChallengeSelectView:OnEnter()
	local var_5_0 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(ActivitySoloChallengeCfg[self.params_.activityID].stage_id[self.params_.difficultyIndex][1])
	local var_5_1, var_5_2 = var_5_0:GetSummaryHeroList(self.params_.activityID, self.params_.difficultyIndex)
	local var_5_3 = false
	local var_5_4 = GetTrialHeroList(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, nil, self.params_.activityID)

	for iter_5_0, iter_5_1 in ipairs(var_5_2) do
		if iter_5_1 ~= 0 and not table.keyof(var_5_4, iter_5_1) and not table.keyof(lockHeroList, iter_5_1) then
			var_5_3 = true
			var_5_2[iter_5_0] = 0
			var_5_1[iter_5_0] = 0
		end
	end

	if var_5_3 then
		var_5_0:SetSummaryHeroList(var_5_1, var_5_2)
		ReserveAction.SaveSoloChallengeContData(self.params_.activityID, self.params_.difficultyIndex, function()
			self:OnTop()
		end)
	end
end

function SoloChallengeSelectView:OnTop()
	self:UpdateBar()

	self.activityID_ = self.params_.activityID
	self.difficultyIndex_ = self.params_.difficultyIndex
	self.difficultyID_ = ActivitySoloChallengeCfg[self.activityID_].stage_id[self.difficultyIndex_][1]
	self.stageList_ = ActivitySoloChallengeCfg[self.activityID_].stage_id[self.difficultyIndex_][2]

	self.list_:StartScroll(#self.stageList_)
	self:RefreshUI()
end

function SoloChallengeSelectView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SoloChallengeSelectView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.activityID_, self.stageList_[arg_9_1], arg_9_1, self.difficultyIndex_)
end

function SoloChallengeSelectView:AddUIListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_11_0 = self:GetNextChallengeStageID()

		if not self:customHeroReady() then
			ShowTips("HERO_UNREADY_SOLO_CHALLENGE")

			return
		end

		if not self:customAffixReady() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("AFFIX_UNREADY_SOLO_CHALLENGE"),
				OkCallback = function()
					self:GoToStage(var_11_0)
				end
			})

			return
		end

		self:GoToStage(var_11_0)
	end)
	self:AddBtnListener(self.giveUpBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_SOLO_CHALLENGE"),
			OkCallback = function()
				SoloChallengeAction.ResetData(self.activityID_, self.onResetDataHandler_)
			end
		})
	end)
end

function SoloChallengeSelectView:GoToStage(arg_15_1)
	SoloChallengeData:SaveActivityID(self.activityID_, arg_15_1)
	SoloChallengeData:SaveDifficultyIndex(self.difficultyIndex_, arg_15_1)
	self:Go("/sectionSelectHero", {
		canChangeTeam = false,
		section = arg_15_1,
		sectionType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
		activityID = self.activityID_,
		reserveParams = ReserveParams.New(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE, self.difficultyID_, table.indexof(self.stageList_, arg_15_1), {
			stageType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
			stageID = arg_15_1,
			activityID = self.activityID_,
			difficultyIndex = self.difficultyIndex_
		})
	})
end

function SoloChallengeSelectView:RefreshUI()
	self:RefreshGiveUpBtn()
end

function SoloChallengeSelectView:RefreshGiveUpBtn()
	local var_17_0 = SoloChallengeData:GetCompletedStageList(self.activityID_)

	self.giveUpBtn_.interactable = not not (var_17_0[self.difficultyIndex_] and #var_17_0[self.difficultyIndex_] ~= 0)
end

function SoloChallengeSelectView:GetNextChallengeStageID()
	local var_18_0 = SoloChallengeData:GetCompletedStageList(self.activityID_)

	for iter_18_0, iter_18_1 in ipairs(self.stageList_) do
		if table.keyof(var_18_0[self.difficultyIndex_], iter_18_1) == nil then
			return iter_18_1
		end
	end

	return 0
end

function SoloChallengeSelectView:OnResetData(arg_19_1, arg_19_2)
	if isSuccess(arg_19_1.result) then
		SoloChallengeData:ResetLockData(arg_19_2)
		self:Back()
	else
		ShowTips(arg_19_1.result)
	end
end

function SoloChallengeSelectView:customHeroReady()
	local var_20_0, var_20_1 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(ActivitySoloChallengeCfg[self.params_.activityID].stage_id[self.params_.difficultyIndex][1]):GetSummaryHeroList(self.params_.activityID, self.params_.difficultyIndex)

	if var_20_0 == nil then
		return false
	else
		for iter_20_0 = 1, #self.stageList_ do
			if var_20_0[iter_20_0] == 0 then
				return false
			end
		end
	end

	return true
end

function SoloChallengeSelectView:customAffixReady()
	local var_21_0 = SoloChallengeData:GetMaxAffixCount(self.activityID_)
	local var_21_1 = SoloChallengeData:GetCompletedStageList(self.activityID_)

	for iter_21_0, iter_21_1 in pairs(self.stageList_) do
		if table.keyof(var_21_1[self.difficultyIndex_], iter_21_1) == nil then
			local var_21_2 = ReserveTools.GetReserveTemplate(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, iter_21_1):GetContDataTemplateById(ActivitySoloChallengeCfg[self.activityID_].stage_id[self.difficultyIndex_][1]):GetAffixList(iter_21_0)

			for iter_21_2 = 1, var_21_0 do
				if not var_21_2[iter_21_2] or var_21_2[iter_21_2] == 0 then
					return false
				end
			end
		end
	end

	return true
end

function SoloChallengeSelectView:OnExit()
	manager.windowBar:HideBar()
end

function SoloChallengeSelectView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.onResetDataHandler_ = nil
	self.onSaveCustomListHandler_ = nil

	SoloChallengeSelectView.super.Dispose(self)
end

function SoloChallengeSelectView:OnReverTeamData()
	self.stageList_ = ActivitySoloChallengeCfg[self.activityID_].stage_id[self.difficultyIndex_][2]

	self.list_:StartScroll(#self.stageList_)
end

return SoloChallengeSelectView
