-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemyNormalAndRandomTwo.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemyNormalAndRandomTwo", package.seeall)

local AtkTargetEnemyNormalAndRandomTwo = class("AtkTargetEnemyNormalAndRandomTwo", AtkTargetEnemyBase)

function AtkTargetEnemyNormalAndRandomTwo:getResult()
	local result = self:_defaultStrategy()
	local enterPosIndex = self:_getEnterPosIndex()
	local row = self:_getRow(enterPosIndex)
	local raceIds = self:_getRaceIds()
	local normalTargetIndex = self:_getRowFirst(row, raceIds)

	if not normalTargetIndex then
		return result
	end

	result[normalTargetIndex] = true

	local count = 2

	for i = 1, 9 do
		if raceIds[i] > 0 and normalTargetIndex < i and count > 0 then
			count = count - 1
			result[i] = true
		end
	end

	return result
end

return AtkTargetEnemyNormalAndRandomTwo
