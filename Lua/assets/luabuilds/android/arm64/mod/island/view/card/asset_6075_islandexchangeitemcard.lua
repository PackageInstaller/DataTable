local IslandExchangeItemCard = class("IslandExchangeItemCard", import(".IslandItemCard"))

function IslandExchangeItemCard:Update(arg_1_1, arg_1_2)
	self.item = arg_1_1
	self.nameTxt.text = self:ShortenString(arg_1_1:GetName(), 6)

	updateCustomDrop(self._tf, Drop.New({
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_1_1.id,
		count = arg_1_1:GetCount()
	}))
	self:UpdateValue(arg_1_2)

	return
end

return IslandExchangeItemCard
