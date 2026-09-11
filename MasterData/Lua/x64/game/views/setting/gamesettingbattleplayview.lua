local GameSettingBattlePlayView = class("GameSettingBattlePlayView", ReduxView)

function GameSettingBattlePlayView:UIName()
	return "Widget/System/Setting/GameSettingBattlePlayUI"
end

function GameSettingBattlePlayView:UIParent()
	return manager.ui.uiPop.transform
end

function GameSettingBattlePlayView:OnCtor()
	return
end

function GameSettingBattlePlayView:InitUI()
	self:BindCfgUI()
end

function GameSettingBattlePlayView:AddUIListener()
	self:AddToggleListener(self.lock1Tgl_, function(arg_6_0)
		if arg_6_0 then
			self.battlePlayType = 2
		end
	end)
	self:AddToggleListener(self.lock2Tgl_, function(arg_7_0)
		if arg_7_0 then
			self.battlePlayType = 1
		end
	end)
	self:AddToggleListener(self.lock3Tgl_, function(arg_8_0)
		if arg_8_0 then
			self.battlePlayType = 0
		end
	end)
	self:AddBtnListener(self.yesBtn_, nil, function()
		JumpTools.Back()

		if self.battlePlayType and self.battlePlayType ~= self.params_.type then
			SettingAction.ChangeGameSetting("battle_play_type", self.battlePlayType)
		end

		OperationRecorder.Record("setting", "setting_battle_play")
	end)
	self:AddBtnListener(self.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function GameSettingBattlePlayView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GameSettingBattlePlayView:OnEnter()
	self.battlePlayType = self.params_.type

	if self.battlePlayType == 2 then
		self.lock1Tgl_.isOn = true
	elseif self.battlePlayType == 1 then
		self.lock2Tgl_.isOn = true
	elseif self.battlePlayType == 0 then
		self.lock3Tgl_.isOn = true
	end

	self.text_1.text = GetTips("ADMIN_CHIP_ACT_QUALITY1")
	self.text_2.text = GetTips("ADMIN_CHIP_ACT_QUALITY_TIPS1")
	self.text_3.text = GetTips("ADMIN_CHIP_ACT_QUALITY2")
	self.text_4.text = GetTips("ADMIN_CHIP_ACT_QUALITY_TIPS2")
	self.text_5.text = GetTips("ADMIN_CHIP_ACT_QUALITY3")
	self.text_6.text = GetTips("ADMIN_CHIP_ACT_QUALITY_TIPS3")
	self.titleText_.text = GetTips("ADMIN_CHIP_ACT_QUALITY_TITLE")
end

function GameSettingBattlePlayView:OnExit()
	return
end

function GameSettingBattlePlayView:Dispose()
	self.params_ = nil

	GameSettingBattlePlayView.super.Dispose(self)
end

return GameSettingBattlePlayView
