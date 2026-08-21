local var_0_0 = class("GuildRenameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubCommunitynamePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.textCost_.text = GetI18NText(GameSetting.club_rename_cost.value[1])
	arg_3_0.freeController_ = arg_3_0.controller:GetController("free")
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = GuildData:GetRenameFreeCnt()

	if var_4_0 > 0 then
		arg_4_0.freeController_:SetSelectedState("false")
	else
		arg_4_0.freeController_:SetSelectedState("true")
	end

	arg_4_0.freeRenameCnt_ = var_4_0
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.buttonClose_, nil, function()
		arg_8_0.inputFieldNick_.text = ""

		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonCancel_, nil, function()
		arg_8_0.inputFieldNick_.text = ""

		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonOk_, nil, function()
		if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.CHANGE_CLUB_NICK) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		local var_11_0 = arg_8_0.inputFieldNick_.text

		if var_11_0 == "" then
			ShowTips("CLUB_NEED_NAME")

			return
		end

		if IsAllSpace(var_11_0) then
			ShowTips("INPUT_CHAT_CONTENT")

			arg_8_0.inputFieldNick_.text = ""

			return
		end

		local var_11_1, var_11_2 = textLimit(var_11_0, 16)
		local var_11_3 = var_11_1

		if not nameRule(var_11_3) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(var_11_3, function(arg_12_0)
			if not arg_12_0 then
				ShowTips("SENSITIVE_WORD")

				return
			end

			if not var_11_2 then
				ShowTips("CLUB_FOUNDED_NAME_MAX")

				return
			end

			local var_12_0 = 2

			if arg_8_0.freeRenameCnt_ > 0 then
				var_12_0 = 1
			else
				local var_12_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)

				if var_12_1 < GameSetting.club_rename_cost.value[1] then
					local var_12_2 = GameSetting.club_rename_cost.value[1] - var_12_1

					JumpTools.OpenPopUp("rechargeDiamondExchange", {
						defaultNum = 1,
						useBaseNum = var_12_2,
						getBaseNum = var_12_2,
						useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
						getId = CurrencyConst.CURRENCY_TYPE_DIAMOND
					}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)

					return
				end
			end

			GuildAction.GuildRename(var_11_3, var_12_0, function(arg_13_0)
				if isSuccess(arg_13_0.result) then
					ShowTips("CLUB_RENANE_SUCCESS")

					if arg_8_0.freeRenameCnt_ <= 0 then
						-- block empty
					else
						GuildData:UseRenameFree()
					end

					arg_8_0.inputFieldNick_.text = ""

					arg_8_0:Back()
				else
					ShowTips(arg_13_0.result)
				end
			end)
		end, JUDGE_MESSAGE_TYPE.GUILD_NAME)
	end)
end

return var_0_0
