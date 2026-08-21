local var_0_0 = class("ValentineGameV2SelectHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ValentineGameV2SelectHeroItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.subActivityID_[arg_5_1])
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityID_ = arg_6_0.params_.activityID
	arg_6_0.subActivityID_ = ActivityCfg[arg_6_0.activityID_].sub_activity_list

	arg_6_0.heroList_:StartScroll(#arg_6_0.subActivityID_)

	if arg_6_0.timer_ == nil then
		arg_6_0.timer_ = Timer.New(function()
			local var_7_0 = arg_6_0.heroList_:GetItemList()

			for iter_7_0, iter_7_1 in pairs(var_7_0) do
				iter_7_1:RefreshTimeText()
			end
		end, 1, -1)

		arg_6_0.timer_:Start()
	end
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VALENTINE_DESCRIBE")
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()

	local var_9_0 = arg_9_0.heroList_:GetItemList()

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		iter_9_1:OnExit()
	end

	arg_9_0:StopTimer()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.heroList_ then
		arg_11_0.heroList_:Dispose()

		arg_11_0.heroList_ = nil
	end

	arg_11_0:StopTimer()
	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
