class = var_0_10000

local var_0_0 = "NcPlayGuide"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetStringArg("guide")

	pg = var_1_10002

	local var_1_1 = var_1_10002.NewGuideMgr.GetInstance()

	var_2.Play(var_1_1, var_1_0, {}, function()
		local var_2_0 = arg_1_0

		var_0.EndAction(var_2_0)

		return
	end, nil)

	return
end

return var_0_1
