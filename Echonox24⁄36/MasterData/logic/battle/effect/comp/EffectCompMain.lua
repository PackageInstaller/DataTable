-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompMain.lua

module("logic.battle.effect.comp.EffectCompMain", package.seeall)

local EffectCompMain = class("EffectCompMain", IEffectComp)

function EffectCompMain:onInit()
	self._loader = self.unit.loader
	self._effectControl = EffectControl.Get(self.unit.mainGO)
	self._speed = 1
	self._keepSpeed = false
	self._effectKey = false
	self._effectCode = false
end

function EffectCompMain:onReset()
	self._effectControl:Clear()

	self._speed = 1
	self._keepSpeed = false
	self._effectCode = false

	removetimer(self._delayShowEffect, self)
end

function EffectCompMain:onDestroy()
	self._loader = false
	self._effectControl = false
	self._speed = false
	self._effectCode = false

	removetimer(self._delayShowEffect, self)
end

function EffectCompMain:setEffectCode(effectCode)
	self._effectCode = effectCode
end

function EffectCompMain:getEffectCode()
	return self._effectCode
end

function EffectCompMain:setPlaySpeed(speed)
	if not self._keepSpeed then
		self._speed = speed

		self._effectControl:SetPlaySpeed(speed)
	end
end

function EffectCompMain:onResourceLoaded()
	self._effectControl:Load(self._loader:getInst())
	self._effectControl:SetPlaySpeed(self._speed)
end

function EffectCompMain:setEffectKey(effectKey)
	self._effectKey = effectKey
end

function EffectCompMain:getEffectKey()
	return self._effectKey
end

function EffectCompMain:delayShowEffect(time)
	self:setEffectActive(false)
	settimer(time, self._delayShowEffect, self, false)
end

function EffectCompMain:_delayShowEffect()
	self:setEffectActive(true)
end

function EffectCompMain:setEffectActive(status)
	goutil.setActive(self._loader:getInst(), status)
end

function EffectCompMain:setKeepSpeed(state)
	self._keepSpeed = state
end

return EffectCompMain
