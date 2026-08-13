class = var_0_10000

local var_0_0 = var_0_10000("BaseVO")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(arg_1_1) do
		arg_1_0[iter_1_0] = iter_1_1
	end

	return
end

function var_0_0.display(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "loaded" or not arg_2_2 then
		return
	end

	local var_2_0 = arg_2_0.__cname
	local var_2_1 = " id: "

	tostring = var_1_10005

	local var_2_2 = var_2_0 .. var_2_1 .. var_1_10005(arg_2_0.id) .. " " .. (arg_2_1 or ".")

	pairs = var_2_1

	for iter_2_0, iter_2_1 in var_2_1(arg_2_0) do
		if iter_2_0 ~= "class" then
			type = var_1_10009
			var_1_10009 = var_1_10009(iter_2_1)

			local var_2_3 = var_2_2
			local var_2_4 = "\n"
			local var_2_5 = iter_2_0
			local var_2_6 = ":"

			tostring = iter_2_3
			var_2_2 = var_2_3 .. var_2_4 .. var_2_5 .. var_2_6 .. iter_2_3(iter_2_1)

			if var_1_10009 == "table" then
				var_2_2 = var_2_2 .. " ["
				pairs = var_10

				for iter_2_2, iter_2_3 in var_10(iter_2_1) do
					local var_2_7 = var_2_2

					tostring = var_16
					var_2_2 = var_2_7 .. var_16(iter_2_3) .. ", "
				end

				var_2_2 = var_2_2 .. "]"
			end
		end
	end

	print = var_4

	var_4(var_2_2)

	return
end

function var_0_0.clone(arg_3_0)
	Clone = var_1_10001

	return var_1_10001(arg_3_0)
end

function var_0_0.bindConfigTable(arg_4_0)
	return
end

function var_0_0.GetConfigID(arg_5_0)
	return arg_5_0.configId
end

function var_0_0.getConfigTable(arg_6_0)
	local var_6_0 = arg_6_0:bindConfigTable()

	assert = var_1_10002

	var_1_10002(var_6_0, "should bindConfigTable() first: " .. arg_6_0.__cname)

	return var_6_0[arg_6_0.configId]
end

function var_0_0.getConfig(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getConfigTable()

	assert = var_1_10003

	local var_7_1 = var_7_0 ~= nil
	local var_7_2 = "Config missed, type -"
	local var_7_3 = arg_7_0.__cname
	local var_7_4 = " configId: "

	tostring = var_1_10009

	var_1_10003(var_7_1, var_7_2 .. var_7_3 .. var_7_4 .. var_1_10009(arg_7_0.configId))

	if arg_7_1 == "name" or arg_7_1 == "desc" then
		HXSet = var_1_10003

		return (var_1_10003.hxLan(var_7_0[arg_7_1]))
	end

	return var_7_0[arg_7_1]
end

return var_0_0
