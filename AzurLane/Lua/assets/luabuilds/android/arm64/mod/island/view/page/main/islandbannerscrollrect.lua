class = var_0_10000

local var_0_0 = "IslandBannerScrollRect"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newMain.page.BannerScrollRect"))

function var_0_1.UpdateDotPosition(arg_1_0, arg_1_1, arg_1_2)
	return
end

function var_0_1.TriggerDot(arg_2_0, arg_2_1, arg_2_2)
	setActive = var_1_10003

	var_1_10003(arg_2_1:Find("unsel"), not arg_2_2)

	setActive = var_1_10003

	var_1_10003(arg_2_1:Find("sel"), arg_2_2)

	return
end

return var_0_1
