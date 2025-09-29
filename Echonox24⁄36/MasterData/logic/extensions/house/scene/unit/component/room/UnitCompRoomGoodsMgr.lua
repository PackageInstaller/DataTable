-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomGoodsMgr.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomGoodsMgr", package.seeall)

local M = class("UnitCompRoomGoodsMgr", UnitComponentBase)
local RoomType = HouseEnum.RoomType
local ContainerRootName = "GoodsUnitRoot"

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._goodsId = nil
	self._dictGoodsUnit = nil
end

function M:onInit()
	self._goodsId = 0
	self._dictGoodsUnit = {}
end

function M:onReset()
	self:destroyAllGoods()

	self._goodsId = 0
end

function M:onDestroy()
	self:onReset()
end

function M:getGoodsCreatePos()
	local navMO = self._unit.model:getNavigationData()

	return navMO:getCreateGoodsPos()
end

function M:getGoodsReturnPos()
	local navMO = self._unit.model:getNavigationData()

	return navMO:getReturnGoodsPos()
end

function M:createGoods()
	self._goodsId = self._goodsId + 1

	local roomId = self._unit.model:getRoomId()
	local goName = string.format("goods_%s_%s", roomId, self._goodsId)
	local pos = self:getGoodsCreatePos()

	if pos then
		local goodsUnit = RoomGoodsUnit:createInstance(goName, pos.x, pos.y, pos.z)

		goutil.addChildToParent(goodsUnit.go, self:_getContainerRoot())
		goodsUnit:setUnitAngle(self._unit.model:getRoomAngle())
		goodsUnit:setOriginRoomId(roomId)

		goodsUnit.id = self._goodsId
		self._dictGoodsUnit[goodsUnit.id] = goodsUnit

		return goodsUnit
	end
end

function M:removeGoods(unit)
	self._dictGoodsUnit[unit.id] = nil
end

function M:destroyGoods(unit)
	self._dictGoodsUnit[unit.id] = nil

	unit:returnSelf()
end

function M:destroyAllGoods()
	for id, unit in pairs(self._dictGoodsUnit) do
		unit:returnSelf()

		self._dictGoodsUnit[id] = nil
	end
end

function M:_getContainerRoot()
	local sceneContainer = SceneMgr.instance:getCurScene():getContainer()
	local goContainer = goutil.findChild(sceneContainer, ContainerRootName)

	if not goContainer then
		goContainer = goutil.create(ContainerRootName, false)

		goutil.addChildToParent(goContainer, sceneContainer)
	end

	return goContainer
end

return M
