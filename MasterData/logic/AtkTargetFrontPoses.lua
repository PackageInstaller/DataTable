-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetFrontPoses.lua

module("logic.extensions.mission.view.atktarget.AtkTargetFrontPoses", package.seeall)

local AtkTargetFrontPoses = class("AtkTargetFrontPoses")

function AtkTargetFrontPoses:getFrontPoses(atkTargetParam, count)
	local result = {}

	for i = 1, 9 do
		result[i] = false
	end

	local num = count

	for i = 1, 9 do
		if atkTargetParam:isExistPet(i) and num > 0 then
			result[i] = true
			num = num - 1
		end
	end

	return result
end

return AtkTargetFrontPoses
