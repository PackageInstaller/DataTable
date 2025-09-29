-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/AirWorkUnitCompTransform.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.AirWorkUnitCompTransform", package.seeall)

local M = class("AirWorkUnitCompTransform", BattleUnitCompBase)

function M:onInit()
	self._scaleX = 1
	self._isComposite = false
	self._coordinates = false
	self._originalCoordinates = false

	self:onReuse()
end

function M:onReuse()
	self._coordinates = Coordinates:createInstance(0, 0)
	self._originalCoordinates = Coordinates:createInstance(0, 0)

	self:resetCoordinates()
end

function M:onReset()
	if self._vertices then
		BattleTableUtil.clearReusableTable(self._vertices)

		self._vertices = false
	end

	if self._rectangle then
		self._rectangle:returnSelf()

		self._rectangle = false
	end

	if self._coordinates then
		self._coordinates:returnSelf()

		self._coordinates = false
	end

	if self._originalCoordinates then
		self._originalCoordinates:returnSelf()

		self._originalCoordinates = false
	end

	self._scaleX = 1
	self._isComposite = false
end

function M:onDestroy()
	self:onReset()
end

function M:setShape(shape)
	if not shape then
		printError(self._unit.property:getName(), "没有配置shape")
	end

	if shape[1] == 1 and shape[2] == 1 then
		return
	end

	if not self._vertices then
		self._isComposite = true
		self._vertices = {}
		self._rectangle = Rectangle:createInstance(0, 0, 0, 0)
	else
		BattleTableUtil.clearReusableTable(self._vertices)
	end

	for x = 0, shape[1] - 1 do
		for y = 0, shape[2] - 1 do
			table.insert(self._vertices, Coordinates:createInstance(x, y))
		end
	end

	self:recalculateBounds()
end

function M:setVertexArray(vertexArray)
	if not vertexArray then
		return
	end

	if not self._vertices then
		self._isComposite = true
		self._vertices = {}
		self._rectangle = Rectangle:createInstance(0, 0, 0, 0)
	else
		BattleTableUtil.clearReusableTable(self._vertices)
	end

	for i = 1, #vertexArray, 2 do
		table.insert(self._vertices, Coordinates:createInstance(vertexArray[i], vertexArray[i + 1]))
	end

	self:recalculateBounds()
end

function M:recalculateBounds()
	if not self:isComposite() then
		return
	end

	local rectangle = self._rectangle

	for _, vertex in pairs(self._vertices) do
		local x = vertex:getX()
		local z = vertex:getZ()

		if x > rectangle:getMaxx() then
			rectangle:setMaxx(x)
		elseif x < rectangle:getMinx() then
			rectangle:setMinx(x)
		end

		if z > rectangle:getMaxz() then
			rectangle:setMaxz(z)
		elseif z < rectangle:getMinz() then
			rectangle:setMinz(z)
		end
	end
end

function M:getCenterOffSet()
	if not self:isComposite() then
		return 0, 0
	end

	local rectangle = self._rectangle
	local length = SpaceX.CheckBoardSetting.GetSideLength()

	return length * (rectangle:getMaxx() + rectangle:getMinx()) / 2, length * (rectangle:getMaxz() + rectangle:getMinz()) / 2
end

function M:getRectangle()
	return self._rectangle
end

function M:getVertices()
	return self._vertices
end

function M:setScaleX(scaleX)
	self._scaleX = scaleX
end

function M:setCoordinates(x, z)
	self._coordinates:setXZ(x, z)
end

function M:setOriginalCoordinates(x, z)
	self._originalCoordinates:setXZ(x, z)
end

function M:getOriginalCoordinates()
	return self._originalCoordinates:getXZ()
end

function M:getCoordinates()
	return self._coordinates:getXZ()
end

function M:resetCoordinates()
	self._coordinates:setXZ(-1, -1)
end

function M:containsCoordinates(x, z)
	local localX, localZ = self:inverseTransformCoordinates(x, z)

	return self:containsLocalCoordinates(localX, localZ)
end

function M:testContainsCoordinates(coordinatesX, coordinatesZ, x, z)
	local localX, localZ = self:testInverseTransformCoordinates(coordinatesX, coordinatesZ, x, z)

	return self:containsLocalCoordinates(localX, localZ)
end

function M:containsLocalCoordinates(localX, localZ)
	if self:isComposite() then
		local vertices = self:getVertices()

		for _, vertex in pairs(vertices) do
			if localX == vertex:getX() and localZ == vertex:getZ() then
				return true
			end
		end

		return false
	else
		return localX == 0 and localZ == 0
	end
end

function M:isComposite()
	return self._isComposite
end

function M:transformCoordinates(localX, localZ)
	local coordinates = self._coordinates

	return localX + coordinates:getX(), localZ + coordinates:getZ()
end

function M:testTransformCoordinates(coordinatesX, coordinatesZ, localX, localZ)
	return localX + coordinatesX, localZ + coordinatesZ
end

function M:inverseTransformCoordinates(x, z)
	local coordinates = self._coordinates

	return x - coordinates:getX(), z - coordinates:getZ()
end

function M:testInverseTransformCoordinates(coordinatesX, coordinatesZ, x, z)
	return x - coordinatesX, z - coordinatesZ
end

function M:inverseTransformToHitVertex(x, z)
	x, z = self:inverseTransformCoordinates(x, z)

	local scaleX = self._scaleX

	if self:isComposite() and scaleX < 0 then
		local rectangle = self._rectangle
		local offsetX = rectangle:getMinx() + rectangle:getMaxx()

		x = -x + offsetX
	end

	return x, z
end

return M
