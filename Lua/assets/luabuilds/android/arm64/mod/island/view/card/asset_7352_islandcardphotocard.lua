local IslandCardPhotoCard = class("IslandCardPhotoCard")

function IslandCardPhotoCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.iconTF = self._tf:Find("icon")
	self.selectedTF = self._tf:Find("sel")
	self.selectedTagTF = self._tf:Find("sel_tag")
	self.unSelectedTF = self._tf:Find("unsel")

	return
end

function IslandCardPhotoCard:Update(arg_2_1, arg_2_2)
	self.id = arg_2_1

	LoadImageSpriteAsync(pg.island_card_diy[arg_2_1].resource, self.iconTF, true)
	self:UpdateSelected(arg_2_2)

	return
end

function IslandCardPhotoCard:UpdateSelected(arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1 == self.id

	setActive(self.selectedTF, arg_3_1 and arg_3_1 == self.id)
	setActive(self.selectedTagTF, var_3_0)
	setActive(self.unSelectedTF, not var_3_0)

	return
end

function IslandCardPhotoCard:Dispose()
	return
end

return IslandCardPhotoCard
