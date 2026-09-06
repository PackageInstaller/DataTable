-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetSelfParam.lua

module("logic.extensions.mission.view.atktarget.AtkTargetSelfParam", package.seeall)

local AtkTargetSelfParam = class("AtkTargetSelfParam", AtkTargetParamBase)

function AtkTargetSelfParam:reset()
	AtkTargetSelfParam.super.reset(self)

	self.tempPetIds = nil
end

function AtkTargetSelfParam:isExistPet(index)
	if self.tempPetIds[index] then
		return self.tempPetIds[index] > 0
	else
		return false
	end
end

return AtkTargetSelfParam
