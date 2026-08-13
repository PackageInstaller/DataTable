table = var_0_10000

function var_0_10000.indexof(arg_1_0, arg_1_1, arg_1_2)
	for iter_1_0 = arg_1_2 or 1, #arg_1_0 do
		if arg_1_0[iter_1_0] == arg_1_1 then
			return iter_1_0
		end
	end

	return false
end

table = var_0_10000

function var_0_10000.keyof(arg_2_0, arg_2_1)
	pairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_0) do
		if iter_2_1 == arg_2_1 then
			return iter_2_0
		end
	end

	return nil
end

table = var_0_10000

function var_0_10000.removebyvalue(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 0

	for iter_3_0 = #arg_3_0, 1, -1 do
		if arg_3_0[iter_3_0] == arg_3_1 then
			table = var_8

			var_8.remove(arg_3_0, iter_3_0)

			var_3_0 = var_3_0 + 1

			if not arg_3_2 then
				break
			end
		end
	end

	return var_3_0
end

table = var_0_10000

function var_0_10000.removebykey(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0[arg_4_1]

	arg_4_0[arg_4_1] = nil

	return var_4_0
end

table = var_0_10000

function var_0_10000.insertto(arg_5_0, arg_5_1, arg_5_2)
	checkint = var_1_10003

	if var_1_10003(arg_5_2) <= 0 then
		arg_5_2 = #arg_5_0 + 1
	end

	local var_5_0 = #arg_5_1

	for iter_5_0 = 0, var_5_0 - 1 do
		arg_5_0[iter_5_0 + arg_5_2] = arg_5_1[iter_5_0 + 1]
	end

	return arg_5_0
end

table = var_0_10000

function var_0_10000.isEmpty(arg_6_0)
	type = var_1_10001

	if var_1_10001(arg_6_0) == "table" then
		next = var_1

		return var_1(arg_6_0) == nil
	end

	return true
end

table = var_0_10000

function var_0_10000.clear(arg_7_0)
	if arg_7_0 then
		pairs = var_1_10001

		for iter_7_0, iter_7_1 in var_1_10001(arg_7_0) do
			arg_7_0[iter_7_0] = nil
		end
	end

	return
end

table = var_0_10000

function var_0_10000.contains(arg_8_0, arg_8_1)
	if arg_8_0 == nil then
		return false
	end

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0) do
		if iter_8_1 == arg_8_1 then
			return true
		end
	end

	return false
end

table = var_0_10000

function var_0_10000.equal(arg_9_0, arg_9_1)
	type = var_1_10002

	local var_9_0 = var_1_10002(arg_9_0)

	type = var_1_10003

	if var_9_0 ~= var_1_10003(arg_9_1) then
		return false
	end

	type = var_9_0

	local var_9_1

	if var_9_0(arg_9_0) ~= "table" then
		var_9_1 = arg_9_0 == arg_9_1

		return var_9_1
	end

	if arg_9_0 == arg_9_1 then
		return true
	end

	pairs = var_9_1

	for iter_9_0, iter_9_1 in var_9_1(arg_9_0) do
		table = var_1_10007

		if not var_1_10007.equal(iter_9_1, arg_9_1[iter_9_0]) then
			return false
		end
	end

	pairs = var_2

	for iter_9_2, iter_9_3 in var_2(arg_9_1) do
		if arg_9_0[iter_9_2] == nil then
			return false
		end
	end

	return true
end

table = var_0_10000

function var_0_10000.containsData(arg_10_0, arg_10_1)
	if arg_10_0 == nil then
		return false
	end

	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0) do
		table = var_1_10007

		if var_1_10007.equal(iter_10_1, arg_10_1) then
			return true
		end
	end

	return false
end

table = var_0_10000

function var_0_10000.Foreach(arg_11_0, arg_11_1)
	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0) do
		arg_11_1(iter_11_0, iter_11_1)
	end

	return
end

table = var_0_10000

function var_0_10000.Ipairs(arg_12_0, arg_12_1)
	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0) do
		arg_12_1(iter_12_0, iter_12_1)
	end

	return
end

table = var_0_10000

function var_0_10000.IpairsCArray(arg_13_0, arg_13_1)
	ipairs = var_1_10002
	table = var_1_10004

	for iter_13_0, iter_13_1 in var_1_10002(var_1_10004.CArrayToArray(arg_13_0)) do
		arg_13_1(iter_13_0 - 1, iter_13_1)
	end

	return
end

table = var_0_10000

function var_0_10000.CArrayToArray(arg_14_0)
	return arg_14_0:ToTable()
end

table = var_0_10000

function var_0_10000.SerialIpairsAsync(arg_15_0, arg_15_1, arg_15_2)
	type = var_1_10003

	if var_1_10003(arg_15_0) ~= "table" then
		return
	end

	local var_15_0
	local var_15_1
	local var_15_2

	ipairs = var_1_10006

	local var_15_3, var_15_4

	var_15_3, arg_15_0, var_15_4 = var_1_10006(arg_15_0)

	local var_15_5

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

table = var_0_10000

function var_0_10000.ParallelIpairsAsync(arg_17_0, arg_17_1, arg_17_2)
	type = var_1_10003

	if var_1_10003(arg_17_0) ~= "table" then
		return
	end

	local var_17_0
	local var_17_1
	local var_17_2

	ipairs = var_1_10006

	local var_17_3, var_17_4

	var_17_3, arg_17_0, var_17_4 = var_1_10006(arg_17_0)

	local var_17_5 = 0
	local var_17_6 = 1

	local function var_17_7()
		var_17_5 = var_17_5 + 1

		if var_17_5 == var_17_6 then
			existCall = var_0

			var_0(arg_17_2)
		end

		return
	end

	while true do
		local var_17_8, var_17_9 = var_17_3(arg_17_0, var_17_4)
		local var_17_10 = var_17_9

		if var_17_8 == nil then
			break
		end

		var_17_6 = var_17_6 + 1

		arg_17_1(var_17_4, var_17_10, var_17_7)
	end

	var_17_7()

	return
end

table = var_0_10000

function var_0_10000.Find(arg_19_0, arg_19_1)
	pairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0) do
		if arg_19_1(iter_19_0, iter_19_1) then
			return iter_19_1, iter_19_0
		end
	end

	return
end

table = var_0_10000

function var_0_10000.Checkout(arg_20_0, arg_20_1)
	pairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(arg_20_0) do
		if arg_20_1(iter_20_0, iter_20_1) ~= nil then
			return var_7
		end
	end

	return
end

table = var_0_10000

function var_0_10000.getCount(arg_21_0)
	local var_21_0 = 0

	pairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0) do
		var_21_0 = var_21_0 + 1
	end

	return var_21_0
end

table = var_0_10000

function var_0_10000.merge(arg_22_0, arg_22_1)
	if not arg_22_1 or not arg_22_0 then
		return
	end

	pairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_1) do
		arg_22_0[iter_22_0] = iter_22_1
	end

	return arg_22_0
end

table = var_0_10000

function var_0_10000.mergeArray(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {}
	local var_23_1 = {}

	;(function(arg_24_0)
		ipairs = var_2_10001

		for iter_24_0, iter_24_1 in var_2_10001(arg_24_0) do
			if arg_23_2 and var_23_0[iter_24_1] then
				-- block empty
			else
				table = var_6

				var_6.insert(var_23_1, iter_24_1)

				var_23_0[iter_24_1] = true
			end
		end

		return
	end)(arg_23_0)
	var_5(arg_23_1)

	return var_23_1
end

table = var_0_10000

function var_0_10000.clean(arg_25_0)
	for iter_25_0 = #arg_25_0, 1, -1 do
		table = var_1_10005

		var_1_10005.remove(arg_25_0, iter_25_0)
	end

	return
end

table = var_0_10000

function var_0_10000.shallowCopy(arg_26_0)
	type = var_1_10001

	if var_1_10001(arg_26_0) ~= "table" then
		return arg_26_0
	end

	local var_26_0 = {}

	pairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0) do
		var_26_0[iter_26_0] = iter_26_1
	end

	return var_26_0
end

table = var_0_10000

function var_0_10000.getIndex(arg_27_0, arg_27_1)
	ipairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0) do
		if arg_27_1(iter_27_1) then
			return iter_27_0
		end
	end

	return
end

table = var_0_10000

function var_0_10000.map(arg_28_0, arg_28_1)
	local var_28_0 = {}

	pairs = var_1_10003

	for iter_28_0, iter_28_1 in var_1_10003(arg_28_0) do
		var_28_0[iter_28_0] = arg_28_1(iter_28_1)
	end

	return var_28_0
end

table = var_0_10000

function var_0_10000.lastof(arg_29_0)
	return arg_29_0[#arg_29_0]
end

table = var_0_10000

function var_0_10000.dichotomyInsert(arg_30_0, arg_30_1, arg_30_2)
	defaultValue = var_1_10003
	arg_30_2 = var_1_10003(arg_30_2, function(arg_31_0)
		return arg_31_0
	end)
	assert = var_3
	type = var_5

	var_3(var_5(arg_30_2) == "function")

	local var_30_0 = {}
	local var_30_1 = 1
	local var_30_2 = #arg_30_0
	local var_30_3

	local function var_30_4(arg_32_0)
		local var_32_0 = var_30_0
		local var_32_1

		if not var_30_0[arg_32_0] then
			var_32_1 = arg_30_2(arg_32_0)
		end

		var_32_0[arg_32_0] = var_32_1

		return var_30_0[arg_32_0]
	end

	while var_30_1 < var_30_2 do
		math = var_1_10008
		var_1_10008 = var_1_10008.floor((var_30_1 + var_30_2) / 2)

		if var_30_4(arg_30_0[var_1_10008]) < var_30_4(arg_30_1) then
			var_30_1 = var_1_10008 + 1
		else
			var_30_2 = var_1_10008
		end
	end

	table = var_1_10008

	var_1_10008.insert(arg_30_0, var_30_1, arg_30_1)

	return
end

table = var_0_10000

function var_0_10000.CastToString(arg_33_0)
	if arg_33_0 == nil then
		return "nil"
	end

	type = var_1_10001

	local var_33_0

	if var_1_10001(arg_33_0) == "string" then
		var_33_0 = "'"
		tostring = var_1_10002

		return var_33_0 .. var_1_10002(arg_33_0) .. "'"
	end

	type = var_33_0

	if var_33_0(arg_33_0) ~= "table" then
		tostring = var_1

		return var_1(arg_33_0)
	end

	local var_33_1 = "{"
	local var_33_2 = #arg_33_0
	local var_33_3 = false

	ipairs = var_1_10004

	for iter_33_0, iter_33_1 in var_1_10004(arg_33_0) do
		if var_33_3 then
			var_33_1 = var_33_1 .. ","
		end

		var_33_3 = true
		var_1_10009 = var_33_1
		table = var_1_10010
		var_33_1 = var_1_10009 .. var_1_10010.CastToString(iter_33_1)
	end

	pairs = var_4

	for iter_33_2, iter_33_3 in var_4(arg_33_0) do
		type = var_1_10009

		if var_1_10009(iter_33_2) == "number" then
			if var_33_2 < iter_33_2 then
				if var_33_3 then
					var_33_1 = var_33_1 .. ","
				end

				var_33_3 = true
				var_1_10009 = var_33_1
				string = var_1_10010
				var_1_10010 = var_1_10010.format

				local var_33_4 = "[%s]=%s"
				local var_33_5 = iter_33_2

				table = var_1_10014
				var_33_1 = var_1_10009 .. var_1_10010(var_33_4, var_33_5, var_1_10014.CastToString(iter_33_3))
			end
		else
			if var_33_3 then
				var_33_1 = var_33_1 .. ","
			end

			var_33_3 = true
			var_1_10009 = var_33_1
			string = var_1_10010
			var_1_10010 = var_1_10010.format

			local var_33_6 = "%s=%s"
			local var_33_7 = iter_33_2

			table = var_1_10014
			var_33_1 = var_1_10009 .. var_1_10010(var_33_6, var_33_7, var_1_10014.CastToString(iter_33_3))
		end
	end

	return var_33_1 .. "}"
end

table = var_0_10000

function var_0_10000.Diff(arg_34_0, arg_34_1, arg_34_2)
	arg_34_2 = arg_34_2 or function(arg_35_0)
		return arg_35_0
	end

	local var_34_0 = {}
	local var_34_1 = {}

	ipairs = var_1_10005

	for iter_34_0, iter_34_1 in var_1_10005(arg_34_0) do
		var_34_0[arg_34_2(iter_34_1)] = iter_34_1
	end

	ipairs = var_5

	for iter_34_2, iter_34_3 in var_5(arg_34_1) do
		var_34_1[arg_34_2(iter_34_3)] = iter_34_3
	end

	local var_34_2 = {}
	local var_34_3 = {}
	local var_34_4 = {}

	pairs = iter_34_2

	for iter_34_4, iter_34_5 in iter_34_2(var_34_1) do
		if var_34_0[iter_34_4] then
			table = var_13

			var_13.insert(var_34_2, iter_34_5)
		else
			table = var_13

			var_13.insert(var_34_3, iter_34_5)
		end
	end

	pairs = var_8

	for iter_34_6, iter_34_7 in var_8(var_34_0) do
		if not var_34_1[iter_34_6] then
			table = var_13

			var_13.insert(var_34_4, iter_34_7)
		end
	end

	return var_34_2, var_34_3, var_34_4
end

return
