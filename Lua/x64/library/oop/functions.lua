local var_0_0 = "Assets/Scripts/LuaScripts/"

local function var_0_1(arg_1_0)
	if not string.find(arg_1_0, ".") then
		arg_1_0 = arg_1_0 .. ".lua"
	end

	return var_0_0 .. arg_1_0
end

function dump_stack(arg_2_0)
	local var_2_0 = string.format("[%s:%s:%d]", arg_2_0.short_src, arg_2_0.name or "?", arg_2_0.currentline)
	local var_2_1 = string.format("<a href=\"%s\" line=\"%d\">", var_0_1(arg_2_0.short_src), arg_2_0.currentline)
	local var_2_2 = "</a>"

	return string.format("%s%s%s", var_2_1, var_2_0, var_2_2)
end

function dump_msg(arg_3_0, arg_3_1)
	return string.format("%s: %s", dump_stack(arg_3_0), arg_3_1)
end

function nullable(arg_4_0, ...)
	local var_4_0 = {
		...
	}

	for iter_4_0 = 1, select("#", ...) do
		local var_4_1 = var_4_0[iter_4_0]

		if arg_4_0 == nil or var_4_1 == nil then
			return nil
		end

		arg_4_0 = arg_4_0[var_4_1]
	end

	return arg_4_0
end

if nullable(debugger, "enabled") then
	local function var_0_2(arg_5_0, arg_5_1, arg_5_2)
		arg_5_0 = arg_5_0 .. "\nstack traceback:"

		for iter_5_0 = 1, arg_5_2 do
			local var_5_0 = debug.getinfo(arg_5_1 + iter_5_0 + 1)

			if var_5_0 == nil then
				break
			end

			arg_5_0 = arg_5_0 .. "\n\t" .. dump_stack(var_5_0)
		end

		if debug.getinfo(arg_5_1 + arg_5_2 + 2) then
			arg_5_0 = arg_5_0 .. "\n\t..."
		end

		return arg_5_0
	end

	local var_0_3 = 3

	function print(arg_6_0, ...)
		local var_6_0 = {
			...
		}
		local var_6_1 = tostring(arg_6_0)

		for iter_6_0 = 1, #var_6_0 do
			var_6_1 = var_6_1 .. "    " .. tostring(var_6_0[iter_6_0])
		end

		local var_6_2 = 2
		local var_6_3 = dump_msg(debug.getinfo(var_6_2), var_6_1)

		Debug.Log(var_0_2(var_6_3, var_6_2, var_0_3))
	end

	function printf(arg_7_0, ...)
		local var_7_0 = 2
		local var_7_1 = dump_msg(debug.getinfo(var_7_0), string.format(arg_7_0, ...))

		Debug.Log(var_0_2(var_7_1, var_7_0, var_0_3))
	end
else
	function printf(arg_8_0, ...)
		print(string.format(arg_8_0, ...))
	end
end

function AssureTable(arg_9_0)
	if type(arg_9_0) ~= "table" then
		arg_9_0 = {}
	end

	return arg_9_0
end

function checknumber(arg_10_0, arg_10_1)
	return tonumber(arg_10_0, arg_10_1) or 0
end

function math.round(arg_11_0)
	arg_11_0 = checknumber(arg_11_0)

	return math.floor(arg_11_0 + 0.5)
end

function checkint(arg_12_0)
	return math.round(checknumber(arg_12_0))
end

function checkbool(arg_13_0)
	return arg_13_0 ~= nil and arg_13_0 ~= false
end

function checktable(arg_14_0)
	if type(arg_14_0) ~= "table" then
		arg_14_0 = {}
	end

	return arg_14_0
end

function table.nums(arg_15_0)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0) do
		var_15_0 = var_15_0 + 1
	end

	return var_15_0
end

function table.keys(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0) do
		var_16_0[#var_16_0 + 1] = iter_16_0
	end

	return var_16_0
end

function table.indexof(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0 = arg_17_2 or 1, #arg_17_0 do
		if arg_17_0[iter_17_0] == arg_17_1 then
			return iter_17_0
		end
	end

	return false
end

function table.keyof(arg_18_0, arg_18_1)
	if type(arg_18_0) ~= "table" then
		return nil
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		if iter_18_1 == arg_18_1 then
			return iter_18_0
		end
	end

	return nil
end

function table.removebyvalue(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = 0
	local var_19_1 = 1
	local var_19_2 = #arg_19_0

	while var_19_1 <= var_19_2 do
		if arg_19_0[var_19_1] == arg_19_1 then
			table.remove(arg_19_0, var_19_1)

			var_19_0 = var_19_0 + 1
			var_19_1 = var_19_1 - 1
			var_19_2 = var_19_2 - 1

			if not arg_19_2 then
				break
			end
		end

		var_19_1 = var_19_1 + 1
	end

	return var_19_0
end

function table.clean(arg_20_0)
	for iter_20_0 = #arg_20_0, 1, -1 do
		table.remove(arg_20_0, iter_20_0)
	end
end

function table.insertto(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2 = checkint(arg_21_2)

	if arg_21_2 <= 0 then
		arg_21_2 = #arg_21_0 + 1
	end

	local var_21_0 = #arg_21_1

	for iter_21_0 = 0, var_21_0 - 1 do
		arg_21_0[iter_21_0 + arg_21_2] = arg_21_1[iter_21_0 + 1]
	end
end

function table.merge(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		arg_22_0[iter_22_0] = iter_22_1
	end
end

function table.length(arg_23_0)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(arg_23_0 or {}) do
		var_23_0 = var_23_0 + 1
	end

	return var_23_0
end

function table.mergeinsert(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in pairs(arg_24_1) do
		if not table.keyof(arg_24_0, iter_24_1) then
			table.insert(arg_24_0, table.nums(arg_24_0) + 1, iter_24_1)
		end
	end

	return arg_24_0
end

function table.deepMerge(arg_25_0, arg_25_1)
	if type(arg_25_1) == "table" then
		for iter_25_0, iter_25_1 in pairs(arg_25_1) do
			if arg_25_0[iter_25_0] then
				table.deepMerge(arg_25_0[iter_25_0], iter_25_1)
			else
				arg_25_0[iter_25_0] = iter_25_1
			end
		end
	end
end

function table.equal(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0 == nil or arg_26_1 == nil or table.length(arg_26_0) ~= table.length(arg_26_1) or type(arg_26_0) ~= type(arg_26_1) then
		return false
	end

	for iter_26_0, iter_26_1 in pairs(arg_26_0) do
		if type(iter_26_1) == "table" then
			if arg_26_2 == "all" or table.indexof(arg_26_2, iter_26_0) then
				if not table.equal(iter_26_1, arg_26_1[iter_26_0], "all") then
					return false
				end
			elseif not table.equal(iter_26_1, arg_26_1[iter_26_0], arg_26_2) then
				return false
			end
		elseif (arg_26_2 == "all" or table.indexof(arg_26_2, iter_26_0)) and iter_26_1 ~= arg_26_1[iter_26_0] then
			return false
		end
	end

	return true
end

function string.split(arg_27_0, arg_27_1)
	arg_27_0 = tostring(arg_27_0)
	arg_27_1 = tostring(arg_27_1)

	if arg_27_1 == "" then
		return false
	end

	local var_27_0 = 0
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in function()
		return string.find(arg_27_0, arg_27_1, var_27_0, true)
	end do
		table.insert(var_27_1, string.sub(arg_27_0, var_27_0, iter_27_0 - 1))

		var_27_0 = iter_27_1 + 1
	end

	table.insert(var_27_1, string.sub(arg_27_0, var_27_0))

	return var_27_1
end

function string.ltrim(arg_29_0)
	return string.gsub(arg_29_0, "^[ \t\n\r]+", "")
end

function string.rtrim(arg_30_0)
	return string.gsub(arg_30_0, "[ \t\n\r]+$", "")
end

function string.trim(arg_31_0)
	arg_31_0 = string.gsub(arg_31_0, "^[ \t\n\r]+", "")

	return string.gsub(arg_31_0, "[ \t\n\r]+$", "")
end

function string.ucfirst(arg_32_0)
	return string.upper(string.sub(arg_32_0, 1, 1)) .. string.sub(arg_32_0, 2)
end

local function var_0_4(arg_33_0)
	return "%" .. string.format("%02X", string.byte(arg_33_0))
end

function handler(arg_34_0, arg_34_1)
	return function(...)
		return arg_34_1(arg_34_0, ...)
	end
end

function handlerArg(arg_36_0, arg_36_1, arg_36_2)
	return function(...)
		return arg_36_1(arg_36_0, unpack(arg_36_2), ...)
	end
end

function handlerArg1(arg_38_0, arg_38_1, arg_38_2)
	return function(...)
		return arg_38_1(arg_38_0, arg_38_2, ...)
	end
end

function handler1layer(arg_40_0, arg_40_1)
	return function(arg_41_0, ...)
		return arg_40_1(arg_40_0, ...)
	end
end

function handler2layer(arg_42_0, arg_42_1, arg_42_2)
	return function(arg_43_0, ...)
		local var_43_0 = arg_42_1(arg_42_0)

		if var_43_0 then
			return var_43_0[arg_42_2](var_43_0, ...)
		end
	end
end

function handler2layerArg1(arg_44_0, arg_44_1, arg_44_2)
	return function(arg_45_0, ...)
		local var_45_0 = {
			...
		}
		local var_45_1 = table.remove(var_45_0, 1)
		local var_45_2 = arg_44_1(arg_44_0, var_45_1)

		if var_45_2 then
			return var_45_2[arg_44_2](var_45_2, unpack(var_45_0))
		end
	end
end

function config2dev(arg_46_0)
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in pairs(arg_46_0) do
		var_46_0[iter_46_0 .. "_"] = iter_46_1
	end

	return var_46_0
end

local var_0_5 = print
local var_0_6 = table.concat
local var_0_7 = table.insert
local var_0_8 = string.rep
local var_0_9 = type
local var_0_10 = pairs
local var_0_11 = tostring
local var_0_12 = next

function print_r(arg_47_0)
	if var_0_9(arg_47_0) ~= "table" then
		return
	end

	local var_47_0 = {
		[arg_47_0] = "."
	}

	local function var_47_1(arg_48_0, arg_48_1, arg_48_2)
		local var_48_0 = {}

		for iter_48_0, iter_48_1 in var_0_10(arg_48_0) do
			local var_48_1 = var_0_11(iter_48_0)

			if var_47_0[iter_48_1] then
				var_0_7(var_48_0, "+" .. var_48_1 .. " {" .. var_47_0[iter_48_1] .. "}")
			elseif var_0_9(iter_48_1) == "table" then
				local var_48_2 = arg_48_2 .. "." .. var_48_1

				var_47_0[iter_48_1] = var_48_2

				var_0_7(var_48_0, "+" .. var_48_1 .. var_47_1(iter_48_1, arg_48_1 .. (var_0_12(arg_48_0, iter_48_0) and "|" or " ") .. var_0_8(" ", #var_48_1), var_48_2))
			else
				var_0_7(var_48_0, "+" .. var_48_1 .. " [" .. var_0_11(iter_48_1) .. "]")
			end
		end

		return var_0_6(var_48_0, "\n" .. arg_48_1)
	end

	var_0_5(var_47_1(arg_47_0, "", ""))
end

function string.firstToUpper(arg_49_0)
	local var_49_0 = string.sub(arg_49_0, 1, 1)

	return string.upper(var_49_0) .. string.sub(arg_49_0, 2)
end

function table.GetFirstElem(arg_50_0)
	for iter_50_0, iter_50_1 in var_0_10(arg_50_0) do
		return iter_50_1
	end
end

function table.GetElemByIndex(arg_51_0, arg_51_1)
	if var_0_9(arg_51_0) == "table" then
		local var_51_0 = 1

		for iter_51_0, iter_51_1 in var_0_10(arg_51_0) do
			if var_51_0 == arg_51_1 then
				return iter_51_1
			end

			var_51_0 = var_51_0 + 1
		end
	end

	return nil
end

function table.isEmpty(arg_52_0)
	if var_0_9(arg_52_0) == "table" then
		for iter_52_0, iter_52_1 in var_0_10(arg_52_0) do
			return false
		end
	end

	return true
end

function table.dup(arg_53_0)
	if var_0_9(arg_53_0) ~= "table" then
		return {}
	end

	local var_53_0 = {}

	table.merge(var_53_0, arg_53_0)

	return var_53_0
end

function table.toString(arg_54_0)
	if var_0_9(arg_54_0) ~= "table" then
		return "{}"
	end

	local function var_54_0(arg_55_0)
		local var_55_0 = ""

		for iter_55_0, iter_55_1 in var_0_10(arg_55_0) do
			if var_0_9(iter_55_1) == "table" then
				if var_0_9(iter_55_0) ~= "number" then
					var_55_0 = var_55_0 .. var_0_11(iter_55_0) .. "="
				end

				var_55_0 = var_55_0 .. "{" .. var_54_0(iter_55_1) .. "},"
			else
				if var_0_9(iter_55_0) ~= "number" then
					var_55_0 = var_55_0 .. var_0_11(iter_55_0) .. "="
				end

				if var_0_9(iter_55_1) == "string" then
					var_55_0 = var_55_0 .. "\"" .. var_0_11(iter_55_1) .. "\","
				else
					var_55_0 = var_55_0 .. var_0_11(iter_55_1) .. ","
				end
			end
		end

		if string.sub(var_55_0, -1, -1) == "," then
			var_55_0 = string.sub(var_55_0, 1, -2)
		end

		return var_55_0
	end

	local var_54_1 = var_54_0(arg_54_0)

	if string.sub(var_54_1, -1, -1) == "," then
		var_54_1 = string.sub(var_54_1, 1, -2)
	end

	return "{" .. var_54_1 .. "}"
end

function table.toStringLimitDepth(arg_56_0, arg_56_1)
	if var_0_9(arg_56_0) ~= "table" then
		return "{}"
	end

	local var_56_0 = 0

	local function var_56_1(arg_57_0)
		var_56_0 = var_56_0 + 1

		if var_56_0 > arg_56_1 then
			return "\"表格深度大于" .. arg_56_1 .. "\","
		end

		local var_57_0 = ""

		for iter_57_0, iter_57_1 in var_0_10(arg_57_0) do
			if var_0_9(iter_57_1) == "table" then
				if var_0_9(iter_57_0) ~= "number" then
					var_57_0 = var_57_0 .. var_0_11(iter_57_0) .. "="
				end

				var_57_0 = var_57_0 .. "{" .. var_56_1(iter_57_1) .. "},"
			else
				if var_0_9(iter_57_0) ~= "number" then
					var_57_0 = var_57_0 .. var_0_11(iter_57_0) .. "="
				end

				if var_0_9(iter_57_1) == "string" then
					var_57_0 = var_57_0 .. "\"" .. var_0_11(iter_57_1) .. "\","
				else
					var_57_0 = var_57_0 .. var_0_11(iter_57_1) .. ","
				end
			end
		end

		return var_57_0
	end

	return "{" .. var_56_1(arg_56_0) .. "}"
end

local function var_0_13(arg_58_0, arg_58_1)
	arg_58_1 = arg_58_1 - 1

	local var_58_0 = arg_58_0[arg_58_1]

	if var_58_0 then
		return arg_58_1, var_58_0
	end
end

function r_ipairs(arg_59_0)
	return var_0_13, arg_59_0, #arg_59_0 + 1
end
