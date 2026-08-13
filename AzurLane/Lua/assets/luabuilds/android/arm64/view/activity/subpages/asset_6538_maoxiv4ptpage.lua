class = var_0_10000

local var_0_0 = "MaoxiV4PtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.battleBtn

	local function var_1_2()
		pg = var_2_10000

		local var_2_0 = var_2_10000.TipsMgr.GetInstance()
		local var_2_1 = var_0.ShowTips

		i18n = var_2_10003

		var_2_1(var_2_0, var_2_10003("challenge_end_tip"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

return var_0_1
