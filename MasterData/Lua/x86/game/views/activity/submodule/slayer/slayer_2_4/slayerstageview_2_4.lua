local SlayerStageView_1_7 = import("game.views.activity.Submodule.slayer.slayer_1_7.SlayerStageView_1_7")
local SplayerStageView_2_4 = class("SplayerStageView_2_4", SlayerStageView_1_7)

function SplayerStageView_2_4:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SLAYER_DESCRIBE")
end

return SplayerStageView_2_4
