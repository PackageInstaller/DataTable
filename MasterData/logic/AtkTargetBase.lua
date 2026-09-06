-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetBase.lua

module("logic.extensions.mission.view.atktarget.AtkTargetBase", package.seeall)

local AtkTargetBase = class("AtkTargetBase")

function AtkTargetBase:ctor()
	return
end

function AtkTargetBase:init(atkTargetParam)
	self._atkTargetParam = atkTargetParam
end

function AtkTargetBase:getResult()
	return self:_defaultStrategy()
end

function AtkTargetBase:_getEnterPosIndex()
	return self._atkTargetParam.enterPosIndex
end

function AtkTargetBase:_defaultStrategy()
	local result = {}

	for i = 1, 9 do
		result[i] = false
	end

	return result
end

function AtkTargetBase:_getRow(posIndex)
	local posIndex = Mathf.Clamp(posIndex, 1, 9)

	return (posIndex - 1) % 3 + 1
end

function AtkTargetBase:_getColumn(posIndex)
	local posIndex = Mathf.Clamp(posIndex, 1, 9)

	return (posIndex - 1) / 3 + 1
end

return AtkTargetBase
