-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/impl/UnitPhotoSpine.lua

module("logic.scene.unit.impl.UnitPhotoSpine", package.seeall)

local UnitPhotoSpine = class("UnitPhotoSpine", UnitBase)

function UnitPhotoSpine:getTag()
	return UnitTag.Player
end

function UnitPhotoSpine:getLayer()
	return SceneLayer.UI3D_Value
end

function UnitPhotoSpine:_initComponents()
	self:_addComponent("spine", UnitCompSpine)
	self:_addComponent("spineEvent", UnitCompSpineEventListener)
	self:_addComponent("material", UnitPhotoSpineMaterial)
end

return UnitPhotoSpine
