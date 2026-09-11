local BattleChipSchemeView = class("BattleChipSchemeView", (import("game.views.chip.scheme.ChipSchemeView")))

function BattleChipSchemeView:GetChipSchemeItem()
	return BattleChipSchemeItem
end

return BattleChipSchemeView
