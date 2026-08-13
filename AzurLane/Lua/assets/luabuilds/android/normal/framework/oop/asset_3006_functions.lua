local function var_0_0(arg_1_0, ...)
	print = var_1_10001
	string = var_1_10002

	local var_1_0 = var_1_10002.format

	tostring = var_1_10003

	var_1_10001(var_1_0(var_1_10003(arg_1_0), ...))

	return
end

local var_0_1 = printf

local function var_0_2(arg_2_0)
	type = var_1_10001

	if var_1_10001(arg_2_0) ~= "table" then
		arg_2_0 = {}
	end

	return arg_2_0
end

local var_0_3 = AssureTable

local function var_0_4(arg_3_0, arg_3_1)
	tonumber = var_1_10002

	local var_3_0

	if not var_1_10002(arg_3_0, arg_3_1) then
		var_3_0 = 0
	end

	return var_3_0
end

math = checknumber

function var_0.round(arg_4_0)
	checknumber = var_1_10001
	arg_4_0 = var_1_10001(arg_4_0)
	math = var_1

	return var_1.floor(arg_4_0 + 0.5)
end

local function var_0_5(arg_5_0)
	math = var_1_10001

	local var_5_0 = var_1_10001.round

	checknumber = var_1_10002

	return var_5_0(var_1_10002(arg_5_0))
end

local var_0_6 = checkint

local function var_0_7(arg_6_0, arg_6_1)
	return function(...)
		return arg_6_1(arg_6_0, ...)
	end
end

local var_0_8 = handler

local function var_0_9(arg_8_0, arg_8_1, arg_8_2)
	return function(...)
		return arg_8_1(arg_8_0, arg_8_2, ...)
	end
end

print = handlerArg1
table = var_1

local var_0_10 = var_1.concat

table = var_0_10002

local var_0_11 = var_0_10002.insert

string = var_0_10003

local var_0_12 = var_0_10003.rep

type = var_0_10004
pairs = var_0_10005
tostring = var_0_10006
next = var_0_10007

local function var_0_13(arg_10_0)
	if var_0_10004(arg_10_0) ~= "table" then
		var_0("root is not table")

		return
	end

	local var_10_0 = {
		[arg_10_0] = "."
	}

	local function var_10_1(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in var_0_10005(arg_11_0) do
			local var_11_1 = var_0_10006(iter_11_0)

			if var_10_0[iter_11_1] then
				var_0_11(var_11_0, "+" .. var_11_1 .. " {" .. var_10_0[iter_11_1] .. "}")
			elseif var_0_10004(iter_11_1) == "table" then
				local var_11_2 = arg_11_2 .. "." .. var_11_1

				var_10_0[iter_11_1] = var_11_2

				var_0_11(var_11_0, "+" .. var_11_1 .. var_10_1(iter_11_1, arg_11_1 .. (var_0_10007(arg_11_0, iter_11_0) and "|" or " ") .. var_0_12(" ", #var_11_1), var_11_2))
			else
				var_0_11(var_11_0, "+" .. var_11_1 .. " [" .. var_0_10006(iter_11_1) .. "]")
			end
		end

		return var_0_10(var_11_0, "\n" .. arg_11_1)
	end

	var_0(var_10_1(arg_10_0, "", ""))

	return
end

local var_0_14 = print_r

return
