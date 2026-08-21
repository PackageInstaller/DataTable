local var_0_0 = class("SectionLineItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.lineTf_ = arg_1_0.transform_:GetComponent("RectTransform")
end

function var_0_0.RefreshUI(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.lineTf_.localPosition = MathTools.GetMidpoint(arg_2_1, arg_2_2)
	arg_2_0.lineTf_.sizeDelta = Vector2(MathTools.GetDistance(arg_2_1, arg_2_2), 8)
	arg_2_0.lineTf_.localEulerAngles = Vector3(0, 0, MathTools.GetAngle(arg_2_1, arg_2_2))

	arg_2_0.lineTf_:SetAsFirstSibling()
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

return var_0_0
