local FuShunMovementScript = class("FuShunMovementScript", import("..RectBaseScript"))

function FuShunMovementScript:onInit()
	self._loop = true
	self._active = true
	self._weight = 1
	self._scriptTime = nil
	self._name = "FuShunMovementScript"

	return
end

function FuShunMovementScript:onStep()
	self._collisionInfo.playerInput.x = 1

	local var_2_0 = self._collisionInfo.playerInput.x * self._collisionInfo.config.moveSpeed
	local var_2_1 = self._collisionInfo:getVelocity()
	local var_2_2 = self._collisionInfo.velocityXSmoothing

	if var_2_1.x == self._collisionInfo.playerInput.x * self._collisionInfo.config.moveSpeed then
		var_2_2 = 0
	end

	local var_2_3

	var_2_1.x, var_2_3 = Mathf.SmoothDamp(var_2_1.x, var_2_0, var_2_2, (self._collisionInfo.below or nil) and (self._collisionInfo.config.accelerationTimeGrounded or self._collisionInfo.config.accelerationTimeAirborne))

	if not self._collisionInfo.below then
		var_2_1.y = var_2_1.y + self._collisionInfo.config.gravity * self._collisionInfo.frameRate
	end

	self._collisionInfo:setVelocity(var_2_1)

	self._collisionInfo.velocityXSmoothing = var_2_3

	return
end

function FuShunMovementScript:onLateStep()
	return
end

function FuShunMovementScript:onTrigger()
	if Application.isEditor and self._triggerKey == KeyCode.A or self._triggerKey == KeyCode.D then
		local var_4_0 = self._keyInfo:getKeyCode(KeyCode.A)

		if self._triggerKey == KeyCode.A then
			self._collisionInfo.playerInput.x = self._triggerStatus and -1 or self._keyInfo:getKeyCode(KeyCode.D) and 1 or 0
		elseif self._triggerKey == KeyCode.D then
			self._collisionInfo.playerInput.x = self._triggerStatus and 1 or var_4_0 and -1 or 0
		end

		self._collisionInfo.directionalInput = self._collisionInfo.playerInput
	end

	return
end

return FuShunMovementScript
