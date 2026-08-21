local var_0_0 = class("AchievementManagerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/AchievementsUI/AchievementManagerUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.noticeRectList_ = {
		arg_3_0.goCultivate_,
		arg_3_0.goCollect_,
		arg_3_0.goMission_,
		arg_3_0.goPlayer_,
		arg_3_0.goBattle_,
		arg_3_0.goOther_
	}
	arg_3_0.achievementButtonList_ = {}

	for iter_3_0, iter_3_1 in pairs(AchievementConst.AchievementType) do
		arg_3_0.achievementButtonList_[iter_3_1] = AchievementManagerButton.New(arg_3_0.noticeRectList_[iter_3_1], iter_3_1)
	end

	arg_3_0:AddListeners()
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
	SetActive(arg_4_0.goRedPoint_, manager.redPoint:getTipValue(RedPointConst.ACHIEVEMENT_STORY) > 0)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.achievementButtonList_) do
		iter_4_1:OnEnter()
	end

	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.noticeRectList_ = nil

	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.achievementButtonList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.achievementButtonList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buttonStory_, nil, function()
		arg_7_0:Go("/achievementStory")
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.textAchievement_.text = AchievementData:GetFinishAchievementCnt()
	arg_9_0.textTotalCnt_.text = string.format("/%s", AchievementData:GetAchievementTotalCnt())

	local var_9_0 = AchievementData:GetCurrentPoint()
	local var_9_1 = AchievementData:GetCurrentLevelPoint()

	if var_9_1 < var_9_0 then
		var_9_0 = var_9_1
	end

	arg_9_0.textPoint_.text = var_9_0
	arg_9_0.textTotalPoint_.text = string.format("/%s", var_9_1)

	local var_9_2 = var_9_0 / var_9_1

	arg_9_0.imageProcess_.value = var_9_2
	arg_9_0.imageSlider_.fillAmount = var_9_2
end

return var_0_0
