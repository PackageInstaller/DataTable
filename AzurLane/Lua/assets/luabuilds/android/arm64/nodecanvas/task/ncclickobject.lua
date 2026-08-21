local var_0_0 = class("NcClickObject", import("..base.NodeCanvasBaseTask"))

function var_0_0.OnExecute(arg_1_0)
	function var_0_0.Click(arg_2_0)
		arg_1_0:EndAction()

		return
	end

	arg_1_0:GetRouter().onMouseDown = arg_1_0:GetRouter().onMouseDown + var_0_0.Click

	return
end

function var_0_0.OnStop(arg_3_0)
	if var_0_0.Click then
		arg_3_0:GetRouter().onMouseDown = arg_3_0:GetRouter().onMouseDown - var_0_0.Click
		var_0_0.Click = nil
	end

	return
end

return var_0_0
