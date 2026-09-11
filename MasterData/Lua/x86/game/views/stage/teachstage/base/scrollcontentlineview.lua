local ScrollContentLineView = class("ScrollContentLineView", BaseView)

function ScrollContentLineView:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.goLineItem_ = arg_1_1
	self.goItemParent_ = arg_1_2
	self.stageItemWidth_ = arg_1_3
	self.offsetX_ = arg_1_4
	self.lineHeight_ = arg_1_5
	self.lineItemList_ = {}
end

function ScrollContentLineView:Dispose()
	ScrollContentLineView.super.Dispose(self)

	for iter_2_0 = #self.lineItemList_, 1, -1 do
		Object.Destroy(self.lineItemList_[iter_2_0])
	end

	self.lineItemList_ = nil
end

function ScrollContentLineView:CreateLineItemList(arg_3_1, arg_3_2, arg_3_3)
	for iter_3_0 = #self.lineItemList_, 1, -1 do
		SetActive(self.lineItemList_[iter_3_0], false)
	end

	for iter_3_1, iter_3_2 in ipairs(arg_3_2) do
		if iter_3_1 > 1 and arg_3_1[iter_3_2] then
			local var_3_0 = arg_3_3[iter_3_1 - 1]:GetLocalPosition() + Vector3(self.stageItemWidth_ / 2 - self.offsetX_, 0, 0)
			local var_3_1 = arg_3_3[iter_3_1]:GetLocalPosition() + Vector3(self.stageItemWidth_ / -2 + self.offsetX_, 0, 0)
			local var_3_2 = self.lineItemList_[iter_3_1] or Object.Instantiate(self.goLineItem_, self.goItemParent_.transform)

			if not self.lineItemList_[iter_3_1] then
				table.insert(self.lineItemList_, var_3_2)
			end

			local var_3_3 = var_3_2.transform

			var_3_3.localPosition = self:GetMidpoint(var_3_0, var_3_1)
			var_3_3:GetComponent("RectTransform").sizeDelta = Vector2(self:GetDistance(var_3_0, var_3_1), self.lineHeight_)
			var_3_3:GetComponent("RectTransform").localEulerAngles = Vector3(0, 0, self:GetAngle(var_3_0, var_3_1))

			var_3_3:SetAsFirstSibling()
			SetActive(var_3_2, true)
		end
	end
end

function ScrollContentLineView:GetDistance(arg_4_1, arg_4_2)
	return math.sqrt((arg_4_1.x - arg_4_2.x) * (arg_4_1.x - arg_4_2.x) + (arg_4_1.y - arg_4_2.y) * (arg_4_1.y - arg_4_2.y))
end

function ScrollContentLineView:GetMidpoint(arg_5_1, arg_5_2)
	return (arg_5_1 + arg_5_2) / 2
end

function ScrollContentLineView:GetAngle(arg_6_1, arg_6_2)
	local var_6_0 = self:GetDistance(arg_6_1, arg_6_2)

	if arg_6_1.x - arg_6_2.x < 0 then
		return math.asin((arg_6_1.y - arg_6_2.y) / var_6_0) / math.pi * -180
	else
		return math.asin((arg_6_1.y - arg_6_2.y) / var_6_0) / math.pi * 180 + 180
	end
end

return ScrollContentLineView
