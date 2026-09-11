local SectionCustomLineItem = class("SectionCustomLineItem", ReduxView)

function SectionCustomLineItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.lineAB_ = arg_1_1
	self.pointAB_ = arg_1_3
	self.lineParent_ = arg_1_2
	self.lineList_ = {}
	self.pointList_ = {}
end

function SectionCustomLineItem:RefreshUI(arg_2_1)
	for iter_2_0, iter_2_1 in pairs(self.lineList_) do
		SetActive(self.lineList_[i], false)
	end

	for iter_2_2, iter_2_3 in pairs(self.pointList_) do
		SetActive(self.pointList_[i], false)
	end

	local var_2_0 = 1

	for iter_2_4, iter_2_5 in pairs(arg_2_1) do
		if iter_2_5[1] == 1 then
			self.lineList_[var_2_0] = self.lineList_[var_2_0] or Object.Instantiate(self.lineAB_, self.lineParent_.transform)

			self:RefreshLine(self.lineList_[var_2_0]:GetComponent("RectTransform"), iter_2_5)
			SetActive(self.lineList_[var_2_0], true)

			var_2_0 = var_2_0 + 1
		elseif iter_2_5[1] == 2 then
			self.pointList_[1] = self.pointList_[1] or Object.Instantiate(self.pointAB_, self.lineParent_.transform)

			self:RefreshPoint(self.pointList_[1]:GetComponent("RectTransform"), iter_2_5)
			SetActive(self.pointList_[var_2_0], true)
		end
	end
end

function SectionCustomLineItem:RefreshPoint(arg_3_1, arg_3_2)
	arg_3_1.localPosition = Vector3(arg_3_2[2][1], arg_3_2[2][2], 0)

	arg_3_1:SetAsFirstSibling()
end

function SectionCustomLineItem:RefreshLine(arg_4_1, arg_4_2)
	arg_4_1.localPosition = Vector3(arg_4_2[2][1], arg_4_2[2][2], 0)
	arg_4_1.sizeDelta = Vector2(arg_4_2[3][1], arg_4_2[3][2])
	arg_4_1.localEulerAngles = Vector3(arg_4_2[4][1], arg_4_2[4][2], arg_4_2[4][3])

	arg_4_1:SetAsFirstSibling()
end

function SectionCustomLineItem:Show(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.lineList_) do
		SetActive(iter_5_1, arg_5_1)
	end

	for iter_5_2, iter_5_3 in pairs(self.pointList_) do
		SetActive(iter_5_3, arg_5_1)
	end
end

function SectionCustomLineItem:Dispose()
	SectionCustomLineItem.super.Dispose(self)

	for iter_6_0, iter_6_1 in pairs(self.lineList_) do
		Object.Destroy(iter_6_1)
	end

	self.lineList_ = nil

	for iter_6_2, iter_6_3 in pairs(self.pointList_) do
		Object.Destroy(iter_6_3)
	end

	self.pointList_ = nil
	self.pointTf1_ = nil
	self.pointTf2_ = nil
	self.pointGo1_ = nil
	self.pointGo2_ = nil
end

return SectionCustomLineItem
