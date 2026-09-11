local ActivityRaceTaskItem = class("ActivityRaceTaskItem", ReduxView)

function ActivityRaceTaskItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function ActivityRaceTaskItem:Init()
	self:InitUI()
	self:AddListeners()

	self.rewardItemList_ = {}
	self.rewardController_ = ControllerUtil.GetController(self.transform_, "reward")
end

function ActivityRaceTaskItem:InitUI()
	self:BindCfgUI()
end

function ActivityRaceTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		ActivityRaceAction.RequireReceive(self.activityID_, self.taskID_, function(arg_6_0)
			ActivityRaceData:SetReceivedTaskList(self.activityID_, self.taskID_)
			getReward2(arg_6_0.reward_list)
			self:RefreshRewardState()
		end)
	end)
end

function ActivityRaceTaskItem:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.rewardItemList_) do
		iter_7_1:Dispose()
	end

	self.rewardItemList_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil

	ActivityRaceTaskItem.super.Dispose(self)
end

function ActivityRaceTaskItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.taskID_ = arg_8_1
	self.isAccumulated_ = arg_8_3
	self.activityID_ = arg_8_2
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime
	self.rewardList_ = ActivityPointRewardCfg[arg_8_1].reward_item_list

	self:RefreshUI()
end

function ActivityRaceTaskItem:RefreshUI()
	self.desctext_.text = self.isAccumulated_ and string.format(GetTips("ACTIVITY_RACE_AMOUNT_REWARD"), tostring(ActivityPointRewardCfg[self.taskID_].need)) or string.format(GetTips("ACTIVITY_RACE_HIGHEST_REWARD"), tostring(ActivityPointRewardCfg[self.taskID_].need))

	self:RefreshRewardItem()
	self:RefreshRewardState()
end

function ActivityRaceTaskItem:RefreshRewardItem()
	for iter_10_0, iter_10_1 in ipairs(self.rewardList_) do
		if self.rewardItemList_[iter_10_0] then
			self.rewardItemList_[iter_10_0]:SetData(iter_10_1, false)
		else
			self.rewardItemList_[iter_10_0] = RewardPoolItem.New(self.goRewardPanel_, iter_10_1)
		end
	end

	for iter_10_2 = #self.rewardList_ + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_10_2]:Show(false)
	end
end

function ActivityRaceTaskItem:OnReceiveReward(arg_11_1)
	ActivityRaceData:SetReceivedTaskList(self.activityID_, self.taskID_)
	getReward2(arg_11_1)
	self:RefreshRewardState()
end

function ActivityRaceTaskItem:RefreshRewardState()
	local var_12_0 = ActivityRaceData:GetStateList()[self.activityID_]

	self.score_ = 0

	if var_12_0 then
		self.score_ = not self.isAccumulated_ and var_12_0.score or tonumber(var_12_0.accumulativeScore)
	end

	if ActivityRaceData:GetReceivedTaskList(self.activityID_)[self.taskID_] then
		self.rewardController_:SetSelectedState("received")
	elseif self.score_ >= ActivityPointRewardCfg[self.taskID_].need then
		self.rewardController_:SetSelectedState("complete")
	elseif not self.isAccumulated_ then
		self.rewardController_:SetSelectedState("incomplete")
	else
		self.rewardController_:SetSelectedState("accumulateIncomplete")

		self.processText_.text = string.format("%d/%d", self.score_, ActivityPointRewardCfg[self.taskID_].need)
	end
end

return ActivityRaceTaskItem
