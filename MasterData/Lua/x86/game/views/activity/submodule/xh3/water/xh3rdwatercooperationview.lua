local XH3rdWaterCooperationView = class("XH3rdWaterCooperationView", (import("game.views.cooperation.CooperationView")))

function XH3rdWaterCooperationView:GetCooperationPlayerClass()
	return XH3rdWaterCooperationPlayer
end

return XH3rdWaterCooperationView
