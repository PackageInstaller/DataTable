local CourtYardFurniturePlaceableArea = class("CourtYardFurniturePlaceableArea", import("...map.CourtYardPlaceableArea"))

function CourtYardFurniturePlaceableArea:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.furniture = arg_1_2

	CourtYardFurniturePlaceableArea.super.Ctor(self, arg_1_1, arg_1_3)

	return
end

function CourtYardFurniturePlaceableArea:LegalPosition(arg_2_1, arg_2_2)
	return CourtYardFurniturePlaceableArea.super.IsEmptyPosition(self, arg_2_1) and table.contains(self.furniture:GetCanputonPosition(), arg_2_1)
end

function CourtYardFurniturePlaceableArea:AreaWithInfo(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	return _.map(arg_3_1:GetAreaByPosition(arg_3_2), function(arg_4_0)
		local var_4_0 = arg_3_4 or self:LegalPosition(arg_4_0)

		return {
			flag = var_4_0 and 3 or 2,
			position = arg_4_0,
			offset = arg_3_3
		}
	end)
end

return CourtYardFurniturePlaceableArea
