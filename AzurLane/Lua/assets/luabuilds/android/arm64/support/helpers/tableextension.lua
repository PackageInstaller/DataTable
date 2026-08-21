function table.indexof(arg_1_0, arg_1_1, arg_1_2)
	for iter_1_0 = arg_1_2 or 1, #arg_1_0 do
		if arg_1_0[iter_1_0] == arg_1_1 then
			return iter_1_0
		end
	end

	return false
end

function table.keyof(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		if iter_2_1 == arg_2_1 then
			return iter_2_0
		end
	end

	return nil
end

function table.removebyvalue(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 0

	for iter_3_0 = #arg_3_0, 1, -1 do
		if arg_3_0[iter_3_0] == arg_3_1 then
			table.remove(arg_3_0, iter_3_0)

			var_3_0 = var_3_0 + 1

			if not arg_3_2 then
				break
			end
		end
	end

	return var_3_0
end

function table.removebykey(arg_4_0, arg_4_1)
	arg_4_0[arg_4_1] = nil

	return arg_4_0[arg_4_1]
end

function table.insertto(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2 = checkint(arg_5_2)

	if arg_5_2 <= 0 then
		arg_5_2 = #arg_5_0 + 1
	end

	for iter_5_0 = 0, #arg_5_1 - 1 do
		arg_5_0[iter_5_0 + arg_5_2] = arg_5_1[iter_5_0 + 1]
	end

	return arg_5_0
end

function table.isEmpty(arg_6_0)
	if type(arg_6_0) == "table" then
		return next(arg_6_0) == nil
	end

	return true
end

function table.clear(arg_7_0)
	if arg_7_0 then
		for iter_7_0, iter_7_1 in pairs(arg_7_0) do
			arg_7_0[iter_7_0] = nil
		end
	end

	return
end

function table.contains(arg_8_0, arg_8_1)
	if arg_8_0 == nil then
		return false
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_0) do
		if iter_8_1 == arg_8_1 then
			return true
		end
	end

	return false
end

function table.equal(arg_9_0, arg_9_1)
	if type(arg_9_0) ~= type(arg_9_1) then
		return false
	end

	if type(arg_9_0) ~= "table" then
		return arg_9_0 == arg_9_1
	end

	if arg_9_0 == arg_9_1 then
		return true
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0) do
		if not table.equal(iter_9_1, arg_9_1[iter_9_0]) then
			return false
		end
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_1) do
		if arg_9_0[iter_9_2] == nil then
			return false
		end
	end

	return true
end

function table.containsData(arg_10_0, arg_10_1)
	if arg_10_0 == nil then
		return false
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0) do
		if table.equal(iter_10_1, arg_10_1) then
			return true
		end
	end

	return false
end

function table.Foreach(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0) do
		arg_11_1(iter_11_0, iter_11_1)
	end

	return
end

function table.Ipairs(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
		arg_12_1(iter_12_0, iter_12_1)
	end

	return
end

function table.IpairsCArray(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(table.CArrayToArray(arg_13_0)) do
		arg_13_1(iter_13_0 - 1, iter_13_1)
	end

	return
end

function table.CArrayToArray(arg_14_0)
	return arg_14_0:ToTable()
end

function table.SerialIpairsAsync(arg_15_0, arg_15_1, arg_15_2)
	if type(arg_15_0) ~= "table" then
		return
	end

	local var_15_1
	local var_15_3, var_15_4

	var_15_3, arg_15_0, var_15_4 = ipairs(arg_15_0)

	;(function()
		var_15_4, var_15_1 = var_15_3(arg_15_0, var_15_4)

		if var_15_4 == nil then
			if arg_15_2 then
				arg_15_2()
			end
		else
			arg_15_1(var_15_4, var_15_1, var_0)
		end

		return
	end)()

	return
end

function table.ParallelIpairsAsync(arg_17_0, arg_17_1, arg_17_2)
	if type(arg_17_0) ~= "table" then
		return
	end

	local var_17_3, var_17_4

	var_17_3, arg_17_0, var_17_4 = ipairs(arg_17_0)

	local var_17_5 = 0
	local var_17_6 = 1

	while true do
		local var_17_7

		var_17_4, var_17_7 = var_17_3(arg_17_0, var_17_4)

		if var_17_4 == nil then
			break
		end

		var_17_6 = 1 + 1

		arg_17_1(var_17_4, var_17_7, function()
			var_17_5 = var_17_5 + 1

			if var_17_5 == var_17_6 then
				existCall(arg_17_2)
			end

			return
		end)
	end

	;(function()
		var_17_5 = var_17_5 + 1

		if var_17_5 == var_17_6 then
			existCall(arg_17_2)
		end

		return
	end)()

	return
end

function table.Find(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_0) do
		if arg_19_1(iter_19_0, iter_19_1) then
			return iter_19_1, iter_19_0
		end
	end

	return
end

function table.Checkout(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_0) do
		local var_20_0 = arg_20_1(iter_20_0, iter_20_1)

		if var_20_0 ~= nil then
			return var_20_0
		end
	end

	return
end

function table.getCount(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(arg_21_0) do
		var_21_0 = var_21_0 + 1
	end

	return var_21_0
end

function table.merge(arg_22_0, arg_22_1)
	if not arg_22_1 or not arg_22_0 then
		return
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		arg_22_0[iter_22_0] = iter_22_1
	end

	return arg_22_0
end

function table.mergeArray(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {}
	local var_23_1 = {}

	;(function(arg_24_0)
		for iter_24_0, iter_24_1 in ipairs(arg_24_0) do
			if arg_23_2 and var_23_0[iter_24_1] then
				-- block empty
			else
				table.insert(var_23_1, iter_24_1)

				var_23_0[iter_24_1] = true
			end
		end

		return
	end)(arg_23_0)
	;(function(arg_24_0)
		for iter_24_0, iter_24_1 in ipairs(arg_24_0) do
			if arg_23_2 and var_23_0[iter_24_1] then
				-- block empty
			else
				table.insert(var_23_1, iter_24_1)

				var_23_0[iter_24_1] = true
			end
		end

		return
	end)(arg_23_1)

	return {}
end

function table.clean(arg_25_0)
	for iter_25_0 = #arg_25_0, 1, -1 do
		table.remove(arg_25_0, iter_25_0)
	end

	return
end

function table.shallowCopy(arg_26_0)
	if type(arg_26_0) ~= "table" then
		return arg_26_0
	end

	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_0) do
		var_26_0[iter_26_0] = iter_26_1
	end

	return var_26_0
end

function table.getIndex(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0) do
		if arg_27_1(iter_27_1) then
			return iter_27_0
		end
	end

	return
end

function table.map(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in pairs(arg_28_0) do
		({})[iter_28_0] = arg_28_1(iter_28_1)
	end

	return {}
end

function table.lastof(arg_29_0)
	return arg_29_0[#arg_29_0]
end

function table.dichotomyInsert(arg_30_0, arg_30_1, arg_30_2)
	arg_30_2 = defaultValue(arg_30_2, function(arg_31_0)
		return arg_31_0
	end)

	assert(type(arg_30_2) == "function")

	local var_30_0 = {}
	local var_30_1 = 1

	while var_30_1 < #arg_30_0 do
		local var_30_3 = math.floor((var_30_1 + #arg_30_0) / 2)
		local var_30_4

		if (function(arg_32_0)
			var_30_0[arg_32_0] = var_30_0[arg_32_0] or arg_30_2(arg_32_0)

			return var_30_0[arg_32_0]
		end)(arg_30_0[var_30_3]) < (function(arg_32_0)
			var_30_0[arg_32_0] = var_30_0[arg_32_0] or arg_30_2(arg_32_0)

			return var_30_0[arg_32_0]
		end)(arg_30_1) then
			var_30_1 = var_30_3 + 1
		else
			var_30_4 = var_30_3
		end
	end

	table.insert(arg_30_0, var_30_1, arg_30_1)

	return
end

function table.CastToString(arg_33_0)
	if arg_33_0 == nil then
		return "nil"
	end

	if type(arg_33_0) == "string" then
		return "'" .. tostring(arg_33_0) .. "'"
	end

	if type(arg_33_0) ~= "table" then
		return tostring(arg_33_0)
	end

	local var_33_0 = "{"
	local var_33_1 = false

	for iter_33_0, iter_33_1 in ipairs(arg_33_0) do
		if var_33_1 then
			var_33_0 = var_33_0 .. ","
		end

		var_33_1 = true
		var_33_0 = var_33_0 .. table.CastToString(iter_33_1)
	end

	for iter_33_2, iter_33_3 in pairs(arg_33_0) do
		if type(iter_33_2) == "number" then
			if #arg_33_0 < iter_33_2 then
				if var_33_1 then
					var_33_0 = var_33_0 .. ","
				end

				var_33_1 = true
				var_33_0 = var_33_0 .. string.format("[%s]=%s", iter_33_2, table.CastToString(iter_33_3))
			end
		else
			if var_33_1 then
				var_33_0 = var_33_0 .. ","
			end

			var_33_1 = true
			var_33_0 = var_33_0 .. string.format("%s=%s", iter_33_2, table.CastToString(iter_33_3))
		end
	end

	return var_33_0 .. "}"
end

function table.Diff(arg_34_0, arg_34_1, arg_34_2)
	arg_34_2 = arg_34_2 or function(arg_35_0)
		return arg_35_0
	end

	local var_34_0 = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_0) do
		var_34_0[arg_34_2(iter_34_1)] = iter_34_1
	end

	for iter_34_2, iter_34_3 in ipairs(arg_34_1) do
		({})[arg_34_2(iter_34_3)] = iter_34_3
	end

	for iter_34_4, iter_34_5 in pairs({}) do
		if var_34_0[iter_34_4] then
			table.insert({}, iter_34_5)
		else
			table.insert({}, iter_34_5)
		end
	end

	for iter_34_6, iter_34_7 in pairs(var_34_0) do
		if not ({})[iter_34_6] then
			table.insert({}, iter_34_7)
		end
	end

	return {}, {}, {}
end

return
