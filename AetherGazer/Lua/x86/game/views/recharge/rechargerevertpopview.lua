local var_0_0 = class("RechargeRevertPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Shop/ShopConversionUI"
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

	arg_4_0.rewardTypeController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "rewardType")
	arg_4_0.costTypeController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "costType")
	arg_4_0.list1 = LuaList.New(handler(arg_4_0, arg_4_0.indexItem1), arg_4_0.list1Go_, CommonItemView)
	arg_4_0.list2 = LuaList.New(handler(arg_4_0, arg_4_0.indexItem2), arg_4_0.list2Go_, CommonItemView)
end

function var_0_0.indexItem1(arg_5_0, arg_5_1, arg_5_2)
	CommonTools.SetCommonData(arg_5_2, {
		id = arg_5_0.buyItem[arg_5_1].id,
		num = arg_5_0.buyItem[arg_5_1].num
	})
end

function var_0_0.indexItem2(arg_6_0, arg_6_1, arg_6_2)
	CommonTools.SetCommonData(arg_6_2, {
		id = arg_6_0.revertItem[arg_6_1].id,
		num = arg_6_0.revertItem[arg_6_1].num
	})
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		arg_7_0.callBack()
	end)
end

function var_0_0.UpdateBar(arg_11_0)
	return
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.callBack = arg_13_0.params_.callBack
	arg_13_0.goodID = arg_13_0.params_.goodId
	arg_13_0.buyNumber = arg_13_0.params_.buyNumber

	arg_13_0:UpdateView()
end

function var_0_0.UpdateView(arg_14_0)
	arg_14_0.buyItem, arg_14_0.revertItem = ShopTools.rewertReward(arg_14_0.goodID, arg_14_0.buyNumber)

	arg_14_0.list1:StartScroll(#arg_14_0.buyItem)
	arg_14_0.list2:StartScroll(#arg_14_0.revertItem)
end

function var_0_0.OnShopBuyResult(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:Back()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.list1 then
		arg_17_0.list1:Dispose()

		arg_17_0.list1 = nil
	end

	if arg_17_0.list2 then
		arg_17_0.list2:Dispose()

		arg_17_0.list2 = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
