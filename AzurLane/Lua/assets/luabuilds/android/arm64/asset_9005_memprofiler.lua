local var_0_0 = {}
local var_0_1 = 0
local var_0_2 = true

local function var_0_3(arg_1_0, arg_1_1)
	collectgarbage = var_1_10002

	if var_1_10002("count") - var_0_1 <= 1e-06 then
		collectgarbage = var_3
		var_0_1 = var_3("count")

		return
	end

	debug = var_3

	local var_1_0 = var_3.getinfo(2, "S").source

	if var_0_2 then
		string = var_4
		var_1_0 = var_4.format("%s__%d", var_1_0, arg_1_1 - 1)
	end

	local var_1_1

	if not var_0_0[var_1_0] then
		var_1_1 = var_0_0
		var_1_1[var_1_0] = {
			var_1_0,
			1,
			var_2
		}
	else
		var_4[2] = var_4[2] + 1
		var_4[3] = var_4[3] + var_2
	end

	collectgarbage = var_1_1
	var_0_1 = var_1_1("count")

	return
end

local function var_0_4(arg_2_0)
	debug = var_1_10001

	if var_1_10001.gethook() then
		SC_MemLeakDetector = var_1

		var_1.SC_StopRecordAllocAndDumpStat()

		return
	end

	var_0_0 = {}
	collectgarbage = var_1
	var_0_1 = var_1("count")
	var_0_2 = not arg_2_0
	debug = var_1

	var_1.sethook(var_0_3, "l")

	return
end

local function var_0_5(arg_3_0)
	debug = var_1_10001

	var_1_10001.sethook()

	if not var_0_0 then
		return
	end

	local var_3_0 = {}

	pairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(var_0_0) do
		table = var_1_10007

		var_1_10007.insert(var_3_0, iter_3_1)
	end

	table = var_2

	var_2.sort(var_3_0, function(arg_4_0, arg_4_1)
		return arg_4_0[3] > arg_4_1[3]
	end)

	arg_3_0 = arg_3_0 or "memAlloc.csv"
	io = var_2

	if not var_2.open(arg_3_0, "w") then
		logw = var_3

		var_3.error("can't open file:", arg_3_0)

		return
	end

	var_2:write("fileLine, count, mem K, avg K\n")

	ipairs = var_3

	for iter_3_2, iter_3_3 in var_3(var_3_0) do
		local var_3_1 = var_2
		local var_3_2 = var_2.write

		string = var_1_10011

		var_3_2(var_3_1, var_1_10011.format("%s, %d, %f, %f\n", iter_3_3[1], iter_3_3[2], iter_3_3[3], iter_3_3[3] / iter_3_3[2]))
	end

	var_2:close()

	var_0_0 = nil

	return
end

return {
	StartRecordAlloc = var_0_4,
	StopRecordAllocAndDumpStat = var_0_5
}
