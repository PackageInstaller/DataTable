local IslandCardAchvCard = class("IslandCardAchvCard")

function IslandCardAchvCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.nameTF = self._tf:Find("name")
	self.iconTF = self._tf:Find("icon")
	self.selectedTF = self._tf:Find("sel")
	self.unSelectedTF = self._tf:Find("unsel")

	return
end

function IslandCardAchvCard:Update(arg_2_1, arg_2_2)
	self.id = arg_2_1

	setText(self.nameTF, pg.island_achievement[arg_2_1].name)
	GetImageSpriteFromAtlasAsync("islandachievement", "achv_stage_" .. pg.island_achievement[arg_2_1].stage, self.iconTF, true)
	self:UpdateSelected(arg_2_2)

	return
end

function IslandCardAchvCard:UpdateSelected(arg_3_1)
	local var_3_0 = table.contains(arg_3_1, self.id)

	setActive(self.selectedTF, var_3_0)
	setActive(self.unSelectedTF, not var_3_0)

	return
end

function IslandCardAchvCard:Dispose()
	return
end

return IslandCardAchvCard
