local PaperCutRewardView = class("PaperCutRewardView", ReduxView)

function PaperCutRewardView:UIName()
	return "UI/EmptyDream/PaperCut/PaperCutRewardUI"
end

function PaperCutRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function PaperCutRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PaperCutRewardView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, PaperCutRewardItem)
end

function PaperCutRewardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function PaperCutRewardView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function PaperCutRewardView:RefreshUI()
	self:RefreshScroll()
end

function PaperCutRewardView:RefreshScroll()
	self.scrollHelper_:StartScroll(self:GetAwardListLength())
end

function PaperCutRewardView:GetAwardListLength()
	self.taskIDList_ = PaperCutData:GetRewardList(self.activityID_)

	return #self.taskIDList_
end

function PaperCutRewardView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.taskIDList_[arg_11_1], self.activityID_)
	arg_11_2:SetReveivedHandler(handler(self, self.RefreshScroll))
end

function PaperCutRewardView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	PaperCutRewardView.super.Dispose(self)
end

return PaperCutRewardView
