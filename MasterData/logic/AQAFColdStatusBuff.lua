-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFColdStatusBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFColdStatusBuff", package.seeall)

local AQAFColdStatusBuff = class("AQAFColdStatusBuff", AQAFDotBuff)

function AQAFColdStatusBuff:onBuffTrigger()
	self._tigCount = self._tigCount + 1
	self._elapsedTime = 0

	local rate = checknumber(self._tiggerParam[2])

	if rate > math.random() then
		local buffId = checknumber(self._tiggerParam[3])
		local buffCfg = AoQiAttackForceConfig.instance:getBuffCfg(buffId)
		local buffType = buffCfg.createType
		local unit = self._unit
		local buff = AQAFBuffMgr.instance:addBuffToUnit(unit, buffType, buffCfg)

		unit:addBuff(self._target)
	end

	local triggerLimit = checknumber(self._tiggerParam[3])

	if triggerLimit ~= 0 or triggerLimit <= self._tigCount then
		self._unit:removeBuff(self)
	end
end

return AQAFColdStatusBuff
