local OutPostScenarioPage = class("OutPostScenarioPage", import("view.activity.CorePage.CoreScenarioTemplatePage"))

OutPostScenarioPage.LINE_COLOR = {
	"29374080",
	"293740",
	"ffffff"
}
OutPostScenarioPage.TITLE_COLOR = {
	"586169",
	"2a343c",
	"5f4c36"
}
OutPostScenarioPage.TITLE_ALPHA = {
	1,
	1,
	1
}

function OutPostScenarioPage:getUIName()
	return "OutPostScenarioPage"
end

function OutPostScenarioPage:OnInit()
	OutPostScenarioPage.super.OnInit(self)
	setText(self.top:Find("top/deco/Text"), i18n("260514_story_title"))
	setText(self.top:Find("top/deco/Text/Text_1"), i18n("260514_story_title_en"))

	return
end

function OutPostScenarioPage:UpdateStory(arg_3_1)
	OutPostScenarioPage.super.UpdateStory(self, arg_3_1)
	setText(self.progressText, "<color=#ffffff>" .. self.storyReadCount .. "</color><color=#27353e>/" .. self.storyReadMax .. "</color>")

	return
end

return OutPostScenarioPage
