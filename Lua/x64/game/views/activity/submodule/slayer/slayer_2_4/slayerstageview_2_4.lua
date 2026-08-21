local var_0_0 = import("game.views.activity.Submodule.slayer.slayer_1_7.SlayerStageView_1_7")
local var_0_1 = class("SplayerStageView_2_4", SlayerStageView_1_7)

function var_0_1.OnTop(arg_1_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SLAYER_DESCRIBE")
end

return var_0_1
