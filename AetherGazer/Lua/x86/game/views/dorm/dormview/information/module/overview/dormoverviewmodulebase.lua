local var_0_0 = class("DormOverviewModuleBase", BaseView)

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

function var_0_0.GetId(arg_6_0)
	return arg_6_0.id
end

function var_0_0.Dispose(arg_7_0)
	if not isNil(arg_7_0.gameObject_) then
		GameObject.Destroy(arg_7_0.gameObject_)
		Asset.Unload(arg_7_0:ModuleName())

		arg_7_0.gameObject_ = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
