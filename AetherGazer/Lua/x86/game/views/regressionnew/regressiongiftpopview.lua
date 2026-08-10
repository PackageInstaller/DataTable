local var_0_0 = class("RegressionGiftPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ReturnThree/RT3rd_GiftPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		arg_5_0:Back()
		RegressionActionNew.ClosePopView()
		RegressionActionNew.CheckRegressionStory()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = RegressionDataNew:GetRegressionLoginTime()
	local var_8_1 = RegressionDataNew:GetLastOfflineTime()
	local var_8_2 = manager.time:STimeDescS(var_8_0 - var_8_1 * 86400, "!%Y/%m/%d")
	local var_8_3 = var_8_1

	arg_8_0.letterText_.text = string.format(GetTips("REGRESSION_GIFT_DESCRIPE"), var_8_2, var_8_3)
	arg_8_0.timeText_.text = var_8_3
	arg_8_0.timedescText_.text = string.format(GetTips("NEW_REGRESSION_FIND_DAYS_DESC"), var_8_3)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
