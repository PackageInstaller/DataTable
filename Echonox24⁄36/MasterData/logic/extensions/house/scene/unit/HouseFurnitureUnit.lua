-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/HouseFurnitureUnit.lua

module("logic.extensions.house.scene.unit.HouseFurnitureUnit", package.seeall)

local M = class("HouseFurnitureUnit", ReusableUnitBase)
local FurnitureOperaType = HouseEnum.FurnitureOperaType
local WallType = HouseEnum.WallType
local kCalculPosGoName = "_calcul_pos_go_"

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:_initComponents()
	self:_addComponent("model", UnitCompFurnitureModel)
	self:_addComponent("resLoader", UnitCompFurnitureResLoader)
	self:_addComponent("perform", UnitCompFurniturePerform)
	self:_addComponent("animation", UnitCompFurnitureAnima)
end

function M:isEffective()
	local furnId = self.model:getFurnitureId()

	return checknumber(furnId) > 0
end

function M:getCenterWorldPos()
	local zLen = self.model:getCoordZLen() / 2 * HouseEnum.FURNITURE_COORD_SIZE
	local offsetX, offsetY, offsetZ = 0, 0, 0

	if self.model:getOperaType() == FurnitureOperaType.Floor then
		offsetY = zLen
	elseif self.model:getOperaType() == FurnitureOperaType.Wall then
		local wallType = self.model:getWallType()

		if wallType == WallType.Middle then
			offsetZ = -1 * zLen
		elseif wallType == WallType.Left then
			offsetX = zLen
		elseif wallType == WallType.Right then
			offsetX = -1 * zLen
		end
	elseif self.model:getOperaType() == FurnitureOperaType.Ceiling then
		offsetY = -1 * zLen
	end

	return self:getWorldPosByOffset(offsetX, offsetY, offsetZ)
end

function M:getWorldPosByOffset(offsetX, offsetY, offsetZ)
	local calculGO = self:_tryGetCalculPosGO()

	Astral.TransformUtil.SetLocalPos(calculGO.transform, offsetX, offsetY, offsetZ)

	return Astral.TransformUtil.GetPos(calculGO.transform, 0, 0, 0)
end

function M:_tryGetCalculPosGO()
	local go = goutil.findChild(self.go, kCalculPosGoName)

	if not go then
		go = goutil.create(kCalculPosGoName, false)

		goutil.addChildToParent(go, self.go)
	end

	return go
end

return M
