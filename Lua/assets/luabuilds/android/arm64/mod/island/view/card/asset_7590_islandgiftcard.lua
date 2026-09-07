local IslandGiftCard = class("IslandGiftCard")

function IslandGiftCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self._tf = arg_1_1.transform
	self.itemTr = findTF(self._tf, "IslandItemTpl")
	self.countTr = self.itemTr:Find("icon_bg/count_bg")
	self.countTxt = self.itemTr:Find("icon_bg/count_bg/count"):GetComponent(typeof(Text))
	self.nameTF = findTF(self._tf, "name/Text")
	self.nameTxt = findTF(self._tf, "name/Text"):GetComponent(typeof(Text))
	self.selected = findTF(self._tf, "selected")
	self.heart = findTF(self._tf, "heart")

	return
end

function IslandGiftCard:Update(arg_2_1, arg_2_2, arg_2_3)
	self.itemId = arg_2_2.id
	self.item = arg_2_2

	updateCustomDrop(self.itemTr, (Drop.New({
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_2_2.id,
		count = arg_2_2:GetCount()
	})))
	setActive(self.countTr, true)
	setScrollText(self.nameTF, arg_2_2:GetName())

	self.countTxt.text = "X" .. arg_2_2:GetCount()

	self:UpdateSelected(arg_2_3)
	setActive(self.heart, table.contains(getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_2_1):GetFavoriteGift(), self.itemId))

	return
end

function IslandGiftCard:UpdateSelected(arg_3_1)
	setActive(self.selected, arg_3_1 == self.itemId)

	return
end

function IslandGiftCard:Dispose()
	return
end

return IslandGiftCard
