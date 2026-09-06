-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/buff/BaseJumpFloorBuff.lua

module("logic.extensions.jumpfloor.view.buff.BaseJumpFloorBuff", package.seeall)

local BaseJumpFloorBuff = class("BaseJumpFloorBuff")

function BaseJumpFloorBuff:ctor(baseJumpFloorGame)
	self._baseJumpFloorGame = baseJumpFloorGame
end

function BaseJumpFloorBuff:excute()
	return
end

return BaseJumpFloorBuff
