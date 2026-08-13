class = var_0_10000

local var_0_0 = "NavTacticsDockyardShipItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.ship.DockyardShipItem"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	findTF = var_4
	arg_1_0.empty = var_4(arg_1_0.tr, "empty")
	findTF = var_4
	arg_1_0.recentTr = var_4(arg_1_0.tr, "recent")
	setText = var_4

	local var_1_0 = arg_1_0.recentTr
	local var_1_1 = var_6.Find(var_1_0, "Text")

	i18n = var_7

	var_4(var_1_1, var_7("tactics_recent_ship_label"))

	return
end

function var_0_1.flush(arg_2_0)
	var_0_1.super.flush(arg_2_0)

	local var_2_0 = arg_2_0.shipVO

	tobool = var_1_10002

	local var_2_1 = var_1_10002(var_2_0)

	setActive = var_3

	var_3(arg_2_0.empty, not var_2_1)

	setActive = var_3

	var_3(arg_2_0.quit, false)

	setActive = var_3

	var_3(arg_2_0.recentTr, false)

	setActive = var_3

	var_3(arg_2_0.iconStatus, false)

	return
end

function var_0_1.clear(arg_3_0)
	var_0_1.super.clear(arg_3_0)

	setActive = var_1

	var_1(arg_3_0.recentTr, false)

	return
end

return var_0_1
