local var_0_0 = class("AEBCSStoryPage", import("view.activity.CorePage.CoreStoryTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)
	setActive(arg_1_0.goBtn:Find("tip"), PlayerPrefs.GetInt("AEBCSStoryReminder", 0) == 0)

	return
end

function var_0_0.IsShowReminder(arg_2_0)
	return PlayerPrefs.GetInt("AEBCSStoryReminder", 0) == 0
end

function var_0_0.ShowScenarioLayer(arg_3_0, arg_3_1)
	var_0_0.super.ShowScenarioLayer(arg_3_0, arg_3_1)

	if arg_3_1 then
		PlayerPrefs.SetInt("AEBCSStoryReminder", 1)
	end

	return
end

return var_0_0
