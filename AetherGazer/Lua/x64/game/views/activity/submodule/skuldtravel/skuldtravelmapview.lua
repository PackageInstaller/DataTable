local var_0_0 = class("SkuldTravelMapView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelmap"
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
end

function var_0_0.AddUIListeners(arg_5_0)
	for iter_5_0 = 1, 3 do
		local var_5_0 = "btn_" .. iter_5_0

		arg_5_0:AddBtnListener(arg_5_0[var_5_0], nil, function()
			JumpTools.OpenPageByJump("skuldTravelItemSelectView", {
				mapindex = iter_5_0
			})
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.bgbtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		local var_9_0 = RedPointConst.TRAVEL_SKULD_TRAVELMAP .. iter_9_0

		manager.redPoint:bindUIandKey(arg_9_0["btn_" .. iter_9_0].transform, var_9_0)
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		local var_11_0 = RedPointConst.TRAVEL_SKULD_TRAVELMAP .. iter_11_0

		manager.redPoint:unbindUIandKey(arg_11_0["btn_" .. iter_11_0].transform, var_11_0)
	end

	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
