-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemyRowColumn.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemyRowColumn", package.seeall)

local AtkTargetEnemyRowColumn = class("AtkTargetEnemyRowColumn", AtkTargetEnemyBase)

function AtkTargetEnemyRowColumn:getResult()
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

	for i = 1, 9 do
		if raceIds[i] > 0 then
			local iRow = self:_getRow(i)
			local iColumn = self:_getColumn(i)

			if iColumn == normalColumn and Mathf.Abs(iRow - normalRow) <= 1 then
				result[i] = true
			elseif iRow == normalRow and Mathf.Abs(iColumn - normalColumn) <= 1 then
				result[i] = true
			end
		end
	end

	return result
end

return AtkTargetEnemyRowColumn
