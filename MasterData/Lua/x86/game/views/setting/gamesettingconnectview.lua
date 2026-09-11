local GameSettingConnectView = class("GameSettingConnectView", ReduxView)

function GameSettingConnectView:UIName()
	return "Widget/System/Setting/GameSettingConnectUI"
end

function GameSettingConnectView:UIParent()
	return manager.ui.uiPop.transform
end

function GameSettingConnectView:OnCtor()
	return
end

function GameSettingConnectView:InitUI()
	self:BindCfgUI()
end

function GameSettingConnectView:AddUIListener()
	self:AddToggleListener(self.connect1Tgl_, function(arg_6_0)
		if arg_6_0 then
			self.connectType = 0
		end
	end)
	self:AddToggleListener(self.connect2Tgl_, function(arg_7_0)
		if arg_7_0 then
			self.connectType = 2
		end
	end)
	self:AddToggleListener(self.connect3Tgl_, function(arg_8_0)
		if arg_8_0 then
			self.connectType = 3
		end
	end)
	self:AddToggleListener(self.connect4Tgl_, function(arg_9_0)
		if arg_9_0 then
			self.connectType = 4
		end
	end)
	self:AddToggleListener(self.connect5Tgl_, function(arg_10_0)
		if arg_10_0 then
			self.connectType = 1
		end
	end)
	self:AddBtnListener(self.yesBtn_, nil, function()
		if self.connectType and self.connectType ~= self.params_.type then
			SettingAction.ChangeGameSetting("cus_full_play_controlled_type", self.connectType)
		end

		JumpTools.Back()
	end)
	self:AddBtnListener(self.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function GameSettingConnectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GameSettingConnectView:OnEnter()
	self.connectType = self.params_.type

	if self.connectType == 0 then
		self.connect1Tgl_.isOn = true
	elseif self.connectType == 2 then
		self.connect2Tgl_.isOn = true
	elseif self.connectType == 3 then
		self.connect3Tgl_.isOn = true
	elseif self.connectType == 4 then
		self.connect4Tgl_.isOn = true
	elseif self.connectType == 1 then
		self.connect5Tgl_.isOn = true
	end
end

function GameSettingConnectView:OnExit()
	return
end

function GameSettingConnectView:Dispose()
	self.params_ = nil

	GameSettingConnectView.super.Dispose(self)
end

return GameSettingConnectView
