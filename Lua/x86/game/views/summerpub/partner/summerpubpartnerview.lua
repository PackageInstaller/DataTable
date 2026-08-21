local var_0_0 = class("SummerPubPartnerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/Partner/Activity_SummerPub_PartnerUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroItemList_ = {}
	arg_4_0.clickFunc = handler(arg_4_0, arg_4_0.onClickItem)

	for iter_4_0 = 1, 10 do
		local var_4_0 = string.format("heroItem%s_", iter_4_0)

		arg_4_0.heroItemList_[iter_4_0] = SummerPubPartnerItem.New(arg_4_0[var_4_0], iter_4_0, arg_4_0.clickFunc)
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	return
end

function var_0_0.OnEnterOver(arg_6_0)
	if arg_6_0.params_.isBack then
		-- block empty
	else
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.heroItemList_) do
			iter_6_1:UpdateState()
		end
	end
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.onClickItem(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.heroItemList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
