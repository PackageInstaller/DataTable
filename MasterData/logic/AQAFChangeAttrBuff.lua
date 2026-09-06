-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFChangeAttrBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFChangeAttrBuff", package.seeall)

local AQAFChangeAttrBuff = class("AQAFChangeAttrBuff", AQAFBuffBase)

function AQAFChangeAttrBuff:onBuffTrigger()
	for _, changeAttrStr in ipairs(self._tiggerParam) do
		local changeParam = string.split(changeAttrStr, ":")

		GameUtil.callBack(self._unit.updateAttr, self._unit, changeParam[1] or "", changeParam[2] or 0)

		if changeParam[1] == "takeMagicDamRate" then
			GlobalDispatcher:dispatch(GlobalNotify.AQAFShowAlertTxt, lang("魔法易伤"), self._unit.position.x, self._unit.position.y + 50, AQAFSimpleFloatTipsMgr.TYPE_SPLIT_TEXT)
		elseif changeParam[1] == "takePhysicalDamRate" then
			GlobalDispatcher:dispatch(GlobalNotify.AQAFShowAlertTxt, lang("物理易伤"), self._unit.position.x, self._unit.position.y + 50, AQAFSimpleFloatTipsMgr.TYPE_SPLIT_TEXT)
		end
	end
end

return AQAFChangeAttrBuff
