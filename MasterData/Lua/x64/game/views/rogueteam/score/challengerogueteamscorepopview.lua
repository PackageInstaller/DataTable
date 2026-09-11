local ChallengeRogueTeamScorePopView = class("ChallengeRogueTeamScorePopView", ReduxView)

function ChallengeRogueTeamScorePopView:UIName()
	return "Widget/System/Activity_Roulike/RoulikepointsPopUI"
end

function ChallengeRogueTeamScorePopView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamScorePopView:Init()
	self:InitUI()
	self:AddUIListener()

	self.rewardItemList_ = {}
end

function ChallengeRogueTeamScorePopView:InitUI()
	self:BindCfgUI()
end

function ChallengeRogueTeamScorePopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.itemBtn_, nil, function()
		ShowPopItemOnly(POP_ITEM, {
			RogueTeamCfg[self.templateID_].point_item,
			0
		})
	end)
end

function ChallengeRogueTeamScorePopView:OnEnter()
	self.activityId_ = self.params_.activityId
	self.templateID_ = ChallengeRogueTeamData:GetCacheTemplateID()
	self.cfg_ = ActivityCfg[self.activityId_]
	self.isFirstSeason_ = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.SEASON, self.templateID_)

	self:RegistEventListener(ACTIVITY_REWARD_GET, handler(self, self.RefreshUI))
	self:RefreshUI()
end

function ChallengeRogueTeamScorePopView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_SCORE_DESC")
end

function ChallengeRogueTeamScorePopView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function ChallengeRogueTeamScorePopView:RefreshUI()
	local var_11_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	self.level_, self.score_, self.expToLvValue_, self.scoreIDList_, self.maxLevel_ = ChallengeRogueTeamTools.GetCurrentSurveyLevel(var_11_0)
	self.levelProgressSlider_.transform.sizeDelta = Vector2(-1 * self.layout_.spacing, self.levelProgressSlider_.transform.sizeDelta.y)
	self.levelProgressSlider_.value = math.min(self.level_, self.maxLevel_) / self.maxLevel_
	self.levelProgressText_.text = self.level_
	self.expProgressText_.text = math.floor(self.score_ / self.expToLvValue_) >= self.maxLevel_ and "--/--" or self.score_ % self.expToLvValue_ .. "/" .. self.expToLvValue_
	self.expProgressSlider_.value = math.floor(self.score_ / self.expToLvValue_) >= self.maxLevel_ and 1 or self.score_ % self.expToLvValue_ / self.expToLvValue_
	self.unCompleteIndex_ = ChallengeRogueTeamData:GetUnCompleteIndex(var_11_0, self.activityId_)

	local var_11_1 = 0
	local var_11_2 = #self.scoreIDList_

	for iter_11_0, iter_11_1 in ipairs((ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_REWARD_LEVEL, ChallengeRogueTeamData:GetCacheTemplateID()))) do
		if iter_11_1 > self.level_ then
			var_11_1 = iter_11_1

			break
		end
	end

	for iter_11_2 = self.unCompleteIndex_, #self.scoreIDList_ do
		if math.floor(ActivityPointRewardCfg[self.scoreIDList_[iter_11_2]].need / self.expToLvValue_) == var_11_1 then
			var_11_2 = iter_11_2

			break
		end
	end

	self.rewardIcon_.sprite = ItemTools.getItemSprite(ActivityPointRewardCfg[self.scoreIDList_[var_11_2]].reward_item_list[1][1])

	self:RefreshScroll()
end

function ChallengeRogueTeamScorePopView:RefreshScroll()
	for iter_12_0, iter_12_1 in ipairs(self.rewardItemList_) do
		SetActive(iter_12_1.gameObject_, false)
	end

	for iter_12_2, iter_12_3 in ipairs(self.scoreIDList_) do
		self.rewardItemList_[iter_12_2] = self.rewardItemList_[iter_12_2] or ChallengeRogueTeamScoreItem.New(GameObject.Instantiate(self.rewardItemGo_, self.rewardContent_), self.scoreIDList_)

		self.rewardItemList_[iter_12_2]:SetData(iter_12_3, iter_12_2)
		SetActive(self.rewardItemList_[iter_12_2].gameObject_, true)
	end

	self.scrollView_.horizontalNormalizedPosition = (self.layout_.padding.left + (self.unCompleteIndex_ - 1) * (self.rewardItemGo_.transform.rect.width + self.layout_.spacing)) / (self.layout_.padding.left + #self.scoreIDList_ * self.rewardItemGo_.transform.rect.width + #self.scoreIDList_ * self.layout_.spacing - self.scrollView_.viewport.rect.width / self.layout_.transform.localScale.x)
end

function ChallengeRogueTeamScorePopView:Dispose()
	if self.rewardItemList_ then
		for iter_13_0, iter_13_1 in ipairs(self.rewardItemList_) do
			iter_13_1:Dispose()
		end

		self.rewardItemList_ = nil
	end

	ChallengeRogueTeamScorePopView.super.Dispose(self)
end

return ChallengeRogueTeamScorePopView
