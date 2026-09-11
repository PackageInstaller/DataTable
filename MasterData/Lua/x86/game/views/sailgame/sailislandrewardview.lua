local SailIslandRewardView = class("SailIslandRewardView", ReduxView)

function SailIslandRewardView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesRewardPopUI"
end

function SailIslandRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function SailIslandRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SailIslandRewardView:InitUI()
	self:BindCfgUI()

	self.rewardItemList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, SailIslandRewardItem)
end

function SailIslandRewardView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SailIslandRewardView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function SailIslandRewardView:Dispose()
	self.rewardItemList_:Dispose()

	self.rewardItemList_ = nil

	SailIslandRewardView.super.Dispose(self)
end

function SailIslandRewardView:RefreshUI()
	self.sortTaskList_ = SailGameData:GetSortTaskList(self.activityID_)

	self.rewardItemList_:StartScroll(#self.sortTaskList_)
end

function SailIslandRewardView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.sortTaskList_[arg_10_1], self.activityID_)
end

function SailIslandRewardView:OnReceiveSailTask()
	self:RefreshUI()
end

return SailIslandRewardView
