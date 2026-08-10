local var_0_0 = import("game.views.prompt.GameHelpProView")
local var_0_1 = class("BossHelperView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VolumeIIIUI/VolumeGameHelpPro"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.AddUIListeners(arg_3_0)
	var_0_1.super.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		BattleBossChallengeAction.EnterBossChallenge()
	end)
end

return var_0_1
