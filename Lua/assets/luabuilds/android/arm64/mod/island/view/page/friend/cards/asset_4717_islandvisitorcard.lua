local IslandVisitorCard = class("IslandVisitorCard", import(".IslandBaseVisitorCard"))

function IslandVisitorCard:Ctor(arg_1_1)
	IslandVisitorCard.super.Ctor(self, arg_1_1)

	self.localtionTxt = arg_1_1.transform:Find("localtion/Text"):GetComponent(typeof(Text))
	self.btnTxt.text = i18n("island_btn_label_kick")

	return
end

function IslandVisitorCard:Update(arg_2_1)
	IslandVisitorCard.super.Update(self, arg_2_1)

	self.localtionTxt.text = i18n("island_btn_label_location", arg_2_1:GetLoaction())

	return
end

return IslandVisitorCard
