module("framework.datastruct.Graph", package.seeall)

function is_in_table(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		if iter_1_1 == arg_1_1 then
			return true
		end
	end

	return false
end

function shallow_copy(arg_2_0)
	local var_2_0 = type(arg_2_0)
	local var_2_1

	if var_2_0 == "table" then
		var_2_1 = {}

		for iter_2_0, iter_2_1 in pairs(arg_2_0) do
			var_2_1[iter_2_0] = iter_2_1
		end
	else
		var_2_1 = arg_2_0
	end

	return var_2_1
end

local var_0_0 = {
	new = function(arg_3_0, arg_3_1)
		local var_3_0 = {}

		arg_3_0.__index = arg_3_0
		arg_3_0._graph = arg_3_1 or {}

		return setmetatable(var_3_0, arg_3_0)
	end,
	get_vertices = function(arg_4_0)
		local var_4_0 = {}

		for iter_4_0 in pairs(arg_4_0._graph) do
			table.insert(var_4_0, iter_4_0)
		end

		return var_4_0
	end,
	get_edges = function(arg_5_0)
		local var_5_0 = {}

		for iter_5_0 in pairs(arg_5_0._graph) do
			for iter_5_1, iter_5_2 in pairs(arg_5_0._graph[iter_5_0]) do
				table.insert(var_5_0, {
					iter_5_0,
					iter_5_2
				})
			end
		end

		return var_5_0
	end,
	add_vertex = function(arg_6_0, arg_6_1)
		if arg_6_0._graph[arg_6_1] == nil then
			arg_6_0._graph[arg_6_1] = {}

			return true
		end

		return false
	end,
	add_edge = function(arg_7_0, arg_7_1, arg_7_2)
		if type(arg_7_1) ~= "string" or type(arg_7_2) ~= "string" then
			return false
		end

		if arg_7_0._graph[arg_7_1] == nil then
			arg_7_0._graph[arg_7_1] = {
				arg_7_2
			}
		else
			table.insert(arg_7_0._graph[arg_7_1], arg_7_2)
		end

		return true
	end,
	remove_edge = function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0._graph[arg_8_1] ~= nil then
			for iter_8_0, iter_8_1 in pairs(arg_8_0._graph[arg_8_1]) do
				if iter_8_1 == arg_8_2 then
					arg_8_0._graph[arg_8_1][iter_8_0] = nil

					return true
				end
			end
		end

		return false
	end,
	remove_vertex = function(arg_9_0, arg_9_1)
		if arg_9_0._graph[arg_9_1] == nil then
			return false
		end

		arg_9_0._graph[arg_9_1] = nil

		for iter_9_0, iter_9_1 in pairs(arg_9_0._graph) do
			for iter_9_2 in pairs(iter_9_1) do
				if iter_9_1[iter_9_2] == arg_9_1 then
					table.remove(iter_9_1, iter_9_2)

					break
				end
			end
		end

		return true
	end,
	destroy = function(arg_10_0)
		return
	end,
	find_path = function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = arg_11_3 or {}

		table.insert(var_11_0, arg_11_1)

		if arg_11_1 == arg_11_2 then
			return var_11_0
		end

		if arg_11_0._graph[arg_11_1] == nil then
			return nil
		end

		local var_11_1

		for iter_11_0, iter_11_1 in pairs(arg_11_0._graph[arg_11_1]) do
			if not is_in_table(var_11_0, iter_11_1) then
				local var_11_2 = arg_11_0:find_path(iter_11_1, arg_11_2, var_11_0)

				if var_11_2 ~= nil then
					return var_11_2
				end
			end
		end

		return nil
	end,
	find_shortest_path = function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = shallow_copy(arg_12_3) or {}

		table.insert(var_12_0, arg_12_1)

		if arg_12_1 == arg_12_2 then
			return var_12_0
		end

		if arg_12_0._graph[arg_12_1] == nil then
			return nil
		end

		local var_12_1
		local var_12_2

		for iter_12_0, iter_12_1 in pairs(arg_12_0._graph[arg_12_1]) do
			if not is_in_table(var_12_0, iter_12_1) then
				local var_12_3 = arg_12_0:find_shortest_path(iter_12_1, arg_12_2, var_12_0)

				if var_12_3 ~= nil and var_12_1 == nil or var_12_1 ~= nil and #var_12_3 < #var_12_1 then
					var_12_1 = var_12_3
				end
			end
		end

		return var_12_1
	end,
	find_all_paths = function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		local var_13_0 = shallow_copy(arg_13_3) or {}

		table.insert(var_13_0, arg_13_1)

		if arg_13_1 == arg_13_2 then
			return {
				var_13_0
			}
		end

		if arg_13_0._graph[arg_13_1] == nil then
			return {}
		end

		local var_13_1 = {}
		local var_13_2

		for iter_13_0, iter_13_1 in pairs(arg_13_0._graph[arg_13_1]) do
			if not is_in_table(var_13_0, iter_13_1) then
				local var_13_3 = arg_13_0:find_all_paths(iter_13_1, arg_13_2, var_13_0)

				for iter_13_2, iter_13_3 in pairs(var_13_3) do
					table.insert(var_13_1, iter_13_3)
				end
			end
		end

		return var_13_1
	end
}

function var_0_0.create()
	return var_0_0:new()
end

return var_0_0
