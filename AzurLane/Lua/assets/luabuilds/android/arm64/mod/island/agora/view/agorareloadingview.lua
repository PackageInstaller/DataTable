local var_0_0 = class("AgoraReloadingView", import("Mod.Island.Core.View.IslandASynLoadSubView"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandAgoraReloadingUI"
end

function var_0_0.FirstFlush(arg_2_0)
	setText(arg_2_0._tf:Find("label/Text"), i18n("island_agora_working"))

	return
end

return var_0_0
