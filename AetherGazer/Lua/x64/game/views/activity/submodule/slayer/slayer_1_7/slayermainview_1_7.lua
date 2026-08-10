local var_0_0 = import("game.views.activity.Submodule.slayer.volume.VolumeSlayerMainView")
local var_0_1 = class("SlayerMainView_1_7", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.slayer_activity_id = arg_1_0.params_.slayer_activity_id or 0

	arg_1_0:RefreshTime()

	arg_1_0.timer = Timer.New(function()
		arg_1_0:RefreshTime()
	end, 1, -1)

	arg_1_0.timer:Start()
	manager.redPoint:bindUIandKey(arg_1_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, arg_1_0.slayer_activity_id))
	manager.redPoint:bindUIandKey(arg_1_0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_1_0.slayer_activity_id))
end

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("slayerRewardView_1_7", {
			slayer_activity_id = arg_3_0.slayer_activity_id
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.m_entrustBtn, nil, function()
		if not ActivityTools.GetActivityIsOpenWithTip(arg_3_0.slayer_activity_id, true) then
			return
		end

		JumpTools.OpenPageByJump("/slayerStageView_1_7", {
			init_tag = true,
			slayer_activity_id = arg_3_0.slayer_activity_id
		})
	end)
end

function var_0_1.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SOLO_SLAYER_DESCRIPE")
	arg_6_0:PlayAudio()
end

function var_0_1.OnExit(arg_7_0)
	var_0_1.super.OnExit(arg_7_0)
	arg_7_0:StopAudio()
end

function var_0_1.PlayAudio(arg_8_0)
	manager.audio:PlayEffect("minigame_activity_1_7", "minigame_activity_1_7_Sword_loop", "")
end

function var_0_1.StopAudio(arg_9_0)
	manager.audio:StopEffect()
end

return var_0_1
