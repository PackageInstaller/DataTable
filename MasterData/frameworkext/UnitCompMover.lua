-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/unit/component/mover/UnitCompMover.lua

module("frameworkext.unit.component.mover.UnitCompMover", package.seeall)

local UnitCompMover = class("UnitCompMover", UnitComponentBase)

function UnitCompMover:ctor(unit)
	UnitCompMover.super.ctor(self, unit)

	self._speed = 0
	self._speedX = 0
	self._speedY = 0
	self._posX = 0
	self._posY = 0
	self._offsetY = 0
	self._wpPool = NavWayPoint.getPool()
	self._wayPoints = {}
	self._curWayPoint = nil
	self._accerationTime = 0
	self._startMoveTime = 0
end

function UnitCompMover:setPosDirectly(x, y)
	self:clearWayPoints()

	self._posX = x
	self._posY = y + self._offsetY

	self:dispatch(UnitNotify.PosChanged, true)
end

function UnitCompMover:getCurWayPoint()
	return self._curWayPoint
end

function UnitCompMover:setOffsetYIndex(index)
	self._offsetY = index % 50 * 0.001

	if self._offsetY < 0 then
		self._offsetY = 0
	elseif self._offsetY > 0.05 then
		self._offsetY = 0.05
	end
end

function UnitCompMover:getPos()
	return self._posX, self._posY
end

function UnitCompMover:setSpeed(speed)
	self._speed = speed

	if not self._curWayPoint or self._speed == 0 then
		self._speedX = 0
		self._speedY = 0
	else
		local vx = self._curWayPoint.x - self._posX
		local vy = self._curWayPoint.y - self._posY

		if vx == 0 and vy == 0 then
			self._speedX = 0
			self._speedY = 0
		else
			local length = math.sqrt(vx * vx + vy * vy)

			vx = vx / length
			vy = vy / length
			self._speedX = vx * self._speed
			self._speedY = vy * self._speed
		end
	end
end

function UnitCompMover:setAccelerationTime(time)
	self._accerationTime = time
end

function UnitCompMover:getAccelerationTime()
	return self._accerationTime
end

function UnitCompMover:setWayPoint(x, y)
	if not self._wayPoints then
		return
	end

	local len = #self._wayPoints

	for i = 1, len do
		self._wpPool:returnObject(self._wayPoints[i])

		self._wayPoints[i] = nil
	end

	local wp = self._wpPool:fetchObject()

	wp.x = x
	wp.y = y + self._offsetY

	self:_setNewWayPoint(wp)
end

function UnitCompMover:addWayPoint(x, y)
	if self._posX == x and self._posY == y then
		if not self._curWayPoint then
			return
		elseif self._curWayPoint.x == x and self._curWayPoint.y == y then
			return
		end
	end

	local wp = self._wpPool:fetchObject()

	wp.x = x
	wp.y = y + self._offsetY

	if not self._curWayPoint then
		self:_setNewWayPoint(wp)
	else
		table.insert(self._wayPoints, wp)
	end
end

function UnitCompMover:clearWayPoints()
	local len = #self._wayPoints

	for i = 1, len do
		self._wpPool:returnObject(self._wayPoints[i])

		self._wayPoints[i] = nil
	end

	if self._curWayPoint then
		self:_setNewWayPoint(nil)
		self:dispatch(UnitNotify.Interrupt)
	end
end

function UnitCompMover:_setNewWayPoint(wp)
	local bStartMove = false

	if self._curWayPoint then
		self._wpPool:returnObject(self._curWayPoint)
	elseif wp then
		bStartMove = true
	end

	self._curWayPoint = wp

	if not self._curWayPoint or self._speed == 0 then
		self._speedX = 0
		self._speedY = 0
	else
		local vx = self._curWayPoint.x - self._posX
		local vy = self._curWayPoint.y - self._posY

		if vx == 0 and vy == 0 then
			self._speedX = 0
			self._speedY = 0
		else
			local length = math.sqrt(vx * vx + vy * vy)

			vx = vx / length
			vy = vy / length
			self._speedX = vx * self._speed
			self._speedY = vy * self._speed
		end
	end

	if bStartMove then
		self._startMoveTime = Time.time

		self:dispatch(UnitNotify.StartMove)
	end
end

function UnitCompMover:update()
	if self._curWayPoint then
		local speedFactor = Time.deltaTime

		if self._accerationTime > 0 then
			local elapsedTime = Time.time - self._startMoveTime

			if elapsedTime < self._accerationTime then
				speedFactor = speedFactor * (elapsedTime / self._accerationTime)
			end
		end

		local nextPosX = self._posX + self._speedX * speedFactor
		local nextPosY = self._posY + self._speedY * speedFactor
		local vecNowNextX = nextPosX - self._posX
		local vecNowNextY = nextPosY - self._posY
		local vecNowDestX = self._curWayPoint.x - self._posX
		local vecNowDestY = self._curWayPoint.y - self._posY
		local distNext = vecNowNextX * vecNowNextX + vecNowNextY * vecNowNextY
		local distDest = vecNowDestX * vecNowDestX + vecNowDestY * vecNowDestY

		if distDest <= distNext then
			self._posX = self._curWayPoint.x
			self._posY = self._curWayPoint.y

			self:dispatch(UnitNotify.PosChanged)
			self:dispatch(UnitNotify.PassWayPoint, self._posX, self._posY)

			if #self._wayPoints > 0 then
				local newWp = self._wayPoints[1]

				table.remove(self._wayPoints, 1)
				self:_setNewWayPoint(newWp)
			else
				self:_setNewWayPoint(nil)
				self:dispatch(UnitNotify.Arrive)
			end
		else
			self._posX = nextPosX
			self._posY = nextPosY

			self:dispatch(UnitNotify.PosChanged)
		end
	end
end

function UnitCompMover:onDestroy()
	self:clearWayPoints()

	self._wpPool = nil
	self._wayPoints = nil
	self._curWayPoint = nil
	self._offsetY = nil
end

return UnitCompMover
