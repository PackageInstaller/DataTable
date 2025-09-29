-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompTimelineMain.lua

module("logic.battle.effect.comp.EffectCompTimelineMain", package.seeall)

local EffectCompTimelineMain = class("EffectCompTimelineMain", IEffectComp)

function EffectCompTimelineMain:onInit()
	self._loader = self.unit.loader
	self._speed = 1
	self._playerDirector = false
	self._effectCode = false
end

function EffectCompTimelineMain:onReset()
	self._effectControl:Clear()

	self._speed = 1
	self._playerDirector = false
	self._effectCode = false
end

function EffectCompTimelineMain:onDestroy()
	self._loader = false
	self._playerDirector = false
	self._speed = false
	self._effectCode = false
end

function EffectCompTimelineMain:setEffectCode(effectCode)
	self._effectCode = effectCode
end

function EffectCompTimelineMain:getEffectCode()
	return self._effectCode
end

function EffectCompTimelineMain:setPlaySpeed(speed)
	self._speed = speed

	if self._playerDirector and self._playerDirector.state == 1 then
		self._playerDirector:SetPlaySpeed(self._speed)
	end
end

function EffectCompTimelineMain:onResourceLoaded()
	self._playerDirector = goutil.addComponentOnce(self._loader:getInst(), ComponentType.PlayableDirector)

	self._playerDirector:Play()
	self._playerDirector:SetPlaySpeed(self._speed)
end

return EffectCompTimelineMain
