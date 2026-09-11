local SpecialEventPopView = class("SpecialEventPopView", ReduxView)

function SpecialEventPopView:UIName()
	return "UI/HouseUI/SpecialEventPop"
end

function SpecialEventPopView:UIParent()
	return manager.ui.uiMain.transform
end

function SpecialEventPopView:Init()
	self:InitUI()
	self:AddListeners()
end

function SpecialEventPopView:InitUI()
	self:BindCfgUI()
end

function SpecialEventPopView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.cancelbtnBtn_, nil, function()
		self.params_.cancelCallback()
	end)
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		self.params_.okCallback()
	end)
end

function SpecialEventPopView:OnEnter()
	self.tex_contentText_.text = GetI18NText(self.params_.content)
end

function SpecialEventPopView:OnExit()
	return
end

function SpecialEventPopView:Dispose()
	SpecialEventPopView.super.Dispose(self)
end

return SpecialEventPopView
