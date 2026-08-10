local var_0_0 = require("library/redux/utils/actionTypes")
local var_0_1 = require("library/redux/utils/isPlainTable")

local function var_0_2(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1 and arg_1_1.type
	local var_1_1 = var_1_0 and string.format("action \"%s\"", tostring(var_1_0)) or "an action"

	return string.format("    Given %s, reducer \"%s\" returned nil.\n    To ignore an action, you must explicitly return the previous state.", var_1_1, arg_1_0)
end

local function var_0_3(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		table.insert(var_2_0, iter_2_0)
	end

	local var_2_1 = arg_2_2 and arg_2_2.type == var_0_0.INIT and "preloadedState argument passed to createStore" or "previous state received by the reducer"

	if #var_2_0 == 0 then
		return "        Store does not have a valid reducer. Make sure the argument passed\n        to combineReducers is an object whose values are reducers."
	end

	if not var_0_1(arg_2_0) then
		return string.format("        The %s has unexpected type.\n        Expected arguments to be a table with the following keys: %s", tostring(var_2_1), table.concat(var_2_0, ", "))
	end

	local var_2_2 = {}

	for iter_2_2, iter_2_3 in pairs(arg_2_0) do
		if not arg_2_1[iter_2_2] and not arg_2_3[iter_2_2] then
			table.insert(var_2_2, iter_2_2)
		end
	end

	for iter_2_4, iter_2_5 in ipairs(var_2_2) do
		arg_2_3[iter_2_5] = true
	end

	if arg_2_2 and arg_2_2.type == var_0_0.REPLACE then
		return
	end

	if #var_2_2 > 0 then
		return string.format("        Unexpected key(s) \"%s\" found in %s.\n        Expected to find one of the known reducer keys instead:\n        \"%s\". Unexpected keys will be ignored.", table.concat(var_2_2, ", "), tostring(var_2_1), table.concat(var_2_0, ", "))
	end
end

local function var_0_4(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		if iter_3_1(nil, {
			type = var_0_0.INIT
		}) == nil then
			error(string.format("            Reducer \"%s\" returned nil during initialization.\n            If the state passed to the reducer is nil, you must explicitly return the intial state.\n            The initial state may not be nil. If you don't want to set a value for this reducer,\n            you can use null instead of undefined", iter_3_0))
		end

		if iter_3_1(nil, {
			type = var_0_0.PROBE_UNKNOWN_ACTION()
		}) == nil then
			error(string.format("            Reducer \"%s\" returned nil when probed with a random type.\n            Don't try to handle %s or other actions in \"redux/*\" namespace.\n            They are considered private. Instead you must return the\n            current state for any unknown actions, unless it is undefined,\n            in which case you must return the initial state, regardless of the action type.\n            The initial state may not be undefined, but can be null"))
		end
	end
end

return function(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		if type(iter_4_1) == "function" then
			var_4_0[iter_4_0] = iter_4_1

			table.insert(var_4_1, iter_4_0)
		end
	end

	local var_4_2 = {}
	local var_4_3, var_4_4 = pcall(var_0_4, var_4_0)

	return function(arg_5_0, arg_5_1)
		if not var_4_3 then
			error(var_4_4)
		end

		if arg_5_0 == nil then
			arg_5_0 = {}
		end

		if DEBUG then
			local var_5_0 = var_0_3(arg_5_0, var_4_0, arg_5_1, var_4_2)

			if var_5_0 and warning then
				warning(var_5_0)
			end
		end

		local var_5_1 = false
		local var_5_2 = {}

		for iter_5_0, iter_5_1 in pairs(var_4_0) do
			local var_5_3 = arg_5_0[iter_5_0]
			local var_5_4 = iter_5_1(var_5_3, arg_5_1)

			if var_5_4 == nil then
				local var_5_5 = var_0_2(iter_5_0, arg_5_1)

				error(var_5_5)
			end

			var_5_2[iter_5_0] = var_5_4
			var_5_1 = var_5_1 or var_5_4 ~= var_5_3
		end

		return var_5_1 and var_5_2 or arg_5_0
	end
end
