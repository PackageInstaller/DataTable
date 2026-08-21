local var_0_0 = class("GuildFoundedManagerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/ClubUI/CreateClubPanelTemplate"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.foundedViewList_ = {}
end

function var_0_0.OnTop(arg_4_0)
	arg_4_0:RefreshWinBar()
end

function var_0_0.OnEnter(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.foundedViewList_) do
		iter_5_1:OnEnter()
	end

	arg_5_0:RefreshToggle()
end

function var_0_0.RefreshWinBar(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:RegistBackCallBack(function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()

	for iter_8_0, iter_8_1 in pairs(arg_8_0.foundedViewList_) do
		iter_8_1:OnExit()
	end
end

function var_0_0.OnUpdate(arg_9_0)
	arg_9_0:RefreshToggle()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	for iter_10_0, iter_10_1 in pairs(arg_10_0.toggleList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.toggleList_ = nil
	arg_10_0.goButtonList_ = nil

	for iter_10_2, iter_10_3 in pairs(arg_10_0.foundedViewList_) do
		iter_10_3:Dispose()
	end

	arg_10_0.foundedViewList_ = nil
end

function var_0_0.AddListeners(arg_11_0)
	return
end

function var_0_0.RefreshToggle(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.toggleList_) do
		iter_12_1:RefreshSelectType(arg_12_0.selectType_)
	end

	if not arg_12_0.foundedViewList_[arg_12_0.selectType_] then
		if arg_12_0.selectType_ == GuildConst.FOUNDED_TYPE.RECOMMEND then
			arg_12_0.foundedViewList_[arg_12_0.selectType_] = GuildRecommendView.New(arg_12_0.goRecommendPanel_)
		else
			arg_12_0.foundedViewList_[arg_12_0.selectType_] = GuildFoundedView.New(arg_12_0.goFoundedPanel_)
		end
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0.foundedViewList_) do
		iter_12_3:Show(iter_12_2 == arg_12_0.selectType_)
	end
end

return var_0_0
