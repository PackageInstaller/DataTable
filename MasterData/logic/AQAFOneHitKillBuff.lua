-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFOneHitKillBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFOneHitKillBuff", package.seeall)

local AQAFOneHitKillBuff = class("AQAFOneHitKillBuff", AQAFBuffBase)

function AQAFOneHitKillBuff:onBuffTrigger()
	local rate = checknumber(self._tiggerParam[1])

	if rate > math.random() then
		GameUtil.callBack(self._target.changeHP, self._target, 0)
	end
end

return AQAFOneHitKillBuff
