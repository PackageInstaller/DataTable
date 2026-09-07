local YunLongSPCoreActivityUI = class("YunLongSPCoreActivityUI", import("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function YunLongSPCoreActivityUI:getUIName()
	return "YunLongSPCoreActivityUI"
end

function YunLongSPCoreActivityUI:init(...)
	YunLongSPCoreActivityUI.super.init(self, ...)
	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("SardiniaSPCoreActivityUI_title"))

	return
end

return YunLongSPCoreActivityUI
