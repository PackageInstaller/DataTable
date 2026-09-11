local SlayerMainView_1_7 = class("SlayerMainView_1_7", (import("game.views.activity.Submodule.slayer.volume.VolumeSlayerMainView")))

function SlayerMainView_1_7:OnEnter()
	self.slayer_activity_id = self.params_.slayer_activity_id or 0

	self:RefreshTime()

	self.timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer:Start()
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, self.slayer_activity_id))
	manager.redPoint:bindUIandKey(self.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.slayer_activity_id))
end

function SlayerMainView_1_7:AddUIListener()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("slayerRewardView_1_7", {
			slayer_activity_id = self.slayer_activity_id
		})
	end)
	self:AddBtnListener(self.m_entrustBtn, nil, function()
		if not ActivityTools.GetActivityIsOpenWithTip(self.slayer_activity_id, true) then
			return
		end

		JumpTools.OpenPageByJump("/slayerStageView_1_7", {
			init_tag = true,
			slayer_activity_id = self.slayer_activity_id
		})
	end)
end

function SlayerMainView_1_7:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SOLO_SLAYER_DESCRIPE")
	self:PlayAudio()
end

function SlayerMainView_1_7:OnExit()
	SlayerMainView_1_7.super.OnExit(self)
	self:StopAudio()
end

function SlayerMainView_1_7:PlayAudio()
	manager.audio:PlayEffect("minigame_activity_1_7", "minigame_activity_1_7_Sword_loop", "")
end

function SlayerMainView_1_7:StopAudio()
	manager.audio:StopEffect()
end

return SlayerMainView_1_7
