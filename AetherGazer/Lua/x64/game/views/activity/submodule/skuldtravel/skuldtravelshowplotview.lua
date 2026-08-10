local var_0_0 = class("SkuldTravelShowPlotView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelrecord"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.itemlist_ = {}

	for iter_4_0 = 1, 9 do
		arg_4_0.itemlist_[iter_4_0] = SkuldTravelShowPlotItem.New(arg_4_0["itemgo_" .. iter_4_0])
	end
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RefreshUI()
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.RefreshUI(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.itemlist_) do
		local var_7_0 = TravelSkuldStoryCfg.all[iter_7_0]

		iter_7_1:SetData(var_7_0)
	end
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.itemlist_ then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.itemlist_) do
			iter_9_1:Dispose()

			arg_9_0.itemlist_[iter_9_0] = nil
		end

		arg_9_0.itemlist_ = nil
	end

	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
