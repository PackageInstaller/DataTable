local var_0_0 = {}

function var_0_0:initRule()
	local var_1_0 = {}

	if self.atkAbsort then
		var_0_0._initAtkAbsort(self, var_1_0)
	elseif self.reboundPhyDam then
		var_0_0._initReboundPhyDam(self, var_1_0)
	elseif self.reboundMagDam then
		var_0_0._initReboundMagDam(self, var_1_0)
	elseif self.resistException then
		var_0_0._initResistException(self, var_1_0)
	elseif self.resistAngerDown then
		var_0_0._initResistAngerDown(self, var_1_0)
	elseif self.recoverAnger then
		var_0_0._initRecoverAnger(self, var_1_0)
	elseif self.ignoreDef then
		var_0_0._initIgnoreDef(self, var_1_0)
	elseif self.comboValue then
		var_0_0._initComboValue(self, var_1_0)
	elseif self.comboValueUpLimit then
		var_0_0._initComboValueUpLimit(self, var_1_0)
	elseif self.comboValueRecover then
		var_0_0._initComboValueRecover(self, var_1_0)
	elseif self.recoverAngerDam then
		var_0_0._initRecoverAngerDam(self, var_1_0)
	elseif self.baseAnger then
		var_0_0._initBaseAnger(self, var_1_0)
	elseif self.HPRecover then
		var_0_0._initHPRecover(self, var_1_0)
	end

	return var_1_0
end

function var_0_0:_initAtkAbsort(arg_2_1)
	arg_2_1.atkAbsort = {
		_atkAbsort = self:getBaseInfo("atkAbsort"),
		execute = function(self, arg_3_1)
			return arg_3_1 * self._atkAbsort / 1000
		end
	}
end

function var_0_0:_initReboundPhyDam(arg_4_1)
	arg_4_1.reboundPhyDam = {
		_reboundPhyDam = self:getBaseInfo("reboundPhyDam"),
		execute = function(self, arg_5_1)
			return arg_5_1 * self._reboundPhyDam / 1000
		end
	}
end

function var_0_0:_initReboundMagDam(arg_6_1)
	arg_6_1.reboundMagDam = {
		_reboundMagDam = self:getBaseInfo("reboundMagDam"),
		execute = function(self, arg_7_1)
			return arg_7_1 * self._reboundMagDam / 1000
		end
	}
end

function var_0_0:_initResistException(arg_8_1)
	arg_8_1.resistException = {
		_resistException = self:getBaseInfo("resistException"),
		execute = function(self, arg_9_1)
			return arg_9_1 * (1000 - self._resistException) / 1000
		end
	}
end

function var_0_0:_initResistAngerDown(arg_10_1)
	arg_10_1.resistAngerDown = {
		_resistAngerDown = self:getBaseInfo("resistAngerDown"),
		execute = function(self, arg_11_1)
			return arg_11_1 * (1000 - self._resistAngerDown) / 1000
		end
	}
end

function var_0_0:_initRecoverAnger(arg_12_1)
	arg_12_1.recoverAnger = {
		_recoverAnger = self:getBaseInfo("recoverAnger"),
		execute = function(self, arg_13_1)
			if arg_13_1:bingo(self._recoverAnger, 1000) == 1 then
				self:setBaseInfo("anger", self:getBaseInfo("anger") + 1)

				return true
			end

			return false
		end
	}
end

function var_0_0:_initIgnoreDef(arg_14_1)
	arg_14_1.ignoreDef = self:getBaseInfo("ignoreDef")
end

function var_0_0:_initComboValue(arg_15_1)
	arg_15_1.comboValue = self:getBaseInfo("comboValue")
end

function var_0_0:_initComboValueUpLimit(arg_16_1)
	arg_16_1.comboValueUpLimit = self:getBaseInfo("comboValueUpLimit")
end

function var_0_0:_initComboValueRecover(arg_17_1)
	arg_17_1.comboValueRecover = {
		_comboValueRecover = self.comboValueRecover,
		execute = function(self, arg_18_1)
			self:setBaseInfo("combo", self:getBaseInfo("combo") + self._comboValueRecover + 10)

			return true
		end
	}
end

function var_0_0:_initRecoverAngerDam(arg_19_1)
	arg_19_1.recoverAngerDam = {
		_recoverAngerDam = self:getBaseInfo("recoverAngerDam"),
		execute = function(arg_20_0)
			return
		end
	}
end

function var_0_0:_initBaseAnger(arg_21_1)
	arg_21_1.baseAnger = self:getBaseInfo("baseAnger")
end

function var_0_0:_initHPRecover(arg_22_1)
	arg_22_1.HPRecover = {
		_HPRecover = self:getBaseInfo("HPRecover"),
		execute = function(self, arg_23_1)
			self:setBaseInfo("hp", self:getBaseInfo("hp") + self:getBaseInfo("maxHp") * self._HPRecover / 1000)

			return true
		end
	}
end

return var_0_0
