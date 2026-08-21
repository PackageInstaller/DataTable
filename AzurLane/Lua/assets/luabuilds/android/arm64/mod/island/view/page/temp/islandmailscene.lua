local var_0_0 = class("IslandMailScene", import("view.main.Mail.MailScene"))

function var_0_0.didEnter(arg_1_0)
	var_0_0.super.didEnter(arg_1_0)
	onNextTick(function()
		arg_1_0:ExtraHandle()

		return
	end)

	return
end

function var_0_0.ExtraHandle(arg_3_0)
	setActive(arg_3_0._tf:Find("adapt/top/res"), false)
	setActive(arg_3_0._tf:Find("adapt/top/option"), false)
	setActive(arg_3_0._tf:Find("adapt/left_length/frame/tagRoot/store"), false)
	setActive(arg_3_0._tf:Find("adapt/left_length/frame/tagRoot/collection"), false)

	return
end

function var_0_0.closeView(arg_4_0)
	arg_4_0.contextData.onClose()

	return
end

function var_0_0.onBackPressed(arg_5_0)
	return
end

return var_0_0
