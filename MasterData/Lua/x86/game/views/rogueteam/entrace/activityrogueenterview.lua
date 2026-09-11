local ActivityRogueEnterView = class("ActivityRogueEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function ActivityRogueEnterView:GetUIName()
	return "Widget/System/Activity_Roulike/Activity_Roulike_MainUI"
end

function ActivityRogueEnterView:Init()
	self:InitUI()
	self:AddListeners()
end

function ActivityRogueEnterView:InitUI()
	self:BindCfgUI()

	self.doubleController_ = self.controllerEx_:GetController("double")
	self.tipsGoList_ = {}
end

function ActivityRogueEnterView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/challengeRogueTeamEntrace", {
			templateID = self.templateId_
		})
	end)
	self:AddBtnListener(self.scoreBtn_, nil, function()
		JumpTools.OpenPageByJump("challengeRogueTeamScorePop", {
			activityId = ChallengeRogueTeamData:GetScoreActivityIDByTemple(self.templateId_)
		})

		local var_6_0, var_6_1 = ChallengeRogueTeamTools.GetIsNewScoreReward(self.templateId_)

		if var_6_0 then
			ChallengeRogueTeamAction.SetLastScoreId(self.templateId_, var_6_1)
			manager.redPoint:setTip(RedPointConst.CHALLENGE_ROGUE_TEAM_NEW_REWARD, 0)
		end
	end)
end

function ActivityRogueEnterView:OnEnter()
	self:UpdateTitleShow()

	self.templateId_ = ChallengeRogueTeamData:GetCacheTemplateID()
	self.levelText_.text = ChallengeRogueTeamTools.GetCurrentSurveyLevel(self.templateId_)

	local var_7_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUE_DOUBLE_REWARD_4_4)

	self.doubleController_:SetSelectedState(tostring(var_7_0 and var_7_0:IsActivitying()))

	self.mutiText_.text = GameSetting.rogue_team_multi_reward.value[1]
	self.timer_ = Timer.New(function()
		self.timeText_.text = manager.time:GetLostTimeStr2(var_7_0.stopTime)
	end, 1, -1)

	self.timer_:Start()

	self.pointRedPointStr_ = string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, ChallengeRogueTeamTools.GetPointActivityID(self.templateId_))

	manager.redPoint:bindUIandKey(self.scoreBtn_.transform, self.pointRedPointStr_)

	self.tipTitleText_.text = GetTips("ROUGE_TEAM_UPDATE_TITLE")
	self.tipsList_ = string.split(GetTips("ROUGE_TEAM_UPDATE"), "\n")

	for iter_7_0, iter_7_1 in ipairs(self.tipsList_) do
		local var_7_1 = self.tipsGoList_[iter_7_0]

		if self.tipsGoList_[iter_7_0] == nil then
			var_7_1 = Object.Instantiate(self.tipItemGo_, self.tipItemContain_, false)

			table.insert(self.tipsGoList_, var_7_1)
		end

		SetActive(var_7_1, true)

		var_7_1.transform:Find("textNEWdec"):GetComponent("Text").text = iter_7_1
	end

	for iter_7_2 = #self.tipsList_ + 1, #self.tipsGoList_ do
		SetActive(self.tipsGoList_[iter_7_2], false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.tipItemContain_)

	self.tipScroll_.enabled = #self.tipsList_ >= 4
end

function ActivityRogueEnterView:OnExit()
	manager.redPoint:unbindUIandKey(self.scoreBtn_.transform, self.pointRedPointStr_)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	ActivityRogueEnterView.super.OnExit(self)
end

function ActivityRogueEnterView:OnDisPose()
	self.super.OnDisPose(self)

	for iter_10_0, iter_10_1 in ipairs(self.tipsGoList_) do
		Object.Destroy(iter_10_1)
	end
end

return ActivityRogueEnterView
