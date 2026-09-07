local MoscowURCoreActivityUI = class("MoscowURCoreActivityUI", import("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function MoscowURCoreActivityUI:getUIName()
	return "MoscowURCoreActivityUI"
end

function MoscowURCoreActivityUI:init(...)
	MoscowURCoreActivityUI.super.init(self, ...)

	self.topPage = self._tf:Find("adapt/TopPage")

	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("HelenaCoreActivity_title"))
	setText(self._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("HelenaCoreActivity_title2"))

	return
end

function MoscowURCoreActivityUI:verifyTabs(arg_3_1)
	if self.activities[self:getActivityIndex(arg_3_1) or self:getActivityIndex(self:GetActiveActivity()) or 1] == nil then
		return
	end

	triggerToggle(self.tabs:Find(tostring((self.activities[self:getActivityIndex(arg_3_1) or self:getActivityIndex(self:GetActiveActivity()) or 1]:getConfig("is_show")))), true)

	return
end

function MoscowURCoreActivityUI:OnAnimations(arg_4_1, arg_4_2)
	SetActive(self._tf:Find("adapt/decorate"), id == 50261 or id == 0)

	return
end

function MoscowURCoreActivityUI:OnToggleName(arg_5_1, arg_5_2)
	setText(arg_5_1:Find("name"), i18n(arg_5_2:getConfig("title_res_tag")))

	return
end

function MoscowURCoreActivityUI:willExit()
	MoscowURCoreActivityUI.super.willExit(self)

	return
end

return MoscowURCoreActivityUI
