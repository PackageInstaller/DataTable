class = var_0_10000

local var_0_0 = "BlackFridayWithManualSignPage_2024"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BlackFridayWithManualSignPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	setActive = var_1

	var_1(arg_1_0.shopBtn, false)

	setText = var_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "AD/signMask/Image/Text")

	i18n = var_1_0

	var_1(var_1_1, var_1_0("challenge_end_tip"))

	return
end

function var_0_1.FlushSignBtn(arg_2_0)
	var_0_1.super.FlushSignBtn(arg_2_0)

	getProxy = var_1
	ActivityProxy = var_2

	local var_2_0 = var_1(var_2)
	local var_2_1, var_2_2

	if var_1.getActivityById(var_2_0, arg_2_0.signInActId) then
		var_2_1 = var_1
		var_2_2 = var_1.isEnd(var_2_1)

		if false then
			var_2_2 = false
		end
	else
		var_2_2 = true
	end

	setActive = var_2_1

	local var_2_3 = arg_2_0._tf

	var_2_1(var_4.Find(var_2_3, "AD/signMask"), var_2_2)

	return
end

return var_0_1
