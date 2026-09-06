-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetParamBase.lua

module("logic.extensions.mission.view.atktarget.AtkTargetParamBase", package.seeall)

local AtkTargetParamBase = class("AtkTargetParamBase")

function AtkTargetParamBase:ctor()
	self:reset()
end

function AtkTargetParamBase:reset()
	self.dragPetId = 0
	self.enterPosIndex = 0
end

function AtkTargetParamBase:isExistPet(index)
	return
end

return AtkTargetParamBase
