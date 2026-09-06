-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetSelfZhongShangThree.lua

module("logic.extensions.mission.view.atktarget.AtkTargetSelfZhongShangThree", package.seeall)

local AtkTargetSelfZhongShangThree = class("AtkTargetSelfZhongShangThree", AtkTargetSelfBase, AtkTargetFrontPoses)

function AtkTargetSelfZhongShangThree:getResult()
	return self:getFrontPoses(self._atkTargetParam, 3)
end

return AtkTargetSelfZhongShangThree
