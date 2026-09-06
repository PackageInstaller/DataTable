-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaycake/view/BirthdayCakeThings.lua

module("logic.extensions.birthdaycake.view.BirthdayCakeThings", package.seeall)

local BirthdayCakeThings = class("BirthdayCakeThings", BirthdayCakeDivide)

function BirthdayCakeThings:ctor(go, func, index)
	self._btnDivide = go
	self._index = index
	self._func = func
end

function BirthdayCakeThings:_onEndDragDivide()
	local trans = self._btnDivide.transform

	GameUtil.callBack(self._func, self._index)
	Framework.TransformUtil.SetLocalPos(trans, self._initialPosX, self._initialPosY, self._initialPosZ)
end

return BirthdayCakeThings
