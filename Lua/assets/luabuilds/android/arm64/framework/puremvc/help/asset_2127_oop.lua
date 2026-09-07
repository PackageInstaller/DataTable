function string.split(arg_1_0, arg_1_1)
	arg_1_0 = tostring(arg_1_0)
	arg_1_1 = tostring(arg_1_1)

	if arg_1_1 == "" then
		return false
	end

	local var_1_0 = 0
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in function()
		return string.find(arg_1_0, arg_1_1, var_1_0, true)
	end do
		table.insert(var_1_1, string.sub(arg_1_0, var_1_0, iter_1_0 - 1))

		var_1_0 = iter_1_1 + 1
	end

	table.insert(var_1_1, string.sub(arg_1_0, var_1_0))

	return var_1_1
end

function import(arg_3_0, arg_3_1)
	local var_3_0
	local var_3_1 = arg_3_0

	while true do
		if string.byte(arg_3_0, 1) ~= 46 then
			var_3_1 = string.sub(arg_3_0, 1)

			if var_3_0 and #var_3_0 > 0 then
				var_3_1 = table.concat(var_3_0, ".") .. "." .. var_3_1
			end

			break
		end

		if not var_3_0 then
			if not arg_3_1 then
				local var_3_3, var_3_4 = debug.getlocal(3, 1)

				arg_3_1 = var_3_4
			end

			var_3_0 = string.split(arg_3_1, ".")
		end

		table.remove(var_3_0, #var_3_0)
	end

	return require(var_3_1)
end

return
