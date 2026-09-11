SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local SPKailiChallengeSectionView = class("SPKailiChallengeSectionView", SectionBaseView)

function SPKailiChallengeSectionView:Init()
	SPKailiChallengeSectionView.super.Init(self)

	self.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(self.threeStarGo_)
end

function SPKailiChallengeSectionView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/KaliChapterSectionInfoUI"
end

function SPKailiChallengeSectionView:RefreshRewardItem(arg_3_1, arg_3_2)
	local var_3_0

	if self.rewardList_[arg_3_1] then
		var_3_0 = rewardToItemTemplate(self.rewardList_[arg_3_1])
		var_3_0.number = self.rewardList_[arg_3_1].num or 0

		function var_3_0.clickFun(arg_4_0)
			ShowPopItem(POP_ITEM, arg_4_0)
		end
	end

	arg_3_2:SetData(var_3_0)
end

function SPKailiChallengeSectionView:RefreshData()
	local var_5_0 = self.params_.stageID or 0
	local var_5_1 = BattleCoreKaliCfg[var_5_0]

	self.sectionName_.text = BattleCoreKaliCfg[var_5_0] and var_5_1.name

	local var_5_2 = SPKaliChallengeData:GetStageData(ActivityCfg.get_id_list_by_sub_activity_list[self.params_.activityID][1], self.params_.stageID)

	self.threeStarDataList_ = {
		{
			var_5_2,
			{
				8
			}
		},
		{
			false
		},
		{
			false
		}
	}

	self.sectionInfoThreeStarBar_:SetData(self.threeStarDataList_)

	self.isFirstClear_ = not var_5_2
	self.dropLibID_ = BattleCoreKaliCfg[var_5_0].drop_lib_id
	self.cost_ = var_5_1.cost or 0
	self.multiple_ = 1
	self.lock_ = not self.params_.lock

	if not ActivityData:GetActivityIsOpen(self.params_.activityID) then
		local var_5_3 = ActivityData:GetActivityData(self.params_.activityID)

		self.lockTips_ = var_5_3 and var_5_3.startTime and self.params_.prePass and string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_5_3.startTime)) or GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
	else
		self.lockTips_ = GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
	end

	self.storyText_.text = var_5_1.tips
end

function SPKailiChallengeSectionView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		self:Back()
		self:OnClickBtn()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SPKailiChallengeSectionView:OnEnter()
	SPKailiChallengeSectionView.super.OnEnter(self)
end

function SPKailiChallengeSectionView:RefreshTitleDesc()
	return
end

function SPKailiChallengeSectionView:UpdateBar()
	return
end

function SPKailiChallengeSectionView:RefreshUI()
	self.hideThreeStarController_:SetSelectedState("false")
	self.hideStageDescController_:SetSelectedState("false")
	self.hideFatigueController_:SetSelectedState("close")
	self:RefreshReward()
	self:RefreshCost()

	if self.lock_ then
		self.btnLockText_.text = self.lockTips_

		self.btnController_:SetSelectedState("true")
	else
		self.btnController_:SetSelectedState("false")
	end

	self.rewardTitleText_.text = self.isFirstClear_ and GetTips("FIRST_DROP") or GetTips("ACTIVITY_KALI_REWARD_DES")
end

function SPKailiChallengeSectionView:HaveCostCntFlag()
	return false
end

function SPKailiChallengeSectionView:OnClickBtn()
	self:GoToSelectHero()
end

function SPKailiChallengeSectionView:GoToSelectHero()
	self:Go("/sectionSelectHero", {
		section = self.params_.stageID,
		sectionType = self.params_.sectionType,
		activityID = self.params_.activityID
	})
end

function SPKailiChallengeSectionView:Dispose()
	self.sectionInfoThreeStarBar_:Dispose()

	self.sectionInfoThreeStarBar_ = nil

	SPKailiChallengeSectionView.super.Dispose(self)
end

return SPKailiChallengeSectionView
