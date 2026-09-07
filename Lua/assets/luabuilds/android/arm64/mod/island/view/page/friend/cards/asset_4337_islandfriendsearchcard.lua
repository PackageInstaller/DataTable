local IslandFriendSearchCard = class("IslandFriendSearchCard", import(".IslandFriendCard"))

function IslandFriendSearchCard:Ctor(arg_1_1)
	IslandFriendSearchCard.super.Ctor(self, arg_1_1)

	self.addBtn = arg_1_1.transform:Find("add")

	setText(self.addBtn:Find("Text"), i18n("island_add_friend"))

	return
end

function IslandFriendSearchCard:Update(arg_2_1)
	IslandFriendSearchCard.super.Update(self, arg_2_1)

	local var_2_0 = getProxy(FriendProxy):isFriend(arg_2_1.id)

	setActive(self.addBtn, not var_2_0)
	setActive(self.visitBtn, var_2_0)

	return
end

return IslandFriendSearchCard
