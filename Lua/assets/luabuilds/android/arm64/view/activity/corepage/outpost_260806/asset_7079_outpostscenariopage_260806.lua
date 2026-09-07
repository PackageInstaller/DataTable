local OutPostScenarioPage_260806 = class("OutPostScenarioPage_260806", import("view.activity.CorePage.CoreScenarioTemplatePage"))

OutPostScenarioPage_260806.LINE_COLOR = {
	"939393",
	"31233f",
	"7a57f1"
}
OutPostScenarioPage_260806.TITLE_COLOR = {
	"ffffff",
	"ffffffff",
	"ffffffff"
}
OutPostScenarioPage_260806.TITLE_ALPHA = {
	0.5,
	1,
	1
}

function OutPostScenarioPage_260806:getUIName()
	return "OutPostScenarioPage_260806"
end

function OutPostScenarioPage_260806:OnInit()
	OutPostScenarioPage_260806.super.OnInit(self)
	setText(self.top:Find("top/deco/Text"), i18n("260806_story_title"))
	setText(self.top:Find("top/deco/Text/Text_1"), i18n("260806_story_title_en"))

	return
end

function OutPostScenarioPage_260806:UpdateStory(arg_3_1)
	OutPostScenarioPage_260806.super.UpdateStory(self, arg_3_1)
	setText(self.progressText, "<color=#27c5ff>" .. self.storyReadCount .. "</color><color=#c7c7c7>/" .. self.storyReadMax .. "</color>")

	return
end

function OutPostScenarioPage_260806:RefreshNodeTitle(arg_4_1, arg_4_2)
	setScrollText(arg_4_1:Find("info/bk/title_form/title"), arg_4_2)
	setActive(arg_4_1:Find("conditionBg"), false)

	return
end

function OutPostScenarioPage_260806:RefreshUnlockDesc(arg_5_1, arg_5_2, arg_5_3)
	setScrollText(arg_5_1:Find("info/bk/title_form/title"), arg_5_2)
	setActive(arg_5_1:Find("conditionBg"), true)
	setScrollText(arg_5_1:Find("conditionBg/Text"), arg_5_3)

	return
end

return OutPostScenarioPage_260806
