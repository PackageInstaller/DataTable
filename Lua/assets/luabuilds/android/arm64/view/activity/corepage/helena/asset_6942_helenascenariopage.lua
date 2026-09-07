local HelenaScenarioPage = class("HelenaScenarioPage", import("view.activity.CorePage.CoreScenarioTemplatePage"))
local PoolPlural = import("Mgr/Pool/PoolPlural")

HelenaScenarioPage.LINE_COLOR = {
	"75828c",
	"23343f",
	"2bc5ff"
}

function HelenaScenarioPage:getUIName()
	return "HelenaScenarioPage"
end

function HelenaScenarioPage:OnInit()
	HelenaScenarioPage.super.OnInit(self)
	setText(self.top:Find("top/deco/Text"), i18n("HelenaPTPage_title"))
	setText(self.top:Find("top/deco/Text/Text_1"), i18n("HelenaPTPage_title2"))

	return
end

function HelenaScenarioPage:UpdateStory(arg_3_1)
	HelenaScenarioPage.super.UpdateStory(self, arg_3_1)
	setText(self.progressText, "<color=#27c5ff>" .. self.storyReadCount .. "</color><color=#c7c7c7>/" .. self.storyReadMax .. "</color>")

	return
end

return HelenaScenarioPage
