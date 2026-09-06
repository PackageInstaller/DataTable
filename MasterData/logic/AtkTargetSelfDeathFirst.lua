-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetSelfDeathFirst.lua

module("logic.extensions.mission.view.atktarget.AtkTargetSelfDeathFirst", package.seeall)

local AtkTargetSelfDeathFirst = class("AtkTargetSelfDeathFirst", AtkTargetSelfBase, AtkTargetFrontPoses)

function AtkTargetSelfDeathFirst:getResult()
	return self:getFrontPoses(self._atkTargetParam, 1)
end

return AtkTargetSelfDeathFirst
