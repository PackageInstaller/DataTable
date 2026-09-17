local WeaponBreakAnimationManager = class("WeaponBreakAnimationManager", (require("controller.base_manager")))

WeaponBreakAnimationManager.MULTITON_MSG = "WeaponBreakAnimationManager instancealready constructed!"

function WeaponBreakAnimationManager:ctor()
	WeaponBreakAnimationManager.super.ctor(self)

	self._data = {}
end

function WeaponBreakAnimationManager:requestInfo(arg_2_1)
	return
end

function WeaponBreakAnimationManager:handlerInfo(arg_3_1)
	return
end

function WeaponBreakAnimationManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function WeaponBreakAnimationManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return WeaponBreakAnimationManager
