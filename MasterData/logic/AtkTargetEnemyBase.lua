-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemyBase.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemyBase", package.seeall)

local AtkTargetEnemyBase = class("AtkTargetEnemyBase", AtkTargetBase)

function AtkTargetEnemyBase:_getRaceIds()
	return self._atkTargetParam.raceIds
end

function AtkTargetEnemyBase:_getRowPos(row, firstRowPos, secondRowPos, thirdRowPos)
	if row == 1 then
		if firstRowPos then
			return firstRowPos
		end

		if secondRowPos then
			return secondRowPos
		end

		if thirdRowPos then
			return thirdRowPos
		end
	elseif row == 2 then
		if secondRowPos then
			return secondRowPos
		end

		if firstRowPos then
			return firstRowPos
		end

		if thirdRowPos then
			return thirdRowPos
		end
	elseif row == 3 then
		if thirdRowPos then
			return thirdRowPos
		end

		if secondRowPos then
			return secondRowPos
		end

		if firstRowPos then
			return firstRowPos
		end
	end

	return nil
end

function AtkTargetEnemyBase:_getRowFirst(row, raceIds)
	local firstRowPos, secondRowPos, thirdRowPos

	for i = 1, 9 do
		if checknumber(raceIds[i]) > 0 then
			local enemyRow = self:_getRow(i)

			if enemyRow == 1 then
				firstRowPos = firstRowPos or i
			end

			if enemyRow == 2 then
				secondRowPos = secondRowPos or i
			end

			if enemyRow == 3 then
				thirdRowPos = thirdRowPos or i
			end
		end
	end

	return self:_getRowPos(row, firstRowPos, secondRowPos, thirdRowPos)
end

function AtkTargetEnemyBase:_getRowAfterFirst(row, raceIds)
	local firstRowPos, secondRowPos, thirdRowPos
	local firstEnemyPos = self:_getRowFirst(row, raceIds)

	if not firstEnemyPos then
		return nil
	end

	local column = self:_getColumn(firstEnemyPos)

	if column == 1 then
		if checknumber(raceIds[firstEnemyPos + 3]) > 0 then
			return firstEnemyPos + 3
		elseif checknumber(raceIds[firstEnemyPos + 6]) > 0 then
			return firstEnemyPos + 6
		end
	elseif column == 2 and checknumber(raceIds[firstEnemyPos + 3]) > 0 then
		return firstEnemyPos + 3
	end

	return firstEnemyPos
end

return AtkTargetEnemyBase
