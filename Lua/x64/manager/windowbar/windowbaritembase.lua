local var_0_0 = class("WindowBarItemBase", import("game.extend.ReduxView"))

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.isCanAdd_ = true
	arg_2_0.isCanClick_ = false

	arg_2_0:RefreshUI()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.RefreshUI(arg_4_0)
	return
end

function var_0_0.OnClick(arg_5_0)
	return
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)

	if arg_6_1 then
		arg_6_0:RegisterEvents()
		arg_6_0:RefreshUI()
	else
		arg_6_0:RemoveAllEventListener()
	end
end

function var_0_0.SetCanAdd(arg_7_0, arg_7_1)
	if arg_7_0.isCanAdd_ == arg_7_1 then
		return
	end

	arg_7_0.isCanAdd_ = arg_7_1

	SetActive(arg_7_0.add_, arg_7_1)
end

function var_0_0.SetCanClick(arg_8_0, arg_8_1)
	arg_8_0.isCanClick_ = arg_8_1
end

function var_0_0.UnBindListener(arg_9_0)
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	arg_10_0.transform_ = nil
	arg_10_0.gameObject_ = nil
end

return var_0_0
