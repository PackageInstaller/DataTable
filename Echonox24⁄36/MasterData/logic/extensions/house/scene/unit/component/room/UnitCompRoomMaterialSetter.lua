-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomMaterialSetter.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomMaterialSetter", package.seeall)

local M = class("UnitCompRoomMaterialSetter", UnitComponentBase)
local RoomType = HouseEnum.RoomType
local RoomOpenTyp = HouseMainEnum.RoomOpenTyp
local kColorContrastID = UnityEngine.Shader.PropertyToID("_ColorContrast")
local kColorCurveStrengthID = UnityEngine.Shader.PropertyToID("_ColorCurveStrength")

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._mainMaterialSetter = nil
	self._emptyMaterialSetter = nil
end

function M:onInit()
	return
end

function M:onLateInit()
	return
end

function M:onReuse()
	return
end

function M:onReset()
	self:onRoomResUnload()

	if self._emptyMaterialSetter then
		self._emptyMaterialSetter:ClearPropertyBlock()
		self._emptyMaterialSetter:Clear()
	end

	self._emptyMaterialSetter = nil
end

function M:onDestroy()
	self:onReset()
end

function M:onRoomEnter(hasRes)
	local roomType = self._unit.model:getRoomType()

	if roomType == RoomType.Shelter then
		local emptyRoomGO = self._unit.resLoader:getEmptyGO()

		if emptyRoomGO and self._emptyMaterialSetter == nil then
			self._emptyMaterialSetter = BatchMaterialSetter.Get(emptyRoomGO)

			self:refreshActiveStatus()
		end
	end
end

function M:onRoomExit()
	return
end

function M:onRoomResLoaded()
	local roomGO = self._unit.resLoader:getRoomGO()
	local roomType = self._unit.model:getRoomType()

	if roomGO and roomType == RoomType.Living then
		self._mainMaterialSetter = BatchMaterialSetter.Get(roomGO)

		self:refreshActiveStatus()
	end
end

function M:onRoomResUnload()
	if self._mainMaterialSetter then
		self._mainMaterialSetter:ClearPropertyBlock()
		self._mainMaterialSetter:Clear()
	end

	self._mainMaterialSetter = nil
end

function M:refreshActiveStatus()
	local roomType = self._unit.model:getRoomType()
	local materialSetter = roomType == RoomType.Shelter and self._emptyMaterialSetter or self._mainMaterialSetter

	if materialSetter then
		local openType = self._unit.model:getOpenType()
		local unactive = openType == RoomOpenTyp.OpenUnActive

		materialSetter:SetFloat(kColorContrastID, unactive and 1.15 or 1)
		materialSetter:SetFloat(kColorCurveStrengthID, unactive and 7.58 or 1)
	end
end

return M
