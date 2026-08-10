local var_0_0 = class("AwakeNameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/LoginInterface/Login_name"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.playerable = arg_3_0.transform_:GetComponent("PlayableDirector")
	arg_3_0.animator = arg_3_0.transform_:GetComponent("Animator")
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
	arg_7_0:AddBtnListener(arg_7_0.confirmBtn_, nil, function()
		if arg_7_0.nameInputField_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")
		else
			local var_8_0 = arg_7_0.nameInputField_.text
			local var_8_1, var_8_2 = textLimit(var_8_0, GameSetting.user_name_max.value[1])

			arg_7_0.nameInputField_.text = GetI18NText(var_8_1)

			local var_8_3 = var_8_1

			if not nameRule(var_8_3) then
				ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

				return
			end

			WordVerifyBySDK(var_8_3, function(arg_9_0)
				if arg_9_0 then
					if not var_8_2 then
						return
					end

					PlayerAction.AwakeName(var_8_3, function()
						SendMessageManagerToSDK("role_create", {
							curNameText = var_8_3
						})

						arg_7_0.confirmBtn_.interactable = false

						arg_7_0.playerable:Stop()
						arg_7_0.animator:Play("Login_name_exit", 0, 0)
						TimeTools.StartAfterSeconds(2, function()
							if arg_7_0.gameObject_ then
								SetActive(arg_7_0.gameObject_, false)
							end
						end, {})
						ShowAwakeNameCallBack()
					end)
				else
					ShowTips("ERROR_USER_NAME_VER_WORD")
				end
			end, JUDGE_MESSAGE_TYPE.PLAYER_NAME)
		end
	end)
end

function var_0_0.Cacheable(arg_12_0)
	return false
end

return var_0_0
