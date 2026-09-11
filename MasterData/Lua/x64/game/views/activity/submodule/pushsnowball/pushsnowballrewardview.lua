local PushSnowBallRewardView = class("PushSnowBallRewardView", ReduxView)

function PushSnowBallRewardView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballRewardsUI"
end

function PushSnowBallRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function PushSnowBallRewardView:Init()
	self.rankTypeConst_ = AdvanceTestData:GetRankTypeConst()

	self:InitUI()

	self.controllerList_ = {}
	self.scoreController_ = ControllerUtil.GetController(self.scoreModelBtn_.transform, "toggle")
	self.bowlingController_ = ControllerUtil.GetController(self.bowlingModelBtn_.transform, "toggle")
	self.bossController_ = ControllerUtil.GetController(self.bossModelBtn_.transform, "toggle")

	table.insert(self.controllerList_, self.scoreController_)
	table.insert(self.controllerList_, self.bowlingController_)
	table.insert(self.controllerList_, self.bossController_)

	self.normalTaskItemList_ = {}
	self.hardTaskItemList_ = {}

	self:AddListeners()
end

function PushSnowBallRewardView:InitUI()
	self:BindCfgUI()

	self.RefreshUIHandler_ = handler(self, self.Refresh)
end

function PushSnowBallRewardView:AddListeners()
	self:AddBtnListener(self.scoreModelBtn_, nil, function()
		self:OnClickSubType(1)
	end)
	self:AddBtnListener(self.bowlingModelBtn_, nil, function()
		self:OnClickSubType(2)
	end)
	self:AddBtnListener(self.bossModelBtn_, nil, function()
		self:OnClickSubType(3)
	end)
end

function PushSnowBallRewardView:OnClickSubType(arg_9_1)
	if self.index ~= arg_9_1 then
		self.scroll_.enabled = false
		self.normalTaskDataList_ = PushSnowBallData:GetNormalTaskListByType(arg_9_1)
		self.hardTaskDataList_ = PushSnowBallData:GetHardTaskListByType(arg_9_1)

		for iter_9_0, iter_9_1 in ipairs(self.normalTaskDataList_) do
			if not self.normalTaskItemList_[iter_9_0] then
				table.insert(self.normalTaskItemList_, (PushSnowBallRewardItem.New((Object.Instantiate(self.taskItem_, self.normalTaskTrs_, false)))))
			end

			self.normalTaskItemList_[iter_9_0]:SetData(iter_9_0, iter_9_1)
		end

		for iter_9_2, iter_9_3 in ipairs(self.hardTaskDataList_) do
			if not self.hardTaskItemList_[iter_9_2] then
				table.insert(self.hardTaskItemList_, (PushSnowBallRewardItem.New((Object.Instantiate(self.taskItem_, self.hardTaskTrs_, false)))))
			end

			self.hardTaskItemList_[iter_9_2]:SetData(iter_9_2, iter_9_3)
		end

		self:RefreshToggle(arg_9_1)

		self.scroll_.enabled = true
	end

	self.index = arg_9_1
end

function PushSnowBallRewardView:RefreshToggle(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.controllerList_) do
		if iter_10_0 == arg_10_1 then
			iter_10_1:SetSelectedState("on")
		else
			iter_10_1:SetSelectedState("off")
		end
	end
end

function PushSnowBallRewardView:OnRewardedTask()
	self:Refresh()
end

function PushSnowBallRewardView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function PushSnowBallRewardView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.activityID_ = self.params_.activityID

	self:OnClickSubType(self.index or 1)
	self:Refresh()
	manager.redPoint:bindUIandKey(self.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 1)
	manager.redPoint:bindUIandKey(self.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 2)
	manager.redPoint:bindUIandKey(self.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 3)
end

function PushSnowBallRewardView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 1)
	manager.redPoint:unbindUIandKey(self.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 2)
	manager.redPoint:unbindUIandKey(self.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 3)
end

function PushSnowBallRewardView:Refresh()
	for iter_15_0, iter_15_1 in ipairs(self.normalTaskItemList_) do
		iter_15_1:RefreshUI()
	end

	for iter_15_2, iter_15_3 in ipairs(self.hardTaskItemList_) do
		iter_15_3:RefreshUI()
	end
end

function PushSnowBallRewardView:Dispose()
	if self.hardTaskItemList_ then
		for iter_16_0, iter_16_1 in ipairs(self.hardTaskItemList_) do
			iter_16_1:Dispose()
		end

		self.hardTaskItemList_ = nil
	end

	if self.normalTaskItemList_ then
		for iter_16_2, iter_16_3 in ipairs(self.normalTaskItemList_) do
			iter_16_3:Dispose()
		end

		self.normalTaskItemList_ = nil
	end

	PushSnowBallRewardView.super.Dispose(self)
end

return PushSnowBallRewardView
