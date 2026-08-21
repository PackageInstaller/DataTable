WeaponModuleView = import("game.views.weapon.WeaponModuleView")

local var_0_0 = class("WeaponModuleStandardView", WeaponModuleView)

function var_0_0.AddRedPoint(arg_1_0)
	return
end

function var_0_0.RemoveRedPoint(arg_2_0)
	return
end

function var_0_0.GetModuleLevel(arg_3_0)
	return arg_3_0.params_.moduleLevel
end

function var_0_0.GetModuleMaxLevel(arg_4_0)
	return arg_4_0:GetModuleLevel()
end

return var_0_0
