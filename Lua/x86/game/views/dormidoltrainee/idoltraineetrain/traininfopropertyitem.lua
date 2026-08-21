local var_0_0 = class("TrainInfoPropertyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.animator_ then
		arg_4_0.animator_.enabled = false

		SetActive(arg_4_0.effectGo_, false)
	end

	arg_4_0.value_.text = arg_4_1
	arg_4_0.total_.text = "/" .. arg_4_2
	arg_4_0.bar_.value = arg_4_1 / arg_4_2
end

function var_0_0.PlayAddAnim(arg_5_0)
	if arg_5_0.animator_ then
		arg_5_0.animator_.enabled = false
		arg_5_0.animator_.enabled = true
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
