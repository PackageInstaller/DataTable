local ActivityHeroLetterPlayBackView = class("ActivityHeroLetterPlayBackView", ReduxView)

function ActivityHeroLetterPlayBackView:UIName()
	return ActivityHeroLetterTools.GetPlayBackUIName(self.params_.activityID)
end

function ActivityHeroLetterPlayBackView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityHeroLetterPlayBackView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityHeroLetterPlayBackView:InitUI()
	self:BindCfgUI()

	self.rewardItem_ = {}
end

function ActivityHeroLetterPlayBackView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btn_, nil, function()
		self:GotoWeb()
	end)
end

function ActivityHeroLetterPlayBackView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshReward()
	self:RefreshType()
end

function ActivityHeroLetterPlayBackView:RefreshReward()
	for iter_9_0, iter_9_1 in ipairs(GameSetting.activity_hero_task_reward_list.value) do
		self.rewardItem_[iter_9_0] = self.rewardItem_[iter_9_0] or CommonItemView.New((Object.Instantiate(self.rewardGo_, self.rewardContent_)))

		local var_9_0 = clone(ItemTemplateData)

		var_9_0.id = iter_9_1[1]
		var_9_0.number = iter_9_1[2]

		function var_9_0.clickFun()
			ShowPopItem(POP_ITEM, {
				var_9_0.id
			})
		end

		self.rewardItem_[iter_9_0]:SetData(var_9_0)
		self.rewardItem_[iter_9_0]:Show(true)
	end

	for iter_9_2 = #GameSetting.activity_hero_task_reward_list.value + 1, #self.rewardItem_ do
		self.rewardItem_[iter_9_2]:Show(false)
	end
end

function ActivityHeroLetterPlayBackView:RefreshType()
	local var_11_0 = ActivityHeroLetterData:GetRewwardSign(self.activityID_)

	for iter_11_0, iter_11_1 in ipairs(self.rewardItem_) do
		iter_11_1:RefreshCompleted(var_11_0 == 1)
	end
end

function ActivityHeroLetterPlayBackView:GotoWeb()
	OperationAction.OpenOperationUrl("ACTIVITY_URL", {
		userId = PlayerData:GetPlayerInfo().userID,
		signUserId = PlayerData:GetPlayerInfo().signUserId
	})

	if ActivityHeroLetterData:GetRewwardSign(self.activityID_) ~= 1 then
		ActivityHeroLetterAction.GetReward(self.activityID_)
	end
end

function ActivityHeroLetterPlayBackView:OnHeroLetterReward()
	self:RefreshReward()
	self:RefreshType()
end

function ActivityHeroLetterPlayBackView:OnExit()
	self:RemoveAllEventListener()
end

function ActivityHeroLetterPlayBackView:Dispose()
	self:RemoveAllListeners()

	for iter_15_0, iter_15_1 in ipairs(self.rewardItem_) do
		iter_15_1:Dispose()
	end

	self.super.Dispose(self)
end

return ActivityHeroLetterPlayBackView
