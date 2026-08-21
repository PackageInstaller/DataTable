local var_0_0 = class("Dorm3dInsBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.root = arg_1_1
	arg_1_0.chat = arg_1_0.root:Find("chat")
	arg_1_0.phone = arg_1_0.root:Find("phone")
	arg_1_0.tip = arg_1_0.root:Find("tip")

	return
end

function var_0_0.Flush(arg_2_0)
	setActive(arg_2_0.tip, arg_2_0.ShouldTip())
	setActive(arg_2_0.chat, not arg_2_0.IsNewPhoneCall())
	setActive(arg_2_0.phone, arg_2_0.IsNewPhoneCall())

	return
end

function var_0_0.IsNewPhoneCall()
	return getProxy(Dorm3dInsProxy):AnyPhoneShouldTip()
end

function var_0_0.ShouldTip()
	local var_4_0 = getProxy(Dorm3dChatProxy):ShouldShowTip()

	var_4_0 = var_4_0 or getProxy(Dorm3dInsProxy):AllInstagramShouldTip()

	return var_4_0
end

return var_0_0
