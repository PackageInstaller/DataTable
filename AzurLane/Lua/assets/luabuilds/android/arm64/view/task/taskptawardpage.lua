local var_0_0 = class("TaskPtAwardPage", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ActivitybonusWindow"
end

function var_0_0.Display(arg_2_0, arg_2_1)
	arg_2_0.window = arg_2_0.window or TaskPtAwardWindow.New(arg_2_0._tf, arg_2_0)

	arg_2_0.window:Show(arg_2_1)
	arg_2_0:Show()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	if arg_3_0.window then
		arg_3_0.window:Dispose()

		arg_3_0.window = nil
	end

	return
end

return var_0_0
