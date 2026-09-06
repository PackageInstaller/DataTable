-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFNewFlightModeBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFNewFlightModeBuff", package.seeall)

local AQAFNewFlightModeBuff = class("AQAFNewFlightModeBuff", AQAFBuffBase)

function AQAFNewFlightModeBuff:onBuffTrigger()
	local mode = self._tiggerParam[1]
	local addParam = self._tiggerParam[2]

	GameUtil.callBack(self._unit.changeFlightMode, self._unit, mode, addParam)
end

return AQAFNewFlightModeBuff
