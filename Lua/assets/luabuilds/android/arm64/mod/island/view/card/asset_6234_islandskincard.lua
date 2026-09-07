local IslandSkinCard = class("IslandSkinCard")

function IslandSkinCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tf = arg_1_1.transform
	self.selectGos = {
		self.tf:Find("select")
	}
	self.notGetTF = self.tf:Find("not_get")
	self.changeColorTF = self.tf:Find("changeColor")
	self.buyTF = self.notGetTF:Find("buy")

	return
end

function IslandSkinCard:Update(arg_2_1, arg_2_2)
	self.configId = arg_2_1

	setText(self.tf:Find("Text"), pg.island_skin_template[self.configId].name)

	if pg.island_skin_template[self.configId].icon ~= "" then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", pg.island_skin_template[self.configId].icon), "", self.tf:Find("icon"))
	end

	self:UpdateSelected(arg_2_2)

	return
end

function IslandSkinCard:UpdateSelected(arg_3_1)
	local var_3_0 = arg_3_1 == self.configId

	for iter_3_0, iter_3_1 in ipairs(self.selectGos) do
		setActive(iter_3_1, var_3_0)
	end

	return
end

function IslandSkinCard:Dispose()
	return
end

return IslandSkinCard
