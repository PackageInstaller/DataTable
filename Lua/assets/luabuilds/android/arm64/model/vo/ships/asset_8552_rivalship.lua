local RivalShip = class("RivalShip", import(".CheckCustomNameShip"))

function RivalShip:IsOwner()
	return false
end

return RivalShip
