-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompLineMover.lua

module("logic.battle.effect.comp.EffectCompLineMover", package.seeall)

local EffectCompLineMover = class("EffectCompLineMover", IEffectComp)
local kTemp1Vec3 = Vector3.New()
local kTemp2Vec3 = Vector3.New()

function EffectCompLineMover:onInit()
	self._passTime = 0
	self._duration = 1
	self._timeScale = 1
	self._position0 = Vector3.New()
	self._position1 = Vector3.New()
	self._handler = Handler.New()
	self._transform = self.unit.transform
end

function EffectCompLineMover:onReuse()
	return
end

function EffectCompLineMover:onReset()
	self:_clear()
end

function EffectCompLineMover:onDestroy()
	self:_clear()

	self._transform = nil
end

function EffectCompLineMover:_clear()
	self._handler:clear()
	FrameUpdate:removeListener(self)
end

function EffectCompLineMover:setDuration(duration)
	self._duration = duration

	return self
end

function EffectCompLineMover:setTimeScale(timeScale)
	self._timeScale = timeScale

	return self
end

function EffectCompLineMover:setListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)

	return self
end

function EffectCompLineMover:setTargetPosition(position)
	self._position1:Set(position:Get())

	return self
end

function EffectCompLineMover:start()
	self._position0:Set(self._transform:getPosition():Get())

	self._passTime = 0

	FrameUpdate:addListener(self)
end

function EffectCompLineMover:luaUpdate(deltaTime)
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

function EffectCompLineMover:_calculatePositionAndAxis(t)
	local t0 = kTemp1Vec3
	local t1 = kTemp2Vec3
	local rt = 1 - t

	t0:Set(self._position0:Get())
	t0:Mul(rt)
	t1:Set(t0:Get())
	t0:Set(self._position1:Get())
	t0:Mul(t)
	t1:Add(t0)
	t0:Set(t1:Get())
	t0:Sub(self._transform:getPosition())

	return t1, t0
end

return EffectCompLineMover
