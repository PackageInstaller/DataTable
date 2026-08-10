HellaMainView = import("game.views.activity.Main.HellaMainView")

local var_0_0 = class("HellaMainReprintView", HellaMainView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
	SetActive(arg_1_0.skinTrialGo_, false)
	SetActive(arg_1_0.tryGo_, false)
end

return var_0_0
