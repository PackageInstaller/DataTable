-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/bootstrap/core/log.lua

module("bootstrap.core.log", package.seeall)

local nprint = print

function printError(...)
	if not enableErrorLog then
		return
	end

	local args = ...

	if args ~= nil then
		args = {
			...
		}

		local arr = {}
		local len = select("#", ...)

		for i = 1, len do
			table.insert(arr, tostring(args[i]))
		end

		local str = table.concat(arr, " ", 1, len)

		nprintError(str .. debug.traceback("", 2))
	else
		nprintError("nil" .. debug.traceback("", 2))
	end
end

function printWarn(...)
	if not enableWarnLog then
		return
	end

	nprintWarn(...)
end

function printInfo(...)
	if not enableLog then
		return
	end

	nprint(...)
end

function forcePrint(...)
	nprint(...)
end

local function dump_value_(v)
	if type(v) == "string" then
		v = "\"" .. v .. "\""
	end

	return tostring(v)
end

function dump(value, desciption, nesting)
	if type(nesting) ~= "number" then
		nesting = 3
	end

	local lookupTable = {}
	local result = {}
	local traceback = string.split(debug.traceback("", 2), "\n")

	nprint("dump from: " .. string.trim(traceback[3]))

	local function dump_(value, desciption, indent, nest, keylen)
		desciption = desciption or "<var>"

		local spc = ""

		if type(keylen) == "number" then
			spc = string.rep(" ", keylen - string.len(dump_value_(desciption)))
		end

		if type(value) ~= "table" then
			result[#result + 1] = string.format("%s%s%s = %s", indent, dump_value_(desciption), spc, dump_value_(value))
		elseif lookupTable[tostring(value)] then
			result[#result + 1] = string.format("%s%s%s = *REF*", indent, dump_value_(desciption), spc)
		else
			lookupTable[tostring(value)] = true

			if nest > nesting then
				result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, dump_value_(desciption))
			else
				result[#result + 1] = string.format("%s%s = {", indent, dump_value_(desciption))

				local indent2 = indent .. "    "
				local keys = {}
				local keylen = 0
				local values = {}

				for k, v in pairs(value) do
					keys[#keys + 1] = k

					local vk = dump_value_(k)
					local vkl = string.len(vk)

					if keylen < vkl then
						keylen = vkl
					end

					values[k] = v
				end

				table.sort(keys, function(a, b)
					if type(a) == "number" and type(b) == "number" then
						return a < b
					else
						return tostring(a) < tostring(b)
					end
				end)

				for i, k in ipairs(keys) do
					dump_(values[k], k, indent2, nest + 1, keylen)
				end

				result[#result + 1] = string.format("%s}", indent)
			end
		end
	end

	dump_(value, desciption, "- ", 1)

	for i, line in ipairs(result) do
		nprint(line)
	end
end

setglobal("printError", printError)
setglobal("printWarn", printWarn)
setglobal("printInfo", printInfo)
setglobal("print", printInfo)
setglobal("forcePrint", forcePrint)
setglobal("dump", dump)
