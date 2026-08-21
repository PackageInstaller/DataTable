local var_0_0 = class("BloodCardChangeNamePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardNameInputPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:GetOrAddComponent(arg_3_0.nameinput_.gameObject, typeof(InputFieldHelper))
	dealEnter(arg_3_0.nameinput_.gameObject)
end

function var_0_0._onValidateInput(arg_4_0, arg_4_1, arg_4_2)
	if #arg_4_0 >= 24 then
		return 0
	end

	return arg_4_2
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelbtnBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okbtnBtn_, nil, function()
		local var_8_0 = PlayerData:GetPlayerInfo().nick
		local var_8_1 = arg_5_0.nameinput_.text

		if var_8_1 == "" then
			ShowTips("ACTIVITY_BLOOD_CARD_GAME_CARDSET_NAME_TOO_SHORT")

			return
		end

		local var_8_2, var_8_3 = textLimit(var_8_1, 16)

		arg_5_0.nameinput_.text = var_8_2

		local var_8_4 = var_8_2

		if not nameRule(var_8_4) then
			return ShowTips("ACTIVITY_BLOOD_CARD_GAME_CARDSET_NAME_SYMBOL_WORD")
		end

		WordVerifyBySDK(var_8_4, function(arg_9_0)
			if not arg_9_0 then
				ShowTips("ACTIVITY_BLOOD_CARD_GAME_CARDSET_NAME_VER_WORD")
			else
				if not var_8_3 then
					return
				end

				BloodCardAction.SendSaveCardGroup(arg_5_0.activityID_, arg_5_0.selectTabIndex_, arg_5_0.selectGroupCardIDList_, var_8_4, function()
					ShowTips(GetTips("ACTIVITY_BLOOD_CARD_GAME_SAVE_CARDSET_SUCCESS"))
				end)
				arg_5_0:Back()
			end
		end, JUDGE_MESSAGE_TYPE.PLAYER_NAME)
	end)
end

function var_0_0.Init(arg_11_0)
	arg_11_0:InitUI()
	arg_11_0:AddUIListener()
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activityID_ = arg_12_0.params_.activityID
	arg_12_0.selectTabIndex_ = arg_12_0.params_.selectTabIndex
	arg_12_0.selectGroupCardIDList_ = arg_12_0.params_.selectGroupCardIDList
	arg_12_0.nameinput_.text = BloodCardData:GetCardGroupName(arg_12_0.selectTabIndex_)
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	arg_14_0.nameinput_.onValueChanged:RemoveAllListeners()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
