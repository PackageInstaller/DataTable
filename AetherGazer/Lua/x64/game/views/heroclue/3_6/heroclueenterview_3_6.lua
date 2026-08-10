local var_0_0 = import("game.views.heroClue.HeroClueEnterView")
local var_0_1 = class("HeroClueEnterView_3_6", var_0_0)

function var_0_1.InitController(arg_1_0)
	arg_1_0.allReceiveController_ = arg_1_0.taskPanelControllerEx_:GetController("clear")
end

return var_0_1
