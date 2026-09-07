local CourtYardOutStorey = class("CourtYardOutStorey", import(".CourtYardStorey"))

function CourtYardOutStorey:CanAddFurniture(arg_1_1)
	return arg_1_1.config.belong == 1
end

return CourtYardOutStorey
