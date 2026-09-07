local IslandMiniShipCard = class("IslandMiniShipCard")

function IslandMiniShipCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tf = arg_1_1.transform
	self.addBtn = self.tf:Find("add")
	self.iconTr = self.tf:Find("icon")
	self.selected = self.tf:Find("sel")
	self.selImg = self.tf:Find("sel_1"):GetComponent(typeof(Image))
	self.redDot = self.tf:Find("red_dot")

	return
end

function IslandMiniShipCard:Update(arg_2_1, arg_2_2)
	self.configId = arg_2_1
	self.ship = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_2_1)

	setActive(self.addBtn, not self.ship)
	GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. IslandShip.StaticGetPrefab(arg_2_1), "", self.iconTr)
	self:UpdateSelected(arg_2_2)
	self:FlushRedDot()

	return
end

function IslandMiniShipCard:FlushRedDot()
	setActive(self.redDot, false)

	return
end

function IslandMiniShipCard:UpdateSelected(arg_4_1)
	setActive(self.selected, arg_4_1 == self.configId)

	return
end

function IslandMiniShipCard:Dispose()
	return
end

return IslandMiniShipCard
