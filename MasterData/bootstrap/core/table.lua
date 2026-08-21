module("bootstrap.core.table", package.seeall)

function table.nums(arg_1_0)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		var_1_0 = var_1_0 + 1
	end

	return var_1_0
end

function table.keys(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		var_2_0[#var_2_0 + 1] = iter_2_0
	end

	return var_2_0
end

function table.values(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		var_3_0[#var_3_0 + 1] = iter_3_1
	end

	return var_3_0
end

function table.merge(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		arg_4_0[iter_4_0] = iter_4_1
	end
end

function table.insertto(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2 = checkint(arg_5_2)

	if arg_5_2 <= 0 then
		arg_5_2 = #arg_5_0 + 1
	end

	local var_5_0 = #arg_5_1

	for iter_5_0 = 0, var_5_0 - 1 do
		arg_5_0[iter_5_0 + arg_5_2] = arg_5_1[iter_5_0 + 1]
	end
end

function table.indexof(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0 = arg_6_2 or 1, #arg_6_0 do
		if arg_6_0[iter_6_0] == arg_6_1 then
			return iter_6_0
		end
	end

	return false
end

function table.keyof(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		if iter_7_1 == arg_7_1 then
			return iter_7_0
		end
	end

	return nil
end

function table.removebyvalue(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0
	local var_8_1 = 1
	local var_8_2 = #arg_8_0

	while var_8_1 <= var_8_2 do
		if arg_8_0[var_8_1] == arg_8_1 then
			table.remove(arg_8_0, var_8_1)

			var_8_0 = var_8_0 + 1
			var_8_1 = var_8_1 - 1
			var_8_2 = var_8_2 - 1

			if not arg_8_2 then
				break
			end
		end

		var_8_1 = var_8_1 + 1
	end

	return var_8_0
end

function table.map(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0) do
		arg_9_0[iter_9_0] = arg_9_1(iter_9_1, iter_9_0)
	end
end

function table.walk(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0) do
		arg_10_1(iter_10_1, iter_10_0)
	end
end

function table.filter(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0) do
		if not arg_11_1(iter_11_1, iter_11_0) then
			arg_11_0[iter_11_0] = nil
		end
	end
end

function table.unique(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = 1

	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		if not var_12_0[iter_12_1] then
			if arg_12_1 then
				var_12_1[var_12_2] = iter_12_1
				var_12_2 = var_12_2 + 1
			else
				var_12_1[iter_12_0] = iter_12_1
			end

			var_12_0[iter_12_1] = true
		end
	end

	return var_12_1
end

function table.clear(arg_13_0)
	if type(arg_13_0) == "table" then
		table.map(arg_13_0, function()
			return nil
		end)
	end
end

function table.serialize(arg_15_0, arg_15_1)
	local var_15_0 = 20
	local var_15_1 = "    "
	local var_15_2 = {}

	arg_15_1 = type(arg_15_1) ~= "number" and var_15_0 or arg_15_1 >= 0 and arg_15_1 <= var_15_0 and arg_15_1 or var_15_0

	local function var_15_3(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = type(arg_16_1)
		local var_16_1 = string.rep(var_15_1, arg_16_2)

		_key = arg_16_0 == nil and "" or string.format("%s%s = ", var_16_1, tostring(arg_16_0))

		if var_16_0 == "nil" then
			return _key .. var_16_0
		elseif var_16_0 == "function" or var_16_0 == "userdata" or var_16_0 == "thread" then
			return _key .. tostring(arg_16_1)
		elseif var_16_0 == "boolean" then
			return _key .. tostring(arg_16_1)
		elseif var_16_0 == "number" then
			return _key .. string.format("%f", arg_16_1)
		elseif var_16_0 == "string" then
			return _key .. string.format("\"%s\"", string.gsub(arg_16_1, "\\", "\\\\"))
		elseif var_16_0 == "table" then
			if var_15_2[arg_16_1] then
				return _key .. string.format("循环引用: %s", tostring(arg_16_1))
			end

			if arg_16_2 >= arg_15_1 then
				return _key .. string.format("table, 超出指定深度:%d", arg_15_1)
			end

			local var_16_2 = StringBuffer.New()

			var_15_2[arg_16_1] = true

			var_16_2:append(_key .. tostring(arg_16_1) .. " {\n")

			for iter_16_0, iter_16_1 in pairs(arg_16_1) do
				var_16_2:append(var_15_3(iter_16_0, iter_16_1, arg_16_2 + 1) .. ",\n")
			end

			local var_16_3 = getmetatable(arg_16_1)

			if var_16_3 ~= nil then
				for iter_16_2, iter_16_3 in pairs(var_16_3) do
					var_16_2:append(var_15_3(iter_16_2, iter_16_3, arg_16_2 + 1) .. ",\n")
				end
			end

			var_16_2:append(var_16_1 .. "}")

			var_15_2[arg_16_1] = false

			return var_16_2:toString()
		else
			return arg_16_0 .. string.format("unknown type: %s", var_16_0)
		end
	end

	return var_15_3(nil, arg_15_0, 0)
end

function table.unserialize(arg_17_0)
	local var_17_0 = type(arg_17_0)

	if var_17_0 == "nil" or arg_17_0 == "" then
		return nil
	elseif var_17_0 == "number" or var_17_0 == "string" or var_17_0 == "boolean" then
		arg_17_0 = tostring(arg_17_0)
	else
		error("can not unserialize a " .. var_17_0 .. " type.")
	end

	arg_17_0 = "return " .. arg_17_0

	local var_17_1 = loadstring(arg_17_0)

	if var_17_1 == nil then
		return nil
	end

	return var_17_1()
end

function table.serialize_new(arg_18_0, arg_18_1)
	local var_18_0 = 20
	local var_18_1 = "    "
	local var_18_2 = {}

	arg_18_1 = type(arg_18_1) ~= "number" and var_18_0 or arg_18_1 >= 0 and arg_18_1 <= var_18_0 and arg_18_1 or var_18_0

	local function var_18_3(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = type(arg_19_1)
		local var_19_1 = string.rep(var_18_1, arg_19_2)

		_key = arg_19_0 == nil and "" or string.format("%s%s = ", var_19_1, tostring(arg_19_0))

		if var_19_0 == "nil" then
			return _key .. var_19_0
		elseif var_19_0 == "function" or var_19_0 == "userdata" or var_19_0 == "thread" then
			return _key .. tostring(arg_19_1)
		elseif var_19_0 == "boolean" then
			return _key .. tostring(arg_19_1)
		elseif var_19_0 == "number" then
			return _key .. string.format("%f", arg_19_1)
		elseif var_19_0 == "string" then
			return _key .. string.format("\"%s\"", string.gsub(arg_19_1, "\\", "\\\\"))
		elseif var_19_0 == "table" then
			if var_18_2[arg_19_1] then
				return _key .. string.format("循环引用: %s", tostring(arg_19_1))
			end

			if arg_19_2 >= arg_18_1 then
				return _key .. string.format("table, 超出指定深度:%d", arg_18_1)
			end

			local var_19_2 = StringBuffer.New()

			var_18_2[arg_19_1] = true

			var_19_2:append(_key .. tostring(arg_19_1) .. " {\n")

			for iter_19_0, iter_19_1 in pairs(arg_19_1) do
				var_19_2:append(var_18_3(iter_19_0, iter_19_1, arg_19_2 + 1) .. ",\n")
			end

			local var_19_3 = getmetatable(arg_19_1)

			if var_19_3 ~= nil then
				for iter_19_2, iter_19_3 in pairs(var_19_3) do
					var_19_2:append(var_18_3(iter_19_2, iter_19_3, arg_19_2 + 1) .. ",\n")
				end
			end

			var_19_2:append(var_19_1 .. "}")

			var_18_2[arg_19_1] = false

			return var_19_2:toString()
		else
			return arg_19_0 .. string.format("unknown type: %s", var_19_0)
		end
	end

	return var_18_3(nil, arg_18_0, 0)
end
