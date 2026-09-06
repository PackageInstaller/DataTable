-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFChangeDamageBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFChangeDamageBuff", package.seeall)

local AQAFChangeDamageBuff = class("AQAFChangeDamageBuff", AQAFBuffBase)

function AQAFChangeDamageBuff:onBuffTrigger()
	local rate = checknumber(self.tiggerParam[1])

	GameUtil.callBack(self._unit.changeDamage, self._unit, rate)
end

return AQAFChangeDamageBuff
