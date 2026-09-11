local HodurChallengeAffixItem = class("HodurChallengeAffixItem", (import("game.views.hodur.challenge.HodurChallengeSelectAffixItem")))

function HodurChallengeAffixItem:SetSelected(arg_1_1)
	self.selected_ = arg_1_1

	self.selectController_:SetSelectedState(arg_1_1 and "select" or "Default")
	self:RefreshUI()
end

return HodurChallengeAffixItem
