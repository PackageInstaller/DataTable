-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemySingle.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemySingle", package.seeall)

local AtkTargetEnemySingle = class("AtkTargetEnemySingle", AtkTargetEnemyBase)

function AtkTargetEnemySingle:getResult()
	local result = self:_defaultStrategy()
	local enterPosIndex = self:_getEnterPosIndex()
	local row = self:_getRow(enterPosIndex)
	local targetIndex = self:_getRowFirst(row, self:_getRaceIds())

	if not targetIndex then
		return result
	end

	result[targetIndex] = true

	return result
end

return AtkTargetEnemySingle
