local IslandFirmActivityOrder = class("IslandFirmActivityOrder", import(".IslandFirmOrder"))

function IslandFirmActivityOrder:IsActivity()
	return true
end

return IslandFirmActivityOrder
