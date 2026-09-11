local RecallSystemInputWordPopView = class("RecallSystemInputWordPopView", ReduxView)

function RecallSystemInputWordPopView:UIName()
	return "Widget/System/RecallUI/RC1stRecallCodeUI"
end

function RecallSystemInputWordPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RecallSystemInputWordPopView:Init()
	self:BindCfgUI()
	self:GetOrAddComponent(self.codeInput_.gameObject, typeof(InputFieldHelper))
	dealEnter(self.codeInput_.gameObject)
	self:AddUIListener()
end

function RecallSystemInputWordPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.sureBtn_, nil, function()
		ActivityRecallAction.RequireWriteRecallCode(ActivityRecallData:GetDataByPara("recalledActivityID"), self.codeInput_.text)

		self.codeInput_.text = ""
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
end

function RecallSystemInputWordPopView:OnReceivedCodeReward()
	self:Back()
end

function RecallSystemInputWordPopView:UpdateBar()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function RecallSystemInputWordPopView:OnTop()
	self:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function RecallSystemInputWordPopView:OnEnter()
	self:UpdateView()
end

function RecallSystemInputWordPopView:UpdateView()
	self.codeInput_.text = ""
end

function RecallSystemInputWordPopView:OnExit()
	manager.windowBar:HideBar()
end

function RecallSystemInputWordPopView:Dispose()
	self.codeInput_.onValueChanged:RemoveAllListeners()
	RecallSystemInputWordPopView.super.Dispose(self)
end

return RecallSystemInputWordPopView
