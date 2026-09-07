local AgoraBuildingMap = class("AgoraBuildingMap", import(".AgoraMap"))

function AgoraBuildingMap:GenMap(arg_1_1)
	return AgoraBuildingMap.super.GenMap(self, Vector2(100, 100))
end

return AgoraBuildingMap
