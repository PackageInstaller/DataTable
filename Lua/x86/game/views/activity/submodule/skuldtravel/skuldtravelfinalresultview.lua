local var_0_0 = class("SkuldTravelFinalResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelend"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.ItemRenderler), arg_4_0.listgo_, SkuldTravelFinalResultItem)
end

function var_0_0.ItemRenderler(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1)
end

function var_0_0.OnEnter(arg_6_0)
	if SkuldTravelData:IsOpenNewEnding() then
		arg_6_0.list_:StartScroll(#TravelSkuldEndingCfg.all, #TravelSkuldEndingCfg.all)
	else
		arg_6_0.list_:StartScroll(#TravelSkuldEndingCfg.all - 1)
	end
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnSkuldOpenEnding(arg_8_0)
	arg_8_0.list_:Refresh()
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.list_ then
		arg_10_0.list_:Dispose()

		arg_10_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
