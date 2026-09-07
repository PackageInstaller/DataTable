local IslandSignInInvitationCard = class("IslandSignInInvitationCard", import(".IslandBaseVisitorCard"))

function IslandSignInInvitationCard:Ctor(arg_1_1)
	IslandSignInInvitationCard.super.Ctor(self, arg_1_1)

	self.btn1 = arg_1_1.transform:Find("btn_1")
	self.btn1Txt = arg_1_1.transform:Find("btn_1/Text"):GetComponent(typeof(Text))
	self.online = arg_1_1.transform:Find("online")
	self.offline = arg_1_1.transform:Find("offline")

	setText(self.online:Find("Text"), i18n("island_btn_label_online"))

	self.offlineTxt = self.offline:Find("Text"):GetComponent(typeof(Text))

	return
end

function IslandSignInInvitationCard:Update(arg_2_1, arg_2_2)
	IslandSignInInvitationCard.super.Update(self, arg_2_1)

	self.btnTxt.text = i18n("island_btn_label_invitation")
	self.btn1Txt.text = i18n("island_btn_label_invitation_already")

	local var_2_0 = arg_2_1:isOnline()

	setActive(self.online, var_2_0)
	setActive(self.offline, not var_2_0)

	if not var_2_0 then
		self.offlineTxt.text = getOfflineTimeStamp(arg_2_1.preOnLineTime)
	end

	setActive(self.btn, not arg_2_2)
	setActive(self.btn1, arg_2_2)

	return
end

return IslandSignInInvitationCard
