local FuShunJumpScript = class("FuShunJumpScript", import("..RectBaseScript"))

function FuShunJumpScript:onInit()
	self._loop = false
	self._active = false
	self._weight = 2
	self._scriptTime = 0.01
	self._lastActive = false
	self._name = "FuShunJumpScript"

	return
end

function FuShunJumpScript:onStep()
	if self._active then
		if self._collisionInfo.below and self._collisionInfo.useJumpTimes == 0 then
			local var_2_0 = self._collisionInfo:getVelocity()

			var_2_0.x = 0

			self._collisionInfo:setVelocity(var_2_0)
		end
	elseif self._lastActive and self:checkScirptApply() and self._collisionInfo.below and self._collisionInfo.useJumpTimes == 0 then
		local var_2_1 = self._collisionInfo:getVelocity()

		var_2_1.y = self._collisionInfo.config.maxJumpVelocity
		self._collisionInfo.useJumpTimes = 1

		if self._event then
			self._event:emit(Fushun3GameEvent.script_jump_event)
		end

		var_2_1.x = self._collisionInfo.config.moveSpeed

		self._collisionInfo:setVelocity(var_2_1)
	end

	self._lastActive = self._active

	return
end

function FuShunJumpScript:onLateStep()
	if self._collisionInfo.below and self._collisionInfo.useJumpTimes == 1 then
		self._collisionInfo.useJumpTimes = 0
	end

	return
end

function FuShunJumpScript:onTrigger(arg_4_1, arg_4_2)
	if Application.isEditor and self._triggerKey == KeyCode.Space then
		if not arg_4_2 then
			print()
		end

		if self:checkScirptApply() then
			self._active = true
		end
	end

	return
end

return FuShunJumpScript
