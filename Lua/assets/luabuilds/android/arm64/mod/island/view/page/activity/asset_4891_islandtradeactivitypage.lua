local IslandTradeActivityPage = class("IslandTradeActivityPage", import("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function IslandTradeActivityPage:OnInit()
	setText(self._tf:Find("bg/desc_1"), i18n("island_trade_activity_desc_1"))
	setText(self._tf:Find("bg/desc_2"), i18n("island_trade_activity_desc_2"))
	setText(self._tf:Find("bg/level/Text"), i18n("island_trade_activity_unlock"))

	return
end

return IslandTradeActivityPage
