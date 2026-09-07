local IslandCardShowLabelCard = class("IslandCardShowLabelCard")

function IslandCardShowLabelCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.nameTF = self._tf:Find("name")
	self.valueTF = self._tf:Find("value")
	self.selectedTF = self._tf:Find("sel")
	self.unSelectedTF = self._tf:Find("unsel")

	setActive(self.selectedTF, false)
	setActive(self.unSelectedTF, true)

	return
end

function IslandCardShowLabelCard:Update(arg_2_1, arg_2_2)
	self.id = arg_2_1
	self.value = arg_2_2

	setText(self.nameTF, pg.island_card_label[self.id].name)
	setText(self.valueTF, arg_2_2)

	return
end

function IslandCardShowLabelCard:Dispose()
	return
end

return IslandCardShowLabelCard
