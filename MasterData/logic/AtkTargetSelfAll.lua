-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetSelfAll.lua

module("logic.extensions.mission.view.atktarget.AtkTargetSelfAll", package.seeall)

local AtkTargetSelfAll = class("AtkTargetSelfAll", AtkTargetSelfBase, AtkTargetFrontPoses)

function AtkTargetSelfAll:getResult()
	return self:getFrontPoses(self._atkTargetParam, 9)
end

return AtkTargetSelfAll
