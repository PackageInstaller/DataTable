local BattleChipSchemeItem = class("BattleChipSchemeItem", (import("game.views.chip.scheme.ChipSchemeItem")))

function BattleChipSchemeItem:OnEnabledBtn()
	self.dataTemplate.useChipIdList = self.schemeData_.chipList

	self.dataTemplate.sectionProxy_:SetMimirChipList(self.schemeData_.chipList)
	manager.notify:Invoke(ENABLED_SCHEME)
end

return BattleChipSchemeItem
