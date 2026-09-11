local EquipBreakThroughMaterialLine = class("EquipBreakThroughMaterialLine", ReduxView)
local var_0_1 = 40

function EquipBreakThroughMaterialLine:Ctor(arg_1_1, arg_1_2, arg_1_3)
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

function EquipBreakThroughMaterialLine:RefreshUI(arg_2_1, arg_2_2)
	self:RefreshLine1(arg_2_1, arg_2_2)
	self:RefreshLine2(arg_2_1, arg_2_2)
	self:RefreshLine3(arg_2_1, arg_2_2)
end

function EquipBreakThroughMaterialLine:RefreshLine1(arg_3_1, arg_3_2)
	self.lineTf1_.localPosition = Vector3(arg_3_2.x - var_0_1 / 2, arg_3_2.y, 0)
	self.lineTf1_.sizeDelta = Vector2(var_0_1, 2)
	self.lineTf1_.localEulerAngles = Vector3(0, 0, 0)

	self.lineTf1_:SetAsFirstSibling()

	self.pointTf1_.localPosition = Vector3(arg_3_2.x, arg_3_2.y, 0)

	self.pointTf1_:SetAsFirstSibling()
end

function EquipBreakThroughMaterialLine:RefreshLine2(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1 + Vector3(var_0_1, 0, 0)
	local var_4_1 = arg_4_2 - Vector3(var_0_1, 0, 0)

	self.lineTf2_.localPosition = Vector3((arg_4_2.x + arg_4_1.x) / 2, (arg_4_1.y + arg_4_2.y) / 2, 0)
	self.lineTf2_.sizeDelta = Vector2(MathTools.GetDistance(var_4_0, var_4_1), 2)
	self.lineTf2_.localEulerAngles = Vector3(0, 0, MathTools.GetAngle(var_4_0, var_4_1))

	self.lineTf2_:SetAsFirstSibling()
end

function EquipBreakThroughMaterialLine:RefreshLine3(arg_5_1, arg_5_2)
	self.lineTf3_.localPosition = Vector3(arg_5_1.x + var_0_1 / 2, arg_5_1.y, 0)
	self.lineTf3_.sizeDelta = Vector2(var_0_1, 2)
	self.lineTf3_.localEulerAngles = Vector3(0, 0, 0)

	self.lineTf3_:SetAsFirstSibling()

	self.pointTf2_.localPosition = Vector3(arg_5_1.x, arg_5_1.y, 0)

	self.pointTf2_:SetAsFirstSibling()
end

function EquipBreakThroughMaterialLine:Show(arg_6_1)
	SetActive(self.lineGo1_, arg_6_1)
	SetActive(self.lineGo2_, arg_6_1)
	SetActive(self.lineGo3_, arg_6_1)
	SetActive(self.pointGo1_, arg_6_1)
	SetActive(self.pointGo2_, arg_6_1)
end

function EquipBreakThroughMaterialLine:Dispose()
	EquipBreakThroughMaterialLine.super.Dispose(self)
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

return EquipBreakThroughMaterialLine
