local CourtYardStageFurniture = class("CourtYardStageFurniture", import(".CourtYardCanPutFurniture"))

function CourtYardStageFurniture:AllowDepthType()
	return {
		CourtYardConst.DEPTH_TYPE_MAT,
		CourtYardConst.DEPTH_TYPE_SHIP,
		CourtYardConst.DEPTH_TYPE_FURNITURE
	}
end

return CourtYardStageFurniture
