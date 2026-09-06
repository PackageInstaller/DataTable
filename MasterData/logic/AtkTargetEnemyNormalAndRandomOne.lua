-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemyNormalAndRandomOne.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemyNormalAndRandomOne", package.seeall)

local AtkTargetEnemyNormalAndRandomOne = class("AtkTargetEnemyNormalAndRandomOne", AtkTargetEnemyBase)

function AtkTargetEnemyNormalAndRandomOne:getResult()
	local result = self:_defaultStrategy()
	local enterPosIndex = self:_getEnterPosIndex()
	local row = self:_getRow(enterPosIndex)
	local raceIds = self:_getRaceIds()
	local normalTargetIndex = self:_getRowFirst(row, raceIds)

	if not normalTargetIndex then
		return result
	end

	result[normalTargetIndex] = true

	for i = 1, 9 do
		if raceIds[i] > 0 and normalTargetIndex < i then
			result[i] = true

			break
		end
	end

	return result
end

return AtkTargetEnemyNormalAndRandomOne
