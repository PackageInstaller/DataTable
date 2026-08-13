class = var_0_10000

local var_0_0 = "NcPlayGuide"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.GetStringArg(var_1_0, "guide")

	pg = var_1_0

	local var_1_2 = var_1_0.NewGuideMgr.GetInstance()

	var_2.Play(var_1_2, var_1_1, {}, function()
		local var_2_0 = arg_1_0

		var_0.EndAction(var_2_0)

		return
	end, nil)

	return
end

return var_0_1
