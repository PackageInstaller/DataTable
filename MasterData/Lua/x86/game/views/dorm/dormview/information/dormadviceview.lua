local DormAdviceView = class("DormAdviceView", ReduxView)

function DormAdviceView:UIName()
	return "Widget/BackHouseUI/Dorm/DormInformationPanelUI"
end

function DormAdviceView:UIParent()
	return manager.ui.uiMain.transform
end

function DormAdviceView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormAdviceView:BuildContext()
	self.page = DormInfomationPage.New(self.infomationObj_)
end

function DormAdviceView:InitUI()
	self:BindCfgUI()
	self:BuildContext()
end

function DormAdviceView:AddUIListener()
	self:AddBtnListener(self.btnMask_, nil, function()
		self:Back()
	end)
end

function DormAdviceView:Render()
	self.page:Show()
	SetActive(self.emptyObj_, self.page:NeedEmpty())
end

function DormAdviceView:OnEnter()
	self:Render()
end

function DormAdviceView:Back()
	DormAdviceView.super.Back(self)
end

function DormAdviceView:OnExit()
	return
end

function DormAdviceView:OnTop()
	self:Render()
end

function DormAdviceView:Dispose()
	self.page:Dispose()

	self.page = nil

	DormAdviceView.super.Dispose(self)
end

return DormAdviceView
