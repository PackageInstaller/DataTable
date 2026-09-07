local PlayerVitaeEducateShipCard = class("PlayerVitaeEducateShipCard", import(".PlayerVitaeEducateBaseCard"))

function PlayerVitaeEducateShipCard:Ctor(arg_1_1, arg_1_2)
	PlayerVitaeEducateShipCard.super.Ctor(self, arg_1_1, arg_1_2)

	self.paintingTr = arg_1_1:Find("ship_icon/painting")
	self.nameTxt = arg_1_1:Find("detail/name_bg/name_mask/name"):GetComponent("ScrollText")

	return
end

function PlayerVitaeEducateShipCard:Flush()
	self:Clear()
	onButton(self, self._tf, function()
		self:emit(PlayerVitaeMediator.ON_SEL_EDUCATE_CHAR)

		return
	end, SFX_PANEL)

	local var_2_0 = VirtualEducateCharShip.New(getProxy(PlayerProxy):getRawData():GetEducateCharacter())

	setPaintingPrefabAsync(self.paintingTr, var_2_0:getPainting(), "biandui")
	self.nameTxt:SetText(var_2_0.name)

	self.ship = var_2_0

	return
end

function PlayerVitaeEducateShipCard:Clear()
	if self.ship then
		retPaintingPrefab(self.paintingTr, self.ship:getPainting())
	end

	removeOnButton(self._tf)

	return
end

return PlayerVitaeEducateShipCard
