require = var_0_10000
string = var_0_10001
table = var_0_10002
int64 = var_0_10003
int64 = var_0_10004
var_0_10003.zero = var_0_10004.new(0, 0)
uint64 = var_0_10003
uint64 = var_4
var_0_10003.zero = var_4.new(0, 0)

function var_0_10001.split(arg_1_0, arg_1_1)
	tostring = var_1_10002
	arg_1_0 = var_1_10002(arg_1_0)
	tostring = var_2

	if var_2(arg_1_1) == "" then
		return false
	end

	local var_1_0 = 0
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in function()
		return var_0_10001.find(arg_1_0, arg_1_1, var_1_0, true)
	end do
		var_0_10002.insert(var_1_1, var_0_10001.sub(arg_1_0, var_1_0, iter_1_0 - 1))

		var_1_0 = iter_1_1 + 1
	end

	var_0_10002.insert(var_1_1, var_0_10001.sub(arg_1_0, var_1_0))

	return var_1_1
end

local function var_0_0(arg_3_0, arg_3_1)
	local var_3_0
	local var_3_1 = arg_3_0
	local var_3_2 = 1

	while true do
		if var_0_10001.byte(arg_3_0, var_3_2) ~= 46 then
			var_3_1 = var_0_10001.sub(arg_3_0, var_3_2)

			if var_3_0 and #var_3_0 > 0 then
				var_3_1 = var_0_10002.concat(var_3_0, ".") .. "." .. var_3_1
			end

			break
		end

		var_3_2 = var_3_2 + 1

		if not var_3_0 then
			if not arg_3_1 then
				debug = var_5

				local var_3_3, var_3_4 = var_5.getlocal(3, 1)

				arg_3_1 = var_3_4
			end

			var_3_0 = var_0_10001.split(arg_3_1, ".")
		end

		var_0_10002.remove(var_3_0, #var_3_0)
	end

	return var_0_10000(var_3_1)
end

local var_0_1 = import

local function var_0_2(arg_4_0)
	package = var_1_10001
	var_1_10001.loaded[arg_4_0] = nil
	var_1_10001.preload[arg_4_0] = nil

	return var_0_10000(arg_4_0)
end

local var_0_3 = reimport

return
