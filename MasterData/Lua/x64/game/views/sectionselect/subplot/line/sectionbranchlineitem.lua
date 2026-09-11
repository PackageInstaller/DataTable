local SectionBranchLineItem = class("SectionBranchLineItem", ReduxView)
local var_0_1 = 200

function SectionBranchLineItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.lineGo1_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.lineTf1_ = self.lineGo1_:GetComponent("RectTransform")
	self.lineGo2_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.lineTf2_ = self.lineGo2_:GetComponent("RectTransform")
	self.lineGo3_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.lineTf3_ = self.lineGo3_:GetComponent("RectTransform")
	self.pointGo1_ = Object.Instantiate(arg_1_3, arg_1_2.transform)
	self.pointTf1_ = self.pointGo1_:GetComponent("RectTransform")
	self.pointGo2_ = Object.Instantiate(arg_1_3, arg_1_2.transform)
	self.pointTf2_ = self.pointGo2_:GetComponent("RectTransform")
end

function SectionBranchLineItem:RefreshUI(arg_2_1, arg_2_2)
	self:RefreshLine1(arg_2_1, arg_2_2)
	self:RefreshLine2(arg_2_1, arg_2_2)
	self:RefreshLine3(arg_2_1, arg_2_2)
end

function SectionBranchLineItem:RefreshLine1(arg_3_1, arg_3_2)
	local var_3_0 = var_0_1
	local var_3_1 = math.abs(arg_3_2.x - arg_3_1.x)

	if var_3_1 < var_0_1 then
		var_3_0 = var_3_1 / 2
	end

	self.lineTf1_.localPosition = Vector3(arg_3_2.x - var_3_0 / 2, arg_3_2.y, 0)
	self.lineTf1_.sizeDelta = Vector2(var_3_0, 8)
	self.lineTf1_.localEulerAngles = Vector3(0, 0, 0)

	self.lineTf1_:SetAsFirstSibling()

	self.pointTf1_.localPosition = Vector3(arg_3_2.x, arg_3_2.y, 0)

	self.pointTf1_:SetAsFirstSibling()
end

function SectionBranchLineItem:RefreshLine2(arg_4_1, arg_4_2)
	if arg_4_1.y == arg_4_2.y then
		SetActive(self.lineGo2_, false)
	else
		local var_4_1 = math.abs(arg_4_2.x - arg_4_1.x)

		self.lineTf2_.localPosition = Vector3(arg_4_2.x - ((var_4_1 < var_0_1 or nil) and var_4_1 / 2), (arg_4_1.y + arg_4_2.y) / 2, 0)
		self.lineTf2_.sizeDelta = Vector2(math.abs(arg_4_1.y - arg_4_2.y), 8)
		self.lineTf2_.localEulerAngles = Vector3(0, 0, 90)

		self.lineTf2_:SetAsFirstSibling()
	end
end

function SectionBranchLineItem:RefreshLine3(arg_5_1, arg_5_2)
	local var_5_0 = var_0_1
	local var_5_1 = math.abs(arg_5_2.x - arg_5_1.x)

	var_5_0 = var_5_1 < var_0_1 and var_5_1 / 2 or var_5_1 - var_0_1
	self.lineTf3_.localPosition = Vector3(arg_5_1.x + var_5_0 / 2, arg_5_1.y, 0)
	self.lineTf3_.sizeDelta = Vector2(var_5_0, 8)
	self.lineTf3_.localEulerAngles = Vector3(0, 0, 0)

	self.lineTf3_:SetAsFirstSibling()

	self.pointTf2_.localPosition = Vector3(arg_5_1.x, arg_5_1.y, 0)

	self.pointTf2_:SetAsFirstSibling()
end

function SectionBranchLineItem:Show(arg_6_1)
	SetActive(self.lineGo1_, arg_6_1)
	SetActive(self.lineGo2_, arg_6_1)
	SetActive(self.lineGo3_, arg_6_1)
	SetActive(self.pointGo1_, arg_6_1)
	SetActive(self.pointGo2_, arg_6_1)
end

function SectionBranchLineItem:Dispose()
	SectionBranchLineItem.super.Dispose(self)
	Object.Destroy(self.lineGo1_)
	Object.Destroy(self.lineGo2_)
	Object.Destroy(self.lineGo3_)
	Object.Destroy(self.pointGo1_)
	Object.Destroy(self.pointGo2_)

	self.lineTf1_ = nil
	self.lineTf2_ = nil
	self.lineTf3_ = nil
	self.pointTf1_ = nil
	self.pointTf2_ = nil
	self.lineGo1_ = nil
	self.lineGo2_ = nil
	self.lineGo3_ = nil
	self.pointGo1_ = nil
	self.pointGo2_ = nil
end

return SectionBranchLineItem
