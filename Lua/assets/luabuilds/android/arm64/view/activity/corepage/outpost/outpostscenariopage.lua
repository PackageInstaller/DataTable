local var_0_0 = class("OutPostScenarioPage", import("view.activity.CorePage.CoreScenarioTemplatePage"))

var_0_0.LINE_COLOR = {
	"29374080",
	"293740",
	"ffffff"
}
var_0_0.TITLE_COLOR = {
	"586169",
	"2a343c",
	"5f4c36"
}
var_0_0.TITLE_ALPHA = {
	1,
	1,
	1
}

function var_0_0.getUIName(arg_1_0)
	return "OutPostScenarioPage"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	setText(arg_2_0.top:Find("top/deco/Text"), i18n("260514_story_title"))
	setText(arg_2_0.top:Find("top/deco/Text/Text_1"), i18n("260514_story_title_en"))

	return
end

function var_0_0.UpdateStory(arg_3_0, arg_3_1)
	var_0_0.super.UpdateStory(arg_3_0, arg_3_1)
	setText(arg_3_0.progressText, "<color=#ffffff>" .. arg_3_0.storyReadCount .. "</color><color=#27353e>/" .. arg_3_0.storyReadMax .. "</color>")

	return
end

return var_0_0
