local FriendListCard = class("FriendListCard", import(".FriendCard"))

function FriendListCard:Ctor(arg_1_1)
	FriendListCard.super.Ctor(self, arg_1_1)

	self.occuptBtn = self.tf:Find("frame/btns/occupy_btn")
	self.deleteBtn = self.tf:Find("frame/btns/delete_btn")
	self.backYardBtn = self.tf:Find("frame/btns/backyard_btn")
	self.chatTip = self.tf:Find("frame/btns/occupy_btn/tip")
	self.date = self.tf:Find("frame/request_info/date"):GetComponent(typeof(Text))
	self.online = self.tf:Find("frame/request_info/online")
	self.levelTF = self.tf:Find("frame/request_info/lv_bg/Text"):GetComponent(typeof(Text))

	return
end

function FriendListCard:update(arg_2_1)
	FriendListCard.super.update(self, arg_2_1)
	setActive(self.chatTip, arg_2_1.unreadCount > 0)

	self.manifestoTF.text = arg_2_1:GetManifesto()

	setActive(self.online, arg_2_1.online == Friend.ONLINE)
	setActive(self.date.gameObject, arg_2_1.online ~= Friend.ONLINE)

	if arg_2_1.online ~= Friend.ONLINE then
		self.date.text = getOfflineTimeStamp(arg_2_1.preOnLineTime)
	end

	self.levelTF.text = "Lv." .. arg_2_1.level

	return
end

return FriendListCard
