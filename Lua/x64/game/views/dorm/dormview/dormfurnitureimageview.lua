local var_0_0 = class("DormFurnitureImageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Shop/contentViews/furnitureImageView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RefreshUI()
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.imageBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.shopID = arg_9_0.params_.shopID
	arg_9_0.imageImg_.sprite = DormTools.GetShopStyleImage(arg_9_0.shopID)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
