local var_0_0 = class("AssetPendToggleItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.id_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")

	arg_1_0:RefreshUI()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		manager.notify:Invoke(ASSET_PEND_CLICK_TOGGLE, arg_3_0.id_)
	end)
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = AssetPendToggleCfg[arg_5_0.id_]

	arg_5_0.nameText1_.text = var_5_0.toggle_name
	arg_5_0.nameText2_.text = var_5_0.toggle_name

	SetActive(arg_5_0.gameObject_, true)
end

function var_0_0.RefreshSelectState(arg_6_0, arg_6_1)
	if arg_6_0.id_ == arg_6_1 then
		arg_6_0.selectController_:SetSelectedState("true")
	else
		arg_6_0.selectController_:SetSelectedState("false")
	end
end

return var_0_0
