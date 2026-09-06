-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFNewBuffBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFNewBuffBuff", package.seeall)

local AQAFNewBuffBuff = class("AQAFNewBuffBuff", AQAFBuffBase)

function AQAFNewBuffBuff:onBuffTrigger()
	local buffId = checknumber(self._tiggerParam[1])
	local targetStr = self._tiggerParam[2]
	local buffCfg = AoQiAttackForceConfig.instance:getBuffCfg(buffId)
	local buffType = buffCfg.createType
	local unit = self._unit

	if targetStr == "target" then
		unit = self._target

		local buff = AQAFBuffMgr.instance:addBuffToUnit(self._target, buffType, buffCfg)

		unit:addBuff(self._unit)
	elseif targetStr == "owner" then
		unit = self._unit.owner

		local buff = AQAFBuffMgr.instance:addBuffToUnit(self._unit.owner, buffType, buffCfg)

		unit:addBuff(self._unit)
	elseif targetStr == "self" then
		unit = self._unit

		local buff = AQAFBuffMgr.instance:addBuffToUnit(self._unit, buffType, buffCfg)

		unit:addBuff(self._unit)
	end
end

return AQAFNewBuffBuff
