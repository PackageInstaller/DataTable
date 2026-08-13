class = var_0_10000

local var_0_0 = "IslandBookNpcPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBookItemPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandBookNpcUI"
end

function var_0_1.GetIllustrationType(arg_2_0)
	IslandIllustration = var_1_10001

	return var_1_10001.TYPES.NPC
end

function var_0_1.GetHelpTip(arg_3_0)
	i18n = var_1_10001

	return var_1_10001("island_guide_help_npc")
end

function var_0_1.OnLoaded(arg_4_0)
	var_0_1.super.OnLoaded(arg_4_0)

	local var_4_0 = arg_4_0.rightTF

	arg_4_0.postNameTF = var_1.Find(var_4_0, "post/Text")

	return
end

function var_0_1.FlushRightPanel(arg_5_0)
	var_0_1.super.FlushRightPanel(arg_5_0)

	if not arg_5_0.showIllustration then
		return
	end

	local var_5_0 = arg_5_0.showIllustration
	local var_5_1 = var_1.getLinkConfig(var_5_0, "group")

	pg = var_5_0

	local var_5_2 = var_5_0.island_npc_hud[var_5_1].title

	setText = var_3

	var_3(arg_5_0.postNameTF, var_5_2)

	return
end

return var_0_1
