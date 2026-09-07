local SardiniaSPCoreActivityUI = class("SardiniaSPCoreActivityUI", import("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function SardiniaSPCoreActivityUI:getUIName()
	return "SardiniaSPCoreActivityUI"
end

function SardiniaSPCoreActivityUI:init(...)
	SardiniaSPCoreActivityUI.super.init(self, ...)
	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("SardiniaSPCoreActivityUI_title"))

	return
end

return SardiniaSPCoreActivityUI
