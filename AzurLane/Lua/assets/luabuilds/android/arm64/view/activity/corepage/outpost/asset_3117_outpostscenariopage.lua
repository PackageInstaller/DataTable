class = var_0_10000

local var_0_0 = "OutPostScenarioPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreScenarioTemplatePage"))

var_0_1.LINE_COLOR = {
	"29374080",
	"293740",
	"ffffff"
}
var_0_1.TITLE_COLOR = {
	"586169",
	"2a343c",
	"5f4c36"
}
var_0_1.TITLE_ALPHA = {
	1,
	1,
	1
}

function var_0_1.getUIName(arg_1_0)
	return "OutPostScenarioPage"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0.top
	local var_2_1 = var_3.Find(var_2_0, "top/deco/Text")

	i18n = var_1_10004

	var_1(var_2_1, var_1_10004("260514_story_title"))

	setText = var_1

	local var_2_2 = arg_2_0.top
	local var_2_3 = var_3.Find(var_2_2, "top/deco/Text/Text_1")

	i18n = var_4

	var_1(var_2_3, var_4("260514_story_title_en"))

	return
end

function var_0_1.UpdateStory(arg_3_0, arg_3_1)
	var_0_1.super.UpdateStory(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0.storyReadCount
	local var_3_1 = arg_3_0.storyReadMax
	local var_3_2 = "<color=#ffffff>" .. var_3_0 .. "</color><color=#27353e>/" .. var_3_1 .. "</color>"

	setText = var_5

	var_5(arg_3_0.progressText, var_3_2)

	return
end

return var_0_1
