local IslandDressCard = class("IslandDressCard")

function IslandDressCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tf = arg_1_1.transform
	self.selectGos = {
		self.tf:Find("select")
	}
	self.canSendTF = self.tf:Find("canSend")
	self.ownNumTF = self.tf:Find("icon/count_bg")
	self.ownNumText = self.ownNumTF:Find("count")
	self.redDot = self.tf:Find("red_dot")
	self.shipHoldTF = self.tf:Find("shipHold")
	self.shipIcon = self.shipHoldTF:Find("ship_icon")
	self.exclusionTF = self.tf:Find("exclusion_item")

	return
end

local var_0_1 = {
	"white",
	"blue",
	"purple",
	"golden"
}

function IslandDressCard:Update(arg_2_1, arg_2_2)
	self.configId = arg_2_1
	self.configType = pg.island_dress_template[arg_2_1].type

	setScrollText(self.tf:Find("textMask/Text"), pg.island_dress_template[arg_2_1].name)

	if pg.island_dress_template[arg_2_1].icon ~= "" then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", pg.island_dress_template[arg_2_1].icon), "", self.tf:Find("icon"))
	end

	if pg.island_dress_template[arg_2_1].quality ~= 0 then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", var_0_1[pg.island_dress_template[arg_2_1].quality]), "", self.tf:Find("frame"))
	end

	self:UpdateSelected(arg_2_2)

	return
end

function IslandDressCard:UpdateSelected(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.selectGos) do
		setActive(iter_3_1, arg_3_1)
	end

	return
end

function IslandDressCard:Dispose()
	return
end

return IslandDressCard
