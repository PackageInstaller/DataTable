-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompBezierCurveMover.lua

module("logic.battle.effect.comp.EffectCompBezierCurveMover", package.seeall)

local EffectCompBezierCurveMover = class("EffectCompBezierCurveMover", IEffectComp)
local kTemp1Vec3 = Vector3.New()
local kTemp2Vec3 = Vector3.New()

function EffectCompBezierCurveMover:onInit()
	self._position0 = Vector3.New()
	self._position1 = Vector3.New()
	self._position2 = Vector3.New()
	self._timeScale = 1
	self._duration = 1
	self._passTime = 0
	self._handler = Handler.New()
	self._transform = self.unit.transform
end

function EffectCompBezierCurveMover:onReuse()
	return
end

function EffectCompBezierCurveMover:onReset()
	self:_clear()
end

function EffectCompBezierCurveMover:onDestroy()
	self:_clear()

	self._transform = nil
end

function EffectCompBezierCurveMover:_clear()
	self._handler:clear()
	FrameUpdate:removeListener(self)
end

function EffectCompBezierCurveMover:setDuration(duration)
	self._duration = duration

	return self
end

function EffectCompBezierCurveMover:setTimeScale(timeScale)
	self._timeScale = timeScale

	return self
end

function EffectCompBezierCurveMover:setInterpPosition(position)
	self._position1:Set(position:Get())

	return self
end

function EffectCompBezierCurveMover:setTargetPosition(position)
	self._position2:Set(position:Get())

	return self
end

function EffectCompBezierCurveMover:setListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)

	return self
end

function EffectCompBezierCurveMover:start()
	self._position0:Set(self._transform:getPosition():Get())

	self._passTime = 0

	FrameUpdate:addListener(self)
end

function EffectCompBezierCurveMover:luaUpdate(deltaTime)
	deltaTime = deltaTime * self._timeScale
	self._passTime = self._passTime + deltaTime

	local position, axis = self:_calculatePositionAndAxis(self._passTime / self._duration)

	self._transform:setPosition(position)
	self._transform:rotationToAxis(axis)

	if self._passTime >= self._duration then
		self._handler:call(self.unit)
		self:_clear()
	end
end

function EffectCompBezierCurveMover:_calculatePositionAndAxis(t)
	local t0 = kTemp1Vec3
	local t1 = kTemp2Vec3
	local rt = 1 - t

	t0:Set(self._position0:Get())
	t0:Mul(rt * rt)
	t1:Set(t0:Get())
	t0:Set(self._position1:Get())
	t0:Mul(2 * t * rt)
	t1:Add(t0)
	t0:Set(self._position2:Get())
	t0:Mul(t * t)
	t1:Add(t0)
	t0:Set(t1:Get())
	t0:Sub(self._transform:getPosition())

	return t1, t0
end

return EffectCompBezierCurveMover
