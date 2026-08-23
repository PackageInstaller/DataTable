local var_0_0 = g.core.config.rank_award_info
local var_0_1 = "reward_type"
local var_0_2 = "reward_value"
local var_0_3 = "reward_size"

return {
	getRankAwardArray = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0 = arg_1_2 or 0
		local var_1_1 = {}

		for iter_1_0, iter_1_1 in var_0_0.ipairs() do
			if iter_1_1.rank_type == arg_1_1 and iter_1_1.activity_id == var_1_0 then
				local var_1_2 = {}
				local var_1_3 = 1
				local var_1_4 = {
					var_0_1
				}

				var_1_4[2] = 1

				local var_1_5 = table.concat(var_1_4)

				while var_0_0.hasKey(var_1_5) do
					if iter_1_1[var_1_5] > 0 then
						table.insert(var_1_2, {
							type = iter_1_1[var_1_5],
							value = iter_1_1[table.concat({
								var_0_2,
								var_1_3
							})],
							size = iter_1_1[table.concat({
								var_0_3,
								var_1_3
							})]
						})
					end

					var_1_3 = var_1_3 + 1
					var_1_5 = table.concat({
						var_0_1,
						var_1_3
					})
				end

				if #var_1_2 > 0 then
					table.insert(var_1_1, {
						minRank = iter_1_1.min_rank,
						maxRank = iter_1_1.max_rank,
						rankId = iter_1_1.id,
						data = var_1_2
					})
				end
			end
		end

		return var_1_1
	end,
	getAwardByTypeAndRank = function(self, arg_2_1, arg_2_2, arg_2_3)
		for iter_2_0, iter_2_1 in ipairs((self:getRankAwardArray(arg_2_1, arg_2_3))) do
			if arg_2_2 >= iter_2_1.minRank and arg_2_2 <= iter_2_1.maxRank then
				return iter_2_1
			end
		end

		return {}
	end,
	getAwardByRank = function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 or {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			if arg_3_2 >= iter_3_1.minRank and arg_3_2 <= iter_3_1.maxRank then
				return iter_3_1
			end
		end

		return {}
	end
}
