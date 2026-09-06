-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetSelfToMe.lua

module("logic.extensions.mission.view.atktarget.AtkTargetSelfToMe", package.seeall)

local AtkTargetSelfToMe = class("AtkTargetSelfToMe", AtkTargetSelfBase)

function AtkTargetSelfToMe:getResult()
	local enterPosIndex = self._atkTargetParam.enterPosIndex
	local result = self:_defaultStrategy()

	result[enterPosIndex] = true

	return result
end

return AtkTargetSelfToMe
