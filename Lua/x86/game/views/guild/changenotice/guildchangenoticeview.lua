local var_0_0 = class("GuildChangeNoticeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubNoticeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	return
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
		if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.CHANGE_CLUB_SIGN) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		local var_10_0 = arg_7_0.inputFieldNotice_.text
		local var_10_1 = GameSetting.club_announcement_max.value[1]
		local var_10_2, var_10_3 = textLimit(arg_7_0.inputFieldNotice_.text, var_10_1)

		arg_7_0.inputFieldNotice_.text = GetI18NText(var_10_2)

		if not var_10_3 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), var_10_1))

			return
		end

		if not nameRule(var_10_2, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(var_10_2, function(arg_11_0)
			if not arg_11_0 then
				ShowTips("SENSITIVE_WORD")
			else
				GuildAction.GuildChangeNotice(var_10_2, function(arg_12_0)
					if isSuccess(arg_12_0.result) then
						arg_7_0:Back()

						arg_7_0.inputFieldNotice_.text = ""

						ShowTips("CLUB_CHANGED_NOTICE_SUCCESS")
					else
						ShowTips(arg_12_0.result)
					end
				end)
			end
		end, JUDGE_MESSAGE_TYPE.GUILD_NOTICE)
	end)
end

return var_0_0
