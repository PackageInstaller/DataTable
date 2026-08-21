local var_0_0 = class("BlackFridayChargeCard", import(".ChargeCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.unlockBlock = arg_1_0.tr:Find("real_tpl/unlock_block")
	arg_1_0.unlockBlockLabel = arg_1_0.tr:Find("real_tpl/unlock_block/label/Text")

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	local var_2_1

	if arg_2_0:inTime(unlockTime) then
		setActive(arg_2_0.unlockBlock, false)
	else
		setActive(arg_2_0.unlockBlock, true)

		local var_2_0 = arg_2_1:getConfig("time")

		setText(arg_2_0.unlockBlockLabel, i18n("blackfriday_shop_tip", var_2_0[1][1][3], var_2_0[1][2][1]))

		var_2_1 = arg_2_0:inTime() and arg_2_1:isTip()
	end

	setActive(arg_2_0.focusTip, var_2_1)

	return
end

function var_0_0.inTime(arg_3_0)
	return pg.TimeMgr.GetInstance():inTime((arg_3_0.goods:getConfig("time")))
end

return var_0_0
