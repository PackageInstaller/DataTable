local var_0_0 = class("ChangeNameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/PopupChangeNameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:GetOrAddComponent(arg_3_0.nameinput_.gameObject, typeof(InputFieldHelper))
	dealEnter(arg_3_0.nameinput_.gameObject)

	arg_3_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CHANGE_NAME_CARD)
	arg_3_0.typeCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("type")
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
	arg_5_0:AddBtnListener(arg_5_0.iconBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			CurrencyConst.CURRENCY_TYPE_CHANGE_NAME_CARD
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.okbtnBtn_, nil, function()
		if arg_5_0.costType_ == 1 and arg_5_0.cardHave <= 0 then
			ShowTips("NAME_CHANGE_CARD_INSUFFICIENT_TIPS")

			return
		end

		local var_9_0 = PlayerData:GetPlayerInfo().nick
		local var_9_1 = arg_5_0.nameinput_.text

		if var_9_1 == "" then
			ShowTips("ERROR_USER_NAME_TOO_SHORT")

			return
		end

		if var_9_0 == var_9_1 then
			ShowTips("NAME_CANNOT_SAME_CURRENT")

			return
		end

		local var_9_2, var_9_3 = textLimit(var_9_1, 16)

		arg_5_0.nameinput_.text = var_9_2

		local var_9_4 = var_9_2

		if not OperationData:IsOperationOpen(OperationConst.CHANGE_NICK) then
			ShowTips("OPERATION_DISABLED")

			return
		end

		if not nameRule(var_9_4) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(var_9_4, function(arg_10_0)
			if not arg_10_0 then
				ShowTips("ERROR_USER_NAME_VER_WORD")
			else
				if not var_9_3 then
					return
				end

				if arg_5_0.costType_ == 1 then
					ShowMessageBox({
						content = string.format(GetTips("NAME_CHANGE_CARD_WHETHER_TIPS"), var_9_4),
						OkCallback = function()
							PlayerAction.ChangeNickname(var_9_4, arg_5_0.costType_)
						end,
						CancelCallback = function()
							return
						end
					})
				else
					PlayerAction.ChangeNickname(var_9_4, arg_5_0.costType_)
				end
			end
		end, JUDGE_MESSAGE_TYPE.PLAYER_NAME)
	end)
end

function var_0_0.OnChangeNickname(arg_13_0, arg_13_1)
	ShowTips("SUCCESS_CHANGE_NAME")
	JumpTools.Back()
end

function var_0_0.Init(arg_14_0)
	arg_14_0:InitUI()
	arg_14_0:AddUIListener()
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.nameinput_.text = ""
	arg_15_0.costType_ = 1

	if PlayerData:GetExtraChangeNickTime() <= 0 then
		arg_15_0.tip_.text = GetTips("TIPS_REVISENAME_ONE")
	else
		arg_15_0.tip_.text = GetTips("TIPS_REVISENAME_FREE")
	end

	if PlayerData:GetPlayerInfo().is_changed_nick == 2 and PlayerData:GetExtraChangeNickTime() <= 0 then
		arg_15_0.costType_ = 1

		arg_15_0.typeCon_:SetSelectedState("card")

		arg_15_0.cardHave = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_CHANGE_NAME_CARD)

		if arg_15_0.cardHave > 0 then
			arg_15_0.num_.text = arg_15_0.cardHave .. "/" .. 1
		else
			arg_15_0.num_.text = "<color=#FF0000>" .. arg_15_0.cardHave .. "</color>" .. "/" .. 1
		end
	else
		arg_15_0.costType_ = 2

		arg_15_0.typeCon_:SetSelectedState("free")

		arg_15_0.tip_.text = GetTips("TIPS_REVISENAME_FREE")
	end
end

function var_0_0.OnExit(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()
	arg_17_0.nameinput_.onValueChanged:RemoveAllListeners()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
