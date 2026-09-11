local FishStaminaRecoverOverflowNotify = class("FishStaminaRecoverOverflowNotify", ReduxView)

function FishStaminaRecoverOverflowNotify:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingPop"
end

function FishStaminaRecoverOverflowNotify:UIParent()
	return manager.ui.uiPop.transform
end

function FishStaminaRecoverOverflowNotify:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.okBtn_, nil, handler(self, self.OnOk))
	self:AddBtnListener(self.cancelBtn_, nil, handler(self, self.OnCancel))
end

function FishStaminaRecoverOverflowNotify:OnEnter()
	self.okCallback = self.params_.OkCallback
	self.cancelCallback = self.params_.CancelCallback
end

function FishStaminaRecoverOverflowNotify:OnOk()
	OperationRecorder.RecordButtonTouch("activity_kagutsuchi_energyspilling_ture")
	JumpTools.Back()

	if self.okCallback then
		self.okCallback()
	end
end

function FishStaminaRecoverOverflowNotify:OnCancel()
	OperationRecorder.RecordButtonTouch("activity_kagutsuchi_energyspilling_false")
	JumpTools.Back()

	if self.cancelCallback then
		self.cancelCallback()
	end
end

return FishStaminaRecoverOverflowNotify
