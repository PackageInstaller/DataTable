local CourtYardMatFurniture = class("CourtYardMatFurniture", import(".CourtYardFurniture"))

function CourtYardMatFurniture:GetDeathType()
	return CourtYardConst.DEPTH_TYPE_MAT
end

return CourtYardMatFurniture
