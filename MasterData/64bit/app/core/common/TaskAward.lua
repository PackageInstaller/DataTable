local var_0_0 = {}
local var_0_1 = g.core.config.action_task_info

var_0_0.MAX_AWARD = 4

function var_0_0.getTaskAwardById(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}

	for iter_1_0 = 1, var_0_1.getLength() do
		local var_1_1 = var_0_1.indexOf(iter_1_0)

		if var_1_1.module == arg_1_1 and var_1_1.require_type == arg_1_2 then
			local var_1_2 = {}

			for iter_1_1 = 1, var_0_0.MAX_AWARD do
				if var_1_1[table.concat({
					"reward_type_",
					iter_1_1
				})] > 0 then
					table.insert(var_1_2, {
						type = var_1_1[table.concat({
							"reward_type_",
							iter_1_1
						})],
						value = var_1_1[table.concat({
							"reward_value_",
							iter_1_1
						})],
						size = var_1_1[table.concat({
							"reward_size_",
							iter_1_1
						})]
					})
				end
			end

			table.insert(var_1_0, {
				isReceive = false,
				awards = var_1_2,
				times = var_1_1.require_value,
				name = var_1_1.name,
				taskId = var_1_1.id
			})
		end
	end

	return var_1_0
end

function var_0_0.getTaskAwardTabByModule(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0 = 1, var_0_1.getLength() do
		local var_2_1 = var_0_1.indexOf(iter_2_0)

		if var_2_1.module == arg_2_1 then
			local var_2_2 = {}

			for iter_2_1 = 1, var_0_0.MAX_AWARD do
				if var_2_1[table.concat({
					"reward_type_",
					iter_2_1
				})] > 0 then
					table.insert(var_2_2, {
						type = var_2_1[table.concat({
							"reward_type_",
							iter_2_1
						})],
						value = var_2_1[table.concat({
							"reward_value_",
							iter_2_1
						})],
						size = var_2_1[table.concat({
							"reward_size_",
							iter_2_1
						})]
					})
				end
			end

			if not var_2_0[var_2_1.tab] then
				var_2_0[var_2_1.tab] = {}

				table.insert(var_2_0[var_2_1.tab], {
					awards = var_2_2,
					times = var_2_1.require_value,
					name = var_2_1.name,
					taskId = var_2_1.id
				})
			else
				table.insert(var_2_0[var_2_1.tab], {
					awards = var_2_2,
					times = var_2_1.require_value,
					name = var_2_1.name,
					taskId = var_2_1.id
				})
			end
		end
	end

	return var_2_0
end

return var_0_0
