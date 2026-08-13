local function var_0_0(arg_1_0)
	local var_1_0

	package = var_1_10002

	local var_1_1

	if var_1_10002.loaded[arg_1_0] then
		package = var_1_1
		var_1_0 = var_1_1.loaded[arg_1_0]
		package = var_1_1
		var_1_1 = var_1_1.loaded
		var_1_1[arg_1_0] = nil
	else
		return
	end

	pcall = var_1_1
	require = var_1_10004

	local var_1_2, var_1_3 = var_1_1(var_1_10004, arg_1_0)

	if not var_1_2 then
		package = var_1_10004
		var_1_10004 = var_1_10004.loaded
		var_1_10004[arg_1_0] = var_1_0
		assert = var_1_10004

		var_1_10004(false, "<color=red>Reload lua file failed.</color>" .. var_1_3)

		return
	end

	package = var_1_10004

	local var_1_4 = var_1_10004.loaded[arg_1_0]
	local var_1_5 = {}

	update_table = var_1_10006

	var_1_10006(var_1_4, var_1_0, var_1_5)

	type = var_1_10006

	if var_1_10006(var_1_0) == "table" and var_1_0.OnReload ~= nil then
		var_1_0:OnReload()
	end

	print = var_6

	var_6("<color=green>Reload succeed : </color>" .. arg_1_0)

	package = var_6
	var_6.loaded[arg_1_0] = var_1_0

	return
end

local var_0_1 = hotfix

local function var_0_2(arg_2_0, arg_2_1)
	local var_2_0 = {}

	type = var_1_10003

	if var_1_10003(arg_2_1) == "function" then
		local var_2_1 = 1

		math = var_1_10004

		for iter_2_0 = var_2_1, var_1_10004.huge do
			debug = var_1_10007

			local var_2_2

			var_1_10007, var_2_2 = var_1_10007.getupvalue(arg_2_1, iter_2_0)

			if not var_1_10007 then
				break
			end

			var_2_0[var_1_10007] = var_2_2
		end
	end

	local var_2_3 = 1

	math = var_1_10004

	for iter_2_1 = var_2_3, var_1_10004.huge do
		debug = var_1_10007

		local var_2_4

		var_1_10007, var_2_4 = var_1_10007.getupvalue(arg_2_0, iter_2_1)

		if not var_1_10007 then
			break
		end

		if var_2_0[var_1_10007] then
			debug = var_10

			var_10.setupvalue(arg_2_0, iter_2_1, var_9)
		end
	end

	return
end

local var_0_3 = update_func

local function var_0_4(arg_3_0, arg_3_1, arg_3_2)
	type = var_1_10003

	if var_1_10003(arg_3_0) == "table" then
		type = var_3

		if var_3(arg_3_1) ~= "table" then
			return
		end

		pairs = var_3

		for iter_3_0, iter_3_1 in var_3(arg_3_0) do
			local var_3_0 = arg_3_1[iter_3_0]

			type = var_1_10009

			if var_1_10009(iter_3_1) == "function" then
				update_func = var_1_10010

				var_1_10010(iter_3_1, var_3_0)

				arg_3_1[iter_3_0] = iter_3_1
			elseif var_1_10009 == "table" and arg_3_2[iter_3_1] == nil then
				arg_3_2[iter_3_1] = true
				update_table = var_1_10010

				var_1_10010(iter_3_1, var_3_0, arg_3_2)
			end
		end

		debug = var_3

		local var_3_1 = var_3.getmetatable(arg_3_1)

		debug = var_4

		local var_3_2 = var_4.getmetatable(arg_3_0)

		type = var_5

		if var_5(var_3_1) == "table" then
			type = var_5

			if var_5(var_3_2) == "table" then
				update_table = var_5

				var_5(var_3_2, var_3_1, arg_3_2)
			end
		end

		return
	end
end

local var_0_5 = update_table

return
