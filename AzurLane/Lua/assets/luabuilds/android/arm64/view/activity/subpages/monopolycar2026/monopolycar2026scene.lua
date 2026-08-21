local var_0_0 = class("MonopolyCar2026Scene", import("..MonopolyCar2024.MonopolyCar2024Scene"))

function var_0_0.getUIName(arg_1_0)
	return "MonopolyCar2026UI"
end

function var_0_0.NewGame(arg_2_0)
	return MonopolyCar2026Game.New(arg_2_0.activity, arg_2_0._tf:Find("adapt"), arg_2_0.event)
end

return var_0_0
