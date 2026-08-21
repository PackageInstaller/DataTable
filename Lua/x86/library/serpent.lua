local var_0_0 = "serpent"
local var_0_1 = "0.302"
local var_0_2 = "Paul Kulchenko"
local var_0_3 = "Lua serializer and pretty printer"
local var_0_4 = {
	[tostring(1 / 0)] = "1/0 --[[math.huge]]",
	[tostring(-1 / 0)] = "-1/0 --[[-math.huge]]",
	[tostring(0 / 0)] = "0/0"
}
local var_0_5 = {
	userdata = true,
	cdata = true,
	thread = true
}
local var_0_6 = debug and debug.getmetatable or getmetatable

local function var_0_7(arg_1_0)
	return next, arg_1_0
end

local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = _G or _ENV

for iter_0_0, iter_0_1 in ipairs({
	"and",
	"break",
	"do",
	"else",
	"elseif",
	"end",
	"false",
	"for",
	"function",
	"goto",
	"if",
	"in",
	"local",
	"nil",
	"not",
	"or",
	"repeat",
	"return",
	"then",
	"true",
	"until",
	"while"
}) do
	var_0_8[iter_0_1] = true
end

for iter_0_2, iter_0_3 in var_0_7(var_0_10) do
	var_0_9[iter_0_3] = iter_0_2
end

for iter_0_4, iter_0_5 in ipairs({
	"coroutine",
	"debug",
	"io",
	"math",
	"string",
	"table",
	"os"
}) do
	for iter_0_6, iter_0_7 in var_0_7(type(var_0_10[iter_0_5]) == "table" and var_0_10[iter_0_5] or {}) do
		var_0_9[iter_0_7] = iter_0_5 .. "." .. iter_0_6
	end
end

local function var_0_11(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.name
	local var_2_1 = arg_2_1.indent
	local var_2_2 = arg_2_1.fatal
	local var_2_3 = arg_2_1.maxnum
	local var_2_4 = arg_2_1.sparse
	local var_2_5 = arg_2_1.custom
	local var_2_6 = not arg_2_1.nohuge
	local var_2_7 = arg_2_1.compact and "" or " "
	local var_2_8 = arg_2_1.maxlevel or math.huge
	local var_2_9 = tonumber(arg_2_1.maxlength)
	local var_2_10 = arg_2_1.metatostring
	local var_2_11 = "_" .. (var_2_0 or "")
	local var_2_12 = arg_2_1.comment and (tonumber(arg_2_1.comment) or math.huge)
	local var_2_13 = arg_2_1.numformat or "%.17g"
	local var_2_14 = {}
	local var_2_15 = {
		"local " .. var_2_11 .. "={}"
	}
	local var_2_16 = {}
	local var_2_17 = 0

	local function var_2_18(arg_3_0)
		return "_" .. tostring(tostring(arg_3_0)):gsub("[^%w]", ""):gsub("(%d%w+)", function(arg_4_0)
			if not var_2_16[arg_4_0] then
				var_2_17 = var_2_17 + 1
				var_2_16[arg_4_0] = var_2_17
			end

			return tostring(var_2_16[arg_4_0])
		end)
	end

	local function var_2_19(arg_5_0)
		return type(arg_5_0) == "number" and tostring(var_2_6 and var_0_4[tostring(arg_5_0)] or var_2_13:format(arg_5_0)) or type(arg_5_0) ~= "string" and tostring(arg_5_0) or ("%q"):format(arg_5_0):gsub("\n", "n"):gsub("\x1A", "\\026")
	end

	local function var_2_20(arg_6_0, arg_6_1)
		return var_2_12 and (arg_6_1 or 0) < var_2_12 and " --[[" .. select(2, pcall(tostring, arg_6_0)) .. "]]" or ""
	end

	local function var_2_21(arg_7_0, arg_7_1)
		return var_0_9[arg_7_0] and var_0_9[arg_7_0] .. var_2_20(arg_7_0, arg_7_1) or not var_2_2 and var_2_19(select(2, pcall(tostring, arg_7_0))) or error("Can't serialize " .. tostring(arg_7_0))
	end

	local function var_2_22(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1 == nil and "" or arg_8_1
		local var_8_1 = type(var_8_0) == "string" and var_8_0:match("^[%l%u_][%w_]*$") and not var_0_8[var_8_0]
		local var_8_2 = var_8_1 and var_8_0 or "[" .. var_2_19(var_8_0) .. "]"

		return (arg_8_0 or "") .. (var_8_1 and arg_8_0 and "." or "") .. var_8_2, var_8_2
	end

	local var_2_23 = type(arg_2_1.sortkeys) == "function" and arg_2_1.sortkeys or function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = tonumber(arg_9_2) or 12
		local var_9_1 = {
			string = "b",
			number = "a"
		}

		local function var_9_2(arg_10_0)
			return ("%0" .. tostring(var_9_0) .. "d"):format(tonumber(arg_10_0))
		end

		table.sort(arg_9_0, function(arg_11_0, arg_11_1)
			return (arg_9_0[arg_11_0] ~= nil and 0 or var_9_1[type(arg_11_0)] or "z") .. tostring(arg_11_0):gsub("%d+", var_9_2) < (arg_9_0[arg_11_1] ~= nil and 0 or var_9_1[type(arg_11_1)] or "z") .. tostring(arg_11_1):gsub("%d+", var_9_2)
		end)
	end

	local function var_2_24(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
		local var_12_0 = type(arg_12_0)
		local var_12_1 = arg_12_6 or 0
		local var_12_2 = var_0_6(arg_12_0)
		local var_12_3, var_12_4 = var_2_22(arg_12_4, arg_12_1)
		local var_12_5 = arg_12_5 and (type(arg_12_1) == "number" and "" or arg_12_1 .. var_2_7 .. "=" .. var_2_7) or arg_12_1 ~= nil and var_12_4 .. var_2_7 .. "=" .. var_2_7 or ""

		if var_2_14[arg_12_0] then
			var_2_15[#var_2_15 + 1] = var_12_3 .. var_2_7 .. "=" .. var_2_7 .. var_2_14[arg_12_0]

			return var_12_5 .. "nil" .. var_2_20("ref", var_12_1)
		end

		if type(var_12_2) == "table" and var_2_10 ~= false then
			local var_12_6, var_12_7 = pcall(function()
				return var_12_2.__tostring(arg_12_0)
			end)
			local var_12_8, var_12_9 = pcall(function()
				return var_12_2.__serialize(arg_12_0)
			end)

			if var_12_6 or var_12_8 then
				var_2_14[arg_12_0] = arg_12_3 or var_12_3
				arg_12_0 = var_12_8 and var_12_9 or var_12_7
				var_12_0 = type(arg_12_0)
			end
		end

		if var_12_0 == "table" then
			if var_12_1 >= var_2_8 then
				return var_12_5 .. "{}" .. var_2_20("maxlvl", var_12_1)
			end

			var_2_14[arg_12_0] = arg_12_3 or var_12_3

			if next(arg_12_0) == nil then
				return var_12_5 .. "{}" .. var_2_20(arg_12_0, var_12_1)
			end

			if var_2_9 and var_2_9 < 0 then
				return var_12_5 .. "{}" .. var_2_20("maxlen", var_12_1)
			end

			local var_12_10 = math.min(#arg_12_0, var_2_3 or #arg_12_0)
			local var_12_11 = {}
			local var_12_12 = {}

			for iter_12_0 = 1, var_12_10 do
				var_12_11[iter_12_0] = iter_12_0
			end

			if not var_2_3 or #var_12_11 < var_2_3 then
				local var_12_13 = #var_12_11

				for iter_12_1 in var_0_7(arg_12_0) do
					if var_12_11[iter_12_1] ~= iter_12_1 then
						var_12_13 = var_12_13 + 1
						var_12_11[var_12_13] = iter_12_1
					end
				end
			end

			if var_2_3 and #var_12_11 > var_2_3 then
				var_12_11[var_2_3 + 1] = nil
			end

			if arg_2_1.sortkeys and var_12_10 < #var_12_11 then
				var_2_23(var_12_11, arg_12_0, arg_2_1.sortkeys)
			end

			local var_12_14 = var_2_4 and var_12_10 < #var_12_11

			for iter_12_2, iter_12_3 in ipairs(var_12_11) do
				local var_12_15 = arg_12_0[iter_12_3]
				local var_12_16 = type(iter_12_3)
				local var_12_17 = iter_12_2 <= var_12_10 and not var_12_14

				if arg_2_1.valignore and arg_2_1.valignore[var_12_15] or arg_2_1.keyallow and not arg_2_1.keyallow[iter_12_3] or arg_2_1.keyignore and arg_2_1.keyignore[iter_12_3] or arg_2_1.valtypeignore and arg_2_1.valtypeignore[type(var_12_15)] or var_12_14 and var_12_15 == nil then
					-- block empty
				elseif var_12_16 == "table" or var_12_16 == "function" or var_0_5[var_12_16] then
					if not var_2_14[iter_12_3] and not var_0_9[iter_12_3] then
						var_2_15[#var_2_15 + 1] = "placeholder"

						local var_12_18 = var_2_22(var_2_11, var_2_18(iter_12_3))

						var_2_15[#var_2_15] = var_2_24(iter_12_3, var_12_18, arg_12_2, var_12_18, var_2_11, true)
					end

					var_2_15[#var_2_15 + 1] = "placeholder"

					local var_12_19 = var_2_14[arg_12_0] .. "[" .. tostring(var_2_14[iter_12_3] or var_0_9[iter_12_3] or var_2_18(iter_12_3)) .. "]"

					var_2_15[#var_2_15] = var_12_19 .. var_2_7 .. "=" .. var_2_7 .. tostring(var_2_14[var_12_15] or var_2_24(var_12_15, nil, arg_12_2, var_12_19))
				else
					var_12_12[#var_12_12 + 1] = var_2_24(var_12_15, iter_12_3, arg_12_2, nil, var_2_14[arg_12_0], var_12_17, var_12_1 + 1)

					if var_2_9 then
						var_2_9 = var_2_9 - #var_12_12[#var_12_12]

						if var_2_9 < 0 then
							break
						end
					end
				end
			end

			local var_12_20 = string.rep(arg_12_2 or "", var_12_1)
			local var_12_21 = arg_12_2 and "{\n" .. var_12_20 .. arg_12_2 or "{"
			local var_12_22 = table.concat(var_12_12, "," .. (arg_12_2 and "\n" .. var_12_20 .. arg_12_2 or var_2_7))
			local var_12_23 = arg_12_2 and "\n" .. var_12_20 .. "}" or "}"

			return (var_2_5 and var_2_5(var_12_5, var_12_21, var_12_22, var_12_23, var_12_1) or var_12_5 .. var_12_21 .. var_12_22 .. var_12_23) .. var_2_20(arg_12_0, var_12_1)
		elseif var_0_5[var_12_0] then
			var_2_14[arg_12_0] = arg_12_3 or var_12_3

			return var_12_5 .. var_2_21(arg_12_0, var_12_1)
		elseif var_12_0 == "function" then
			var_2_14[arg_12_0] = arg_12_3 or var_12_3

			if arg_2_1.nocode then
				return var_12_5 .. "function() --[[..skipped..]] end" .. var_2_20(arg_12_0, var_12_1)
			end

			local var_12_24, var_12_25 = pcall(string.dump, arg_12_0)
			local var_12_26 = var_12_24 and "((loadstring or load)(" .. var_2_19(var_12_25) .. ",'@serialized'))" .. var_2_20(arg_12_0, var_12_1)

			return var_12_5 .. (var_12_26 or var_2_21(arg_12_0, var_12_1))
		else
			return var_12_5 .. var_2_19(arg_12_0)
		end
	end

	local var_2_25 = var_2_1 and "\n" or ";" .. var_2_7
	local var_2_26 = var_2_24(arg_2_0, var_2_0, var_2_1)
	local var_2_27 = #var_2_15 > 1 and table.concat(var_2_15, var_2_25) .. var_2_25 or ""
	local var_2_28 = arg_2_1.comment and #var_2_15 > 1 and var_2_7 .. "--[[incomplete output with shared/self-references skipped]]" or ""

	return not var_2_0 and var_2_26 .. var_2_28 or "do local " .. var_2_26 .. var_2_25 .. var_2_27 .. "return " .. var_2_0 .. var_2_25 .. "end"
end

local function var_0_12(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 and arg_15_1.safe == false and var_0_10 or setmetatable({}, {
		__index = function(arg_16_0, arg_16_1)
			return arg_16_0
		end,
		__call = function(arg_17_0, ...)
			error("cannot call functions")
		end
	})
	local var_15_1, var_15_2 = (loadstring or load)("return " .. arg_15_0, nil, nil, var_15_0)

	if not var_15_1 then
		var_15_1, var_15_2 = (loadstring or load)(arg_15_0, nil, nil, var_15_0)
	end

	if not var_15_1 then
		return var_15_1, var_15_2
	end

	if setfenv then
		setfenv(var_15_1, var_15_0)
	end

	return pcall(var_15_1)
end

local function var_0_13(arg_18_0, arg_18_1)
	if arg_18_1 then
		for iter_18_0, iter_18_1 in var_0_7(arg_18_1) do
			arg_18_0[iter_18_0] = iter_18_1
		end
	end

	return arg_18_0
end

return {
	_NAME = var_0_0,
	_COPYRIGHT = var_0_2,
	_DESCRIPTION = var_0_3,
	_VERSION = var_0_1,
	serialize = var_0_11,
	load = var_0_12,
	dump = function(arg_19_0, arg_19_1)
		return var_0_11(arg_19_0, var_0_13({
			sparse = true,
			name = "_",
			compact = true
		}, arg_19_1))
	end,
	line = function(arg_20_0, arg_20_1)
		return var_0_11(arg_20_0, var_0_13({
			sortkeys = true,
			comment = true
		}, arg_20_1))
	end,
	block = function(arg_21_0, arg_21_1)
		return var_0_11(arg_21_0, var_0_13({
			sortkeys = true,
			indent = "  ",
			comment = true
		}, arg_21_1))
	end
}
