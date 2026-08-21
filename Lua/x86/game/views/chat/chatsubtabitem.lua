local var_0_0 = class("ChatSubTabItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.chatToggleID_ = arg_1_3
	arg_1_0.click_ = arg_1_4

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.tabController_ = arg_2_0.tabControllerEx_:GetController("state")
	arg_2_0.titleText_.text = ChatToggleCfg[arg_2_0.chatToggleID_].name
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.tabBtn_, nil, function()
		if arg_3_0:IsLock() then
			ShowTips("ACTIVITY_CLUB_NOT_JOIN")

			return
		end

		if arg_3_0.click_ then
			arg_3_0.click_()
		end

		if arg_3_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS then
			OperationRecorder.RecordButtonTouch({
				source = 2,
				button_name = "activity_autochess_item_exchange_channel_homepage_touch",
				activity_id = AutoChessData:GetActivityID()
			})
		end
	end)
end

function var_0_0.IsLock(arg_5_0)
	if arg_5_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		return not GuildActivityData:HaveRegister()
	end

	if arg_5_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_4 or arg_5_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_8 then
		return not GuildActivitySPData:HaveRegister()
	end

	if arg_5_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS then
		return not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)
	end

	return false
end

function var_0_0.SetTabState(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.tabController_:SetSelectedState("select")
	else
		arg_6_0.tabController_:SetSelectedState(arg_6_0:IsLock() and "lock" or "unlock")
	end
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
	Object.Destroy(arg_8_0.gameObject_)

	arg_8_0.transform_ = nil
	arg_8_0.gameObject_ = nil
end

return var_0_0
