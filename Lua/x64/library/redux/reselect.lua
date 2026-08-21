local function var_0_0(arg_1_0, arg_1_1)
	return arg_1_0 == arg_1_1
end

local function var_0_1(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == nil or arg_2_2 == nil or #arg_2_1 ~= #arg_2_2 then
		return false
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if not arg_2_0(iter_2_1, arg_2_2[iter_2_0]) then
			return false
		end
	end

	return true
end

local function var_0_2(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		arg_3_1 = var_0_0
	end

	local var_3_0
	local var_3_1

	return function(...)
		local var_4_0 = {
			...
		}

		if not var_0_1(arg_3_1, var_3_0, var_4_0) then
			var_3_1 = arg_3_0(unpack(var_4_0))
		end

		var_3_0 = var_4_0

		return var_3_1
	end
end

local function var_0_3(arg_5_0)
	local var_5_0

	if type(arg_5_0[1]) == "table" then
		var_5_0 = arg_5_0[1]
	else
		var_5_0 = {
			unpack(arg_5_0)
		}
	end

	local var_5_1 = true

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if type(iter_5_1) ~= "function" then
			var_5_1 = false

			break
		end
	end

	if not var_5_1 then
		local var_5_2 = {}

		for iter_5_2, iter_5_3 in ipairs(var_5_0) do
			table.insert(var_5_2, type(iter_5_3))
		end

		error(string.format("        Selector creators expect all input-selectors to be functions,\n        instead received the following types: [%s]", table.concat(var_5_2, ", ")))
	end

	return var_5_0
end

local function var_0_4(arg_6_0, ...)
	local var_6_0 = {
		...
	}

	return function(...)
		local var_7_0 = {
			...
		}
		local var_7_1 = 0
		local var_7_2 = table.remove(var_7_0)
		local var_7_3 = var_0_3(var_7_0)
		local var_7_4 = arg_6_0(function(...)
			var_7_1 = var_7_1 + 1

			return var_7_2(unpack({
				...
			}))
		end, unpack(var_6_0))
		local var_7_5 = arg_6_0(function(...)
			local var_9_0 = {}

			for iter_9_0, iter_9_1 in ipairs(var_7_3) do
				table.insert(var_9_0, iter_9_1(unpack({
					...
				})))
			end

			return var_7_4(unpack(var_9_0))
		end)

		return {
			compute = var_7_5,
			resultFunc = var_7_2,
			dependencies = var_7_3,
			recomputations = function()
				return var_7_1
			end,
			resetRecomputations = function()
				var_7_1 = 0
			end
		}
	end
end

local var_0_5 = var_0_4(var_0_2)

local function var_0_6(arg_12_0, arg_12_1)
	if arg_12_1 == nil then
		arg_12_1 = var_0_5
	end

	if type(arg_12_0) ~= "table" then
		error(string.format("        createStructuredSelector expects first argument to be an object\n        where each property is a selecotr, instead received a %s", type(arg_12_0)))
	end

	local var_12_0 = {}
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		table.insert(var_12_1, iter_12_0)
		table.insert(var_12_0, iter_12_1)
	end

	return arg_12_1(var_12_0, function(...)
		local var_13_0 = {}

		for iter_13_0, iter_13_1 in ipairs({
			...
		}) do
			var_13_0[var_12_1[iter_13_0]] = iter_13_1
		end

		return var_13_0
	end)
end

return {
	defaultMemoize = var_0_2,
	createSelectorCreator = var_0_4,
	createSelector = var_0_5,
	createStructuredSelector = var_0_6
}
