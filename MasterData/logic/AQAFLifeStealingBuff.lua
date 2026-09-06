-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFLifeStealingBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFLifeStealingBuff", package.seeall)

local AQAFLifeStealingBuff = class("AQAFLifeStealingBuff", AQAFBuffBase)

function AQAFLifeStealingBuff:onBuffTrigger()
	local rate1 = checknumber(self._tiggerParam[1])

	AoQiAttackForceGameController.instance.playerUnit:heal(self._dammage * rate1)
end

return AQAFLifeStealingBuff
