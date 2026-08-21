local var_0_0 = class("NorseSurpriseGiftWishPoolPage", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftWishPoolUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.onChooseHandler = handler(arg_3_0, arg_3_0.OnNorseGiftChooseSuccess)
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, NorseSurpriseGiftWishPoolItem)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_info, nil, function()
		JumpTools.OpenPageByJump("norseSurpriseGiftChoosePage")
	end)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.choose_list and #arg_6_0.choose_list >= 6 then
		arg_6_2:SetData(arg_6_0.choose_list[arg_6_1])

		if arg_6_0.draw_list and #arg_6_0.draw_list > 0 then
			arg_6_2:SetDrawState(arg_6_0.draw_list)
		end

		if arg_6_0.result_role_id and arg_6_0.result_role_id > 0 then
			arg_6_2:SetGetState(arg_6_0.result_role_id)
		end
	end
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_RANDOM_TARGET_COIN
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_OPTIONAL_RANDOM_RULE")
end

function var_0_0.OnEnter(arg_9_0)
	var_0_0.super.OnEnter(arg_9_0)
	manager.notify:RegistListener(NORSE_GIFT_CHOOSE_SUCCESS, arg_9_0.onChooseHandler)

	arg_9_0.choose_list = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	if arg_9_0.params_.choose_list then
		arg_9_0.choose_list = arg_9_0.params_.choose_list
	end

	arg_9_0.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	arg_9_0.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	arg_9_0:RefreshView()
end

function var_0_0.OnExit(arg_10_0)
	var_0_0.super.OnExit(arg_10_0)
	manager.notify:RemoveListener(NORSE_GIFT_CHOOSE_SUCCESS, arg_10_0.onChooseHandler)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)

	if arg_11_0.uiList_ then
		arg_11_0.uiList_:Dispose()

		arg_11_0.uiList_ = nil
	end
end

function var_0_0.RefreshView(arg_12_0)
	TimeTools.StartAfterSeconds(0.033, function()
		if arg_12_0.choose_list and #arg_12_0.choose_list >= 6 then
			arg_12_0.uiList_:StartScroll(#arg_12_0.choose_list)
		else
			arg_12_0.uiList_:StartScroll(6)
		end
	end, {})
end

function var_0_0.OnNorseGiftChooseSuccess(arg_14_0, arg_14_1)
	arg_14_0.choose_list = arg_14_1
	arg_14_0.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	arg_14_0.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	arg_14_0:RefreshView()
end

return var_0_0
