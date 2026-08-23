local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBullet = class("OutpostEntityBullet", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBase"))

function OutpostEntityBullet:ctor()
	OutpostEntityBullet.super.ctor(self)

	self.entityType = var_0_2.EntityType.Bullet
	self._bulletSpeed = var_0_2.WorldParam.BulletSpeed
	self._tickCount = 0
end

function OutpostEntityBullet:onCreate(arg_2_1)
	self._fightResult = arg_2_1

	if arg_2_1.playInfo then
		self._bulletSpeed = arg_2_1.playInfo.trajectory_speed
	end

	self._startPos = cc.p(arg_2_1.attacker:getPos())
	self._startPos.y = self._startPos.y - var_0_2.WorldParam.BulletStartHeight
	self._endPos = cc.p(arg_2_1.victim:getPos())
	self._endPos.y = self._endPos.y - var_0_2.WorldParam.BulletStartHeight

	local var_2_0 = math.sqrt((self._endPos.x - self._startPos.x) * (self._endPos.x - self._startPos.x) + (self._endPos.y - self._startPos.y) * (self._endPos.y - self._startPos.y))

	if var_2_0 > 0 then
		self._normalizeX = (self._endPos.x - self._startPos.x) / var_2_0
		self._normalizeY = (self._endPos.y - self._startPos.y) / var_2_0
	end

	self:setPosVec2(self._startPos)
end

function OutpostEntityBullet:onTick(arg_3_1)
	if not self._fightResult.victim:canVictim() then
		self:dispose()

		return
	end

	local var_3_0 = self._endPos.x - self._startPos.x

	if var_3_0 * var_3_0 + (self._endPos.y - self._startPos.y) * (self._endPos.y - self._startPos.y) < var_0_2.WorldParam.BulletBoomDist2 then
		self._fightResult:applySkill()
		var_0_1:dispatchWorldEvent(OutpostEvent.RoleUpdateFightEffect, self._fightResult)
		self:dispose()

		return
	else
		self._startPos.x = self._startPos.x + self._normalizeX * (arg_3_1 * self._bulletSpeed)
		self._startPos.y = self._startPos.y + self._normalizeY * (arg_3_1 * self._bulletSpeed)

		self:setPosVec2(self._startPos)
	end

	self._tickCount = self._tickCount + 1

	if self._tickCount > var_0_2.WorldParam.TickDelayCount then
		self._tickCount = 0
		self._endPos = cc.p(self._fightResult.victim:getPos())
		self._endPos.y = self._endPos.y - var_0_2.WorldParam.BulletStartHeight

		local var_3_1 = math.sqrt((self._endPos.x - self._startPos.x) * (self._endPos.x - self._startPos.x) + (self._endPos.y - self._startPos.y) * (self._endPos.y - self._startPos.y))

		if var_3_1 > 0 then
			self._normalizeX = (self._endPos.x - self._startPos.x) / var_3_1
			self._normalizeY = (self._endPos.y - self._startPos.y) / var_3_1
		end
	end
end

function OutpostEntityBullet:getFightResult()
	return self._fightResult
end

function OutpostEntityBullet:onDestroy()
	self._fightResult:dispose()

	self._fightResult = nil
end

return OutpostEntityBullet
