local IslandNpcShip = class("IslandNpcShip", import(".IslandShip"))

function IslandNpcShip:GetState()
	return IslandNpcShip.STATE_NORMAL
end

function IslandNpcShip:GetEnergy()
	return self.maxEnerey
end

function IslandNpcShip:GetCurrentEnergy()
	return self.maxEnerey
end

return IslandNpcShip
