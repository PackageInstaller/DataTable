local GuideStuckPopView = class("GuideStuckPopView", ReduxView)

function GuideStuckPopView:UIName()
	return "Widget/System/GuideNewUI/GuideStuckPopView"
end

function GuideStuckPopView:UIParent()
	return manager.ui.uiTips.transform
end

function GuideStuckPopView:Init()
	self:InitUI()
	self:AddListeners()
end

function GuideStuckPopView:InitUI()
	self:BindCfgUI()
end

function GuideStuckPopView:AddListeners()
	self.okBtn_.onClick:AddListener(function()
		self:OnClickOk()
	end)
	self.cancelBtn_.onClick:AddListener(function()
		self:OnClickCancel()
	end)
	self.maskBtn_.onClick:AddListener(function()
		self:OnClickCancel()
	end)
end

function GuideStuckPopView:OnClickOk()
	if self.info_.OkCallback then
		self.info_.OkCallback()
	end

	self:Back()
end

function GuideStuckPopView:OnClickCancel()
	if self.info_.CancelCallback then
		self.info_.CancelCallback()
	end

	self:Back()
end

function GuideStuckPopView:RemoveListeners()
	self.okBtn_.onClick:RemoveAllListeners()
	self.cancelBtn_.onClick:RemoveAllListeners()
	self.tipsBtn_.onClick:RemoveAllListeners()
end

function GuideStuckPopView:OnEnter()
	self.info_ = self.params_
	self.tipContent_.text = self.info_.content
end

function GuideStuckPopView:SetGaussionBg()
	manager.ui:SetUISeparateRender(true)

	return true
end

function GuideStuckPopView:Hide()
	return
end

function GuideStuckPopView:Dispose()
	GuideStuckPopView.super.Dispose(self)
end

return GuideStuckPopView
