local var_0_0 = class("ChapterBaseVirtualItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:Show(true)
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.OnExit(arg_4_0)
	arg_4_0:Show(false)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil
end

function var_0_0.SetSiblingIndex(arg_6_0, arg_6_1)
	arg_6_0.transform_:SetSiblingIndex(arg_6_1)
end

function var_0_0.GetLocalPosition(arg_7_0)
	return arg_7_0.transform_.localPosition
end

return var_0_0
