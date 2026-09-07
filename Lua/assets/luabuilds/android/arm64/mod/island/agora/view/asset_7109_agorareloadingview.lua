local AgoraReloadingView = class("AgoraReloadingView", import("Mod.Island.Core.View.IslandASynLoadSubView"))

function AgoraReloadingView:GetUIName()
	return "IslandAgoraReloadingUI"
end

function AgoraReloadingView:FirstFlush()
	setText(self._tf:Find("label/Text"), i18n("island_agora_working"))

	return
end

return AgoraReloadingView
