local var_0_0 = class("BaseVO")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		arg_1_0[iter_1_0] = iter_1_1
	end

	return
end

function var_0_0.display(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "loaded" or not arg_2_2 then
		return
	end

	local var_2_0 = arg_2_0.__cname .. " id: " .. tostring(arg_2_0.id) .. " " .. (arg_2_1 or ".")

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		if iter_2_0 ~= "class" then
			var_2_0 = var_2_0 .. "\n" .. iter_2_0 .. ":" .. tostring(iter_2_1)

			if type(iter_2_1) == "table" then
				var_2_0 = var_2_0 .. " ["

				for iter_2_2, iter_2_3 in pairs(iter_2_1) do
					var_2_0 = var_2_0 .. tostring(iter_2_3) .. ", "
				end

				var_2_0 = var_2_0 .. "]" or var_2_0
			end
		end
	end

	print(var_2_0)

	return
end

function var_0_0.clone(arg_3_0)
	return Clone(arg_3_0)
end

function var_0_0.bindConfigTable(arg_4_0)
	return
end

function var_0_0.GetConfigID(arg_5_0)
	return arg_5_0.configId
end

function var_0_0.getConfigTable(arg_6_0)
	local var_6_0 = arg_6_0:bindConfigTable()

	assert(var_6_0, "should bindConfigTable() first: " .. arg_6_0.__cname)

	return var_6_0[arg_6_0.configId]
end

function var_0_0.getConfig(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getConfigTable()

	assert(var_7_0 ~= nil, "Config missed, type -" .. arg_7_0.__cname .. " configId: " .. tostring(arg_7_0.configId))

	if arg_7_1 == "name" or arg_7_1 == "desc" then
		return (HXSet.hxLan(var_7_0[arg_7_1]))
	end

	return var_7_0[arg_7_1]
end

return var_0_0
