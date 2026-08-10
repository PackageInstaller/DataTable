local var_0_0 = class("EquipBaseView", ReduxView)

function var_0_0.Init(arg_1_0)
	return
end

function var_0_0.Show(arg_2_0, arg_2_1)
	SetActive(arg_2_0.gameObject_, true)

	arg_2_0.params_ = arg_2_1

	arg_2_0:OnEnter()
end

function var_0_0.Hide(arg_3_0)
	SetActive(arg_3_0.gameObject_, false)
	arg_3_0:OnExit()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
