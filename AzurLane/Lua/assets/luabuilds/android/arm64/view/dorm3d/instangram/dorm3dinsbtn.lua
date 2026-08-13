class = var_0_10000

local var_0_0 = var_0_10000("Dorm3dInsBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.root = arg_1_1

	local var_1_0 = arg_1_0.root

	arg_1_0.chat = var_2.Find(var_1_0, "chat")

	local var_1_1 = arg_1_0.root

	arg_1_0.phone = var_2.Find(var_1_1, "phone")

	local var_1_2 = arg_1_0.root

	arg_1_0.tip = var_2.Find(var_1_2, "tip")

	return
end

function var_0_0.Flush(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0.tip, arg_2_0.ShouldTip())

	setActive = var_1_10001

	var_1_10001(arg_2_0.chat, not arg_2_0.IsNewPhoneCall())

	setActive = var_1_10001

	var_1_10001(arg_2_0.phone, arg_2_0.IsNewPhoneCall())

	return
end

function var_0_0.IsNewPhoneCall()
	getProxy = var_1_10000
	Dorm3dInsProxy = var_1_10002

	local var_3_0 = var_1_10000(var_1_10002)

	return var_0.AnyPhoneShouldTip(var_3_0)
end

function var_0_0.ShouldTip()
	getProxy = var_1_10000
	Dorm3dChatProxy = var_1_10002

	local var_4_0 = var_1_10000(var_1_10002)
	local var_4_2

	if not var_0.ShouldShowTip(var_4_0) then
		getProxy = var_4_2
		Dorm3dInsProxy = var_4_0

		local var_4_1 = var_4_2(var_4_0)

		var_4_2 = var_4_2.AllInstagramShouldTip(var_4_1)
	end

	return var_4_2
end

return var_0_0
