class = var_0_10000

local var_0_0 = "BlackFridayChargeCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ChargeCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.tr

	arg_1_0.unlockBlock = var_2.Find(var_1_0, "real_tpl/unlock_block")

	local var_1_1 = arg_1_0.tr

	arg_1_0.unlockBlockLabel = var_2.Find(var_1_1, "real_tpl/unlock_block/label/Text")

	return
end

function var_0_1.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_1.super.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.inTime

	unlockTime = var_6

	if var_2_1(var_2_0, var_6) then
		setActive = var_4

		var_4(arg_2_0.unlockBlock, false)
	else
		setActive = var_4

		var_4(arg_2_0.unlockBlock, true)

		local var_2_2 = arg_2_1:getConfig("time")[1][1][3]
		local var_2_3 = var_4[1][2][1]

		setText = var_7

		local var_2_4 = arg_2_0.unlockBlockLabel

		i18n = var_1_10009

		var_7(var_2_4, var_1_10009("blackfriday_shop_tip", var_2_2, var_2_3))
	end

	setActive = var_4

	local var_2_5 = arg_2_0.focusTip
	local var_2_6

	if arg_2_0:inTime() then
		var_2_6 = arg_2_1:isTip()
	end

	var_4(var_2_5, var_2_6)

	return
end

function var_0_1.inTime(arg_3_0)
	local var_3_0 = arg_3_0.goods
	local var_3_1 = var_1.getConfig(var_3_0, "time")

	pg = var_3_0

	local var_3_2 = var_3_0.TimeMgr.GetInstance()

	return var_2.inTime(var_3_2, var_3_1)
end

return var_0_1
