local var_0_0 = {
	BuffType = {
		Buff1 = 1,
		Buff2 = 2
	},
	BuffTimeType = {
		LimitTime = 2,
		Forever = 1
	},
	buffAttr = {},
	defaultBuff = function(arg_1_0, arg_1_1)
		return true, arg_1_0
	end
}

function var_0_0:buff1()
	local var_2_0 = self.buffCfg.buff_effect_type
	local var_2_1 = self.buffCfg.buff_attribute_type == 1 and 1 or -1
	local var_2_2 = self.buffCfg.buff_value_1
	local var_2_3 = self.victim:getAttr()
	local var_2_4 = var_0_0.buffAttr[self.buffCfg.buff_effect_type] or var_2_0

	return function(arg_3_0, arg_3_1)
		var_2_3:addChangeAttr(var_2_4, var_2_2 * var_2_1)

		return true, arg_3_0
	end
end

function var_0_0:buff2()
	local var_4_0 = self.buffCfg.buff_value_1

	return function(arg_5_0, arg_5_1)
		arg_5_0.subMs = var_4_0

		return true, arg_5_0
	end
end

return var_0_0
