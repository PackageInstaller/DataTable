local IslandShipCard = class("IslandShipCard", import(".IslandMiniShipCard"))

function IslandShipCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tf = arg_1_1.transform
	self.addBtn = self.tf:Find("add")
	self.iconTr = self.tf:Find("mask/icon")
	self.selected = self.tf:Find("sel")
	self.levelTxt = self.tf:Find("Text"):GetComponent(typeof(Text))

	return
end

function IslandShipCard:Update(arg_2_1, arg_2_2)
	self.configId = arg_2_1
	self.ship = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_2_1)

	setActive(self.addBtn, not self.ship)
	GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(arg_2_1), "", self.iconTr)

	self.levelTxt.text = self.ship and "Lv." .. self.ship:GetLevel() or ""

	self:UpdateSelected(arg_2_2)

	return
end

function IslandShipCard:Dispose()
	return
end

return IslandShipCard
