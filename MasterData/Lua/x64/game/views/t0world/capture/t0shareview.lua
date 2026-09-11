HeroDisplayShareView = import("game.views.heroDisplay.HeroDisplayShareView")

local T0ShareView = class("T0ShareView", HeroDisplayShareView)

function T0ShareView:SendToSDK(arg_1_1)
	return
end

function T0ShareView:OnSnape(arg_2_1)
	T0ShareView.super.OnSnape(self, arg_2_1)
	self.animator_:Play("T0_108502_Capture_Result", 0, 0)
end

return T0ShareView
