local var_0_0 = class("RegressionNewGiftView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ReturnTwo/RT2stGift2UI"
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
	arg_4_0.rewardItems_ = {}
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

	arg_8_0:Refresh()
end

function var_0_0.Refresh(arg_9_0)
	local var_9_0 = RegressionData:GetRegressionGiftReceive()

	arg_9_0.receivedController:SetSelectedIndex(var_9_0 and 1 or 0)
	arg_9_0:RefreshReward()
	arg_9_0:RefreshTime()
end

function var_0_0.RefreshReward(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.gifts) do
		local var_10_0 = clone(ItemTemplateData)

		var_10_0.id = iter_10_1[1]
		var_10_0.number = iter_10_1[2]

		function var_10_0.clickFun(arg_11_0)
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_11_0.id,
				arg_11_0.number
			})
		end

		if arg_10_0.rewardItems_[iter_10_0] == nil then
			arg_10_0.rewardItems_[iter_10_0] = CommonItemPool.New(arg_10_0.rewardParent_, var_10_0, true)
		else
			arg_10_0.rewardItems_[iter_10_0]:SetData(var_10_0)
		end

		arg_10_0.rewardItems_[iter_10_0]:Show(true)
	end

	for iter_10_2 = #arg_10_0.gifts + 1, #arg_10_0.rewardItems_ do
		arg_10_0.rewardItems_[iter_10_2]:Show(false)
	end
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.rewardItems_) do
		iter_13_1:Dispose()
	end

	arg_13_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.OnRegressionGiftReward(arg_14_0)
	arg_14_0:Refresh()
end

function var_0_0.RefreshTime(arg_15_0)
	local var_15_0 = RegressionData:GetLastOfflineTime()
	local var_15_1 = manager.time:STimeDescS(var_15_0, "!%Y/%m/%d")
	local var_15_2 = RegressionData:GetRegressionLoginTime()
	local var_15_3 = manager.time:DiffDay2(var_15_0, var_15_2)

	arg_15_0.descText_.text = string.format(GetTips("REGRESSION_GIFT_DESCRIPE"), var_15_1, var_15_3)
end

return var_0_0
