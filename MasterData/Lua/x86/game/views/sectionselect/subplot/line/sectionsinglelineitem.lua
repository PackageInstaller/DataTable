local SectionSingleLineItem = class("SectionSingleLineItem", ReduxView)

function SectionSingleLineItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.lineTf_ = self.transform_:GetComponent("RectTransform")
	self.lineHeight_ = arg_1_3 or 4
end

function SectionSingleLineItem:RefreshUI(arg_2_1, arg_2_2)
	self.lineTf_.localPosition = MathTools.GetMidpoint(arg_2_1, arg_2_2)
	self.lineTf_.sizeDelta = Vector2(MathTools.GetDistance(arg_2_1, arg_2_2), self.lineHeight_)
	self.lineTf_.localEulerAngles = Vector3(0, 0, MathTools.GetAngle(arg_2_1, arg_2_2))

	self.lineTf_:SetAsFirstSibling()
end

function SectionSingleLineItem:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function SectionSingleLineItem:Dispose()
	SectionSingleLineItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return SectionSingleLineItem
