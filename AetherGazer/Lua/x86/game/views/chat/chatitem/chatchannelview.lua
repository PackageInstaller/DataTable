local var_0_0 = class("ChatChannelView", ChatBaseItemView)

function var_0_0.SetData(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.textTitle_.text = string.format(GetTips("ENTER_CHAT_CHANNEL"), GetI18NText(arg_1_1.content))
	arg_1_0.index_ = arg_1_2

	arg_1_0:Show(true)
end

return var_0_0
