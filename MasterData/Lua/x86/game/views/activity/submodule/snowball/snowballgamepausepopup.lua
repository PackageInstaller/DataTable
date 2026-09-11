local SnowballGamePausePopup = class("SnowballGamePausePopup", ReduxView)

function SnowballGamePausePopup:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGamePausePopup"
end

function SnowballGamePausePopup:UIParent()
	return manager.ui.uiPop.transform
end

function SnowballGamePausePopup:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.okBtn_, nil, function()
		JumpTools.Back()

		if self.OkCallback then
			self.OkCallback()
		end
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		JumpTools.Back()

		if self.CancelCallback then
			self.CancelCallback()
		end
	end)
end

function SnowballGamePausePopup:OnEnter()
	self.OkCallback = self.params_.OkCallback
	self.CancelCallback = self.params_.CancelCallback
end

return SnowballGamePausePopup
