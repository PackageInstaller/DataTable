local var_0_0 = class("SkuldTravelTipsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelling"
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
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		gameContext:Go("/skuldTravelView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgbtn_, nil, function()
		gameContext:Go("/skuldTravelView")
	end)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.super.Dispose(arg_8_0)
end

return var_0_0
