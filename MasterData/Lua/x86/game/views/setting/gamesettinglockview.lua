local GameSettingLockView = class("GameSettingLockView", ReduxView)

function GameSettingLockView:UIName()
	return "Widget/System/Setting/GameSettingLockUI"
end

function GameSettingLockView:UIParent()
	return manager.ui.uiPop.transform
end

function GameSettingLockView:OnCtor()
	return
end

function GameSettingLockView:InitUI()
	self:BindCfgUI()
end

function GameSettingLockView:AddUIListener()
	self:AddToggleListener(self.lock1Tgl_, function(arg_6_0)
		if arg_6_0 then
			self.lockType = 0
		end
	end)
	self:AddToggleListener(self.lock2Tgl_, function(arg_7_0)
		if arg_7_0 then
			self.lockType = 1
		end
	end)
	self:AddToggleListener(self.lock3Tgl_, function(arg_8_0)
		if arg_8_0 then
			self.lockType = 2
		end
	end)
	self:AddBtnListener(self.yesBtn_, nil, function()
		JumpTools.Back()

		if self.lockType and self.lockType ~= self.params_.type then
			SettingAction.ChangeGameSetting("battle_lock_type", self.lockType)
		end

		OperationRecorder.Record("setting", "setting_lock")
	end)
	self:AddBtnListener(self.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function GameSettingLockView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GameSettingLockView:OnEnter()
	self.lockType = self.params_.type

	if self.lockType == 0 then
		self.lock1Tgl_.isOn = true
	elseif self.lockType == 1 then
		self.lock2Tgl_.isOn = true
	elseif self.lockType == 2 then
		self.lock3Tgl_.isOn = true
	end
end

function GameSettingLockView:OnExit()
	return
end

function GameSettingLockView:Dispose()
	self.params_ = nil

	GameSettingLockView.super.Dispose(self)
end

return GameSettingLockView
