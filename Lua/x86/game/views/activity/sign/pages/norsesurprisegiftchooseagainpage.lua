local var_0_0 = class("NorseSurpriseGiftChooseAgainPage", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftChooseAgainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_no, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.btn_yes, nil, function()
		arg_4_0:Back()
		arg_4_0:Back()
		NorseSurpriseGiftReceiveAction.ChooseHeartList(242832, arg_4_0.heartList)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	var_0_0.super.OnEnter(arg_7_0)

	arg_7_0.sortList = arg_7_0.params_.sortList

	arg_7_0:RefreshView()
end

function var_0_0.OnExit(arg_8_0)
	var_0_0.super.OnExit(arg_8_0)
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	if arg_9_0.sortList then
		arg_9_0.sortList = nil
	end

	if arg_9_0.heartList then
		arg_9_0.heartList = nil
	end
end

function var_0_0.RefreshView(arg_10_0)
	arg_10_0.tipsTxt_.text = GetTips("PROMPT")
	arg_10_0.infoTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_1")
	arg_10_0.heartList = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.sortList) do
		table.insert(arg_10_0.heartList, iter_10_1.id)
	end
end

return var_0_0
