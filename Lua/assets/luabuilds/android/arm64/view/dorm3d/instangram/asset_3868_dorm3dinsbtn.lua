local Dorm3dInsBtn = class("Dorm3dInsBtn")

function Dorm3dInsBtn:Ctor(arg_1_1)
	self.root = arg_1_1
	self.chat = self.root:Find("chat")
	self.phone = self.root:Find("phone")
	self.tip = self.root:Find("tip")

	return
end

function Dorm3dInsBtn:Flush()
	setActive(self.tip, self.ShouldTip())
	setActive(self.chat, not self.IsNewPhoneCall())
	setActive(self.phone, self.IsNewPhoneCall())

	return
end

function Dorm3dInsBtn.IsNewPhoneCall()
	return getProxy(Dorm3dInsProxy):AnyPhoneShouldTip()
end

function Dorm3dInsBtn.ShouldTip()
	local var_4_0 = getProxy(Dorm3dChatProxy):ShouldShowTip()

	var_4_0 = var_4_0 or getProxy(Dorm3dInsProxy):AllInstagramShouldTip()

	return var_4_0
end

return Dorm3dInsBtn
