local var_0_0 = class("MythicFinalRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Mythic/MythicRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.controller_ = arg_5_0.transform_:GetComponent("ControllerExCollection"):GetController("default0")
	arg_5_0.hotrewardList_ = LuaList.New(handler(arg_5_0, arg_5_0.RefreashItem), arg_5_0.uiList_, MythicFinalRewardItem)
end

function var_0_0.OnEnter(arg_6_0)
	if arg_6_0.timer_ == nil then
		arg_6_0.timer_ = Timer.New(function()
			local var_7_0 = MythicData:GetNextRefreshTime()

			arg_6_0.timetext_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(var_7_0))
		end, 1, -1)

		arg_6_0.timer_:Start()
	end

	local var_6_0 = MythicData:GetNextRefreshTime()

	arg_6_0.timetext_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(var_6_0))
	arg_6_0.passtext_.text = string.format(GetTips("MYTHIC_FINAL_REWARD_FOLLOW_TIPS"), MythicData:GetPassHotLevel())

	arg_6_0:RefreashUI()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.receiveallbtn_, nil, function()
		if MythicData:GetFinalIsReward() == 0 then
			ShowMessageBox({
				content = GetTips("MYTHIC_REWARD_LOACK_DIFFICULTY"),
				OkCallback = function()
					MythicAction:GetAllFinalReward()
				end
			})
		else
			MythicAction:GetAllFinalReward()
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.maskBtn_, nil, function()
		arg_9_0:Back()
	end)
end

function var_0_0.RefreashItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1)
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
	arg_14_0:StopTimer()
end

function var_0_0.OnMythicFinalGetReward(arg_15_0)
	arg_15_0:RefreashUI()
end

function var_0_0.RefreashUI(arg_16_0)
	if MythicData:GetPassHotLevel() > 0 then
		if MythicData:GetIsHaveRewardNotGet() then
			arg_16_0.controller_:SetSelectedIndex(0)
		else
			arg_16_0.controller_:SetSelectedIndex(1)
		end
	else
		arg_16_0.controller_:SetSelectedIndex(1)
	end

	MythicData:SortRewards()
	arg_16_0.hotrewardList_:StartScroll(#MythicFinalCfg.all)
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.hotrewardList_ then
		arg_17_0.hotrewardList_:Dispose()

		arg_17_0.hotrewardList_ = nil
	end

	arg_17_0:StopTimer()
	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.StopTimer(arg_18_0)
	if arg_18_0.timer_ then
		arg_18_0.timer_:Stop()

		arg_18_0.timer_ = nil
	end
end

return var_0_0
