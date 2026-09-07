local FuShunAttakeScript = class("FuShunAttakeScript", import("..RectBaseScript"))

function FuShunAttakeScript:onInit()
	self._loop = false
	self._active = false
	self._weight = 2
	self._scriptTime = 0.4
	self._overrideAble = true
	self._name = "FuShunAttakeScript"

	return
end

function FuShunAttakeScript:onStep()
	if self._active and self._collisionInfo.below and not self._lateActive then
		self._event:emit(Fushun3GameEvent.script_attack_event)
	end

	return
end

function FuShunAttakeScript:onLateStep()
	return
end

function FuShunAttakeScript:onTrigger()
	if Application.isEditor and self._triggerKey == KeyCode.J and self._triggerStatus and self:checkScirptApply() then
		self._active = true
	end

	return
end

return FuShunAttakeScript
