local var_0_0 = class("GuildShareInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubShareMessagePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	dealEnter(arg_4_0.inputFieldNotice_)
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buttonClose_, nil, function()
		arg_7_0.inputFieldNotice_.text = ""

		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonCancel_, nil, function()
		arg_7_0.inputFieldNotice_.text = ""

		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonOk_, nil, function()
		local var_10_0 = arg_7_0.inputFieldNotice_.text
		local var_10_1 = GameSetting.club_share_max.value[1]
		local var_10_2, var_10_3 = textLimit(arg_7_0.inputFieldNotice_.text, var_10_1)

		arg_7_0.inputFieldNotice_.text = GetI18NText(var_10_2)

		if not nameRule(arg_7_0.inputFieldNotice_.text) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		if not var_10_3 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), var_10_1))

			return
		end

		WordVerifyBySDK(var_10_2, function(arg_11_0)
			if not arg_11_0 then
				ShowTips("SENSITIVE_WORD")
			else
				GuildAction.GuildShare(var_10_2, function(arg_12_0)
					if isSuccess(arg_12_0.result) then
						arg_7_0:Back()

						arg_7_0.inputFieldNotice_.text = ""

						ChatAction.RequireGuildShareInfo()
						JumpTools.OpenPageByJump("chat", {
							ignoreBG = true,
							chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_RECRUIT
						}, ViewConst.SYSTEM_ID.CHAT)
					else
						ShowTips(arg_12_0.result)
					end
				end)
			end
		end, JUDGE_MESSAGE_TYPE.GUILD_SHARE)
	end)
end

return var_0_0
