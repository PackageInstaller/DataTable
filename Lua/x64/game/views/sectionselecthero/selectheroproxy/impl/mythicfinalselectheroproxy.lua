local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("MythicFinalSelectHeroProxy", var_0_0)

function var_0_1.CustomCheckBeforeBattle(arg_1_0)
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function()
				JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
			end
		})

		return false
	end

	return true
end

return var_0_1
