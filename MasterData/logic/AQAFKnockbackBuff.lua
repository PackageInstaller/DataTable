-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFKnockbackBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFKnockbackBuff", package.seeall)

local AQAFKnockbackBuff = class("AQAFKnockbackBuff", AQAFBuffBase)

function AQAFKnockbackBuff:onBuffTrigger()
	local prams = {}

	for i, v in ipairs(self._tiggerParam) do
		local paramsArr = string.split(v, ":")

		prams[paramsArr[1]] = checknumber(paramsArr[2])
	end

	local rate = checknumber(prams.rate)
	local distance = checknumber(prams.dir)
	local time = checknumber(prams.time)

	if rate > math.random() and self._target.changeKnockback then
		GameUtil.callBack(self._target.changeKnockback, self._target, -distance, time)
	end
end

return AQAFKnockbackBuff
