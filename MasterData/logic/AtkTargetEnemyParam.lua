-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetEnemyParam.lua

module("logic.extensions.mission.view.atktarget.AtkTargetEnemyParam", package.seeall)

local AtkTargetEnemyParam = class("AtkTargetEnemyParam", AtkTargetParamBase)

function AtkTargetEnemyParam:reset()
	AtkTargetEnemyParam.super.reset(self)

	self.raceIds = nil
end

function AtkTargetEnemyParam:_getRaceIds()
	return self._atkTargetParam.raceIds
end

function AtkTargetEnemyParam:isExistPet(index)
	if self.raceIds[index] then
		return self.raceIds[index] > 0
	else
		return false
	end
end

return AtkTargetEnemyParam
