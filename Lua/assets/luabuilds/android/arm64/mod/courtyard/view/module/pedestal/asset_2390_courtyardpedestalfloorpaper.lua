local CourtYardPedestalFloorPaper = class("CourtYardPedestalFloorPaper", import(".CourtYardPedestalStructure"))
local var_0_1 = {
	0.5,
	0.67,
	0.83,
	1
}

function CourtYardPedestalFloorPaper:Update(arg_1_1, arg_1_2)
	self.paper = arg_1_1

	CourtYardPedestalFloorPaper.super.Update(self, arg_1_2)

	return
end

function CourtYardPedestalFloorPaper:GetAssetPath()
	if not self.paper then
		return "furnitrues/base/floor_4"
	end

	local var_2_0 = self.paper:GetObjType()

	if var_2_0 == CourtYardConst.OBJ_TYPE_COMMOM then
		return "furnitrues/" .. self.paper:GetPicture()
	elseif var_2_0 == CourtYardConst.OBJ_TYPE_SPINE then
		local var_2_1, var_2_2 = self.paper:GetSpineNameAndAction()

		return "sfurniture/" .. var_2_1
	end

	return
end

function CourtYardPedestalFloorPaper:GetParent()
	return self.parent._tf:Find("paper")
end

function CourtYardPedestalFloorPaper:OnLoaded(arg_4_1)
	rtf(arg_4_1).sizeDelta = Vector2(1888, 944)
	rtf(arg_4_1).anchorMin = Vector2(0.5, 1)
	rtf(arg_4_1).anchorMax = Vector2(0.5, 1)
	rtf(arg_4_1).pivot = Vector2(0.5, 1)
	rtf(arg_4_1).localScale = Vector3(1, 1, 1)

	setAnchoredPosition(rtf(arg_4_1), Vector3(0, -280, 0))

	if self.paper and self.paper:GetObjType() == CourtYardConst.OBJ_TYPE_SPINE then
		self:InitSpine(arg_4_1)
	end

	tf(arg_4_1):SetSiblingIndex((self:GetRect():GetSiblingIndex()))

	arg_4_1.transform.localScale = Vector3(var_0_1[self.level], var_0_1[self.level], 1)

	return
end

function CourtYardPedestalFloorPaper:InitSpine(arg_5_1)
	local var_5_0, var_5_1 = self.paper:GetSpineNameAndAction()

	if var_5_1 then
		GetOrAddComponent(tf(arg_5_1):GetChild(0), typeof(SpineAnimUI)):SetAction(var_5_1, 0)
	end

	return
end

return CourtYardPedestalFloorPaper
