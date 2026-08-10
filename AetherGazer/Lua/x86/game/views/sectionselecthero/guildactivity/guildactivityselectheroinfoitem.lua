local var_0_0 = import("game.views.sectionSelectHero.SectionSelectHeroInfoItem")
local var_0_1 = class("GuildActivitySelectHeroInfoItem", var_0_0)

function var_0_1.RefreshEnergyUI(arg_1_0)
	if not GuildActivityTools:IsLastBossDefeated(arg_1_0.sectionProxy_.activityClubCfg.id) and arg_1_0.heroID_ ~= 0 then
		arg_1_0.energyController_:SetSelectedState("true")

		arg_1_0.energyText_.text = arg_1_0:GetHeroEnergy()

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_0.energyBgTrans_)
	else
		arg_1_0.energyController_:SetSelectedState("false")
	end
end

return var_0_1
