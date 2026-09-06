-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemyNormalAndAfterAnyone.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemyNormalAndAfterAnyone", package.seeall)

local AtkTargetEnemyNormalAndAfterAnyone = class("AtkTargetEnemyNormalAndAfterAnyone", AtkTargetEnemyBase)

function AtkTargetEnemyNormalAndAfterAnyone:getResult()
	local result = self:_defaultStrategy()
	local enterPosIndex = self:_getEnterPosIndex()
	local row = self:_getRow(enterPosIndex)
	local normalTargetIndex = self:_getRowFirst(row, self:_getRaceIds())

	if not normalTargetIndex then
		return result
	end

	result[normalTargetIndex] = true

	local newRow = self:_getRow(normalTargetIndex)
	local afterNormalTargetIndex = self:_getRowAfterFirst(newRow, self:_getRaceIds())

	if not afterNormalTargetIndex then
		return result
	end

	result[afterNormalTargetIndex] = true

	return result
end

return AtkTargetEnemyNormalAndAfterAnyone
