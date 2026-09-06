-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemyNormalColumn.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemyNormalColumn", package.seeall)

local AtkTargetEnemyNormalColumn = class("AtkTargetEnemyNormalColumn", AtkTargetEnemyBase)

function AtkTargetEnemyNormalColumn:getResult()
	local result = self:_defaultStrategy()
	local enterPosIndex = self:_getEnterPosIndex()
	local row = self:_getRow(enterPosIndex)
	local raceIds = self:_getRaceIds()
	local normalTargetIndex = self:_getRowFirst(row, raceIds)

	if not normalTargetIndex then
		return result
	end

	result[normalTargetIndex] = true

	local normalRow = self:_getRow(normalTargetIndex)
	local normalColumn = self:_getColumn(normalTargetIndex)

	if normalRow == 1 then
		if raceIds[normalTargetIndex + 1] > 0 then
			result[normalTargetIndex + 1] = true
		elseif raceIds[normalTargetIndex + 2] > 0 then
			result[normalTargetIndex + 2] = true
		end
	elseif normalRow == 2 then
		if raceIds[normalTargetIndex - 1] > 0 then
			result[normalTargetIndex - 1] = true
		elseif raceIds[normalTargetIndex + 1] > 0 then
			result[normalTargetIndex + 1] = true
		end
	elseif normalRow == 3 then
		if raceIds[normalTargetIndex - 1] > 0 then
			result[normalTargetIndex - 1] = true
		elseif raceIds[normalTargetIndex - 2] > 0 then
			result[normalTargetIndex - 2] = true
		end
	end

	return result
end

return AtkTargetEnemyNormalColumn
