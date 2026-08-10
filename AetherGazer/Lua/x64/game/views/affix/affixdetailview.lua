local var_0_0 = class("AffixDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Affix/AffixDetailUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.uiListGo_, AffixDetailItemView)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.affixList_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	return
end

function var_0_0.OnTop(arg_10_0)
	return
end

function var_0_0.OnBehind(arg_11_0)
	return
end

function var_0_0.UpdateBar(arg_12_0)
	return
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:AddEventListeners()

	arg_13_0.affixList_ = arg_13_0.params_.affixList

	arg_13_0.uiList_:StartScroll(#arg_13_0.affixList_)
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_15_0)
	return
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.uiList_ then
		arg_16_0.uiList_:Dispose()

		arg_16_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
