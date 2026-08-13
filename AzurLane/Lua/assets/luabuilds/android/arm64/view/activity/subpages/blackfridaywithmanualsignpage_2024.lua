class = var_0_10000

local var_0_0 = "BlackFridayWithManualSignPage_2024"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BlackFridayWithManualSignPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	setActive = var_1

	var_1(arg_1_0.shopBtn, false)

	setText = var_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "AD/signMask/Image/Text")

	i18n = var_4

	var_1(var_1_1, var_4("challenge_end_tip"))

	return
end

function var_0_1.FlushSignBtn(arg_2_0)
	var_0_1.super.FlushSignBtn(arg_2_0)

	getProxy = var_1
	ActivityProxy = var_3

	local var_2_0 = var_1(var_3)
	local var_2_1 = not var_1.getActivityById(var_2_0, arg_2_0.signInActId) or var_1:isEnd()

	setActive = var_2_0

	local var_2_2 = arg_2_0._tf

	var_2_0(var_5.Find(var_2_2, "AD/signMask"), var_2_1)

	return
end

return var_0_1
