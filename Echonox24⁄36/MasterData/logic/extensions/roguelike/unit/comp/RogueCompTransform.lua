-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/RogueCompTransform.lua

module("logic.extensions.roguelike.unit.comp.RogueCompTransform", package.seeall)

local M = class("RogueCompTransform", RogueUnitCompBase)

function M:onInit()
	self._loader = self._unit.loader
	self._transform = self._unit.go.transform
	self._position = self._transform.position
	self._localPosition = self._transform.localPosition
	self._spineDirection = UnitSpineDir.Right
end

function M:onReuse()
	return
end

function M:onReset()
	return
end

function M:onDestroy()
	self._loader = nil
	self._transform = nil
	self._position = nil
	self._localPosition = nil
end

function M:onResourceLoaded()
	self:_updateDirection()
end

function M:getPosition()
	return self._transform.position
end

function M:getLocalPosition()
	return self._localPosition
end

function M:setPosition(position)
	self:setPositionXYZ(position:Get())
end

function M:setPositionXYZ(x, y, z)
	if self._position.x == x and self._position.y == y and self._position.z == z then
		return
	end

	self._position:Set(x, y, z)
	Astral.TransformUtil.SetPos(self._transform, x, y, z)
end

function M:doMove(pos, duration)
	return self._transform:DOMove(pos, duration)
end

function M:doRotation(rotation, duration)
	return self._transform:DORotate(rotation, duration)
end

function M:setLocalPosition(localPosition)
	self:setLocalPositionXYZ(localPosition:Get())
end

function M:setLocalPositionXYZ(x, y, z)
	if self._localPosition.x == x and self._localPosition.y == y and self._localPosition.z == z then
		return
	end

	self._localPosition:Set(x, y, z)
	Astral.TransformUtil.SetLocalPos(self._transform, x, y, z)
end

function M:setScale(localScale)
	self:setScaleXYZ(localScale:Get())
end

function M:setScaleXYZ(x, y, z)
	Astral.TransformUtil.SetLocalScale(self._transform, x, y, z)
end

function M:setScaleX(x)
	local scale = self._transform.localScale

	Astral.TransformUtil.SetLocalScale(self._transform, x * math.abs(scale.x), scale.y, scale.z)
end

function M:SetEulerAngles(x, y, z)
	TransformUtils.SetEulerAngles(self._transform, x, y, z)
end

function M:rotationToAxis(axis)
	Astral.RotationToAxis(self._transform, axis.x, axis.y, axis.z)
end

function M:setActive(isActive)
	goutil.setActive(self._transform.gameObject, isActive)
end

function M:setSpineDirection(spineDirection)
	self._spineDirection = spineDirection

	self:_updateDirection()
end

function M:_updateDirection()
	if self._spineDirection == UnitSpineDir.Right then
		return
	end

	local inst = self._loader:getInst()

	if not inst then
		return
	end

	local trans = inst.transform
	local x, y, z = Astral.TransformUtil.GetLocalPos(trans, 0, 0, 0)

	Astral.TransformUtil.SetLocalPos(trans, -x, y, z)
	Astral.TransformUtil.SetLocalRotation(trans, 0, 180, 0)
end

return M
