local IslandFriendRequestCard = class("IslandFriendRequestCard", import(".IslandFriendCard"))

function IslandFriendRequestCard:Ctor(arg_1_1)
	IslandFriendRequestCard.super.Ctor(self, arg_1_1)

	self.agreeBtn = arg_1_1.transform:Find("agree")
	self.refuseBtn = arg_1_1.transform:Find("refuse")

	setText(self.agreeBtn:Find("Text"), i18n("island_friend_agree"))
	setText(self.refuseBtn:Find("Text"), i18n("island_friend_refuse"))

	return
end

function IslandFriendRequestCard:Update(arg_2_1)
	IslandFriendRequestCard.super.Update(self, arg_2_1.player)

	self.descTxt.text = arg_2_1.content

	return
end

function IslandFriendRequestCard:UpdateOnline(arg_3_1)
	setActive(self.onlineTr, false)
	setActive(self.offlineTr, false)
	setActive(self.giftTr, false)

	return
end

return IslandFriendRequestCard
