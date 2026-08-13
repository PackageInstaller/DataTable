class = var_0_10000

local var_0_0 = "HelenaScenarioPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreScenarioTemplatePage"))

import = var_0_0

local var_0_2 = var_0_0("Mgr/Pool/PoolPlural")

var_0_1.LINE_COLOR = {
	"75828c",
	"23343f",
	"2bc5ff"
}

function var_0_1.getUIName(arg_1_0)
	return "HelenaScenarioPage"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0.top
	local var_2_1 = var_2.Find(var_2_0, "top/deco/Text")

	i18n = var_2_0

	var_1(var_2_1, var_2_0("HelenaPTPage_title"))

	setText = var_1

	local var_2_2 = arg_2_0.top
	local var_2_3 = var_2.Find(var_2_2, "top/deco/Text/Text_1")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("HelenaPTPage_title2"))

	return
end

function var_0_1.UpdateStory(arg_3_0, arg_3_1)
	var_0_1.super.UpdateStory(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0.storyReadCount
	local var_3_1 = arg_3_0.storyReadMax
	local var_3_2 = "<color=#27c5ff>" .. var_3_0 .. "</color><color=#c7c7c7>/" .. var_3_1 .. "</color>"

	setText = var_5

	var_5(arg_3_0.progressText, var_3_2)

	return
end

return var_0_1
