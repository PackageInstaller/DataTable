local var_0_0 = require("cjson")

local function var_0_1(arg_1_0)
	local var_1_0 = 0
	local var_1_1 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if type(iter_1_0) == "number" then
			if var_1_0 < iter_1_0 then
				var_1_0 = iter_1_0
			end

			var_1_1 = var_1_1 + 1
		else
			return -1
		end
	end

	if var_1_0 > var_1_1 * 2 then
		return -1
	end

	return var_1_0
end

local var_0_2

local function var_0_3(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0
	local var_2_1
	local var_2_2

	if arg_2_1 then
		var_2_0 = "\n" .. arg_2_1
		var_2_1 = ("\n" .. arg_2_1) .. "  "
		var_2_2 = arg_2_1 .. "  "

		goto label_2_0

		var_2_2 = false
		var_2_1 = " "
	end

	var_2_0 = " "

	::label_2_0::

	arg_2_2 = arg_2_2 + 1

	if arg_2_2 > 50 then
		return "Cannot serialise any further: too many nested tables"
	end

	local var_2_3 = var_0_1(arg_2_0)
	local var_2_4 = false
	local var_2_5 = {
		"{" .. var_2_1
	}

	if var_2_3 > 0 then
		for iter_2_0 = 1, var_2_3 do
			if var_2_4 then
				table.insert(var_2_5, "," .. var_2_1)
			end

			table.insert(var_2_5, var_0_2(arg_2_0[iter_2_0], var_2_2, arg_2_2))

			var_2_4 = true
		end
	elseif var_2_3 < 0 then
		for iter_2_1, iter_2_2 in pairs(arg_2_0) do
			if var_2_4 then
				table.insert(var_2_5, "," .. var_2_1)
			end

			table.insert(var_2_5, ("[%s] = %s"):format(var_0_2(iter_2_1, var_2_2, arg_2_2), var_0_2(iter_2_2, var_2_2, arg_2_2)))

			var_2_4 = true
		end
	end

	table.insert(var_2_5, var_2_0 .. "}")

	return table.concat(var_2_5)
end

local var_0_4 = 0
local var_0_5 = 0

return {
	serialise_value = function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_1 == nil then
			arg_3_1 = ""
		end

		if arg_3_2 == nil then
			arg_3_2 = 0
		end

		if arg_3_0 == var_0_0.null then
			return "json.null"
		elseif type(arg_3_0) == "string" then
			return ("%q"):format(arg_3_0)
		elseif type(arg_3_0) == "nil" or type(arg_3_0) == "number" or type(arg_3_0) == "boolean" then
			return tostring(arg_3_0)
		elseif type(arg_3_0) == "table" then
			return var_0_3(arg_3_0, arg_3_1, arg_3_2)
		else
			return "\"<" .. type(arg_3_0) .. ">\""
		end

		return
	end,
	file_load = function(arg_4_0)
		local var_4_0

		if arg_4_0 == nil then
			var_4_0 = io.stdin
		else
			local var_4_2

			var_4_0, var_4_2 = io.open(arg_4_0, "rb")

			if var_4_0 == nil then
				error(("Unable to read '%s': %s"):format(arg_4_0, var_4_2))
			end
		end

		local var_4_3 = var_4_0:read("*a")

		if arg_4_0 ~= nil then
			var_4_0:close()
		end

		if var_4_3 == nil then
			error("Failed to read " .. arg_4_0)
		end

		return var_4_3
	end,
	file_save = function(arg_5_0, arg_5_1)
		local var_5_0

		if arg_5_0 == nil then
			var_5_0 = io.stdout
		else
			local var_5_2

			var_5_0, var_5_2 = io.open(arg_5_0, "wb")

			if var_5_0 == nil then
				error(("Unable to write '%s': %s"):format(arg_5_0, var_5_2))
			end
		end

		var_5_0:write(arg_5_1)

		if arg_5_0 ~= nil then
			var_5_0:close()
		end

		return
	end,
	compare_values = function(arg_6_0, arg_6_1)
		local var_6_0 = type(arg_6_0)

		if var_6_0 ~= type(arg_6_1) then
			return false
		end

		if var_6_0 == "number" and arg_6_0 ~= arg_6_0 and arg_6_1 ~= arg_6_1 then
			return true
		end

		if var_6_0 ~= "table" then
			return arg_6_0 == arg_6_1
		end

		local var_6_1 = {}

		for iter_6_0, iter_6_1 in pairs(arg_6_0) do
			var_6_1[iter_6_0] = true
		end

		for iter_6_2, iter_6_3 in pairs(arg_6_1) do
			if not var_6_1[iter_6_2] then
				return false
			end

			if not var_0(arg_6_0[iter_6_2], arg_6_1[iter_6_2]) then
				return false
			end

			var_6_1[iter_6_2] = nil
		end

		for iter_6_4, iter_6_5 in pairs(var_6_1) do
			return false
		end

		return true
	end,
	run_test_summary = function()
		return var_0_4, var_0_5
	end,
	run_test = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		local var_8_0 = {
			pcall(arg_8_1, unpack(arg_8_2))
		}
		local var_8_1 = table.remove(var_8_0, 1)
		local var_8_2 = false

		if var_8_1 == arg_8_3 and var_0(var_8_0, arg_8_4) then
			var_8_2 = true
			var_0_4 = var_0_4 + 1
		end

		var_0_5 = var_0_5 + 1

		print(("==> Test [%d] %s: %s"):format(var_0_5, arg_8_0, ({
			[true] = "PASS",
			[false] = "FAIL"
		})[var_8_2]))
		;(function(arg_9_0, arg_9_1, arg_9_2)
			if arg_9_1 ~= nil then
				arg_9_0 = arg_9_0 .. ({
					[true] = ":success",
					[false] = ":error"
				})[arg_9_1]
			end

			print(("[%s] %s"):format(arg_9_0, var_0_2(arg_9_2, false)))

			return
		end)("Input", nil, arg_8_2)

		if not var_8_2 then
			(function(arg_9_0, arg_9_1, arg_9_2)
				if arg_9_1 ~= nil then
					arg_9_0 = arg_9_0 .. ({
						[true] = ":success",
						[false] = ":error"
					})[arg_9_1]
				end

				print(("[%s] %s"):format(arg_9_0, var_0_2(arg_9_2, false)))

				return
			end)("Expected", arg_8_3, arg_8_4)
		end

		;(function(arg_9_0, arg_9_1, arg_9_2)
			if arg_9_1 ~= nil then
				arg_9_0 = arg_9_0 .. ({
					[true] = ":success",
					[false] = ":error"
				})[arg_9_1]
			end

			print(("[%s] %s"):format(arg_9_0, var_0_2(arg_9_2, false)))

			return
		end)("Received", var_8_1, var_8_0)
		print()

		return var_8_2, var_8_0
	end,
	run_test_group = function(arg_10_0)
		for iter_10_0, iter_10_1 in ipairs(arg_10_0) do
			if iter_10_1[4] == nil then
				(function(arg_11_0, arg_11_1, arg_11_2)
					if type(arg_11_0) == "string" and #arg_11_0 > 0 then
						print("==> " .. arg_11_0)
					end

					arg_11_1(unpack(arg_11_2 or {}))
					print()

					return
				end)(unpack(iter_10_1))
			else
				var_0(unpack(iter_10_1))
			end
		end

		return
	end,
	run_script = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1 or {}
		local var_12_1

		if _G.setfenv then
			var_12_1 = loadstring(arg_12_0)

			if var_12_1 then
				setfenv(var_12_1, var_12_0)
			end
		else
			var_12_1 = load(arg_12_0, nil, nil, var_12_0)
		end

		if var_12_1 == nil then
			error("Invalid syntax.")
		end

		var_12_1()

		return var_12_0
	end
}
