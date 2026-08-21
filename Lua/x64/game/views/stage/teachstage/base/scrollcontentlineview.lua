local var_0_0 = class("ScrollContentLineView", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.goLineItem_ = arg_1_1
	arg_1_0.goItemParent_ = arg_1_2
	arg_1_0.stageItemWidth_ = arg_1_3
	arg_1_0.offsetX_ = arg_1_4
	arg_1_0.lineHeight_ = arg_1_5
	arg_1_0.lineItemList_ = {}
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	for iter_2_0 = #arg_2_0.lineItemList_, 1, -1 do
		Object.Destroy(arg_2_0.lineItemList_[iter_2_0])
	end

	arg_2_0.lineItemList_ = nil
end

function var_0_0.CreateLineItemList(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	for iter_3_0 = #arg_3_0.lineItemList_, 1, -1 do
		SetActive(arg_3_0.lineItemList_[iter_3_0], false)
	end

	for iter_3_1, iter_3_2 in ipairs(arg_3_2) do
		if iter_3_1 > 1 and arg_3_1[iter_3_2] then
			local var_3_0 = arg_3_3[iter_3_1 - 1]:GetLocalPosition() + Vector3(arg_3_0.stageItemWidth_ / 2 - arg_3_0.offsetX_, 0, 0)
			local var_3_1 = arg_3_3[iter_3_1]:GetLocalPosition() + Vector3(arg_3_0.stageItemWidth_ / -2 + arg_3_0.offsetX_, 0, 0)
			local var_3_2 = arg_3_0.lineItemList_[iter_3_1] or Object.Instantiate(arg_3_0.goLineItem_, arg_3_0.goItemParent_.transform)

			if not arg_3_0.lineItemList_[iter_3_1] then
				table.insert(arg_3_0.lineItemList_, var_3_2)
			end

			local var_3_3 = var_3_2.transform

			var_3_3.localPosition = arg_3_0:GetMidpoint(var_3_0, var_3_1)
			var_3_3:GetComponent("RectTransform").sizeDelta = Vector2(arg_3_0:GetDistance(var_3_0, var_3_1), arg_3_0.lineHeight_)
			var_3_3:GetComponent("RectTransform").localEulerAngles = Vector3(0, 0, arg_3_0:GetAngle(var_3_0, var_3_1))

			var_3_3:SetAsFirstSibling()
			SetActive(var_3_2, true)
		end
	end
end

function var_0_0.GetDistance(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = (arg_4_1.x - arg_4_2.x) * (arg_4_1.x - arg_4_2.x) + (arg_4_1.y - arg_4_2.y) * (arg_4_1.y - arg_4_2.y)

	return math.sqrt(var_4_0)
end

function var_0_0.GetMidpoint(arg_5_0, arg_5_1, arg_5_2)
	return (arg_5_1 + arg_5_2) / 2
end

function var_0_0.GetAngle(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:GetDistance(arg_6_1, arg_6_2)

	if arg_6_1.x - arg_6_2.x < 0 then
		return math.asin((arg_6_1.y - arg_6_2.y) / var_6_0) / math.pi * -180
	else
		return math.asin((arg_6_1.y - arg_6_2.y) / var_6_0) / math.pi * 180 + 180
	end
end

return var_0_0
