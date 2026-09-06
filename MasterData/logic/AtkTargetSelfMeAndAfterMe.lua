-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetSelfMeAndAfterMe.lua

module("logic.extensions.mission.view.atktarget.AtkTargetSelfMeAndAfterMe", package.seeall)

local AtkTargetSelfMeAndAfterMe = class("AtkTargetSelfMeAndAfterMe", AtkTargetSelfBase)

function AtkTargetSelfMeAndAfterMe:getResult()
	local result = self:_defaultStrategy()
	local enterPosIndex = self._atkTargetParam.enterPosIndex

	result[enterPosIndex] = true

	local index = enterPosIndex + 3
	local index2 = enterPosIndex + 6

	if self._atkTargetParam:isExistPet(index) then
		result[index] = true
	elseif self._atkTargetParam:isExistPet(index2) then
		result[index2] = true
	end

	return result
end

return AtkTargetSelfMeAndAfterMe
