local QWorldComfirmView_4_0 = class("QWorldComfirmView_4_0", ReduxView)

function QWorldComfirmView_4_0:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_ComfirmUI"
end

function QWorldComfirmView_4_0:UIParent()
	return manager.ui.uiPop.transform
end

function QWorldComfirmView_4_0:Init()
	self:InitUI()
	self:AddListener()
end

function QWorldComfirmView_4_0:InitUI()
	self:BindCfgUI()

	self.cancelBtnText_.text = GetTips("CANCEL")
	self.comfirmBtnText_.text = GetTips("ROGUE_TEAM_BUTTON_CONFIRM")
end

function QWorldComfirmView_4_0:AddListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		if self.params_.cancelCallback then
			self.params_.cancelCallback()
		end
	end)
	self:AddBtnListener(self.comfirmBtn_, nil, function()
		if self.params_.comfirmCallback then
			self.params_.comfirmCallback()
		end
	end)
end

function QWorldComfirmView_4_0:OnEnter()
	self:RefreshUI()
end

function QWorldComfirmView_4_0:RefreshUI()
	self.titleText_.text = self.params_.title or ""
	self.contentText_.text = self.params_.content or ""
end

return QWorldComfirmView_4_0
