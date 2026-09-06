-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFCreateStatusBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFCreateStatusBuff", package.seeall)

local AQAFCreateStatusBuff = class("AQAFCreateStatusBuff", AQAFBuffBase)

function AQAFCreateStatusBuff:onBuffTrigger()
	self._isAdd = false
	self._status = self._tiggerParam[1]

	local rate = checknumber(self._tiggerParam[2])

	if rate > math.random() then
		self._isAdd = true

		GameUtil.callBack(self._unit.addNewStatus, self._unit, self._status)
	end
end

function AQAFCreateStatusBuff:onRemove(unit)
	if self._isAdd then
		GameUtil.callBack(self._unit.removeStatus, self._unit, self._status)
	end
end

return AQAFCreateStatusBuff
