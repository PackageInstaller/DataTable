local FuShunMonsterScript = class("FuShunMonsterScript", import("..RectBaseScript"))

function FuShunMonsterScript:onInit()
	self._loop = true
	self._active = true
	self._weight = 1
	self._scriptTime = nil
	self._collisionInfo.playerInput.x = math.random() > 0.5 and 1 or -1
	self._collisionInfo.directionalInput = self._collisionInfo.playerInput
	self._name = "FuShunMonsterScript"

	return
end

function FuShunMonsterScript:onStep()
	self._collisionInfo.config.moveSpeed = 1

	if self._collisionInfo.left and self._collisionInfo.playerInput.x == -1 then
		self._collisionInfo.playerInput.x = 1
		self._collisionInfo.directionalInput = self._collisionInfo.playerInput
	elseif self._collisionInfo.right and self._collisionInfo.playerInput.x == 1 then
		self._collisionInfo.playerInput.x = -1
		self._collisionInfo.directionalInput = self._collisionInfo.playerInput
	end

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

function FuShunMonsterScript:onLateStep()
	return
end

function FuShunMonsterScript:onTrigger()
	return
end

return FuShunMonsterScript
