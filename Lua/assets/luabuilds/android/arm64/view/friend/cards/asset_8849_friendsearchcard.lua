local FriendSearchCard = class("FriendSearchCard", import(".FriendCard"))

function FriendSearchCard:Ctor(arg_1_1)
	FriendSearchCard.super.Ctor(self, arg_1_1)

	self.addBtn = self.tf:Find("frame/add_btn")
	self.levelTF = self.tf:Find("frame/request_info/lv_bg/Text"):GetComponent(typeof(Text))

	return
end

function FriendSearchCard:update(arg_2_1)
	FriendSearchCard.super.update(self, arg_2_1)

	self.manifestoTF.text = arg_2_1:GetManifesto()
	self.levelTF.text = "Lv." .. arg_2_1.level

	return
end

return FriendSearchCard
