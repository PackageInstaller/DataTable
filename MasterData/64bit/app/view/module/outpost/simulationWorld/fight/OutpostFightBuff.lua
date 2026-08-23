local OutpostFightBuffRule = require("app.view.module.outpost.simulationWorld.fight.OutpostFightBuffRule")
local var_0_1 = OutpostFightBuffRule.BuffTimeType
local var_0_2 = math.max
local OutpostFightBuff = class("OutpostFightBuff", require("app.view.module.outpost.simulationWorld.pool.ObjectPoolItem"))

function OutpostFightBuff:onGet(arg_1_1)
	self.buffCfg = arg_1_1.buffInfo
	self.buffType = self.buffCfg.buff_type
	self.buffEffectType = self.buffCfg.buff_effect_type
	self.timeType = arg_1_1.timeType
	self.timeValue = arg_1_1.timeValue
	self.attacker = arg_1_1.attacker
	self.victim = arg_1_1.victim
	self.fightSystem = arg_1_1.fightSystem
	self.executeCount = 0
	self.level = 0
	self.layerNumber = 0
	self._executeFunc = OutpostFightBuffRule["buff" .. self.buffType] and OutpostFightBuffRule["buff" .. self.buffType](self) or OutpostFightBuffRule.defaultBuff
end

function OutpostFightBuff:onReset()
	self.attacker = nil
	self.victim = nil
	self.buffCfg = nil
	self.timeType = 0
	self.timeValue = 0
	self.executeCount = 0
	self.buffType = 0
	self.fightSystem = nil
	self.level = 0
	self.layerNumber = 0
	self._executeFunc = nil
	self._isAttackRole = false
end

function OutpostFightBuff:setAttackRole()
	self._isAttackRole = true

	if self.timeType == var_0_1.LimitTime then
		self.fightSystem:addBuffTick(self)
	end
end

function OutpostFightBuff:addSameBuff(arg_4_1)
	if arg_4_1.buffCfg.num_layer_type == 1 then
		self.timeValue = arg_4_1.timeValue
	elseif arg_4_1.buffCfg.num_layer_type == 2 then
		self.timeValue = self.timeValue + arg_4_1.timeValue
	end

	if self.layerNumber <= self.buffCfg.num_layer_value then
		self.layerNumber = self.layerNumber + 1
	end

	arg_4_1:dispose()
end

function OutpostFightBuff:executeBuff(arg_5_1, arg_5_2)
	local var_5_0, var_5_1 = self._executeFunc(arg_5_1, arg_5_2)

	if var_5_0 then
		self.executeCount = self.executeCount + 1
	end

	return var_5_0, arg_5_1
end

function OutpostFightBuff:onTick(arg_6_1)
	if self.timeType == var_0_1.LimitTime then
		self.timeValue = var_0_2(self.timeValue - arg_6_1, 0)

		if self.timeValue <= 0 then
			self:dispose()
		end
	end
end

function OutpostFightBuff:dispose()
	if self._isAttackRole then
		if self.timeType == var_0_1.LimitTime then
			self.fightSystem:removeBuffTick(self)
		end

		if self.victim then
			self.victim:removeBuff(self)
		end
	end

	self:releaseToPool()
end

return OutpostFightBuff
