local RecallSystemRewardView = class("RecallSystemRewardView", ReduxView)

function RecallSystemRewardView:UIName()
	return "Widget/System/RecallUI/RC1stRewardUI"
end

function RecallSystemRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function RecallSystemRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RecallSystemRewardView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, RecallSystemRewardItem)
end

function RecallSystemRewardView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.params_.list[arg_5_1])
end

function RecallSystemRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function RecallSystemRewardView:UpdateBar()
	return
end

function RecallSystemRewardView:OnTop()
	manager.windowBar:SetAsLastSibling()
end

function RecallSystemRewardView:OnEnter()
	self:UpdateView()
end

function RecallSystemRewardView:UpdateView()
	self.list_:StartScroll(#self.params_.list)
end

function RecallSystemRewardView:OnExit()
	manager.windowBar:HideBar()
end

function RecallSystemRewardView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	RecallSystemRewardView.super.Dispose(self)
end

return RecallSystemRewardView
