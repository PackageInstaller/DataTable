local var_0_0 = 0

local function var_0_1()
	var_0_0 = var_0_0 + 1

	return var_0_0
end

local var_0_2 = g.core.const.ConstMgr.PubgConst
local Pubg2EntityBase = class("Pubg2EntityBase")

function Pubg2EntityBase:ctor(arg_2_1)
	self.oid = var_0_1()
	self.x = 0
	self.y = 0
	self.renderDependWidth = 0
	self.renderDependHeight = 0
	self.renderDependenciesAfter = {}
	self.renderDependenciesBefore = {}
	self._isStatic = false
	self.node = nil
	self._id = arg_2_1
	self._type = var_0_2.entity.base
	self.renderComp = nil
	self._isClear = false
end

function Pubg2EntityBase:getId()
	return self._id
end

function Pubg2EntityBase:setClear(arg_4_1)
	self._isClear = arg_4_1
end

function Pubg2EntityBase:isClear()
	return self._isClear
end

function Pubg2EntityBase:isObstacle()
	return self._type == var_0_2.entity.obstacle
end

function Pubg2EntityBase:isMonster()
	return self._type == var_0_2.entity.monster
end

function Pubg2EntityBase:isUser()
	return self._type == var_0_2.entity.user
end

function Pubg2EntityBase:isBuff()
	return self._type == var_0_2.entity.buff
end

function Pubg2EntityBase:isObstaclePoint()
	return self._type == var_0_2.entity.obstacle_point
end

function Pubg2EntityBase:getId()
	return self._id
end

function Pubg2EntityBase:getType()
	return self._type
end

function Pubg2EntityBase:setStatic(arg_13_1)
	self._isStatic = arg_13_1
end

function Pubg2EntityBase:isStatic()
	return self._isStatic
end

return Pubg2EntityBase
