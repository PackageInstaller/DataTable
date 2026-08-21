local var_0_0 = class("ANTTFFScenarioPage", import("view.activity.CorePage.CoreScenarioTemplatePage"))
local var_0_1 = import("Mgr/Pool/PoolPlural")

var_0_0.LINE_COLOR = {
	"75828c",
	"23343f",
	"2bc5ff"
}

function var_0_0.getUIName(arg_1_0)
	return "ANTTFFScenarioPage"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	setText(arg_2_0.top:Find("top/deco/Text"), i18n("ANTTFFCoreActivityPtpage_title"))
	setText(arg_2_0.top:Find("top/deco/Text/Text_1"), i18n("ANTTFFCoreActivityPtpage_title2"))

	return
end

function var_0_0.UpdateStory(arg_3_0, arg_3_1)
	var_0_0.super.UpdateStory(arg_3_0, arg_3_1)
	setText(arg_3_0.progressText, "<color=#27c5ff>" .. arg_3_0.storyReadCount .. "</color><color=#c7c7c7>/" .. arg_3_0.storyReadMax .. "</color>")

	return
end

function var_0_0.Show(arg_4_0)
	setActive(arg_4_0._parentTf:Find("AD/headline/VX_logo"), false)
	var_0_0.super.Show(arg_4_0)

	return
end

function var_0_0.Hide(arg_5_0)
	setActive(arg_5_0._parentTf:Find("AD/headline/VX_logo"), true)
	var_0_0.super.Hide(arg_5_0)

	return
end

return var_0_0
