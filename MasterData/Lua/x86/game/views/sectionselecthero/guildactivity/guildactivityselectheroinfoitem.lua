local GuildActivitySelectHeroInfoItem = class("GuildActivitySelectHeroInfoItem", (import("game.views.sectionSelectHero.SectionSelectHeroInfoItem")))

function GuildActivitySelectHeroInfoItem:RefreshEnergyUI()
	if not GuildActivityTools:IsLastBossDefeated(self.sectionProxy_.activityClubCfg.id) and self.heroID_ ~= 0 then
		self.energyController_:SetSelectedState("true")

		self.energyText_.text = self:GetHeroEnergy()

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.energyBgTrans_)
	else
		self.energyController_:SetSelectedState("false")
	end
end

return GuildActivitySelectHeroInfoItem
