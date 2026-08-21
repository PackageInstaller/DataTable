function hotfix(arg_1_0)
	if package.loaded[arg_1_0] then
		package.loaded[arg_1_0] = nil
	else
		return
	end

	local var_1_1, var_1_2 = pcall(require, arg_1_0)

	if not var_1_1 then
		package.loaded[arg_1_0] = package.loaded[arg_1_0]

		assert(false, "<color=red>Reload lua file failed.</color>" .. var_1_2)

		return
	end

	update_table(package.loaded[arg_1_0], package.loaded[arg_1_0], {})

	if type(package.loaded[arg_1_0]) == "table" and package.loaded[arg_1_0].OnReload ~= nil then
		package.loaded[arg_1_0]:OnReload()
	end

	print("<color=green>Reload succeed : </color>" .. arg_1_0)

	package.loaded[arg_1_0] = package.loaded[arg_1_0]

	return
end

function update_func(arg_2_0, arg_2_1)
	if type(arg_2_1) == "function" then
		for iter_2_0 = 1, math.huge do
			local var_2_0, var_2_1 = debug.getupvalue(arg_2_1, iter_2_0)

			if not var_2_0 then
				break
			end

			;({})[var_2_0] = var_2_1
		end
	end

	for iter_2_1 = 1, math.huge do
		local var_2_2, var_2_3 = debug.getupvalue(arg_2_0, iter_2_1)

		if not var_2_2 then
			break
		end

		local var_2_4 = ({})[var_2_2]

		if ({})[var_2_2] then
			debug.setupvalue(arg_2_0, iter_2_1, var_2_4)
		end
	end

	return
end

function update_table(arg_3_0, arg_3_1, arg_3_2)
	if type(arg_3_0) ~= "table" or type(arg_3_1) ~= "table" then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		local var_3_0 = type(iter_3_1)

		if var_3_0 == "function" then
			update_func(iter_3_1, arg_3_1[iter_3_0])

			arg_3_1[iter_3_0] = iter_3_1
		elseif var_3_0 == "table" and arg_3_2[iter_3_1] == nil then
			arg_3_2[iter_3_1] = true

			update_table(iter_3_1, arg_3_1[iter_3_0], arg_3_2)
		end
	end

	local var_3_1 = debug.getmetatable(arg_3_1)
	local var_3_2 = debug.getmetatable(arg_3_0)

	if type(var_3_1) == "table" and type(var_3_2) == "table" then
		update_table(var_3_2, var_3_1, arg_3_2)
	end

	return
end

return
