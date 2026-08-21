local var_0_0 = class("IslandTradeActivityPage", import("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	setText(arg_1_0._tf:Find("bg/desc_1"), i18n("island_trade_activity_desc_1"))
	setText(arg_1_0._tf:Find("bg/desc_2"), i18n("island_trade_activity_desc_2"))
	setText(arg_1_0._tf:Find("bg/level/Text"), i18n("island_trade_activity_unlock"))

	return
end

return var_0_0
