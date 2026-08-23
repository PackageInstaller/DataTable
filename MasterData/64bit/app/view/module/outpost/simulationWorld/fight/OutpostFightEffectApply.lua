local var_0_0 = g.core.model.User.outpostData
local var_0_1 = math.floor

return {
	apply0 = function(arg_1_0)
		return
	end,
	apply1 = function(self)
		local var_2_0 = self.victim
		local var_2_1 = var_0_1(self.effectValue * self.result.elementalInfo["elemental_" .. self.victim:getElemental()] * 0.001)

		var_2_1 = self.attacker:isKnight() and var_0_1(var_2_1 * var_0_0:getKnightDamageRate()) or var_0_1(var_2_1 * var_0_0:getMonsterDamageRate())
		self.effectValue = var_2_1

		var_2_0:hurt(self.effectValue, self)
	end,
	apply2 = function(self)
		self.victim:recover(self.effectValue, self)
	end
}
