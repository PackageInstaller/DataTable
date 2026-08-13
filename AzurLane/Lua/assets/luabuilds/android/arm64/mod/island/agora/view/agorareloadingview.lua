class = var_0_10000

local var_0_0 = "AgoraReloadingView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandASynLoadSubView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandAgoraReloadingUI"
end

function var_0_1.FirstFlush(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "label/Text")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("island_agora_working"))

	return
end

return var_0_1
