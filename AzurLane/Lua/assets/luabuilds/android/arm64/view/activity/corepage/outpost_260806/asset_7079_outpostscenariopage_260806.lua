class = var_0_10000

local var_0_0 = "OutPostScenarioPage_260806"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreScenarioTemplatePage"))

var_0_1.LINE_COLOR = {
	"939393",
	"31233f",
	"7a57f1"
}
var_0_1.TITLE_COLOR = {
	"ffffff",
	"ffffffff",
	"ffffffff"
}
var_0_1.TITLE_ALPHA = {
	0.5,
	1,
	1
}

function var_0_1.getUIName(arg_1_0)
	return "OutPostScenarioPage_260806"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0.top
	local var_2_1 = var_3.Find(var_2_0, "top/deco/Text")

	i18n = var_1_10004

	var_1(var_2_1, var_1_10004("260806_story_title"))

	setText = var_1

	local var_2_2 = arg_2_0.top
	local var_2_3 = var_3.Find(var_2_2, "top/deco/Text/Text_1")

	i18n = var_4

	var_1(var_2_3, var_4("260806_story_title_en"))

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

function var_0_1.RefreshNodeTitle(arg_4_0, arg_4_1, arg_4_2)
	setScrollText = var_1_10003

	var_1_10003(arg_4_1:Find("info/bk/title_form/title"), arg_4_2)

	setActive = var_1_10003

	var_1_10003(arg_4_1:Find("conditionBg"), false)

	return
end

function var_0_1.RefreshUnlockDesc(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	setScrollText = var_1_10004

	var_1_10004(arg_5_1:Find("info/bk/title_form/title"), arg_5_2)

	setActive = var_1_10004

	var_1_10004(arg_5_1:Find("conditionBg"), true)

	setScrollText = var_1_10004

	var_1_10004(arg_5_1:Find("conditionBg/Text"), arg_5_3)

	return
end

return var_0_1
