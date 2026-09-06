-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetSelfZhongShangOne.lua

module("logic.extensions.mission.view.atktarget.AtkTargetSelfZhongShangOne", package.seeall)

local AtkTargetSelfZhongShangOne = class("AtkTargetSelfZhongShangOne", AtkTargetSelfBase, AtkTargetFrontPoses)

function AtkTargetSelfZhongShangOne:getResult()
	return self:getFrontPoses(self._atkTargetParam, 1)
end

return AtkTargetSelfZhongShangOne
