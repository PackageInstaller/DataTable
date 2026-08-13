class = var_0_10000

local var_0_0 = "BossRushDALFleetSelectView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BossRushFleetSelectView"))

function var_0_1.getUIName(arg_1_0)
	return "BossRushFleetSelectUIDALCollab"
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "Panel/Info/Start/text")

	i18n = var_2_0

	var_1(var_2_1, var_2_0("dal_chapter_goto"))

	return
end

return var_0_1
