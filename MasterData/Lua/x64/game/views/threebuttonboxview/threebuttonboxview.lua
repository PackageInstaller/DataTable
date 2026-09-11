local ThreeButtonBoxView = class("ThreeButtonBoxView", ReduxView)

function ThreeButtonBoxView:UIName()
	return "UI/PopUp/PopupmationUI"
end

function ThreeButtonBoxView:UIParent()
	return manager.ui.uiPop.transform
end

function ThreeButtonBoxView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transformPanel_, "screenOrientation")
end

function ThreeButtonBoxView:OnEnter()
	self.textContent_.text = self.params_.content

	if getScreenOrientation() then
		self.controller_:SetSelectedState("horizontal")
	else
		self.controller_:SetSelectedState("vertical")
	end
end

function ThreeButtonBoxView:OnExit()
	return
end

function ThreeButtonBoxView:OnTop()
	SetActive(self.gameObject_, true)
end

function ThreeButtonBoxView:OnBehind()
	SetActive(self.gameObject_, false)
end

function ThreeButtonBoxView:Dispose()
	ThreeButtonBoxView.super.Dispose(self)
end

function ThreeButtonBoxView:AddListeners()
	self:AddBtnListener(self.buttonMask_, nil, function()
		self.params_.cancelFun()
	end)
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self.params_.cancelFun()
	end)
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
		self.params_.closeFun()
	end)
	self:AddBtnListener(self.buttonOk_, nil, function()
		self.params_.okFun()
	end)
end

return ThreeButtonBoxView
