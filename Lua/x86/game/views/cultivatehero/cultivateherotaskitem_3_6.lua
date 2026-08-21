local var_0_0 = import("game.views.cultivateHero.CultivateHeroTaskItem")
local var_0_1 = class("CultivateHeroTaskItem_3_6", var_0_0)

function var_0_1.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:AddListeners()

	arg_1_0.rewardState_ = arg_1_0.controllerEx_:GetController("status")
end

return var_0_1
