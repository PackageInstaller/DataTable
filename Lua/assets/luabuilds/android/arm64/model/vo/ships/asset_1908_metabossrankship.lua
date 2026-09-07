local MetaBossRankShip = class("MetaBossRankShip", import(".CheckCustomNameShip"))

function MetaBossRankShip:IsOwner()
	return false
end

return MetaBossRankShip
