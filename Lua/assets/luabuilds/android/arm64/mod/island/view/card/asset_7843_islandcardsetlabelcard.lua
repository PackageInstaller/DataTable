local IslandCardSetLabelCard = class("IslandCardSetLabelCard")

function IslandCardSetLabelCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.nameTF = self._tf:Find("name")
	self.valueTF = self._tf:Find("value")
	self.selectedTF = self._tf:Find("sel")
	self.unSelectedTF = self._tf:Find("unsel")

	return
end

function IslandCardSetLabelCard:Update(arg_2_1, arg_2_2, arg_2_3)
	self.id = arg_2_1
	self.value = arg_2_2

	setText(self.nameTF, pg.island_card_label[self.id].name)
	setText(self.valueTF, arg_2_2)
	self:UpdateSelected(arg_2_3)

	return
end

function IslandCardSetLabelCard:UpdateSelected(arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1 == self.id

	setActive(self.selectedTF, arg_3_1 and arg_3_1 == self.id)
	setActive(self.unSelectedTF, not var_3_0)

	return
end

function IslandCardSetLabelCard:Dispose()
	return
end

return IslandCardSetLabelCard
