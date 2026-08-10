local var_0_0 = class("BloodCardDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardCardDetailUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.cardInfoView_ = BloodCardInGameCardInfoView.New(arg_3_0.cardInfoGo_)
	arg_3_0.cardItem_ = BloodCardVisualCardView.New(arg_3_0.cardItemGo_)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.cardID_ = arg_7_0.params_.cardID
	arg_7_0.isEnemy_ = arg_7_0.params_.isEnemy

	arg_7_0:RefreshUI()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.cardItem_:SetData(1, arg_9_0.cardID_, arg_9_0.isEnemy_)
	arg_9_0.cardInfoView_:SetData(arg_9_0.cardID_)
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.cardItem_:Dispose()
	arg_11_0.cardInfoView_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
