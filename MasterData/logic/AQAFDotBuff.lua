-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFDotBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFDotBuff", package.seeall)

local AQAFDotBuff = class("AQAFDotBuff", AQAFBuffBase)

function AQAFDotBuff:_clearLast()
	AQAFDotBuff.super._clearLast(self)

	self._elapsedTime = 0
	self._tigCount = 0
end

function AQAFDotBuff:onUpdate()
	if not self._isAdded then
		return
	end

	self._curTimeInterval = checknumber(self._tiggerParam[1])
	self._elapsedTime = self._elapsedTime + Time.deltaTime

	if self._elapsedTime > self._curTimeInterval then
		self:onBuffTrigger()
	end
end

function AQAFDotBuff:onBuffTrigger()
	self._tigCount = self._tigCount + 1
	self._elapsedTime = 0

	self._unit:removeBuff(self)
end

function AQAFDotBuff:onHit(unit)
	return
end

function AQAFDotBuff:onBeHit(unit)
	return
end

function AQAFDotBuff:onCrit(unit)
	return
end

function AQAFDotBuff:onAttack(unit)
	return
end

function AQAFDotBuff:onBeforeCauseDamage(unit)
	return
end

function AQAFDotBuff:onBeforeDammage(unit)
	return
end

function AQAFDotBuff:onAfterDammage(unit)
	return
end

function AQAFDotBuff:onAfterCauseDamage(unit)
	return
end

return AQAFDotBuff
