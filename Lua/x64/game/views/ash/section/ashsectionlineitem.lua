local var_0_0 = class("AshSectionLineItem", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_Com/Stage_item/stageLine"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.transform_.parent = arg_1_1
	arg_1_0.lineTf_ = arg_1_0.transform_:GetComponent("RectTransform")
	arg_1_0.transform_.localPosition = Vector3.zero
	arg_1_0.transform_.localRotation = Quaternion.identity
	arg_1_0.transform_.localScale = Vector3.one
end

function var_0_0.RefreshUI(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.lineTf_.localPosition = arg_2_1
	arg_2_0.lineTf_.localScale = Vector2.New(arg_2_2 and 1 or -1, 1)
end

function var_0_0.Dispose(arg_3_0)
	GameObject.DestroyImmediate(arg_3_0.gameObject_)
	Asset.Unload(var_0_1)
	arg_3_0.super.Dispose(arg_3_0)
end

return var_0_0
