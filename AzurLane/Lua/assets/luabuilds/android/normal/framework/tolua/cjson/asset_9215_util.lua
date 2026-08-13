require = var_0_10000

local var_0_0 = var_0_10000("cjson")

local function var_0_1(arg_1_0)
	local var_1_0 = 0
	local var_1_1 = 0

	pairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(arg_1_0) do
		type = var_1_10008

		if var_1_10008(iter_1_0) == "number" then
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
		var_2_1 = ("\n" .. arg_2_1) .. "  "
		var_2_2 = arg_2_1 .. "  "
	else
		var_2_0, var_2_1, var_2_2 = " ", " ", false
	end

	if arg_2_2 + 1 > 50 then
		return "Cannot serialise any further: too many nested tables"
	end

	local var_2_3 = var_0_1(arg_2_0)
	local var_2_4 = false
	local var_2_5 = {
		"{" .. var_2_1
	}

	if 0 < var_2_3 then
		for iter_2_0 = 1, var_2_3 do
			if var_2_4 then
				table = var_1_10013

				var_1_10013.insert(var_2_5, "," .. var_2_1)
			end

			table = var_1_10013

			var_1_10013.insert(var_2_5, var_0_2(arg_2_0[iter_2_0], var_2_2, arg_2_2))

			var_2_4 = true
		end
	elseif var_2_3 < 0 then
		pairs = var_9

		for iter_2_1, iter_2_2 in var_9(arg_2_0) do
			if var_2_4 then
				table = var_1_10014

				var_1_10014.insert(var_2_5, "," .. var_2_1)
			end

			table = var_1_10014
			var_1_10014 = var_1_10014.insert

			local var_2_6 = var_2_5
			local var_2_7 = "[%s] = %s"

			var_1_10014(var_2_6, var_16.format(var_2_7, var_0_2(iter_2_1, var_2_2, arg_2_2), var_0_2(iter_2_2, var_2_2, arg_2_2)))

			var_2_4 = true
		end
	end

	table = var_9

	var_9.insert(var_2_5, var_2_0 .. "}")

	table = var_9

	return var_9.concat(var_2_5)
end

function var_0_2(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == nil then
		arg_3_1 = ""
	end

	if arg_3_2 == nil then
		arg_3_2 = 0
	end

	if arg_3_0 == var_0_0.null then
		do return "json.null" end

		goto label_3_0
	end

	type = var_3

	if var_3(arg_3_0) == "string" then
		local var_3_0 = "%q"

		do return var_3.format(var_3_0, arg_3_0) end

		goto label_3_0
	end

	type = var_3

	if var_3(arg_3_0) ~= "nil" then
		type = var_3

		if var_3(arg_3_0) ~= "number" then
			type = var_3

			if var_3(arg_3_0) == "boolean" then
				tostring = var_3

				return var_3(arg_3_0)
			else
				type = var_3

				if var_3(arg_3_0) == "table" then
					return var_0_3(arg_3_0, arg_3_1, arg_3_2)
				else
					local var_3_1 = "\"<"

					type = var_4

					return var_3_1 .. var_4(arg_3_0) .. ">\""
				end
			end

			::label_3_0::

			return
		end
	end
end

local function var_0_4(arg_4_0)
	local var_4_0

	if arg_4_0 == nil then
		io = var_1_10002
		var_4_0 = var_1_10002.stdin
	else
		local var_4_1

		io = var_1_10003

		local var_4_2, var_4_3 = var_1_10003.open(arg_4_0, "rb")
		local var_4_4 = var_4_3

		if var_4_2 == nil then
			error = var_4_2

			local var_4_5 = "Unable to read '%s': %s"

			var_4_2(var_4.format(var_4_5, arg_4_0, var_4_4))
		end
	end

	local var_4_6 = var_4_0
	local var_4_7 = var_4_0.read(var_4_6, "*a")

	if arg_4_0 ~= nil then
		var_4_0:close()
	end

	if var_4_7 == nil then
		error = var_4_6

		var_4_6("Failed to read " .. arg_4_0)
	end

	return var_4_7
end

local function var_0_5(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_0 == nil then
		io = var_1_10003
		var_5_0 = var_1_10003.stdout
	else
		local var_5_1

		io = var_1_10004

		local var_5_2, var_5_3 = var_1_10004.open(arg_5_0, "wb")
		local var_5_4 = var_5_3

		if var_5_2 == nil then
			error = var_5_2

			local var_5_5 = "Unable to write '%s': %s"

			var_5_2(var_5.format(var_5_5, arg_5_0, var_5_4))
		end
	end

	var_5_0:write(arg_5_1)

	if arg_5_0 ~= nil then
		var_5_0:close()
	end

	return
end

local function var_0_6(arg_6_0, arg_6_1)
	type = var_1_10002

	local var_6_0 = var_1_10002(arg_6_0)

	type = var_3

	if var_6_0 ~= var_3(arg_6_1) then
		return false
	end

	if var_6_0 == "number" and arg_6_0 ~= arg_6_0 and arg_6_1 ~= arg_6_1 then
		return true
	end

	if var_6_0 ~= "table" then
		return arg_6_0 == arg_6_1
	end

	local var_6_1 = {}

	pairs = var_1_10005

	for iter_6_0, iter_6_1 in var_1_10005(arg_6_0) do
		var_6_1[iter_6_0] = true
	end

	pairs = var_5

	for iter_6_2, iter_6_3 in var_5(arg_6_1) do
		if not var_6_1[iter_6_2] then
			return false
		end

		if not var_0_6(arg_6_0[iter_6_2], arg_6_1[iter_6_2]) then
			return false
		end

		var_6_1[iter_6_2] = nil
	end

	pairs = var_5

	for iter_6_4, iter_6_5 in var_5(var_6_1) do
		return false
	end

	return true
end

local var_0_7 = 0
local var_0_8 = 0

local function var_0_9()
	return var_0_7, var_0_8
end

local function var_0_10(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local function var_8_0(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = {
			[true] = ":success",
			[false] = ":error"
		}

		if arg_9_1 ~= nil then
			arg_9_0 = arg_9_0 .. var_9_0[arg_9_1]
		end

		print = var_2_10004

		local var_9_1 = "[%s] %s"

		var_2_10004(var_5.format(var_9_1, arg_9_0, var_0_2(arg_9_2, false)))

		return
	end

	local var_8_1 = {}

	pcall = var_1_10007

	local var_8_2 = arg_8_1

	unpack = var_1_10009
	var_8_1[1] = var_1_10007(var_8_2, var_1_10009(arg_8_2))
	table = var_7

	local var_8_3 = var_7.remove(var_8_1, 1)
	local var_8_4 = false

	if var_8_3 == arg_8_3 and var_0_6(var_8_1, arg_8_4) then
		var_8_4 = true
		var_0_7 = var_0_7 + 1
	end

	var_0_8 = var_0_8 + 1

	local var_8_5 = {
		[true] = "PASS",
		[false] = "FAIL"
	}

	print = var_10

	local var_8_6 = "==> Test [%d] %s: %s"

	var_10(var_11.format(var_8_6, var_0_8, arg_8_0, var_8_5[var_8_4]))
	var_8_0("Input", nil, arg_8_2)

	if not var_8_4 then
		var_8_0("Expected", arg_8_3, arg_8_4)
	end

	var_8_0("Received", var_8_3, var_8_1)

	print = var_10

	var_10()

	return var_8_4, var_8_1
end

local function var_0_11(arg_10_0)
	local function var_10_0(arg_11_0, arg_11_1, arg_11_2)
		type = var_2_10003

		if var_2_10003(arg_11_0) == "string" then
			local var_11_0 = #arg_11_0

			if 0 < var_11_0 then
				print = var_11_0

				var_11_0("==> " .. arg_11_0)
			end
		end

		local var_11_1 = arg_11_1

		unpack = var_4

		var_11_1(var_4(arg_11_2 or {}))

		print = var_11_1

		var_11_1()

		return
	end

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0) do
		if iter_10_1[4] == nil then
			local var_10_1 = var_10_0

			unpack = var_1_10008

			var_10_1(var_1_10008(iter_10_1))
		else
			local var_10_2 = var_0_10

			unpack = var_1_10008

			var_10_2(var_1_10008(iter_10_1))
		end
	end

	return
end

local function var_0_12(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 or {}
	local var_12_1

	_G = var_1_10004

	if var_1_10004.setfenv then
		loadstring = var_4

		if var_4(arg_12_0) then
			setfenv = var_4

			var_4(var_12_1, var_12_0)
		end
	else
		load = var_4
		var_12_1 = var_4(arg_12_0, nil, nil, var_12_0)
	end

	if var_12_1 == nil then
		error = var_4

		var_4("Invalid syntax.")
	end

	var_12_1()

	return var_12_0
end

return {
	serialise_value = var_0_2,
	file_load = var_0_4,
	file_save = var_0_5,
	compare_values = var_0_6,
	run_test_summary = var_0_9,
	run_test = var_0_10,
	run_test_group = var_0_11,
	run_script = var_0_12
}
