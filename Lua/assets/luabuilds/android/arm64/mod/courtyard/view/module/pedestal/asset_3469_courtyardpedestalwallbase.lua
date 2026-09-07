local CourtYardPedestalWallBase = class("CourtYardPedestalWallBase", import(".CourtYardPedestalStructure"))

function CourtYardPedestalWallBase:GetAssetPath()
	return "furnitrues/base/wall_" .. self.level
end

function CourtYardPedestalWallBase:OnLoaded(arg_2_1)
	arg_2_1.transform:SetAsFirstSibling()

	return
end

function CourtYardPedestalWallBase:GetParent()
	return self.parent._tf:Find("base")
end

return CourtYardPedestalWallBase
