function hotfix(arg_1_0)
	local var_1_0

	if package.loaded[arg_1_0] then
		var_1_0 = package.loaded[arg_1_0]
		package.loaded[arg_1_0] = nil
	else
		return
	end

	local var_1_1, var_1_2 = pcall(require, arg_1_0)

	if not var_1_1 then
		package.loaded[arg_1_0] = var_1_0

		return
	end

	local var_1_3 = package.loaded[arg_1_0]
	local var_1_4 = {}

	update_table(var_1_3, var_1_0, var_1_4)

	if type(var_1_0) == "table" and var_1_0.OnReload ~= nil then
		var_1_0:OnReload()
	end

	package.loaded[arg_1_0] = var_1_0
end

function update_func(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0 = 1, math.huge do
		local var_2_1, var_2_2 = debug.getupvalue(arg_2_1, iter_2_0)

		if not var_2_1 then
			break
		end

		var_2_0[var_2_1] = var_2_2
	end

	for iter_2_1 = 1, math.huge do
		local var_2_3, var_2_4 = debug.getupvalue(arg_2_0, iter_2_1)

		if not var_2_3 then
			break
		end

		local var_2_5 = var_2_0[var_2_3]

		if var_2_5 then
			debug.setupvalue(arg_2_0, iter_2_1, var_2_5)
		end
	end
end

function update_table(arg_3_0, arg_3_1, arg_3_2)
	if type(arg_3_0) ~= "table" or type(arg_3_1) ~= "table" then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		local var_3_0 = arg_3_1[iter_3_0]
		local var_3_1 = type(iter_3_1)

		if var_3_1 == "function" then
			update_func(iter_3_1, var_3_0)

			arg_3_1[iter_3_0] = iter_3_1
		elseif var_3_1 == "table" and arg_3_2[iter_3_1] == nil then
			arg_3_2[iter_3_1] = true

			update_table(iter_3_1, var_3_0, arg_3_2)
		end
	end

	local var_3_2 = debug.getmetatable(arg_3_1)
	local var_3_3 = debug.getmetatable(arg_3_0)

	if type(var_3_2) == "table" and type(var_3_3) == "table" then
		update_table(var_3_3, var_3_2, arg_3_2)
	end
end
