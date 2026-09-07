local CourtYardWallMatFurniture = class("CourtYardWallMatFurniture", import(".CourtYardWallFurniture"))

function CourtYardWallMatFurniture:GetDeathType()
	return CourtYardConst.DEPTH_TYPE_MAT
end

return CourtYardWallMatFurniture
