local var_0_0 = class("HellaParkourView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourUI"
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
		if ActivityData:GetActivityIsOpen(arg_5_0.parkour_activity_id) then
			JumpTools.OpenPageByJump("hellaParkourReward", {
				parkour_activity_id = arg_5_0.parkour_activity_id
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_entrustBtn, nil, function()
		if ActivityData:GetActivityIsOpen(arg_5_0.parkour_activity_id) then
			JumpTools.OpenPageByJump("/hellaParkourEntrust", {
				parkour_activity_id = arg_5_0.parkour_activity_id
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_loseBtn, nil, function()
		if ActivityData:GetActivityIsOpen(arg_5_0.parkour_activity_id) then
			JumpTools.OpenPageByJump("/hellaParkourLose", {
				parkour_activity_id = arg_5_0.parkour_activity_id
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_PARKOUR_DESCRIPE")
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.parkour_activity_id = arg_10_0.params_.parkour_activity_id or 61101

	arg_10_0:RefreshTime()

	arg_10_0.timer = Timer.New(function()
		arg_10_0:RefreshTime()
	end, 1, -1)

	arg_10_0.timer:Start()
	manager.redPoint:bindUIandKey(arg_10_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_REWARD, arg_10_0.parkour_activity_id))
	manager.redPoint:bindUIandKey(arg_10_0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, arg_10_0.parkour_activity_id))
	manager.redPoint:bindUIandKey(arg_10_0.m_loseBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, arg_10_0.parkour_activity_id))
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()

	if arg_12_0.timer then
		arg_12_0.timer:Stop()

		arg_12_0.timer = nil
	end

	manager.redPoint:unbindUIandKey(arg_12_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_REWARD, arg_12_0.parkour_activity_id))
	manager.redPoint:unbindUIandKey(arg_12_0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, arg_12_0.parkour_activity_id))
	manager.redPoint:unbindUIandKey(arg_12_0.m_loseBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, arg_12_0.parkour_activity_id))
end

function var_0_0.RefreshTime(arg_13_0)
	local var_13_0 = ActivityData:GetActivityData(arg_13_0.parkour_activity_id)

	if var_13_0 and var_13_0:IsActivitying() then
		local var_13_1 = var_13_0.stopTime

		arg_13_0.m_timer.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr(var_13_1)
	else
		arg_13_0.m_timer.text = GetTips("TIME_OUT")
	end
end

return var_0_0
