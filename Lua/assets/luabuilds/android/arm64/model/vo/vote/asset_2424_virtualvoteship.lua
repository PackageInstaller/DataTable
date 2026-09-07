local VirtualVoteShip = class("VirtualVoteShip", import(".VoteShip"))

function VirtualVoteShip:GenConfigId(arg_1_1)
	return arg_1_1
end

function VirtualVoteShip:bindConfigTable()
	return pg.activity_vote_virtual_ship_data
end

function VirtualVoteShip:getRarity()
	return self:getConfig("rarity")
end

function VirtualVoteShip:getShipName()
	return self:getConfig("name")
end

function VirtualVoteShip:getEnName()
	return self:getConfig("english_name")
end

function VirtualVoteShip:getTeamType()
	return ShipType.GetTeamFromShipType(self:getShipType())
end

function VirtualVoteShip:getPainting()
	return self:getConfig("painting")
end

function VirtualVoteShip:GetDesc()
	return self:getConfig("desc")
end

function VirtualVoteShip:getShipType()
	return ""
end

function VirtualVoteShip:getNationality()
	return nil
end

return VirtualVoteShip
