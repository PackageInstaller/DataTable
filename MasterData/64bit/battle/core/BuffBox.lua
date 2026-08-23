local var_0_0 = {}
local var_0_1 = loadCfg("core.config.cfg.buff_box_info")
local var_0_2 = {}

for iter_0_0 = 1, var_0_1.getLength() do
	local var_0_3 = var_0_1.indexOf(iter_0_0)

	var_0_2[var_0_3.buff_box_id] = var_0_2[var_0_3.buff_box_id] or {}

	table.insert(var_0_2[var_0_3.buff_box_id], var_0_3)
end

function var_0_0.getBuffsByBoxId(arg_1_0)
	return var_0_2[arg_1_0]
end

function var_0_0.getRandBuffsById(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not var_0_2[arg_2_0] then
		return {}
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_2[arg_2_0]) do
		table.insert(var_2_0, iter_2_1)
	end

	local var_2_1 = {}

	if arg_2_1 == 1 then
		table.insert(var_2_1, (var_0_0._getRandBuff(var_2_0, arg_2_2)))
	elseif arg_2_1 == 2 then
		table.insert(var_2_1, (var_0_0._getRandBuff(var_2_0, arg_2_2)))
		table.insert(var_2_1, (var_0_0._getRandBuff(var_2_0, arg_2_2)))
	elseif arg_2_1 == 3 then
		local var_2_2 = {}

		for iter_2_2, iter_2_3 in ipairs(var_2_0) do
			if arg_2_3.victim:getBuffCount(iter_2_3.buff_id, false, true) <= 0 then
				table.insert(var_2_2, iter_2_3)
			end
		end

		table.insert(var_2_1, next(var_2_2) and var_0_0._getRandBuff(var_2_2, arg_2_2) or var_0_0._getRandBuff(var_2_0, arg_2_2))
	end

	return var_2_1
end

function var_0_0._getRandBuff(arg_3_0, arg_3_1)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		var_3_0 = var_3_0 + iter_3_1.buff_prop
	end

	local var_3_1 = arg_3_1:boundedRandom(1, var_3_0)

	for iter_3_2, iter_3_3 in ipairs(arg_3_0) do
		if var_3_1 <= iter_3_3.buff_prop then
			local var_3_2 = {
				buff_id = iter_3_3.buff_id,
				buff_time = iter_3_3.buff_time
			}

			table.remove(arg_3_0, iter_3_2)

			return var_3_2
		end

		var_3_1 = var_3_1 - iter_3_3.buff_prop
	end
end

return var_0_0
