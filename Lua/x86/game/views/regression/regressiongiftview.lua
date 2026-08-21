local var_0_0 = class("RegressionGiftView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/ReturnUI/RegressionGiftUI"
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

	arg_4_0.receivedController = ControllerUtil.GetController(arg_4_0.transform_, "received")
	arg_4_0.rewardList = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, CommonItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_btn, nil, function()
		RegressionAction.QueryRegressionGift()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		if RegressionData:GetRegressionGiftReceive() then
			arg_5_0:Back()
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = RegressionData:GetRegressionVersion()

	arg_8_0.gifts = RegressionCfg[var_8_0] and RegressionCfg[var_8_0].gift or {}

	arg_8_0.rewardList:StartScroll(#arg_8_0.gifts)
	arg_8_0:Refresh()
end

function var_0_0.Refresh(arg_9_0)
	local var_9_0 = RegressionData:GetRegressionGiftReceive()

	arg_9_0.receivedController:SetSelectedIndex(var_9_0 and 1 or 0)
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.gifts[arg_11_1]

	arg_11_2:RefreshData(formatReward(var_11_0))
	arg_11_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_11_0)
	end)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.rewardList:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.OnRegressionGiftReward(arg_14_0)
	arg_14_0:Refresh()
end

return var_0_0
