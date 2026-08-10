local var_0_0 = class("ChatTimeView", ChatBaseItemView)

function var_0_0.IsTimeBar(arg_1_0)
	return true
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.textTimeStamp_.text = manager.time:FormatTime(arg_2_1.timestamp)
	arg_2_0.index_ = arg_2_2

	arg_2_0:Show(true)
end

return var_0_0
