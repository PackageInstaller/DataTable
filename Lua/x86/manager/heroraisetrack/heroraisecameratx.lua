local var_0_0 = class("HeroRaiseCameraTx")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.gameObject_ = nil
	arg_1_0.transform_ = nil
	arg_1_0.animator_ = nil
end

function var_0_0.Init(arg_2_0, arg_2_1)
	local var_2_0 = Asset.Load(arg_2_1)

	arg_2_0.transform_ = Object.Instantiate(var_2_0, manager.ui.mainCamera.transform)

	if not isNil(arg_2_0.transform_) then
		arg_2_0.gameObject_ = arg_2_0.transform_.gameObject
		arg_2_0.animator_ = arg_2_0.transform_:GetComponent(typeof(Animator))

		if isNil(arg_2_0.animator_) then
			arg_2_0.animator_ = arg_2_0.transform_:GetComponentInChildren(typeof(Animator))
		end
	end
end

function var_0_0.PlayAnim(arg_3_0, arg_3_1)
	if isNil(arg_3_0.animator_) then
		return
	end

	arg_3_0.animator_:Play(arg_3_1)
end

function var_0_0.CheckValid(arg_4_0)
	if isNil(arg_4_0.gameObject_) then
		return false
	end

	return true
end

function var_0_0.Dispose(arg_5_0)
	if not isNil(arg_5_0.gameObject_) then
		Object.Destroy(arg_5_0.gameObject_)
	end

	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil
	arg_5_0.animator_ = nil
end

return var_0_0
