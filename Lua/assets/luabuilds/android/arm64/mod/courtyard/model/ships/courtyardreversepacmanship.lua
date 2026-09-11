local CourtYardReversePacmanShip = class("CourtYardReversePacmanShip", import(".CourtYardShip"))

function CourtYardReversePacmanShip:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	CourtYardReversePacmanShip.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	self.roleID = arg_1_2.roleID

	return
end

function CourtYardReversePacmanShip:GetShipType()
	return CourtYardConst.SHIP_TYPE_REVERSE_PACMAN
end

function CourtYardReversePacmanShip:ShowChatBubble()
	self:DispatchEvent(CourtYardEvent.REVERSE_PACMAN_CHAT_BUBBLE, roleID)

	return
end

return CourtYardReversePacmanShip
