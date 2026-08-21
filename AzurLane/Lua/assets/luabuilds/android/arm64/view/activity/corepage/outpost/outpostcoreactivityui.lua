local var_0_0 = class("OutPostCoreActivityUI", import("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function var_0_0.getUIName(arg_1_0)
	return "OutPostCoreActivityUI"
end

function var_0_0.ActiveScenarioLayer(arg_2_0, arg_2_1)
	arg_2_0.contextData.activeScenario = arg_2_1

	return
end

return var_0_0
