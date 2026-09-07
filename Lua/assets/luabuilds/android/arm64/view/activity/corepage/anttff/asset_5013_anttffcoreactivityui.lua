local ANTTFFCoreActivityUI = class("ANTTFFCoreActivityUI", import("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function ANTTFFCoreActivityUI:getUIName()
	return "ANTTFFCoreActivityUI"
end

function ANTTFFCoreActivityUI:init(...)
	ANTTFFCoreActivityUI.super.init(self, ...)
	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("ANTTFFCoreActivity_title"))
	setText(self._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("ANTTFFCoreActivity_title2"))

	return
end

function ANTTFFCoreActivityUI:OnToggleName(arg_3_1, arg_3_2)
	setText(arg_3_1:Find("on/name"), i18n(arg_3_2:getConfig("title_res_tag")))
	setText(arg_3_1:Find("name"), i18n(arg_3_2:getConfig("title_res_tag")))

	return
end

function ANTTFFCoreActivityUI:OnAnimations(arg_4_1, arg_4_2)
	return
end

return ANTTFFCoreActivityUI
