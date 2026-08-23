local var_0_0 = math.random
local var_0_1 = table.insert
local var_0_2 = table.remove
local ObjectPool = require("app.view.module.outpost.simulationWorld.pool.ObjectPool")
local OutpostFightResult = require("app.view.module.outpost.simulationWorld.fight.OutpostFightResult")
local OutpostFightSystem = class("OutpostFightSystem")

function OutpostFightSystem:ctor()
	self.pool = ObjectPool.new()
	self._buffTickDict = {}
	self._addBuffTickList = {}
	self._removeBuffTickList = {}
end

function OutpostFightSystem:createFightResult(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = self.pool:getObj(OutpostFightResult, self)

	var_2_0:setFightAttacker(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function OutpostFightSystem:onTick(arg_3_1)
	local var_3_0 = var_0_2(self._addBuffTickList, 1)

	while var_3_0 do
		self._buffTickDict[var_3_0.buffEffectType] = var_3_0
		var_3_0 = var_0_2(self._addBuffTickList, 1)
	end

	for iter_3_0, iter_3_1 in pairs(self._buffTickDict) do
		iter_3_1:onTick(arg_3_1)
	end

	local var_3_1 = var_0_2(self._removeBuffTickList, 1)

	while var_3_1 do
		self._buffTickDict[var_3_1.buffEffectType] = var_3_1
		var_3_1 = var_0_2(self._removeBuffTickList, 1)
	end
end

function OutpostFightSystem:addBuffTick(arg_4_1)
	var_0_1(self._addBuffTickList, arg_4_1)
end

function OutpostFightSystem:removeBuffTick(arg_5_1)
	var_0_1(self._removeBuffTickList, arg_5_1)
end

function OutpostFightSystem:bingo(arg_6_1)
	return arg_6_1 > var_0_0(0, 999)
end

return OutpostFightSystem
