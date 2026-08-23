local var_0_0 = {
	addRule = function(arg_1_0, arg_1_1, arg_1_2)
		return {
			info = loadCfg("core.config.cfg.unite_skill").get(arg_1_1),
			round = {},
			count = {},
			ownerId = arg_1_0,
			execute = function(self, arg_2_1)
				if self.info.unite_skill_trigger == 1 and arg_2_1 ~= self.ownerId then
					return false
				end

				local var_2_0 = self.info.trigger_maxtime_type
				local var_2_1 = arg_1_2:getRoundCount()

				self.round[arg_2_1] = self.round[arg_2_1] or 0
				self.count[arg_2_1] = self.count[arg_2_1] or 0

				if var_2_1 > self.round[arg_2_1] and var_2_0 == 2 then
					self.count[arg_2_1] = 0
					self.round[arg_2_1] = var_2_1
				end

				if var_2_0 == 0 or self.count[arg_2_1] < self.info.trigger_maxtime_value then
					self.count[arg_2_1] = self.count[arg_2_1] + 1

					return true, {
						type = self.info.unite_skill_type,
						value = self.info.unite_skill_value
					}
				end

				return false
			end
		}
	end
}

function var_0_0.initRule(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = loadCfg("core.config.cfg.unite_token_info").get(arg_3_0)

	if var_3_2.unite_skill_id > 0 then
		var_3_1[1] = var_3_2.unite_skill_id
	end

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		table.insert(var_3_0, (var_0_0.addRule(arg_3_0, iter_3_1, arg_3_1)))
	end

	return var_3_0
end

return var_0_0
