local var_0_0 = class("SectionCustomLineItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.lineAB_ = arg_1_1
	arg_1_0.pointAB_ = arg_1_3
	arg_1_0.lineParent_ = arg_1_2
	arg_1_0.lineList_ = {}
	arg_1_0.pointList_ = {}
end

function var_0_0.RefreshUI(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.lineList_) do
		SetActive(arg_2_0.lineList_[i], false)
	end

	for iter_2_2, iter_2_3 in pairs(arg_2_0.pointList_) do
		SetActive(arg_2_0.pointList_[i], false)
	end

	local var_2_0 = 1
	local var_2_1 = 1

	for iter_2_4, iter_2_5 in pairs(arg_2_1) do
		if iter_2_5[1] == 1 then
			arg_2_0.lineList_[var_2_0] = arg_2_0.lineList_[var_2_0] or Object.Instantiate(arg_2_0.lineAB_, arg_2_0.lineParent_.transform)

			arg_2_0:RefreshLine(arg_2_0.lineList_[var_2_0]:GetComponent("RectTransform"), iter_2_5)
			SetActive(arg_2_0.lineList_[var_2_0], true)

			var_2_0 = var_2_0 + 1
		elseif iter_2_5[1] == 2 then
			arg_2_0.pointList_[var_2_1] = arg_2_0.pointList_[var_2_1] or Object.Instantiate(arg_2_0.pointAB_, arg_2_0.lineParent_.transform)

			arg_2_0:RefreshPoint(arg_2_0.pointList_[var_2_1]:GetComponent("RectTransform"), iter_2_5)
			SetActive(arg_2_0.pointList_[var_2_0], true)

			var_2_1 = var_2_1 + 1
		end
	end
end

function var_0_0.RefreshPoint(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1.localPosition = Vector3(arg_3_2[2][1], arg_3_2[2][2], 0)

	arg_3_1:SetAsFirstSibling()
end

function var_0_0.RefreshLine(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1.localPosition = Vector3(arg_4_2[2][1], arg_4_2[2][2], 0)
	arg_4_1.sizeDelta = Vector2(arg_4_2[3][1], arg_4_2[3][2])
	arg_4_1.localEulerAngles = Vector3(arg_4_2[4][1], arg_4_2[4][2], arg_4_2[4][3])

	arg_4_1:SetAsFirstSibling()
end

function var_0_0.Show(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.lineList_) do
		SetActive(iter_5_1, arg_5_1)
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0.pointList_) do
		SetActive(iter_5_3, arg_5_1)
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.lineList_) do
		Object.Destroy(iter_6_1)
	end

	arg_6_0.lineList_ = nil

	for iter_6_2, iter_6_3 in pairs(arg_6_0.pointList_) do
		Object.Destroy(iter_6_3)
	end

	arg_6_0.pointList_ = nil
	arg_6_0.pointTf1_ = nil
	arg_6_0.pointTf2_ = nil
	arg_6_0.pointGo1_ = nil
	arg_6_0.pointGo2_ = nil
end

return var_0_0
