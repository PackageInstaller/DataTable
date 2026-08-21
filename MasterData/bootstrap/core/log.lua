module("bootstrap.core.log", package.seeall)

local var_0_0 = print

local function var_0_1(...)
	local var_1_0 = select("#", ...)
	local var_1_1 = {
		...
	}
	local var_1_2 = {}

	for iter_1_0 = 1, var_1_0 do
		table.insert(var_1_2, tostring(var_1_1[iter_1_0]))
	end

	return table.concat(var_1_2, " ")
end

function printError(...)
	if not enableErrorLog then
		return
	end

	local var_2_0 = var_0_1(...)
	local var_2_1 = debug.getinfo(2, "nSl")
	local var_2_2 = var_2_1.currentline
	local var_2_3 = var_2_1.name or "closure"
	local var_2_4 = var_2_1.source
	local var_2_5 = string.sub(var_2_4, -string.len(".lua")) == ".lua" and "" or "." .. string.lower(var_2_1.what)

	nprintError("[" .. var_2_4 .. var_2_5 .. ":" .. var_2_2 .. "]:{" .. var_2_3 .. "} " .. var_2_0 .. debug.traceback("", 2))
end

function printWarn(...)
	if not enableWarnLog then
		return
	end

	local var_3_0 = var_0_1(...)
	local var_3_1 = debug.getinfo(2, "nSl")
	local var_3_2 = var_3_1.currentline
	local var_3_3 = var_3_1.name or "closure"
	local var_3_4 = var_3_1.source
	local var_3_5 = string.sub(var_3_4, -string.len(".lua")) == ".lua" and "" or "." .. string.lower(var_3_1.what)

	nprintWarn("[" .. var_3_4 .. var_3_5 .. ":" .. var_3_2 .. "]:{" .. var_3_3 .. "} " .. var_3_0)
end

function printInfo(...)
	if not enableLog then
		return
	end

	local var_4_0 = var_0_1(...)
	local var_4_1 = debug.getinfo(2, "nSl")
	local var_4_2 = var_4_1.currentline
	local var_4_3 = var_4_1.name or "closure"
	local var_4_4 = var_4_1.source
	local var_4_5 = string.sub(var_4_4, -string.len(".lua")) == ".lua" and "" or "." .. string.lower(var_4_1.what)

	var_0_0("[" .. var_4_4 .. var_4_5 .. ":" .. var_4_2 .. "]:{" .. var_4_3 .. "} " .. var_4_0)
end

function forcePrint(...)
	local var_5_0 = var_0_1(...)
	local var_5_1 = debug.getinfo(2, "nSl")
	local var_5_2 = var_5_1.currentline
	local var_5_3 = var_5_1.name or "closure"
	local var_5_4 = var_5_1.source
	local var_5_5 = string.sub(var_5_4, -string.len(".lua")) == ".lua" and "" or "." .. string.lower(var_5_1.what)

	var_0_0("[" .. var_5_4 .. var_5_5 .. ":" .. var_5_2 .. "]:{" .. var_5_3 .. "} " .. var_5_0)
end

local function var_0_2(arg_6_0)
	if type(arg_6_0) == "string" then
		arg_6_0 = "\"" .. arg_6_0 .. "\""
	end

	return tostring(arg_6_0)
end

function dump(arg_7_0, arg_7_1, arg_7_2)
	if type(arg_7_2) ~= "number" then
		arg_7_2 = 3
	end

	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = string.split(debug.traceback("", 2), "\n")

	printInfo("dump from: " .. string.trim(var_7_2[3]))

	local function var_7_3(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		arg_8_1 = arg_8_1 or "<var>"

		local var_8_0 = ""

		if type(arg_8_4) == "number" then
			var_8_0 = string.rep(" ", arg_8_4 - string.len(var_0_2(arg_8_1)))
		end

		if type(arg_8_0) ~= "table" then
			var_7_1[#var_7_1 + 1] = string.format("%s%s%s = %s", arg_8_2, var_0_2(arg_8_1), var_8_0, var_0_2(arg_8_0))
		elseif var_7_0[tostring(arg_8_0)] then
			var_7_1[#var_7_1 + 1] = string.format("%s%s%s = *REF*", arg_8_2, var_0_2(arg_8_1), var_8_0)
		else
			var_7_0[tostring(arg_8_0)] = true

			if arg_8_3 > arg_7_2 then
				var_7_1[#var_7_1 + 1] = string.format("%s%s = *MAX NESTING*", arg_8_2, var_0_2(arg_8_1))
			else
				var_7_1[#var_7_1 + 1] = string.format("%s%s = {", arg_8_2, var_0_2(arg_8_1))

				local var_8_1 = arg_8_2 .. "    "
				local var_8_2 = {}
				local var_8_3 = 0
				local var_8_4 = {}

				for iter_8_0, iter_8_1 in pairs(arg_8_0) do
					var_8_2[#var_8_2 + 1] = iter_8_0

					local var_8_5 = var_0_2(iter_8_0)
					local var_8_6 = string.len(var_8_5)

					if var_8_3 < var_8_6 then
						var_8_3 = var_8_6
					end

					var_8_4[iter_8_0] = iter_8_1
				end

				table.sort(var_8_2, function(arg_9_0, arg_9_1)
					if type(arg_9_0) == "number" and type(arg_9_1) == "number" then
						return arg_9_0 < arg_9_1
					else
						return tostring(arg_9_0) < tostring(arg_9_1)
					end
				end)

				for iter_8_2, iter_8_3 in ipairs(var_8_2) do
					var_7_3(var_8_4[iter_8_3], iter_8_3, var_8_1, arg_8_3 + 1, var_8_3)
				end

				var_7_1[#var_7_1 + 1] = string.format("%s}", arg_8_2)
			end
		end
	end

	var_7_3(arg_7_0, arg_7_1, "- ", 1)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		printInfo(iter_7_1)
	end
end

setglobal("printError", printError)
setglobal("printWarn", printWarn)
setglobal("printInfo", printInfo)
setglobal("print", printInfo)
setglobal("forcePrint", forcePrint)
setglobal("dump", dump)
