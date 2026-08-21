local var_0_0 = class("NavTacticsDockyardShipItem", import("view.ship.DockyardShipItem"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.empty = findTF(arg_1_0.tr, "empty")
	arg_1_0.recentTr = findTF(arg_1_0.tr, "recent")

	setText(arg_1_0.recentTr:Find("Text"), i18n("tactics_recent_ship_label"))

	return
end

function var_0_0.flush(arg_2_0)
	var_0_0.super.flush(arg_2_0)
	setActive(arg_2_0.empty, not tobool(arg_2_0.shipVO))
	setActive(arg_2_0.quit, false)
	setActive(arg_2_0.recentTr, false)
	setActive(arg_2_0.iconStatus, false)

	return
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	setActive(arg_3_0.recentTr, false)

	return
end

return var_0_0
