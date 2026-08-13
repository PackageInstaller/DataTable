class = var_0_10000

local var_0_0 = "ZProjectPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.awardTF = var_1.Find(var_1_0, "AD/award")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client").drop

	updateDrop = var_1_10002

	var_1_10002(arg_2_0.awardTF, var_2_1)

	onButton = var_1_10002

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.awardTF

	local function var_2_4()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		BaseUI = var_2_10003

		var_3_1(var_3_0, var_2_10003.ON_DROP, var_2_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_2_2, var_2_3, var_2_4, var_1_10007)

	return
end

return var_0_1
