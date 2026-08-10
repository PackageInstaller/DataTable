local var_0_0 = class("AdminCatExploreFirstPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ExploreUI/ExploCalculusGoUI"
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
	arg_5_0:AddBtnListener(arg_5_0.maskBg_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.UpdateBar(arg_7_0)
	return
end

function var_0_0.UpdateView(arg_8_0)
	return
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateView()
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Hide(arg_11_0)
	SetActive(arg_11_0.gameObject_, false)
end

function var_0_0.Show(arg_12_0)
	SetActive(arg_12_0.gameObject_, true)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
	Object.Destroy(arg_13_0.gameObject_)
end

return var_0_0
