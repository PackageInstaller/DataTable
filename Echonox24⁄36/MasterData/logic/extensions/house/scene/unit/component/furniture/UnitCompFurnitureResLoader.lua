-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/furniture/UnitCompFurnitureResLoader.lua

module("logic.extensions.house.scene.unit.component.furniture.UnitCompFurnitureResLoader", package.seeall)

local M = class("UnitCompFurnitureResLoader", UnitComponentBase)
local FurnitureOperaType = HouseEnum.FurnitureOperaType
local vec3Temp = Vector3.New()

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = nil
	self._goInst = nil
	self._originRotaX = nil
	self._originRotaY = nil
	self._originRotaZ = nil
	self._navObstacle = nil
end

function M:onInit()
	self._resLoader = SingleResLoader.New()

	self:_resetData()
end

function M:_resetData()
	return
end

function M:onReuse()
	return
end

function M:onReset()
	self:destroyGoInst()
	self._resLoader:clear()
	self:_resetData()
end

function M:onDestroy()
	self:onReset()

	self._resLoader = false
end

function M:loadRes()
	local url = self._unit.model:getResUrl()

	self._resLoader:load(url, self._onResLoaded, self)
end

function M:_onResLoaded()
	self:destroyGoInst()

	self._goInst = self._resLoader:getResInstance()

	goutil.addChildToParent(self._goInst, self._unit.go)
	goutil.setActive(self._goInst, true)

	self._originRotaX, self._originRotaY, self._originRotaZ = Astral.TransformUtil.GetLocalRotation(self._goInst.transform, 0, 0, 0)

	self:refreshByAngle()
	self._unit.perform:initTrigger()
	self._unit:dispatchInnerEvent(UnitActionType.FurnitureLoaded, self)

	local roomUnit = self._unit.model:getBelongRoom()

	if roomUnit then
		roomUnit:dispatchInnerEvent(UnitActionType.RoomFurnitureResLoaded, self._unit.model:getOperaType(), self._unit.model:getFurnitureId(), self._unit.model:getUUId())
	end
end

function M:destroyGoInst()
	self._unit.perform:clearTrigger()
	self._unit.animation:clear()

	if self._goInst then
		goutil.destroy(self._goInst)
	end

	self._goInst = false
	self._navObstacle = false
	self._originRotaX = false
	self._originRotaY = false
	self._originRotaZ = false
end

function M:refreshByAngle()
	if self._goInst then
		local angle = 0

		if self._unit.model:getOperaType() == FurnitureOperaType.Wall then
			local wallType = self._unit.model:getWallType()

			angle = HouseEnum.WallType2Angle[wallType]
		else
			angle = self._unit.model:getAngle()
		end

		local rotaY = self._originRotaY + angle

		Astral.TransformUtil.SetLocalRotation(self._goInst.transform, self._originRotaX, rotaY, self._originRotaZ)
	end
end

function M:getGO()
	return self._goInst
end

function M:getBoxColliderCenter()
	if self._goInst then
		local boxCollider = self._goInst:GetComponent(ComponentType.BoxCollider)

		if boxCollider then
			return boxCollider.center
		end
	end
end

function M:getBoxColliderSize()
	if self._goInst then
		local boxCollider = self._goInst:GetComponent(ComponentType.BoxCollider)

		if boxCollider then
			return boxCollider.size
		end
	end
end

function M:_createNavObstacle()
	self._navObstacle = false

	if self._goInst and self._unit.model:getOperaType() == FurnitureOperaType.Floor then
		self._navObstacle = goutil.addComponentOnce(self._goInst, ComponentType.NavMeshObstacle)

		local edge = 0.5

		vec3Temp:Set(0, edge / 2, 0)

		local boxCenter = self:getBoxColliderCenter()

		if boxCenter then
			self._navObstacle.center = boxCenter
		else
			self._navObstacle.center = vec3Temp
		end

		vec3Temp:Set(edge, edge, edge)

		local boxSize = self:getBoxColliderSize()

		if boxSize then
			self._navObstacle.size = boxSize
		else
			self._navObstacle.size = vec3Temp
		end

		self._navObstacle.carving = true
		self._navObstacle.carvingTimeToStationary = HouseEnum.FURNITURE_CARVING_TIME
	end
end

return M
