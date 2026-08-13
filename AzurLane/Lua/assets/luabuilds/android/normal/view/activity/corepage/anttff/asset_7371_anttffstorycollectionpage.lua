class = var_0_10000

local var_0_0 = "ANTTFFStoryCollectionPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.Helena.HelenaPTPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	ANTTFFScenarioPage = var_1
	arg_1_0.scenario = var_1.New(arg_1_0._tf, arg_1_0.event)

	local var_1_0 = arg_1_0.scenario

	var_1.SetCoreStoryPage(var_1_0, arg_1_0)

	local var_1_1 = arg_1_0.scenario

	var_1.RegisterView(var_1_1, arg_1_0.coreActivityUI)

	AutoLoader = var_1
	arg_1_0.loader = var_1.New()
	arg_1_0.mapGroup = {}
	arg_1_0.currentBG = nil

	return
end

return var_0_1
