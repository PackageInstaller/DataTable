-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFBloodLossStatusBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFBloodLossStatusBuff", package.seeall)

local AQAFBloodLossStatusBuff = class("AQAFBloodLossStatusBuff", AQAFDotBuff)

function AQAFBloodLossStatusBuff:onBuffTrigger()
	self._tigCount = self._tigCount + 1
	self._elapsedTime = 0

	local rate = checknumber(self._tiggerParam[2])

	self._unit:beDamage(self._target, rate * self._target:getCurAtk() / 100, AQAFGameEnum.AttackDamageType.Normal)

	local triggerLimit = checknumber(self._tiggerParam[3])

	if triggerLimit ~= 0 or triggerLimit <= self._tigCount then
		self._unit:removeBuff(self)
	end
end

return AQAFBloodLossStatusBuff
