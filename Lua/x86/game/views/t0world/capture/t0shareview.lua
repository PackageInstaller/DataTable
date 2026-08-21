HeroDisplayShareView = import("game.views.heroDisplay.HeroDisplayShareView")

local var_0_0 = class("T0ShareView", HeroDisplayShareView)

function var_0_0.SendToSDK(arg_1_0, arg_1_1)
	return
end

function var_0_0.OnSnape(arg_2_0, arg_2_1)
	var_0_0.super.OnSnape(arg_2_0, arg_2_1)
	arg_2_0.animator_:Play("T0_108502_Capture_Result", 0, 0)
end

return var_0_0
