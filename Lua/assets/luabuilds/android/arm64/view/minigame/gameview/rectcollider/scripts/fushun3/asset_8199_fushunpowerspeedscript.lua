local FuShunPowerSpeedScript = class("FuShunPowerSpeedScript", import("..RectBaseScript"))
local var_0_1 = {
	400,
	450
}
local var_0_2 = 20

function FuShunPowerSpeedScript:onInit()
	self._loop = false
	self._active = false
	self._weight = 4
	self._overrideAble = false
	self._lastActive = false
	self._scriptTime = 10
	self._name = "FuShunPowerSpeedScript"

	return
end

function FuShunPowerSpeedScript:onStep()
	if self._active then
		local var_2_0 = self._collisionInfo:getVelocity()
		local var_2_1 = self._collisionInfo:getPos()

		if var_2_1.y >= var_0_1[2] then
			var_2_0.y = -10
		elseif var_2_1.y <= var_0_1[1] then
			var_2_0.y = 10
		else
			var_2_0.y = 0
			var_2_0.x = var_0_2

			if not self.powerFlag then
				self._event:emit(Fushun3GameEvent.script_power_event)

				self.powerFlag = true
			end
		end

		self._collisionInfo:setVelocity(var_2_0)
	else
		self.powerFlag = false

		if self._collisionInfo.script == self then
			self._collisionInfo:removeScript()
		end
	end

	self._lastActive = self._active

	return
end

function FuShunPowerSpeedScript:onLateStep()
	return
end

function FuShunPowerSpeedScript:onTrigger()
	return
end

return FuShunPowerSpeedScript
