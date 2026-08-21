local var_0_0 = class("MoonPartyShareView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonPartyShareUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_8_0 = MoonCakeData:GetLastShareTimestamp()

		if manager.time:GetServerTime() - var_8_0 < GameSetting.activity_mid_autumn_party_share_interval.value[1] then
			ShowTips("SEND_MESSAGE_FREQUENTLY")

			return
		end

		if ChatData:IsMuted() then
			arg_5_0.inputField_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		local var_8_1 = arg_5_0.inputField_.text

		if var_8_1 == "" then
			var_8_1 = GetTips("MID_AUTUMN_FESTIVAL_PARTY_SHARE_EMPTY_TIPS")
		end

		local var_8_2 = GameSetting.club_share_max.value[1]
		local var_8_3, var_8_4 = textLimit(var_8_1, var_8_2)

		arg_5_0.inputField_.text = var_8_3

		if not var_8_4 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), var_8_2))

			return
		end

		if not nameRule(var_8_3, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(var_8_3, function(arg_9_0, arg_9_1)
			if not arg_9_0 then
				ShowTips("SENSITIVE_WORD")
			else
				local var_9_0 = string.format("%s_%s", ViewConst.JUMP_SPECIAL_ID.MOON_CAKE, USER_ID)

				ChatAction.SendChatNormalJump(ChatConst.CHAT_CHANNEL_MOON_CAKE, var_8_3, var_9_0, arg_9_1, function(arg_10_0)
					arg_5_0:SendMessageResult(arg_10_0)
				end)
				SDKTools.SendMessageToSDK("activity_mid_autumn_phase2_party_share", {
					activity_id = arg_5_0.activityID_,
					content = var_8_3
				})
			end
		end, JUDGE_MESSAGE_TYPE.ACTIVITY_MOON_CAKE)
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityID_ = arg_11_0.params_.activityID
	arg_11_0.inputField_.text = ""
end

function var_0_0.SendMessageResult(arg_12_0, arg_12_1)
	if isSuccess(arg_12_1.result) then
		MoonCakeData:SetLastShareTimestamp()
		ChatData:SetSendTextTimestamp()

		arg_12_0.inputField_.text = ""

		arg_12_0:Back()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_MOON_CAKE
		}, ViewConst.SYSTEM_ID.CHAT)
	elseif arg_12_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function()
				arg_12_0:Back()
			end
		})
	elseif arg_12_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		arg_12_0.inputField_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(arg_12_1.result)
	end
end

return var_0_0
