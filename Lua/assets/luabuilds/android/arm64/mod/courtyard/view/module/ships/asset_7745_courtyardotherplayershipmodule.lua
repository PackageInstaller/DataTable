local CourtYardOtherPlayerShipModule = class("CourtYardOtherPlayerShipModule", import(".CourtYardShipModule"))

function CourtYardOtherPlayerShipModule:Emit(arg_1_1, ...)
	if arg_1_1 == "TouchShip" or arg_1_1 == "ShipAnimtionFinish" then
		CourtYardOtherPlayerShipModule.super.Emit(self, arg_1_1, ...)
	end

	return
end

function CourtYardOtherPlayerShipModule:OnBeginDrag()
	return
end

function CourtYardOtherPlayerShipModule:OnDragging(arg_3_1)
	return
end

function CourtYardOtherPlayerShipModule:OnDragEnd(arg_4_1)
	return
end

return CourtYardOtherPlayerShipModule
