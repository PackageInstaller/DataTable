local CourtYardVisitorShip = class("CourtYardVisitorShip", import(".CourtYardShip"))

function CourtYardVisitorShip:Ctor(arg_1_1, arg_1_2)
	CourtYardVisitorShip.super.Ctor(self, arg_1_1, arg_1_2)

	self.name = arg_1_2.name
	self.inimacy = 0
	self.coin = 0

	return
end

function CourtYardVisitorShip:GetName()
	return self.name
end

function CourtYardVisitorShip:GetShipType()
	return CourtYardConst.SHIP_TYPE_OTHER
end

return CourtYardVisitorShip
