local var_0_0 = class("NorseSurpriseGiftReceivePage", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftReceiveUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, NorseSurpriseGiftReceiveItem)
	arg_3_0.btnCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("btn")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnClose_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.btn_true, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_5"),
			OkCallback = function()
				NorseSurpriseGiftReceiveAction.ReceiveRewardRole(242832, arg_4_0.infocfg.id)
				arg_4_0:Back()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.indexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.draw_list[arg_9_1], arg_9_1)
	arg_9_2:SetSelect(arg_9_0.infocfg)

	if arg_9_0.heart_list and #arg_9_0.heart_list > 0 then
		arg_9_2:SetHeart(arg_9_0.heart_list)
	end

	arg_9_2:RegistCallBack(function(arg_10_0)
		if arg_10_0 == arg_9_0.infocfg.id then
			arg_9_0.infocfg = {
				id = 0,
				flag = 1
			}
		else
			arg_9_0.infocfg = {
				flag = 0,
				id = arg_10_0
			}
		end

		local var_10_0 = arg_9_0.uiList_:GetItemList()

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			iter_10_1:SetSelect(arg_9_0.infocfg)

			if arg_9_0.heart_list and #arg_9_0.heart_list > 0 then
				iter_10_1:SetHeart(arg_9_0.heart_list)
			end
		end

		arg_9_0:RefreshChooseBtn(arg_9_0.infocfg.flag)
	end)
end

function var_0_0.RefreshChooseBtn(arg_11_0, arg_11_1)
	arg_11_0.btnCtrl:SetSelectedIndex(arg_11_1)
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_14_0)
	var_0_0.super.OnEnter(arg_14_0)

	arg_14_0.infocfg = {
		id = 0,
		flag = 1
	}

	arg_14_0:RefreshView()
	arg_14_0.btnCtrl:SetSelectedIndex(1)

	arg_14_0.tipsTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_4")
end

function var_0_0.OnExit(arg_15_0)
	var_0_0.super.OnExit(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	if arg_16_0.uiList_ then
		arg_16_0.uiList_:Dispose()

		arg_16_0.uiList_ = nil
	end
end

function var_0_0.RefreshView(arg_17_0)
	arg_17_0.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	arg_17_0.heart_list = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	TimeTools.StartAfterSeconds(0.033, function()
		arg_17_0.uiList_:StartScroll(#arg_17_0.draw_list)
	end, {})
end

return var_0_0
