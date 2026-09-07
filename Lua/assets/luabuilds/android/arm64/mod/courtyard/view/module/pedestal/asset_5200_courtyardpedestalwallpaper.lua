local CourtYardPedestalWallPaper = class("CourtYardPedestalWallPaper", import(".CourtYardPedestalStructure"))

function CourtYardPedestalWallPaper:Update(arg_1_1, arg_1_2)
	self.paper = arg_1_1

	if not self.paper then
		self:Unload()

		return
	end

	CourtYardPedestalWallPaper.super.Update(self, arg_1_2)

	return
end

function CourtYardPedestalWallPaper:GetAssetPath()
	local var_2_0 = self.paper:GetObjType()

	if var_2_0 == CourtYardConst.OBJ_TYPE_COMMOM then
		return "furnitrues/" .. self.paper:GetPicture() .. self.level
	elseif var_2_0 == CourtYardConst.OBJ_TYPE_SPINE then
		local var_2_1, var_2_2 = self.paper:GetSpineNameAndAction()

		return "sfurniture/" .. var_2_1 .. self.level
	end

	return
end

function CourtYardPedestalWallPaper:GetParent()
	return self.parent._tf:Find("paper")
end

function CourtYardPedestalWallPaper:OnLoaded(arg_4_1)
	rtf(arg_4_1).anchorMin = Vector2(0.5, 1)
	rtf(arg_4_1).anchorMax = Vector2(0.5, 1)
	rtf(arg_4_1).pivot = Vector2(0.5, 1)
	rtf(arg_4_1).localScale = Vector3(1, 1, 1)

	local var_4_0 = self.paper:GetObjType()

	if var_4_0 == CourtYardConst.OBJ_TYPE_COMMOM then
		self:InitCommon(arg_4_1)
	elseif var_4_0 == CourtYardConst.OBJ_TYPE_SPINE then
		self:InitSpine(arg_4_1)
	end

	tf(arg_4_1):SetSiblingIndex(1)

	return
end

function CourtYardPedestalWallPaper:InitCommon(arg_5_1)
	setAnchoredPosition(arg_5_1, {
		x = 0,
		y = -6
	})

	return
end

function CourtYardPedestalWallPaper:InitSpine(arg_6_1)
	setAnchoredPosition(arg_6_1, Vector3(0, -10, 0))

	local var_6_0, var_6_1 = self.paper:GetSpineNameAndAction()

	if var_6_1 then
		GetOrAddComponent(tf(arg_6_1):GetChild(0), typeof(SpineAnimUI)):SetAction(var_6_1, 0)
	end

	return
end

return CourtYardPedestalWallPaper
