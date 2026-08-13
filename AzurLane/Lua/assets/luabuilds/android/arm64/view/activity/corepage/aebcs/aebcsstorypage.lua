class = var_0_10000

local var_0_0 = "AEBCSStoryPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreStoryTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	setActive = var_1

	local var_1_0 = arg_1_0.goBtn
	local var_1_1 = var_3.Find(var_1_0, "tip")

	PlayerPrefs = var_1_10004

	var_1(var_1_1, var_1_10004.GetInt("AEBCSStoryReminder", 0) == 0)

	return
end

function var_0_1.IsShowReminder(arg_2_0)
	PlayerPrefs = var_1_10001

	return var_1_10001.GetInt("AEBCSStoryReminder", 0) == 0
end

function var_0_1.ShowScenarioLayer(arg_3_0, arg_3_1)
	var_0_1.super.ShowScenarioLayer(arg_3_0, arg_3_1)

	if arg_3_1 then
		PlayerPrefs = var_2

		var_2.SetInt("AEBCSStoryReminder", 1)
	end

	return
end

return var_0_1
