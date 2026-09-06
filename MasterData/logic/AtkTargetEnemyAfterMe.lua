-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemyAfterMe.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemyAfterMe", package.seeall)

local AtkTargetEnemyAfterMe = class("AtkTargetEnemyAfterMe", AtkTargetEnemyBase)

function AtkTargetEnemyAfterMe:getResult()
	local result = self:_defaultStrategy()
	local enterPosIndex = self:_getEnterPosIndex()
	local row = self:_getRow(enterPosIndex)
	local targetIndex = self:_getRowAfterFirst(row, self:_getRaceIds())

	if not targetIndex then
		return result
	end

	result[targetIndex] = true

	return result
end

return AtkTargetEnemyAfterMe
