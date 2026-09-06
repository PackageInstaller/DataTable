-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetSelfZhongShangTwo.lua

module("logic.extensions.mission.view.atktarget.AtkTargetSelfZhongShangTwo", package.seeall)

local AtkTargetSelfZhongShangTwo = class("AtkTargetSelfZhongShangTwo", AtkTargetSelfBase, AtkTargetFrontPoses)

function AtkTargetSelfZhongShangTwo:getResult()
	return self:getFrontPoses(self._atkTargetParam, 2)
end

return AtkTargetSelfZhongShangTwo
