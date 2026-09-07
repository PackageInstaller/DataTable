local IslandFoodCard = class("IslandFoodCard")

function IslandFoodCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.iconTF = self._tf:Find("bg/icon")
	self.barTF = self._tf:Find("bg/silder/bar")
	self.countTF = self._tf:Find("count/Text")
	self.eventTF = self._tf:Find("event")
	self.selectedTF = self._tf:Find("selected")

	return
end

function IslandFoodCard:Update(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.item = arg_2_1

	GetImageSpriteFromAtlasAsync("island/" .. self.item:GetIcon(), "", self.iconTF)
	self:UpdateSelectedCnt(arg_2_2)
	setActive(self.eventTF, arg_2_3)
	setFillAmount(self.barTF, arg_2_4)

	return
end

function IslandFoodCard:UpdateSelectedCnt(arg_3_1)
	setText(self.countTF, self.item:GetCount() - arg_3_1)
	setActive(self.selectedTF, arg_3_1 > 0)

	return
end

function IslandFoodCard:Dispose()
	return
end

return IslandFoodCard
