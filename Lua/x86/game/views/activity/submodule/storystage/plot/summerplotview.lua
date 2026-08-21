local var_0_0 = class("SummerPlotView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/SummerUI/SummerPlotUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.plotUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, SummerPlotItem)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistHomeCallBack(function()
		arg_4_0:HideRedPoint()
		arg_4_0:Go("/home")
	end)
	manager.windowBar:RegistBackCallBack(function()
		arg_4_0:HideRedPoint()
		arg_4_0:Back()
	end)

	local var_4_0 = arg_4_0.params_.theme

	arg_4_0.plotList_ = ActivityStoryCollect[var_4_0].story_id

	local var_4_1, var_4_2 = ActivityTools.GetActivityChessProgress(ChessConst.SUBPLOT_TAG.ISLAND)

	arg_4_0.value_ = math.floor(var_4_1 / var_4_2)

	arg_4_0.plotUIList_:StartScroll(#arg_4_0.plotList_, 1)
	arg_4_0:RefreshText()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	if arg_8_0.plotUIList_ then
		arg_8_0.plotUIList_:Dispose()

		arg_8_0.plotUIList_ = nil
	end
end

function var_0_0.AddListeners(arg_9_0)
	return
end

function var_0_0.RefreshItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.plotList_[arg_10_1]

	arg_10_2:SetData(var_10_0, ActivityStoryCollect[arg_10_0.params_.theme].unlock_value[arg_10_1] or 100, arg_10_0.value_)
end

function var_0_0.RefreshText(arg_11_0)
	arg_11_0.finishRateText_.text = string.format("%d%%", arg_11_0.value_)
end

function var_0_0.HideRedPoint(arg_12_0)
	local var_12_0 = ActivityConst.SUMMER_CHESS_ISLAND
	local var_12_1, var_12_2 = ActivityTools.GetActivityChessProgress(ChessConst.SUBPLOT_TAG.ISLAND)
	local var_12_3 = var_12_1 / var_12_2
	local var_12_4 = ActivityCfg[var_12_0].activity_theme
	local var_12_5 = ActivityStoryCollect[var_12_4]

	for iter_12_0, iter_12_1 in pairs(var_12_5.story_id) do
		local var_12_6 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, var_12_4, iter_12_1)

		if var_12_3 >= var_12_5.unlock_value[iter_12_0] then
			WarChessAction.SetActivityChessPlotRedPoint(var_12_4, iter_12_1)
		end
	end
end

return var_0_0
