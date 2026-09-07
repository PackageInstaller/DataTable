local IslandBlackWhitListCard = class("IslandBlackWhitListCard", import(".IslandFriendCard"))

function IslandBlackWhitListCard:Ctor(arg_1_1)
	IslandBlackWhitListCard.super.Ctor(self, arg_1_1)

	self.removeBtn = arg_1_1.transform:Find("remove")

	setText(self.removeBtn:Find("Text"), i18n("island_btn_label_remove"))

	return
end

return IslandBlackWhitListCard
