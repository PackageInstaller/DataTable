class = var_0_10000

local var_0_0 = "NcClickObject"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	function var_0_1.Click(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.EndAction(var_2_0)

		return
	end

	arg_1_0:GetRouter().onMouseDown = arg_1_0:GetRouter().onMouseDown + var_0_1.Click

	return
end

function var_0_1.OnStop(arg_3_0)
	if var_0_1.Click then
		arg_3_0:GetRouter().onMouseDown = arg_3_0:GetRouter().onMouseDown - var_0_1.Click
		var_0_1.Click = nil
	end

	return
end

return var_0_1
