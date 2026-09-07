local WinterFestival2025ShrineShipWordView = class("WinterFestival2025ShrineShipWordView", import(".Shrine2022ShipWordView"))

function WinterFestival2025ShrineShipWordView:getUIName()
	return "WinterFestival2025ShrineShipWordUI"
end

function WinterFestival2025ShrineShipWordView:setUIData()
	self.shipWordSpriteList = {}
	self.shipWordSpriteList[self.curSelectShip] = getImageSprite(self._tf:Find("Res"):Find("ShipWord" .. self.curSelectShip))

	return
end

return WinterFestival2025ShrineShipWordView
