local var_0_0 = class("DormInfomationModuleBase", BaseView)

function var_0_0.ModuleName(arg_1_0)
	return ""
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_2_0:ModuleName()), arg_2_1)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform
	arg_2_0.transform_.localPosition = Vector3.zero
	arg_2_0.transform_.localScale = Vector3.one
	arg_2_0.isActive = true

	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	return
end

function var_0_0.OnEnter(arg_4_0)
	return
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.CanShow(arg_6_0, arg_6_1)
	return true
end

function var_0_0.Show(arg_7_0, arg_7_1)
	arg_7_0.gameObject_:SetActive(true)

	arg_7_0.id = arg_7_1
end

function var_0_0.Hide(arg_8_0)
	arg_8_0.gameObject_:SetActive(false)
end

function var_0_0.GetId(arg_9_0)
	return arg_9_0.id
end

function var_0_0.Dispose(arg_10_0)
	if not isNil(arg_10_0.gameObject_) then
		GameObject.Destroy(arg_10_0.gameObject_)
		Asset.Unload(arg_10_0:ModuleName())

		arg_10_0.gameObject_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
