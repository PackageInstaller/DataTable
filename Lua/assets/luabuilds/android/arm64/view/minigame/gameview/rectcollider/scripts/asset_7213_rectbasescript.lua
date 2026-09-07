local RectBaseScript = class("RectBaseScript")

function RectBaseScript:Ctor()
	self._weight = 1
	self._loop = false
	self._active = false
	self._scriptTime = 0
	self._overrideAble = false
	self._lateActive = false
	self._name = ""

	return
end

function RectBaseScript:init()
	return
end

function RectBaseScript:setData(arg_3_1, arg_3_2, arg_3_3)
	self._collisionInfo = arg_3_1
	self._keyInfo = arg_3_2
	self._event = arg_3_3

	self:onInit()

	return
end

function RectBaseScript:step()
	self:onStep()

	self._triggerKey = nil
	self._triggerStatus = nil

	return
end

function RectBaseScript:addScriptApply()
	self._collisionInfo:removeScript()
	self._collisionInfo:setScript(self, self._weight, self._scriptTime, self._overrideAble)

	return
end

function RectBaseScript:checkScirptApply()
	if not self._collisionInfo.script then
		self:addScriptApply()

		return true
	elseif self._collisionInfo.script ~= self and self._collisionInfo.scriptOverrideAble and self._collisionInfo.scriptWeight <= self._weight then
		self:addScriptApply()

		return true
	end

	print("当前脚本 " .. self._collisionInfo.script._name .. " 中，无法执行" .. self._name)

	return false
end

function RectBaseScript:onStep()
	return
end

function RectBaseScript:lateStep()
	self._lateActive = self._active

	self:onLateStep()

	return
end

function RectBaseScript:onLateStep()
	return
end

function RectBaseScript:active(arg_10_1)
	self._active = arg_10_1

	return
end

function RectBaseScript:onActive()
	return
end

function RectBaseScript:keyTrigger(arg_12_1, arg_12_2)
	self._triggerKey = arg_12_1
	self._triggerStatus = arg_12_2

	self:onTrigger(arg_12_1, arg_12_2)

	return
end

function RectBaseScript:getWeight()
	return self._weight
end

return RectBaseScript
