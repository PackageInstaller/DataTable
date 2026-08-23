local var_0_0 = math.min
local var_0_1 = math.max
local var_0_2 = math.floor
local OutpostAttrType = require("app.view.module.outpost.simulationWorld.fight.OutpostAttrType")
local OutpostAttrEntry = class("OutpostAttrEntry")

function OutpostAttrEntry:ctor()
	self._originAttrDict = {}
	self._changeAttrDict = {}
	self._curAttrDict = {}

	for iter_1_0, iter_1_1 in pairs(OutpostAttrType) do
		self._originAttrDict[iter_1_1] = 0
	end

	self._curHp = 1
	self._atk = 0
	self._maxHp = 1
	self._maxAttackRange = 0
	self._moveSpeed = 0
	self._attackSpeed = 0
end

function OutpostAttrEntry:setAttr(arg_2_1, arg_2_2)
	self._originAttrDict[arg_2_1] = arg_2_2
end

function OutpostAttrEntry:setCurAttr(arg_3_1, arg_3_2)
	self._curAttrDict[arg_3_1] = arg_3_2
end

function OutpostAttrEntry:addChangeAttr(arg_4_1, arg_4_2)
	self._changeAttrDict[arg_4_1] = (self._changeAttrDict[arg_4_1] or 0) + arg_4_2
end

function OutpostAttrEntry:resetAllCurAttr()
	self._curAttrDict = {}
	self._changeAttrDict = {}
end

function OutpostAttrEntry:applyAttr()
	self._curAttrDict = {}

	for iter_6_0, iter_6_1 in pairs(self._changeAttrDict) do
		self:setCurAttr(iter_6_0, self._originAttrDict[iter_6_0] + iter_6_1)
	end

	self._maxHp = var_0_2(self:getAttr(OutpostAttrType.hp) * (1000 + self:getChangeAttr(OutpostAttrType.hpPercent)) * 0.001)
	self._curHp = var_0_2(self._maxHp * self:getHpRate())
	self._atk = var_0_2(self:getAttr(OutpostAttrType.atk) * (1000 + self:getChangeAttr(OutpostAttrType.atkPercent)) * 0.001)
	self._def = var_0_2(self:getAttr(OutpostAttrType.def) * (1000 + self:getChangeAttr(OutpostAttrType.defPercent)) * 0.001)
	self._attackSpeed = var_0_2(self:getAttr(OutpostAttrType.attackSpeed) * (1000 + self:getChangeAttr(OutpostAttrType.attackSpeedPercent)) * 0.001)
	self._maxAttackRange = var_0_2(self:getAttr(OutpostAttrType.maxAttackRange) * (1000 + self:getChangeAttr(OutpostAttrType.maxAttackRangePercent)) * 0.001)
	self._moveSpeed = var_0_2(self:getAttr(OutpostAttrType.moveSpeed) * (1000 + self:getChangeAttr(OutpostAttrType.moveSpeedPercent)) * 0.001)
end

function OutpostAttrEntry:getMoveSpeed()
	return self._moveSpeed
end

function OutpostAttrEntry:getAtkRateSpeed()
	return self._attackSpeed
end

function OutpostAttrEntry:getOriginAttr(arg_9_1)
	return self._originAttrDict[arg_9_1]
end

function OutpostAttrEntry:getAttr(arg_10_1)
	return self._curAttrDict[arg_10_1] or self:getOriginAttr(arg_10_1)
end

function OutpostAttrEntry:getChangeAttr(arg_11_1)
	return self._changeAttrDict[arg_11_1] or 0
end

function OutpostAttrEntry:getHp()
	return self._curHp
end

function OutpostAttrEntry:hurt(arg_13_1)
	self:setCurHp(var_0_1(self._curHp - arg_13_1, 0))
end

function OutpostAttrEntry:recover(arg_14_1)
	self:setCurHp(var_0_0(self._curHp + arg_14_1, self._maxHp))
end

function OutpostAttrEntry:setCurHp(arg_15_1)
	self._curHp = arg_15_1
end

function OutpostAttrEntry:getMaxHp()
	return self._maxHp
end

function OutpostAttrEntry:getAtk()
	return self._atk
end

function OutpostAttrEntry:getDef()
	return self._def
end

function OutpostAttrEntry:isFullHp()
	return self._curHp >= self._maxHp
end

function OutpostAttrEntry:getHpRate()
	return self._curHp / self._maxHp
end

function OutpostAttrEntry:getAttackMinRange()
	return self:getAttr(OutpostAttrType.minAttackRange)
end

function OutpostAttrEntry:getAttackMaxRange()
	return self._maxAttackRange
end

return OutpostAttrEntry
