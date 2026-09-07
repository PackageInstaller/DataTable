local FriendRequestCard = class("FriendRequestCard", import(".FriendCard"))

function FriendRequestCard:Ctor(arg_1_1)
	FriendRequestCard.super.Ctor(self, arg_1_1)

	self.acceptBtn = self.tf:Find("frame/accpet_btn")
	self.refuseBtn = self.tf:Find("frame/refuse_btn")
	self.reportBtn = self.tf:Find("frame/report_btn")
	self.date = self.tf:Find("frame/request_info/date/Text"):GetComponent(typeof(Text))
	self.levelTF = self.tf:Find("frame/request_info/lv_bg/Text"):GetComponent(typeof(Text))

	return
end

function FriendRequestCard:update(arg_2_1, arg_2_2, arg_2_3)
	FriendRequestCard.super.update(self, arg_2_1)

	self.manifestoTF.text = arg_2_3
	self.date.text = pg.TimeMgr.GetInstance():STimeDescS(arg_2_2)
	self.levelTF.text = "Lv." .. arg_2_1.level

	return
end

return FriendRequestCard
