local var_0_0 = class("AchievementStoryView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/AchievementsUI/AchievementStoryUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.storyItemList_ = {}

	for iter_3_0, iter_3_1 in ipairs(AchievementStoryCfg.all) do
		arg_3_0.storyItemList_[iter_3_1] = AchievementStoryItem.New(arg_3_0[string.format("goItem%s_", iter_3_0)], iter_3_1)
	end
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.storyItemList_) do
		iter_4_1:Refresh()
	end
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.storyItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.storyItemList_ = nil
end

return var_0_0
