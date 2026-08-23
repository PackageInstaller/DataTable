local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBase = class("OutpostEntityBase")

function OutpostEntityBase:ctor()
	self.x = 0
	self.y = 0
	self.entityType = var_0_2.EntityType.None
	self.oid = var_0_1:nextOid()
	self._isStatic = false
	self.node = nil
	self._isClear = false
	self.renderDependWidth = 0
	self.renderDependHeight = 0
	self.renderDependenciesAfter = {}
	self.renderDependenciesBefore = {}
	self.world = nil
end

function OutpostEntityBase:setClear(arg_2_1)
	self._isClear = arg_2_1
end

function OutpostEntityBase:isClear()
	return self._isClear
end

function OutpostEntityBase:dispose()
	if self.node then
		self.node:removeEntity(self)
	end

	if self.world then
		self.world:removeEntity(self)

		if not self.world.lockEvent then
			var_0_1:dispatchWorldEvent(OutpostEvent.EntityDestroy, self)
		end
	end

	self._isClear = true
end

function OutpostEntityBase:setStatic(arg_5_1)
	self._isStatic = arg_5_1
end

function OutpostEntityBase:isStatic()
	return self._isStatic
end

function OutpostEntityBase:setPos(arg_7_1, arg_7_2)
	if self.node then
		self.node:updateEntity(self, arg_7_1, arg_7_2)
	else
		self.x = arg_7_1
		self.y = arg_7_2
	end

	var_0_1:dispatchWorldEvent(OutpostEvent.EntityUpdatePos, self)
end

function OutpostEntityBase:setPosVec2(arg_8_1)
	self:setPos(arg_8_1.x, arg_8_1.y)
end

function OutpostEntityBase:getPos()
	return self.x, self.y
end

function OutpostEntityBase:isKnight()
	return self.entityType == var_0_2.EntityType.Knight
end

function OutpostEntityBase:isMonster()
	return self.entityType == var_0_2.EntityType.Monster
end

function OutpostEntityBase:isBoss()
	return self.entityType == var_0_2.EntityType.Boss
end

function OutpostEntityBase:isEnemy(arg_13_1)
	return var_0_2.EnemyMask[bit.bor(self.entityType, arg_13_1.entityType)]
end

function OutpostEntityBase:isFriendly(arg_14_1)
	return self.entityType == arg_14_1.entityType or var_0_2.FriendlyMask[bit.bor(self.entityType, arg_14_1.entityType)]
end

function OutpostEntityBase:canVictim()
	return false
end

function OutpostEntityBase:isHide()
	return false
end

function OutpostEntityBase:getDis2(arg_17_1)
	return (self.x - arg_17_1.x) * (self.x - arg_17_1.x) + (self.y - arg_17_1.y) * (self.y - arg_17_1.y)
end

function OutpostEntityBase:onDestroy()
	self:setClear(true)
end

function OutpostEntityBase:onTick(arg_19_1)
	return
end

function OutpostEntityBase:onSecondTick()
	return
end

function OutpostEntityBase:onCreate(arg_21_1)
	return
end

return OutpostEntityBase
