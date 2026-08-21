local var_0_0 = {}
local var_0_1 = 0
local var_0_2 = true

local function var_0_3(arg_1_0, arg_1_1)
	local var_1_0 = collectgarbage("count") - var_0_1

	if var_1_0 <= 1e-06 then
		var_0_1 = collectgarbage("count")

		return
	end

	local var_1_1 = debug.getinfo(2, "S").source

	if var_0_2 then
		var_1_1 = string.format("%s__%d", var_1_1, arg_1_1 - 1)
	end

	local var_1_2 = var_0_0[var_1_1]

	if not var_0_0[var_1_1] then
		var_0_0[var_1_1] = {
			var_1_1,
			1,
			var_1_0
		}
	else
		var_1_2[2] = var_1_2[2] + 1
		var_1_2[3] = var_1_2[3] + var_1_0
	end

	var_0_1 = collectgarbage("count")

	return
end

return {
	StartRecordAlloc = function(arg_2_0)
		if debug.gethook() then
			SC_MemLeakDetector.SC_StopRecordAllocAndDumpStat()

			return
		end

		var_0_0 = {}
		var_0_1 = collectgarbage("count")
		var_0_2 = not arg_2_0

		debug.sethook(var_0_3, "l")

		return
	end,
	StopRecordAllocAndDumpStat = function(arg_3_0)
		debug.sethook()

		if not var_0_0 then
			return
		end

		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(var_0_0) do
			table.insert(var_3_0, iter_3_1)
		end

		table.sort(var_3_0, function(arg_4_0, arg_4_1)
			return arg_4_0[3] > arg_4_1[3]
		end)

		arg_3_0 = arg_3_0 or "memAlloc.csv"

		local var_3_1 = io.open(arg_3_0, "w")

		if not var_3_1 then
			logw.error("can't open file:", arg_3_0)

			return
		end

		var_3_1:write("fileLine, count, mem K, avg K\n")

		for iter_3_2, iter_3_3 in ipairs(var_3_0) do
			var_3_1:write(string.format("%s, %d, %f, %f\n", iter_3_3[1], iter_3_3[2], iter_3_3[3], iter_3_3[3] / iter_3_3[2]))
		end

		var_3_1:close()

		var_0_0 = nil

		return
	end
}
