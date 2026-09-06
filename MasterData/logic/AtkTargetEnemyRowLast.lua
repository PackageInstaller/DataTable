-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemyRowLast.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemyRowLast", package.seeall)

local AtkTargetEnemyRowLast = class("AtkTargetEnemyRowLast", AtkTargetEnemyBase)

function AtkTargetEnemyRowLast:_getRowLast(row, raceIds)
	local firstRowPos, secondRowPos, thirdRowPos

	for i = 1, 9 do
		if raceIds[i] > 0 then
			local enemyRow = self:_getRow(i)

			if enemyRow == 1 then
				firstRowPos = i
			elseif enemyRow == 2 then
				secondRowPos = i
			elseif enemyRow == 3 then
				thirdRowPos = i
			end
		end
	end

	return self:_getRowPos(row, firstRowPos, secondRowPos, thirdRowPos)
end

function AtkTargetEnemyRowLast:getResult()
	local result = self:_defaultStrategy()
	local enterPosIndex = self:_getEnterPosIndex()
	local row = self:_getRow(enterPosIndex)
	local targetIndex = self:_getRowLast(row, self:_getRaceIds())

	if not targetIndex then
		return result
	end

	result[targetIndex] = true

	return result
end

return AtkTargetEnemyRowLast
