-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/datastruct/BoundingBox2D.lua

module("framework.datastruct.BoundingBox2D", package.seeall)

local BoundingBox2D = class("BoundingBox2D")

function BoundingBox2D:ctor()
	self.width = 0
	self.height = 0
	self.halfWidth = 0
	self.halfHeight = 0
	self._center = Vector2.New()
end

function BoundingBox2D:setSize(width, height)
	self.width = width
	self.height = height
	self.halfWidth = self.width * 0.5
	self.halfHeight = self.height * 0.5
	self._minX = self._center.x - self.halfWidth
	self._minY = self._center.y - self.halfHeight
	self._maxX = self._center.x + self.halfWidth
	self._maxY = self._center.y + self.halfHeight
end

function BoundingBox2D:setCenter(x, y)
	self._center.x = x
	self._center.y = y
	self._minX = self._center.x - self.halfWidth
	self._minY = self._center.y - self.halfHeight
	self._maxX = self._center.x + self.halfWidth
	self._maxY = self._center.y + self.halfHeight
end

function BoundingBox2D:getCenter()
	return self._center
end

function BoundingBox2D:setBorders(minX, minY, maxX, maxY)
	self._minX = minX
	self._minY = minY
	self._maxX = maxX
	self._maxY = maxY
	self.width = maxX - minX
	self.height = maxY - minY
	self.halfWidth = self.width * 0.5
	self.halfHeight = self.height * 0.5
end

function BoundingBox2D:getBorders()
	return self._minX, self._minY, self._maxX, self._maxY
end

function BoundingBox2D:intersects(bounds)
	if self._minX > bounds._maxX or self._minY > bounds._maxY or self._maxX < bounds._minX or self._maxY < bounds._minY then
		return false
	end

	return true
end

function BoundingBox2D:contains(x, y)
	if y == nil then
		local p = x

		if p.x < self._minX or p.y < self._minY or p.x > self._maxX or p.y > self._maxY then
			return false
		end
	elseif x < self._minX or y < self._minY or x > self._maxX or y > self._maxY then
		return false
	end

	return true
end

return BoundingBox2D
