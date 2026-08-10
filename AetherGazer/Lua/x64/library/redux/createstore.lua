local var_0_0 = require("library/redux/utils/actionTypes")
local var_0_1 = require("library/redux/utils/isPlainTable")

local function var_0_2(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_2 ~= nil then
		if type(arg_1_2) ~= "function" then
			error("Expected the enhancer to be a function.")
		end

		return arg_1_2(var_0_2)(arg_1_0, arg_1_1)
	end

	if type(arg_1_0) ~= "function" then
		error("Expected the reducer to be a function")
	end

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_1
	local var_1_2 = {}
	local var_1_3 = var_1_2
	local var_1_4 = false

	local function var_1_5()
		if var_1_3 == var_1_2 then
			var_1_3 = {}

			for iter_2_0, iter_2_1 in ipairs(var_1_2) do
				table.insert(var_1_3, iter_2_1)
			end
		end
	end

	local function var_1_6()
		if var_1_4 then
			error("            You may not call store.getState() while the reducer is executing.\n            The reducer has already received the state as an argument.\n            Pass it down from the top reducer instead of reading it from the store.")
		end

		return var_1_1
	end

	local function var_1_7(arg_4_0)
		if type(arg_4_0) ~= "function" then
			error("Expected the listener to be a function.")
		end

		if var_1_4 then
			error("            You may not call store.subscribe() while the reducer is executing.\n            If you would like to be notified after the store has been updated, subscribe from a\n            component and invoke store.getState() in the callback to access the latest state.\n            See https://redux.js.org/api-reference/store#subscribe(listener) for more details.")
		end

		local var_4_0 = true

		var_1_5()
		table.insert(var_1_3, arg_4_0)

		return function()
			if not var_4_0 then
				return
			end

			if var_1_4 then
				error("                You may not unsubscribe from a store listener while the reducer is executing.\n                See https://redux.js.org/api-reference/store#subscribe(listener) for more details.")
			end

			var_4_0 = false

			var_1_5()

			local var_5_0 = 0

			for iter_5_0, iter_5_1 in ipairs(var_1_3) do
				if iter_5_1 == arg_4_0 then
					var_5_0 = iter_5_0

					break
				end
			end

			if var_5_0 ~= 0 then
				table.remove(var_1_3, var_5_0)
			end
		end
	end

	local function var_1_8(arg_6_0)
		if not var_0_1(arg_6_0) then
			error("            Actions must be plain tables.\n            Use custom middleware for async actions")
		end

		if arg_6_0.type == nil then
			error("            Actions may not have a nil 'type' property.\n            Have you misspelled a constant?")
		end

		if var_1_4 then
			error("Reducers may not dispatch actions.")
		end

		local var_6_0, var_6_1 = pcall(function()
			var_1_4 = true
			var_1_1 = var_1_0(var_1_1, arg_6_0)
		end)

		if not var_6_0 then
			error(var_6_1)
		end

		var_1_4 = false
		var_1_2 = var_1_3

		local var_6_2 = var_1_2

		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			for iter_6_2, iter_6_3 in ipairs(var_1_3) do
				if iter_6_3 == iter_6_1 then
					iter_6_1(arg_6_0)
				end
			end
		end

		return arg_6_0
	end

	local function var_1_9(arg_8_0)
		if type(arg_8_0) ~= "function" then
			error("Expected the nextReducer to be a function.")
		end

		var_1_0 = arg_8_0

		var_1_8({
			type = var_0_0.REPLACE
		})
	end

	var_1_8({
		type = var_0_0.INIT
	})

	return {
		dispatch = var_1_8,
		subscribe = var_1_7,
		getState = var_1_6,
		replaceReducer = var_1_9
	}
end

return var_0_2
