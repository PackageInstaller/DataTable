local var_0_0 = class("EquipBreakThroughMaterialLine", ReduxView)
local var_0_1 = 40

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.lineGo1_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.lineTf1_ = arg_1_0.lineGo1_:GetComponent("RectTransform")
	arg_1_0.lineGo2_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.lineTf2_ = arg_1_0.lineGo2_:GetComponent("RectTransform")
	arg_1_0.lineGo3_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.lineTf3_ = arg_1_0.lineGo3_:GetComponent("RectTransform")
	arg_1_0.pointGo1_ = Object.Instantiate(arg_1_3, arg_1_2.transform)
	arg_1_0.pointTf1_ = arg_1_0.pointGo1_:GetComponent("RectTransform")
	arg_1_0.pointGo2_ = Object.Instantiate(arg_1_3, arg_1_2.transform)
	arg_1_0.pointTf2_ = arg_1_0.pointGo2_:GetComponent("RectTransform")
end

function var_0_0.RefreshUI(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:RefreshLine1(arg_2_1, arg_2_2)
	arg_2_0:RefreshLine2(arg_2_1, arg_2_2)
	arg_2_0:RefreshLine3(arg_2_1, arg_2_2)
end

function var_0_0.RefreshLine1(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_1

	arg_3_0.lineTf1_.localPosition = Vector3(arg_3_2.x - var_3_0 / 2, arg_3_2.y, 0)
	arg_3_0.lineTf1_.sizeDelta = Vector2(var_3_0, 2)
	arg_3_0.lineTf1_.localEulerAngles = Vector3(0, 0, 0)

	arg_3_0.lineTf1_:SetAsFirstSibling()

	arg_3_0.pointTf1_.localPosition = Vector3(arg_3_2.x, arg_3_2.y, 0)

	arg_3_0.pointTf1_:SetAsFirstSibling()
end

function var_0_0.RefreshLine2(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_1
	local var_4_1 = arg_4_1 + Vector3(var_4_0, 0, 0)
	local var_4_2 = arg_4_2 - Vector3(var_4_0, 0, 0)

	arg_4_0.lineTf2_.localPosition = Vector3((arg_4_2.x + arg_4_1.x) / 2, (arg_4_1.y + arg_4_2.y) / 2, 0)
	arg_4_0.lineTf2_.sizeDelta = Vector2(MathTools.GetDistance(var_4_1, var_4_2), 2)
	arg_4_0.lineTf2_.localEulerAngles = Vector3(0, 0, MathTools.GetAngle(var_4_1, var_4_2))

	arg_4_0.lineTf2_:SetAsFirstSibling()
end

function var_0_0.RefreshLine3(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_1

	arg_5_0.lineTf3_.localPosition = Vector3(arg_5_1.x + var_5_0 / 2, arg_5_1.y, 0)
	arg_5_0.lineTf3_.sizeDelta = Vector2(var_5_0, 2)
	arg_5_0.lineTf3_.localEulerAngles = Vector3(0, 0, 0)

	arg_5_0.lineTf3_:SetAsFirstSibling()

	arg_5_0.pointTf2_.localPosition = Vector3(arg_5_1.x, arg_5_1.y, 0)

	arg_5_0.pointTf2_:SetAsFirstSibling()
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.lineGo1_, arg_6_1)
	SetActive(arg_6_0.lineGo2_, arg_6_1)
	SetActive(arg_6_0.lineGo3_, arg_6_1)
	SetActive(arg_6_0.pointGo1_, arg_6_1)
	SetActive(arg_6_0.pointGo2_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.lineGo1_)
	Object.Destroy(arg_7_0.lineGo2_)
	Object.Destroy(arg_7_0.lineGo3_)
	Object.Destroy(arg_7_0.pointGo1_)
	Object.Destroy(arg_7_0.pointGo2_)

	arg_7_0.lineTf1_ = nil
	arg_7_0.lineTf2_ = nil
	arg_7_0.lineTf3_ = nil
	arg_7_0.pointTf1_ = nil
	arg_7_0.pointTf2_ = nil
	arg_7_0.lineGo1_ = nil
	arg_7_0.lineGo2_ = nil
	arg_7_0.lineGo3_ = nil
	arg_7_0.pointGo1_ = nil
	arg_7_0.pointGo2_ = nil
end

return var_0_0
