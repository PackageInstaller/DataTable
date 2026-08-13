class = var_0_10000

local var_0_0 = "JapanV3SkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.dayTF

	setColorStr = var_1_10003

	var_1(var_1_0, var_1_10003(arg_1_0.nday, "#f7ecd9") .. "/" .. #arg_1_0.taskGroup)

	GetImageSpriteFromAtlasAsync = var_1

	local var_1_1 = "ui/activityuipage/japanv3skinpage_atlas"
	local var_1_2 = "bj_" .. arg_1_0.nday
	local var_1_3 = arg_1_0.bg

	var_1(var_1_1, var_1_2, var_4.Find(var_1_3, "painting"))

	return
end

function var_0_1.GetProgressColor(arg_2_0)
	return "#b37a4a"
end

return var_0_1
