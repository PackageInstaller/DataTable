local AprilFoolDiscovery2026UI = class("AprilFoolDiscovery2026UI", import("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function AprilFoolDiscovery2026UI:getUIName()
	return "AprilFoolDiscovery2026UI"
end

function AprilFoolDiscovery2026UI:init(...)
	AprilFoolDiscovery2026UI.super.init(self, ...)
	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("SardiniaSPCoreActivityUI_title"))

	return
end

return AprilFoolDiscovery2026UI
