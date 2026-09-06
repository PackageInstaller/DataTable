-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemyColumn.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemyColumn", package.seeall)

local AtkTargetEnemyColumn = class("AtkTargetEnemyColumn", AtkTargetEnemyBase)

function AtkTargetEnemyColumn:getResult()
	local result = self:_defaultStrategy()
	local enterPosIndex = self:_getEnterPosIndex()
	local row = self:_getRow(enterPosIndex)
	local raceIds = self:_getRaceIds()
	local normalTargetIndex = self:_getRowFirst(row, raceIds)

	if not normalTargetIndex then
		return result
	end

	result[normalTargetIndex] = true

	local normalColumn = self:_getColumn(normalTargetIndex)

	for i = 1, 9 do
		if raceIds[i] > 0 and normalColumn == self:_getColumn(i) then
			result[i] = true
		end
	end

	return result
end

return AtkTargetEnemyColumn
