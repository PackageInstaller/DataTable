-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFFrozenStatusBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFFrozenStatusBuff", package.seeall)

local AQAFFrozenStatusBuff = class("AQAFFrozenStatusBuff", AQAFDotBuff)

function AQAFFrozenStatusBuff:onAdd(unit)
	AQAFFrozenStatusBuff.super.onAdd(self, unit)

	if not self._isInStatus then
		self._isInStatus = true

		GameUtil.callBack(self._unit.changeFrozend, self._unit, true)
	end
end

function AQAFFrozenStatusBuff:onRemove(unit)
	GameUtil.callBack(self._unit.changeFrozend, self._unit, false)
end

return AQAFFrozenStatusBuff
