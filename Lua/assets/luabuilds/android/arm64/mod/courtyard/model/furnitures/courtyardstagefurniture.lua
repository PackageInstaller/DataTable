local var_0_0 = class("CourtYardStageFurniture", import(".CourtYardCanPutFurniture"))

function var_0_0.AllowDepthType(arg_1_0)
	return {
		CourtYardConst.DEPTH_TYPE_MAT,
		CourtYardConst.DEPTH_TYPE_SHIP,
		CourtYardConst.DEPTH_TYPE_FURNITURE
	}
end

return var_0_0
