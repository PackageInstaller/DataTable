-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFChangeBulletCountBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFChangeBulletCountBuff", package.seeall)

local AQAFChangeBulletCountBuff = class("AQAFChangeBulletCountBuff", AQAFBuffBase)

function AQAFChangeBulletCountBuff:onBuffTrigger()
	local num = checknumber(self._tiggerParam[1])

	GameUtil.callBack(self._unit.updateBulletCount, self._unit, num)
end

function AQAFChangeBulletCountBuff:onRemove(unit)
	GameUtil.callBack(self._unit.resetBulletCount, self._unit)
end

return AQAFChangeBulletCountBuff
