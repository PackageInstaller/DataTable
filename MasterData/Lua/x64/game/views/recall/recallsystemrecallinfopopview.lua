local RecallSystemRecallInfoPopView = class("RecallSystemRecallInfoPopView", ReduxView)

function RecallSystemRecallInfoPopView:UIName()
	return "Widget/System/RecallUI/RC1stRecordUI"
end

function RecallSystemRecallInfoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RecallSystemRecallInfoPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RecallSystemRecallInfoPopView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, RecallSystemRecallNumberInfoItem)
end

function RecallSystemRecallInfoPopView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(ActivityRecallData:GetDataByPara("userInfoList")[arg_5_1])
end

function RecallSystemRecallInfoPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function RecallSystemRecallInfoPopView:UpdateBar()
	return
end

function RecallSystemRecallInfoPopView:OnTop()
	self:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function RecallSystemRecallInfoPopView:OnEnter()
	self:UpdateView()
end

function RecallSystemRecallInfoPopView:UpdateView()
	self.list_:StartScroll((ActivityRecallData:GetDataByPara("codeUseNum")))
end

function RecallSystemRecallInfoPopView:OnExit()
	manager.windowBar:HideBar()
end

function RecallSystemRecallInfoPopView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	RecallSystemRecallInfoPopView.super.Dispose(self)
end

return RecallSystemRecallInfoPopView
