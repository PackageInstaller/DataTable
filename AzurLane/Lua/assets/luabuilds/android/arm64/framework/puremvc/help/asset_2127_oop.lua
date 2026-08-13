string = var_0_10000

function var_0_10000.split(arg_1_0, arg_1_1)
	tostring = var_1_10002
	arg_1_0 = var_1_10002(arg_1_0)
	tostring = var_2

	if var_2(arg_1_1) == "" then
		return false
	end

	local var_1_0 = 0
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in function()
		string = var_2_10000

		return var_2_10000.find(arg_1_0, arg_1_1, var_1_0, true)
	end do
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_1_2 = var_1_1

		string = var_1_10012

		var_1_10009(var_1_2, var_1_10012.sub(arg_1_0, var_1_0, iter_1_0 - 1))

		var_1_0 = iter_1_1 + 1
	end

	table = var_4

	local var_1_3 = var_4.insert
	local var_1_4 = var_1_1

	string = iter_1_0

	var_1_3(var_1_4, iter_1_0.sub(arg_1_0, var_1_0))

	return var_1_1
end

local function var_0_0(arg_3_0, arg_3_1)
	local var_3_0
	local var_3_1 = arg_3_0
	local var_3_2 = 1

	while true do
		string = var_1_10005

		if var_1_10005.byte(arg_3_0, var_3_2) ~= 46 then
			string = var_1_10005
			var_3_1 = var_1_10005.sub(arg_3_0, var_3_2)

			if var_3_0 and #var_3_0 > 0 then
				table = var_1_10005
				var_3_1 = var_1_10005.concat(var_3_0, ".") .. "." .. var_3_1
			end

			break
		end

		var_3_2 = var_3_2 + 1

		if not var_3_0 then
			if not arg_3_1 then
				debug = var_1_10005

				local var_3_3

				var_1_10005, var_3_3 = var_1_10005.getlocal(3, 1)
				arg_3_1 = var_3_3
			end

			string = var_1_10005
			var_3_0 = var_1_10005.split(arg_3_1, ".")
		end

		table = var_1_10005

		var_1_10005.remove(var_3_0, #var_3_0)
	end

	require = var_1_10005

	return var_1_10005(var_3_1)
end

local var_0_1 = import

return
