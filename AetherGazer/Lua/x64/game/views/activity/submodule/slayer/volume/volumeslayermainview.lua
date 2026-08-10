local var_0_0 = class("VolumeSlayerMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return SlayerTools.GetMainUIName(arg_1_0.params_.slayer_activity_id or 0)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("hellaSlayerReward", {
			slayer_activity_id = arg_5_0.slayer_activity_id
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_entrustBtn, nil, function()
		if not ActivityTools.GetActivityIsOpenWithTip(arg_5_0.slayer_activity_id, true) then
			return
		end

		JumpTools.OpenPageByJump("/volumeSlayer", {
			init_tag = true,
			slayer_activity_id = arg_5_0.slayer_activity_id
		})
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VOLUME_SLAYER_DESCRIPE")
end

function var_0_0.OnEnter(arg_9_0)
	if arg_9_0.params_.playerAnim then
		arg_9_0.m_animator:Play("VolumeCutgrassMainUI", 0, 0)

		arg_9_0.params_.playerAnim = nil
	else
		arg_9_0.m_animator:Play("VolumeCutgrassMainUI", 0, 9999999)
	end

	arg_9_0.slayer_activity_id = arg_9_0.params_.slayer_activity_id or 0

	arg_9_0:RefreshTime()

	arg_9_0.timer = Timer.New(function()
		arg_9_0:RefreshTime()
	end, 1, -1)

	arg_9_0.timer:Start()
	manager.redPoint:bindUIandKey(arg_9_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, arg_9_0.slayer_activity_id))
	manager.redPoint:bindUIandKey(arg_9_0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_9_0.slayer_activity_id))
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()

	if arg_11_0.timer then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end

	manager.redPoint:unbindUIandKey(arg_11_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, arg_11_0.slayer_activity_id))
	manager.redPoint:unbindUIandKey(arg_11_0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_11_0.slayer_activity_id))
end

function var_0_0.RefreshTime(arg_12_0)
	local var_12_0 = ActivityData:GetActivityData(arg_12_0.slayer_activity_id)

	if var_12_0 then
		arg_12_0.m_timeLab.text = manager.time:GetLostTimeStr(var_12_0.stopTime)
	else
		arg_12_0.m_timeLab.text = GetTips("TIME_OVER")
	end
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
