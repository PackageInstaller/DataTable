class = var_0_10000

local var_0_0 = "AgoraDecorationPreview"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandASynLoadSubView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandAgoraPreviewDecorationUI"
end

function var_0_1.OnInit(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_2.Find(var_2_0, "top/back")
	onButton = var_2

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.backBtn

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.Op(var_3_0, "GoBackLastExitPoint")

		return
	end

	SFX_CANCEL = var_1_10007

	var_2(var_2_1, var_2_2, var_2_3, var_1_10007)

	setText = var_2

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_4.Find(var_2_4, "top/title/Text")

	i18n = var_2_2

	var_2(var_2_5, var_2_2("island_agora_furniure_preview"))

	return
end

function var_0_1.Execute(arg_4_0, arg_4_1, ...)
	if not arg_4_0[arg_4_1] then
		return
	end

	var_0_1.super.Execute(arg_4_0, arg_4_1, ...)

	return
end

return var_0_1
