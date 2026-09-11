local ActivityPtScrollPopView = class("ActivityPtScrollPopView", ReduxView)

function ActivityPtScrollPopView:UIName()
	return ActivityPtScrollTools.GetBuffPopUIName(self.params_.mainActivityID)
end

function ActivityPtScrollPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityPtScrollPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPtScrollPopView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityPtScrollPopItem)
end

function ActivityPtScrollPopView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshData(ActivityPtScrollData:GetAffixInfo(self.activityID_, self.list_[arg_5_1]), self.contentRect_, self.viewRect_.rect.height)
end

function ActivityPtScrollPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function ActivityPtScrollPopView:OnEnter()
	self.activityID_ = self.params_.mainActivityID

	self:RefreshData()
	self:RefreshList()
end

function ActivityPtScrollPopView:RefreshData()
	self.list_ = {}

	local var_9_0 = ActivityPtScrollData:GetAffixList(self.activityID_)

	table.insertto(self.list_, var_9_0)
	table.insertto(self.list_, var_9_0)

	self.chooseIndex_ = #var_9_0 + (#var_9_0 - 1) / 2 + 1
end

function ActivityPtScrollPopView:RefreshList()
	if self.params_.isScroll then
		self.params_.isScroll = false

		manager.audio:PlayEffect("minigame_activity_2_6", "minigame_activity_2_6_pt1_rotate", "")
		self.scrollHelper_:StartScroll(#self.list_, self.chooseIndex_, true, true, 3.5)
	else
		manager.audio:PlayEffect("minigame_activity_2_6", "minigame_activity_2_6_pt1_platform", "")
		self.scrollHelper_:StartScroll(#self.list_, self.chooseIndex_, true)
	end
end

function ActivityPtScrollPopView:OnExit()
	self.scrollHelper_:RemoveTween()
	self.scrollHelper_:SetScrolledPosition(Vector2.one)

	for iter_11_0, iter_11_1 in pairs(self.scrollHelper_.itemOfInstanceID_) do
		iter_11_1:OnExit()
	end
end

function ActivityPtScrollPopView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivityPtScrollPopView
