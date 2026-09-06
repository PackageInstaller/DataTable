-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaycake/view/BirthdayCakeDivide.lua

module("logic.extensions.birthdaycake.view.BirthdayCakeDivide", package.seeall)

local BirthdayCakeDivide = class("BirthdayCakeDivide")

function BirthdayCakeDivide:ctor(go, func)
	self._btnDivide = go
	self._func = func
end

function BirthdayCakeDivide:onEnter()
	self._dragTrigger = Framework.UIDragTrigger.Get(self._btnDivide.gameObject)
	self._dragTrigger.enabled = true

	self._dragTrigger:AddBeginDragListener(self._onBeginDragDivide, self)
	self._dragTrigger:AddEndDragListener(self._onEndDragDivide, self)
	self._dragTrigger:AddDragListener(self._onDragDivide, self)

	self._collider = goutil.findChild(self._btnDivide.gameObject, "collider").transform

	local scaleX, scaleY = Framework.TransformUtil.GetLocalScale(self._btnDivide.transform, 1, 1, 1)
	local cx, cyPos = Framework.TransformUtil.GetLocalPos(self._collider, nil, nil, nil)

	self._colliderLocalX = cx * scaleX
	self._colliderLocalY = cyPos * scaleY

	local sizeDelta = self._collider.transform.sizeDelta

	self._colliderSizeX = sizeDelta.x * scaleX
	self._colliderSizeY = sizeDelta.y * scaleY
	self._boundingBox = BoundingBox2D.New()
end

function BirthdayCakeDivide:onExit()
	self._boundingBox = nil

	self._dragTrigger:RemoveBeginDragListener()
	self._dragTrigger:RemoveEndDragListener()
	self._dragTrigger:RemoveDragListener()
end

function BirthdayCakeDivide:getColliderPos()
	local x, y = Framework.TransformUtil.GetLocalPos(self._btnDivide.transform, nil, nil, nil)

	return self._colliderLocalX + x, y + self._colliderLocalY
end

function BirthdayCakeDivide:getBoundingBox()
	local x, y = self:getColliderPos()

	self._boundingBox:setSize(self._colliderSizeX, self._colliderSizeY)
	self._boundingBox:setCenter(x, y)

	return self._boundingBox
end

function BirthdayCakeDivide:_onDragDivide(eventData)
	self._btnDivide.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function BirthdayCakeDivide:_onBeginDragDivide()
	local trans = self._btnDivide.transform

	self._initialPosX, self._initialPosY, self._initialPosZ = Framework.TransformUtil.GetLocalPos(trans, 0, 0, 0)
end

function BirthdayCakeDivide:_onEndDragDivide()
	local trans = self._btnDivide.transform

	GameUtil.callBack(self._func)
	Framework.TransformUtil.SetLocalPos(trans, self._initialPosX, self._initialPosY, self._initialPosZ)
end

return BirthdayCakeDivide
