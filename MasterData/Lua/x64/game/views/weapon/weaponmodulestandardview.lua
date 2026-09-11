WeaponModuleView = import("game.views.weapon.WeaponModuleView")

local WeaponModuleStandardView = class("WeaponModuleStandardView", WeaponModuleView)

function WeaponModuleStandardView:AddRedPoint()
	return
end

function WeaponModuleStandardView:RemoveRedPoint()
	return
end

function WeaponModuleStandardView:GetModuleLevel()
	return self.params_.moduleLevel
end

function WeaponModuleStandardView:GetModuleMaxLevel()
	return self:GetModuleLevel()
end

return WeaponModuleStandardView
