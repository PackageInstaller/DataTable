class = var_0_10000

local var_0_0 = "OutPostCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function var_0_1.getUIName(arg_1_0)
	return "OutPostCoreActivityUI"
end

function var_0_1.ActiveScenarioLayer(arg_2_0, arg_2_1)
	arg_2_0.contextData.activeScenario = arg_2_1

	return
end

return var_0_1
