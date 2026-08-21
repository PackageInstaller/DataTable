local var_0_0 = class("RecallPageBase", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	return
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.UpdateBar(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Hide(arg_7_0)
	SetActive(arg_7_0.gameObject_, false)
end

function var_0_0.Show(arg_8_0)
	SetActive(arg_8_0.gameObject_, true)
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)
end

return var_0_0
