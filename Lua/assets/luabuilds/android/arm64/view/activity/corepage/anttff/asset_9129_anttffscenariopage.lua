local ANTTFFScenarioPage = class("ANTTFFScenarioPage", import("view.activity.CorePage.CoreScenarioTemplatePage"))
local PoolPlural = import("Mgr/Pool/PoolPlural")

ANTTFFScenarioPage.LINE_COLOR = {
	"75828c",
	"23343f",
	"2bc5ff"
}

function ANTTFFScenarioPage:getUIName()
	return "ANTTFFScenarioPage"
end

function ANTTFFScenarioPage:OnInit()
	ANTTFFScenarioPage.super.OnInit(self)
	setText(self.top:Find("top/deco/Text"), i18n("ANTTFFCoreActivityPtpage_title"))
	setText(self.top:Find("top/deco/Text/Text_1"), i18n("ANTTFFCoreActivityPtpage_title2"))

	return
end

function ANTTFFScenarioPage:UpdateStory(arg_3_1)
	ANTTFFScenarioPage.super.UpdateStory(self, arg_3_1)
	setText(self.progressText, "<color=#27c5ff>" .. self.storyReadCount .. "</color><color=#c7c7c7>/" .. self.storyReadMax .. "</color>")

	return
end

function ANTTFFScenarioPage:Show()
	setActive(self._parentTf:Find("AD/headline/VX_logo"), false)
	ANTTFFScenarioPage.super.Show(self)

	return
end

function ANTTFFScenarioPage:Hide()
	setActive(self._parentTf:Find("AD/headline/VX_logo"), true)
	ANTTFFScenarioPage.super.Hide(self)

	return
end

return ANTTFFScenarioPage
