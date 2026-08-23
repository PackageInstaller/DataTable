local var_0_0 = table.sort
local var_0_1 = table.insert

return {
	findTarget1 = function(arg_1_0, arg_1_1, arg_1_2)
		return arg_1_1:canVictim() and {
			arg_1_1
		} or {}
	end,
	findTarget2 = function(self, arg_2_1, arg_2_2)
		local var_2_0 = {
			arg_2_1
		}
		local var_2_1 = self:getAttr()
		local var_2_2 = {}

		var_0_0(var_2_1, function(arg_3_0, arg_3_1)
			local var_3_0 = arg_3_1.oid

			var_2_2[arg_3_0.oid] = var_2_2[arg_3_0.oid] or self:getDis2(arg_3_0)
			var_2_2[var_3_0] = var_2_2[var_3_0] or self:getDis2(arg_3_1)

			return var_2_2[arg_3_0.oid] < var_2_2[var_3_0]
		end)

		local var_2_3 = 0

		for iter_2_0, iter_2_1 in ipairs((arg_2_1.world:getVirtualMap():queryRangeEntities(arg_2_1.x, arg_2_1.y, (var_2_1:getAttackMaxRange())))) do
			if self:isEnemy(iter_2_1) and iter_2_1:canVictim() then
				var_0_1(var_2_0, iter_2_1)

				var_2_3 = var_2_3 + 1

				if arg_2_2 <= var_2_3 then
					break
				end
			end
		end

		return var_2_0
	end,
	findTarget3 = function(arg_4_0, arg_4_1, arg_4_2)
		return {
			arg_4_0
		}
	end,
	findTarget4 = function(self, arg_5_1, arg_5_2)
		local var_5_0 = {
			self
		}
		local var_5_1 = self:getAttr()
		local var_5_2 = {}

		var_0_0(var_5_1, function(arg_6_0, arg_6_1)
			local var_6_0 = arg_6_1.oid

			var_5_2[arg_6_0.oid] = var_5_2[arg_6_0.oid] or self:getDis2(arg_6_0)
			var_5_2[var_6_0] = var_5_2[var_6_0] or self:getDis2(arg_6_1)

			return var_5_2[arg_6_0.oid] < var_5_2[var_6_0]
		end)

		local var_5_3 = 0

		for iter_5_0, iter_5_1 in ipairs((self.world:getVirtualMap():queryRangeEntities(self.x, self.y, (var_5_1:getAttackMaxRange())))) do
			if iter_5_1.oid ~= self.oid and self:isFriendly(iter_5_1) and iter_5_1:canVictim() then
				var_0_1(var_5_0, iter_5_1)

				var_5_3 = var_5_3 + 1

				if arg_5_2 <= var_5_3 then
					break
				end
			end
		end

		return var_5_0
	end
}
