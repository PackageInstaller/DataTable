local FriendBlackListCard = class("FriendBlackListCard", import(".FriendCard"))

function FriendBlackListCard:Ctor(arg_1_1)
	FriendBlackListCard.super.Ctor(self, arg_1_1)

	self.btn = self.tf:Find("frame/occupy_btn")

	return
end

function FriendBlackListCard:update(arg_2_1)
	FriendBlackListCard.super.update(self, arg_2_1)

	return
end

return FriendBlackListCard
