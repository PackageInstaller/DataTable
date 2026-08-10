local var_0_0 = class("ShopTreeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetShopId(arg_5_0, arg_5_1)
	arg_5_0.shopId_ = arg_5_1
	arg_5_0.shopListCfg_ = ShopListCfg[arg_5_1]

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	arg_6_0.nameText_.text = arg_6_0.shopListCfg_.remark
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.GetToggle(arg_9_0)
	return arg_9_0.toggle_
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	Object.Destroy(arg_10_0.gameObject_)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
