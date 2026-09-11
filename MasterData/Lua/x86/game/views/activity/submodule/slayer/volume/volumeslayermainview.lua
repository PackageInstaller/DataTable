local VolumeSlayerMainView = class("VolumeSlayerMainView", ReduxView)

function VolumeSlayerMainView:UIName()
	return SlayerTools.GetMainUIName(self.params_.slayer_activity_id or 0)
end

function VolumeSlayerMainView:UIParent()
	return manager.ui.uiMain.transform
end

function VolumeSlayerMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function VolumeSlayerMainView:InitUI()
	self:BindCfgUI()
end

function VolumeSlayerMainView:AddUIListener()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("hellaSlayerReward", {
			slayer_activity_id = self.slayer_activity_id
		})
	end)
	self:AddBtnListener(self.m_entrustBtn, nil, function()
		if not ActivityTools.GetActivityIsOpenWithTip(self.slayer_activity_id, true) then
			return
		end

		JumpTools.OpenPageByJump("/volumeSlayer", {
			init_tag = true,
			slayer_activity_id = self.slayer_activity_id
		})
	end)
end

function VolumeSlayerMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VOLUME_SLAYER_DESCRIPE")
end

function VolumeSlayerMainView:OnEnter()
	if self.params_.playerAnim then
		self.m_animator:Play("VolumeCutgrassMainUI", 0, 0)

		self.params_.playerAnim = nil
	else
		self.m_animator:Play("VolumeCutgrassMainUI", 0, 9999999)
	end

	self.slayer_activity_id = self.params_.slayer_activity_id or 0

	self:RefreshTime()

	self.timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer:Start()
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, self.slayer_activity_id))
	manager.redPoint:bindUIandKey(self.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.slayer_activity_id))
end

function VolumeSlayerMainView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, self.slayer_activity_id))
	manager.redPoint:unbindUIandKey(self.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.slayer_activity_id))
end

function VolumeSlayerMainView:RefreshTime()
	local var_12_0 = ActivityData:GetActivityData(self.slayer_activity_id)

	self.m_timeLab.text = var_12_0 and manager.time:GetLostTimeStr(var_12_0.stopTime) or GetTips("TIME_OVER")
end

function VolumeSlayerMainView:Dispose()
	VolumeSlayerMainView.super.Dispose(self)
end

return VolumeSlayerMainView
