-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/UnitCompUIFollow.lua

module("logic.scene.unit.component.UnitCompUIFollow", package.seeall)

local UnitCompUIFollow = class("UnitCompUIFollow", UnitComponentBase)
local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
local uiCameraTarget = CameraTargetMgr.instance:getUICameraTarget()
local plane2D = SceneRoot2DMgr.instance:getSceneUIRoot().transform

function UnitCompUIFollow:onInit()
	self._uiFollow = self:_createUIFollow()

	self._uiFollow:SetFollowArgs(mainCameraTarget:getCamera(), uiCameraTarget:getCamera(), plane2D)
	self._uiFollow:SetPerspectiveArgs(10, 0.7, 1.5)
	self:onReuse()
end

function UnitCompUIFollow:_createUIFollow()
	local uiFollow = UIFollowUnit.Get(self._unit.go)

	uiFollow:CreateFollowGroup(0, 1)
	uiFollow:CreateFollowGroup(0, 0.5)
	uiFollow:CreateFollowGroup(0, 0)

	return uiFollow
end

function UnitCompUIFollow:onReuse()
	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function UnitCompUIFollow:onReset()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	self._uiFollow:Clear()
end

function UnitCompUIFollow:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)

	self._uiFollow = nil
end

function UnitCompUIFollow:forceFollow()
	if not self._uiFollow then
		return
	end

	self._uiFollow:ForceFollow()
end

function UnitCompUIFollow:setSize(x, y)
	if not self._uiFollow then
		return
	end

	self._uiFollow:SetUnitSize(x, y)
end

function UnitCompUIFollow:setPivot(followType, pivotX, pivotY)
	if not self._uiFollow then
		return
	end

	self._uiFollow:SetPivot(followType, pivotX, pivotY)
end

function UnitCompUIFollow:setPerspectiveEnable(enable)
	if not self._uiFollow then
		return
	end

	self._uiFollow:SetPerspectiveEnable(enable)
end

function UnitCompUIFollow:setPerspectiveArgs(standardDistance, minScale, maxScale)
	if self._uiFollow then
		self._uiFollow:SetPerspectiveArgs(standardDistance, minScale, maxScale)
	end
end

function UnitCompUIFollow:setMainGameObject(mainGameObject)
	if not self._uiFollow then
		return
	end

	self._uiFollow:SetMainGameObject(mainGameObject)
end

function UnitCompUIFollow:addFollowGameObject(followType, go)
	if not self._uiFollow then
		return
	end

	self._uiFollow:AddFollowGameObject(followType, go)
end

function UnitCompUIFollow:removeFollowGameObject(followType, go)
	if not self._uiFollow then
		return
	end

	self._uiFollow:RemoveFollowGameObject(followType, go)
end

function UnitCompUIFollow:removeAllFollowGameObject()
	if not self._uiFollow then
		return
	end

	self._uiFollow:RemoveAllFollowGameObject()
end

function UnitCompUIFollow:addTopFollowGameObject(go)
	self:addFollowGameObject(UIFollowType.Top, go)
end

function UnitCompUIFollow:removeTopFollowGameObject(go)
	self:removeFollowGameObject(UIFollowType.Top, go)
end

function UnitCompUIFollow:addCenterFollowGameObject(go)
	self:addFollowGameObject(UIFollowType.Center, go)
end

function UnitCompUIFollow:removeCenterFollowGameObject(go)
	self:removeFollowGameObject(UIFollowType.Center, go)
end

function UnitCompUIFollow:addBottomFollowGameObject(go)
	self:addFollowGameObject(UIFollowType.Bottom, go)
end

function UnitCompUIFollow:removeBottomFollowGameObject(go)
	self:removeFollowGameObject(UIFollowType.Bottom, go)
end

function UnitCompUIFollow:_onMeshModelLoaded()
	local size = self._unit.meshModel:getBodySize()

	self:setSize(size.x, size.y)

	if self._unit.meshModel:getInst() then
		self:setMainGameObject(self._unit.meshModel:getInst())
	end
end

return UnitCompUIFollow
