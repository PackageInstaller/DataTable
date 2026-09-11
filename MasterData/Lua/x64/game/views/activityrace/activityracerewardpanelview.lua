local ActivityRaceRewardPanelView = class("ActivityRaceRewardPanelView", ReduxView)

function ActivityRaceRewardPanelView:UIName()
	return "UI/VolumeIIIDownUI/ActivityRace/ActivityRaceRewardPanelUI"
end

function ActivityRaceRewardPanelView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityRaceRewardPanelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityRaceRewardPanelView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, ActivityRaceRewardItem)
end

function ActivityRaceRewardPanelView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function ActivityRaceRewardPanelView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function ActivityRaceRewardPanelView:RefreshUI()
	self.sortedRewardList_ = ActivityRaceData:GetSortedRewardList(self.activityID_)

	self.scrollHelper_:StartScroll(#self.sortedRewardList_)
end

function ActivityRaceRewardPanelView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.sortedRewardList_[arg_9_1])
end

function ActivityRaceRewardPanelView:Dispose()
	self.scrollHelper_:Dispose()
	ActivityRaceRewardPanelView.super.Dispose(self)
end

return ActivityRaceRewardPanelView
