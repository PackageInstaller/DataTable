local SectionLineItem = class("SectionLineItem", ReduxView)

function SectionLineItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.lineTf_ = self.transform_:GetComponent("RectTransform")
end

function SectionLineItem:RefreshUI(arg_2_1, arg_2_2)
	self.lineTf_.localPosition = MathTools.GetMidpoint(arg_2_1, arg_2_2)
	self.lineTf_.sizeDelta = Vector2(MathTools.GetDistance(arg_2_1, arg_2_2), 8)
	self.lineTf_.localEulerAngles = Vector3(0, 0, MathTools.GetAngle(arg_2_1, arg_2_2))

	self.lineTf_:SetAsFirstSibling()
end

function SectionLineItem:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function SectionLineItem:Dispose()
	SectionLineItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return SectionLineItem
