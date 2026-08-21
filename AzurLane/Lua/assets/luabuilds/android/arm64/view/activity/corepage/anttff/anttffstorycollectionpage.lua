local var_0_0 = class("ANTTFFStoryCollectionPage", import("view.activity.CorePage.Helena.HelenaPTPage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.scenario = ANTTFFScenarioPage.New(arg_1_0._tf, arg_1_0.event)

	arg_1_0.scenario:SetCoreStoryPage(arg_1_0)
	arg_1_0.scenario:RegisterView(arg_1_0.coreActivityUI)

	arg_1_0.loader = AutoLoader.New()
	arg_1_0.mapGroup = {}
	arg_1_0.currentBG = nil

	return
end

return var_0_0
