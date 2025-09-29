-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/editorsetting/LuaDebug.lua

module("logic.extensions.hacktool.editorsetting.LuaDebug", package.seeall)

local debugger_stackInfo, coro_debugger
local debugger_require = require
local debugger_exeLuaString, loadstring_

if loadstring then
	loadstring_ = loadstring
else
	loadstring_ = load
end

local ZZBase64 = {}
local LuaDebugTool_

if LuaDebugTool then
	LuaDebugTool_ = LuaDebugTool
elseif CS and CS.LuaDebugTool then
	LuaDebugTool_ = CS.LuaDebugTool
end

local LuaDebugTool = LuaDebugTool_
local loadstring = loadstring_
local getinfo = debug.getinfo

local function createSocket()
	local base = _G
	local string = require("string")
	local math = require("math")
	local socket = require("socket.core")
	local _M = socket

	function _M.connect4(address, port, laddress, lport)
		return socket.connect(address, port, laddress, lport, "inet")
	end

	function _M.connect6(address, port, laddress, lport)
		return socket.connect(address, port, laddress, lport, "inet6")
	end

	if not _M.connect then
		function _M.connect(address, port, laddress, lport)
			local sock, err = socket.tcp()

			if not sock then
				return nil, err
			end

			if laddress then
				local res, err = sock:bind(laddress, lport, -1)

				if not res then
					return nil, err
				end
			end

			local res, err = sock:connect(address, port)

			if not res then
				return nil, err
			end

			return sock
		end
	end

	function _M.bind(host, port, backlog)
		if host == "*" then
			host = "0.0.0.0"
		end

		local addrinfo, err = socket.dns.getaddrinfo(host)

		if not addrinfo then
			return nil, err
		end

		local sock, res

		err = "no info on address"

		for i, alt in base.ipairs(addrinfo) do
			if alt.family == "inet" then
				sock, err = socket.tcp4()
			else
				sock, err = socket.tcp6()
			end

			if not sock then
				return nil, err
			end

			sock:setoption("reuseaddr", true)

			res, err = sock:bind(alt.addr, port)

			if not res then
				sock:close()
			else
				res, err = sock:listen(backlog)

				if not res then
					sock:close()
				else
					return sock
				end
			end
		end

		return nil, err
	end

	_M.try = _M.newtry()

	function _M.choose(table)
		return function(name, opt1, opt2)
			if base.type(name) ~= "string" then
				name, opt1, opt2 = "default", name, opt1
			end

			local f = table[name or "nil"]

			if not f then
				base.error("unknown key (" .. base.tostring(name) .. ")", 3)
			else
				return f(opt1, opt2)
			end
		end
	end

	local sourcet, sinkt = {}, {}

	_M.sourcet = sourcet
	_M.sinkt = sinkt
	_M.BLOCKSIZE = 2048
	sinkt["close-when-done"] = function(sock)
		return base.setmetatable({
			getfd = function()
				return sock:getfd()
			end,
			dirty = function()
				return sock:dirty()
			end
		}, {
			__call = function(self, chunk, err)
				if not chunk then
					sock:close()

					return 1
				else
					return sock:send(chunk)
				end
			end
		})
	end
	sinkt["keep-open"] = function(sock)
		return base.setmetatable({
			getfd = function()
				return sock:getfd()
			end,
			dirty = function()
				return sock:dirty()
			end
		}, {
			__call = function(self, chunk, err)
				if chunk then
					return sock:send(chunk)
				else
					return 1
				end
			end
		})
	end
	sinkt.default = sinkt["keep-open"]
	_M.sink = _M.choose(sinkt)
	sourcet["by-length"] = function(sock, length)
		return base.setmetatable({
			getfd = function()
				return sock:getfd()
			end,
			dirty = function()
				return sock:dirty()
			end
		}, {
			__call = function()
				if length <= 0 then
					return nil
				end

				local size = math.min(socket.BLOCKSIZE, length)
				local chunk, err = sock:receive(size)

				if err then
					return nil, err
				end

				length = length - string.len(chunk)

				return chunk
			end
		})
	end
	sourcet["until-closed"] = function(sock)
		local done

		return base.setmetatable({
			getfd = function()
				return sock:getfd()
			end,
			dirty = function()
				return sock:dirty()
			end
		}, {
			__call = function()
				if done then
					return nil
				end

				local chunk, err, partial = sock:receive(socket.BLOCKSIZE)

				if not err then
					return chunk
				elseif err == "closed" then
					sock:close()

					done = 1

					return partial
				else
					return nil, err
				end
			end
		})
	end
	sourcet.default = sourcet["until-closed"]
	_M.source = _M.choose(sourcet)

	return _M
end

local function createJson()
	local math = require("math")
	local string = require("string")
	local table = require("table")
	local object
	local json = {}
	local json_private = {}

	json.EMPTY_ARRAY = {}
	json.EMPTY_OBJECT = {}

	local decode_scanArray, decode_scanComment, decode_scanConstant, decode_scanNumber, decode_scanObject, decode_scanString, decode_scanWhitespace, encodeString, isArray, isEncodable

	function json.encode(v)
		if v == nil then
			return "null"
		end

		local vtype = type(v)

		if vtype == "string" then
			return "\"" .. json_private.encodeString(v) .. "\""
		end

		if vtype == "number" or vtype == "boolean" then
			return tostring(v)
		end

		if vtype == "table" then
			local rval = {}
			local bArray, maxCount = isArray(v)

			if bArray then
				for i = 1, maxCount do
					table.insert(rval, json.encode(v[i]))
				end
			else
				for i, j in pairs(v) do
					if isEncodable(i) and isEncodable(j) then
						table.insert(rval, "\"" .. json_private.encodeString(i) .. "\":" .. json.encode(j))
					end
				end
			end

			if bArray then
				return "[" .. table.concat(rval, ",") .. "]"
			else
				return "{" .. table.concat(rval, ",") .. "}"
			end
		end

		if vtype == "function" and v == json.null then
			return "null"
		end

		assert(false, "encode attempt to encode unsupported type " .. vtype .. ":" .. tostring(v))
	end

	function json.decode(s, startPos)
		startPos = startPos and startPos or 1
		startPos = decode_scanWhitespace(s, startPos)

		assert(startPos <= string.len(s), "Unterminated JSON encoded object found at position in [" .. s .. "]")

		local curChar = string.sub(s, startPos, startPos)

		if curChar == "{" then
			return decode_scanObject(s, startPos)
		end

		if curChar == "[" then
			return decode_scanArray(s, startPos)
		end

		if string.find("+-0123456789.e", curChar, 1, true) then
			return decode_scanNumber(s, startPos)
		end

		if curChar == "\"" or curChar == "'" then
			return decode_scanString(s, startPos)
		end

		if string.sub(s, startPos, startPos + 1) == "/*" then
			return json.decode(s, decode_scanComment(s, startPos))
		end

		return decode_scanConstant(s, startPos)
	end

	function json.null()
		return json.null
	end

	function decode_scanArray(s, startPos)
		local array = {}
		local stringLen = string.len(s)

		assert(string.sub(s, startPos, startPos) == "[", "decode_scanArray called but array does not start at position " .. startPos .. " in string:\n" .. s)

		startPos = startPos + 1

		repeat
			startPos = decode_scanWhitespace(s, startPos)

			assert(startPos <= stringLen, "JSON String ended unexpectedly scanning array.")

			local curChar = string.sub(s, startPos, startPos)

			if curChar == "]" then
				return array, startPos + 1
			end

			if curChar == "," then
				startPos = decode_scanWhitespace(s, startPos + 1)
			end

			assert(startPos <= stringLen, "JSON String ended unexpectedly scanning array.")

			object, startPos = json.decode(s, startPos)

			table.insert(array, object)
		until false
	end

	function decode_scanComment(s, startPos)
		assert(string.sub(s, startPos, startPos + 1) == "/*", "decode_scanComment called but comment does not start at position " .. startPos)

		local endPos = string.find(s, "*/", startPos + 2)

		assert(endPos ~= nil, "Unterminated comment in string at " .. startPos)

		return endPos + 2
	end

	function decode_scanConstant(s, startPos)
		local consts = {
			["false"] = false,
			["true"] = true
		}
		local constNames = {
			"true",
			"false",
			"null"
		}

		for i, k in pairs(constNames) do
			if string.sub(s, startPos, startPos + string.len(k) - 1) == k then
				return consts[k], startPos + string.len(k)
			end
		end

		assert(nil, "Failed to scan constant from string " .. s .. " at starting position " .. startPos)
	end

	function decode_scanNumber(s, startPos)
		local endPos = startPos + 1
		local stringLen = string.len(s)
		local acceptableChars = "+-0123456789.e"

		while string.find(acceptableChars, string.sub(s, endPos, endPos), 1, true) and endPos <= stringLen do
			endPos = endPos + 1
		end

		local stringValue = "return " .. string.sub(s, startPos, endPos - 1)
		local stringEval = loadstring(stringValue)

		assert(stringEval, "Failed to scan number [ " .. stringValue .. "] in JSON string at position " .. startPos .. " : " .. endPos)

		return stringEval(), endPos
	end

	function decode_scanObject(s, startPos)
		local object = {}
		local stringLen = string.len(s)
		local key, value

		assert(string.sub(s, startPos, startPos) == "{", "decode_scanObject called but object does not start at position " .. startPos .. " in string:\n" .. s)

		startPos = startPos + 1

		repeat
			startPos = decode_scanWhitespace(s, startPos)

			assert(startPos <= stringLen, "JSON string ended unexpectedly while scanning object.")

			local curChar = string.sub(s, startPos, startPos)

			if curChar == "}" then
				return object, startPos + 1
			end

			if curChar == "," then
				startPos = decode_scanWhitespace(s, startPos + 1)
			end

			assert(startPos <= stringLen, "JSON string ended unexpectedly scanning object.")

			key, startPos = json.decode(s, startPos)

			assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)

			startPos = decode_scanWhitespace(s, startPos)

			assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)
			assert(string.sub(s, startPos, startPos) == ":", "JSON object key-value assignment mal-formed at " .. startPos)

			startPos = decode_scanWhitespace(s, startPos + 1)

			assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)

			value, startPos = json.decode(s, startPos)
			object[key] = value
		until false
	end

	local escapeSequences = {
		["\\n"] = "\n",
		["\\t"] = "\t",
		["\\f"] = "\f",
		["\\r"] = "\r",
		["\\b"] = "\b"
	}

	setmetatable(escapeSequences, {
		__index = function(t, k)
			return string.sub(k, 2)
		end
	})

	function decode_scanString(s, startPos)
		assert(startPos, "decode_scanString(..) called without start position")

		local startChar = string.sub(s, startPos, startPos)

		assert(startChar == "\"" or startChar == "'", "decode_scanString called for a non-string")

		local t = {}
		local i, j = startPos, startPos

		while string.find(s, startChar, j + 1) ~= j + 1 do
			local oldj = j

			i, j = string.find(s, "\\.", j + 1)

			local x, y = string.find(s, startChar, oldj + 1)

			if not i or x < i then
				i, j = x, y - 1
			end

			table.insert(t, string.sub(s, oldj + 1, i - 1))

			if string.sub(s, i, j) == "\\u" then
				local a = string.sub(s, j + 1, j + 4)

				j = j + 4

				local n = tonumber(a, 16)

				assert(n, "String decoding failed: bad Unicode escape " .. a .. " at position " .. i .. " : " .. j)

				local x

				if n < 128 then
					x = string.char(n % 128)
				elseif n < 2048 then
					x = string.char(192 + math.floor(n / 64) % 32, 128 + n % 64)
				else
					x = string.char(224 + math.floor(n / 4096) % 16, 128 + math.floor(n / 64) % 64, 128 + n % 64)
				end

				table.insert(t, x)
			else
				table.insert(t, escapeSequences[string.sub(s, i, j)])
			end
		end

		table.insert(t, string.sub(j, j + 1))
		assert(string.find(s, startChar, j + 1), "String decoding failed: missing closing " .. startChar .. " at position " .. j .. "(for string at position " .. startPos .. ")")

		return table.concat(t, ""), j + 2
	end

	function decode_scanWhitespace(s, startPos)
		local whitespace = " \n\r\t"
		local stringLen = string.len(s)

		while string.find(whitespace, string.sub(s, startPos, startPos), 1, true) and startPos <= stringLen do
			startPos = startPos + 1
		end

		return startPos
	end

	local escapeList = {
		["\f"] = "\\f",
		["\b"] = "\\b",
		["\n"] = "\\n",
		["\r"] = "\\r",
		["\t"] = "\\t",
		["\\"] = "\\\\",
		["/"] = "\\/",
		["\""] = "\\\""
	}

	function json_private.encodeString(s)
		local s = tostring(s)

		return s:gsub(".", function(c)
			return escapeList[c]
		end)
	end

	function isArray(t)
		if t == json.EMPTY_ARRAY then
			return true, 0
		end

		if t == json.EMPTY_OBJECT then
			return false
		end

		local maxIndex = 0

		for k, v in pairs(t) do
			if type(k) == "number" and math.floor(k) == k and k >= 1 then
				if not isEncodable(v) then
					return false
				end

				maxIndex = math.max(maxIndex, k)
			elseif k == "n" then
				if v ~= (t.n or #t) then
					return false
				end
			elseif isEncodable(v) then
				return false
			end
		end

		return true, maxIndex
	end

	function isEncodable(o)
		local t = type(o)

		return t == "string" or t == "boolean" or t == "number" or t == "nil" or t == "table" or t == "function" and o == json.null
	end

	return json
end

local debugger_print = print
local debug_server, breakInfoSocket
local json = createJson()
local LuaDebugger = {
	StepIn = false,
	StepInLevel = 0,
	printType = 1,
	StepNext = false,
	version = "1.0.4",
	isHook = true,
	isDebugPrint = true,
	StepNextLevel = 0,
	isProntToConsole = 1,
	runLineCount = 0,
	currentFileName = "",
	Run = true,
	DebugLuaFie = "",
	StepOut = false,
	hookType = "lrc",
	fileMaps = {},
	breakInfos = {},
	pathCachePaths = {},
	splitFilePaths = {}
}

LuaDebugger.event = {
	C2S_StepOutResponse = 13,
	S2C_StepOutRequest = 12,
	C2S_StepInResponse = 11,
	C2S_NextResponseOver = 9,
	S2C_ReqVar = 5,
	C2S_DebugXpCall = 20,
	C2S_LuaPrint = 14,
	S2C_SetBreakPoints = 1,
	C2S_NextResponse = 8,
	S2C_DebugClose = 21,
	C2S_ReqVar = 6,
	S2C_NextRequest = 7,
	C2S_LoadLuaScript = 18,
	C2S_SetBreakPoints = 2,
	S2C_LoadLuaScript = 16,
	S2C_StepInRequest = 10,
	C2S_HITBreakPoint = 4,
	S2C_RUN = 3,
	C2S_SetSocketName = 17
}

function print1(...)
	if LuaDebugger.printType == 1 or LuaDebugger.printType == 3 or LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 3 then
		debugger_print(...)
	end

	if (LuaDebugger.printType == 1 or LuaDebugger.printType == 2 or LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 2) and debug_server then
		local arg = {
			...
		}
		local str = ""

		if #arg == 0 then
			arg = {
				"nil"
			}
		end

		for k, v in pairs(arg) do
			str = str .. tostring(v) .. "\t"
		end

		local sendMsg = {
			event = LuaDebugger.event.C2S_LuaPrint,
			data = {
				type = 1,
				msg = ZZBase64.encode(str)
			}
		}
		local sendStr = json.encode(sendMsg)

		debug_server:send(sendStr .. "__debugger_k0204__")
	end
end

print = print1

function luaIdePrintWarn(...)
	if LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 3 then
		debugger_print(...)
	end

	if (LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 2) and debug_server then
		local arg = {
			...
		}
		local str = ""

		if #arg == 0 then
			arg = {
				"nil"
			}
		end

		for k, v in pairs(arg) do
			str = str .. tostring(v) .. "\t"
		end

		local sendMsg = {
			event = LuaDebugger.event.C2S_LuaPrint,
			data = {
				type = 2,
				msg = ZZBase64.encode(str)
			}
		}
		local sendStr = json.encode(sendMsg)

		debug_server:send(sendStr .. "__debugger_k0204__")
	end
end

function luaIdePrintErr(...)
	if LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 3 then
		debugger_print(...)
	end

	if (LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 2) and debug_server then
		local arg = {
			...
		}
		local str = ""

		if #arg == 0 then
			arg = {
				"nil"
			}
		end

		for k, v in pairs(arg) do
			str = str .. tostring(v) .. "\t"
		end

		local sendMsg = {
			event = LuaDebugger.event.C2S_LuaPrint,
			data = {
				type = 3,
				msg = ZZBase64.encode(str)
			}
		}
		local sendStr = json.encode(sendMsg)

		debug_server:send(sendStr .. "__debugger_k0204__")
	end
end

local debug_hook

local function debugger_strSplit(input, delimiter)
	input = tostring(input)
	delimiter = tostring(delimiter)

	if delimiter == "" then
		return false
	end

	local pos, arr = 0, {}

	for st, sp in function()
		return string.find(input, delimiter, pos, true)
	end do
		table.insert(arr, string.sub(input, pos, st - 1))

		pos = sp + 1
	end

	table.insert(arr, string.sub(input, pos))

	return arr
end

local function debugger_strTrim(input)
	input = string.gsub(input, "^[ \t\n\r]+", "")

	return string.gsub(input, "[ \t\n\r]+$", "")
end

local function debugger_dump(value, desciption, nesting)
	if type(nesting) ~= "number" then
		nesting = 3
	end

	local lookupTable = {}
	local result = {}

	local function _v(v)
		if type(v) == "string" then
			v = "\"" .. v .. "\""
		end

		return tostring(v)
	end

	local traceback = debugger_strSplit(debug.traceback("", 2), "\n")

	print1("dump from: " .. debugger_strTrim(traceback[3]))

	local function _dump(value, desciption, indent, nest, keylen)
		desciption = desciption or "<var>"
		spc = ""

		if type(keylen) == "number" then
			spc = string.rep(" ", keylen - string.len(_v(desciption)))
		end

		if type(value) ~= "table" then
			result[#result + 1] = string.format("%s%s%s = %s", indent, _v(desciption), spc, _v(value))
		elseif lookupTable[value] then
			result[#result + 1] = string.format("%s%s%s = *REF*", indent, desciption, spc)
		else
			lookupTable[value] = true

			if nest > nesting then
				result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, desciption)
			else
				result[#result + 1] = string.format("%s%s = {", indent, _v(desciption))

				local indent2 = indent .. "    "
				local keys = {}
				local keylen = 0
				local values = {}

				for k, v in pairs(value) do
					keys[#keys + 1] = k

					local vk = _v(k)
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
					_dump(values[k], k, indent2, nest + 1, keylen)
				end

				result[#result + 1] = string.format("%s}", indent)
			end
		end
	end

	_dump(value, desciption, "- ", 1)

	for i, line in ipairs(result) do
		print1(line)
	end
end

local function debugger_setVarInfo(name, value)
	local vt = type(value)
	local valueStr = ""

	if vt ~= "table" then
		valueStr = tostring(value)
		valueStr = ZZBase64.encode(valueStr)
	end

	local valueInfo = {
		name = name,
		valueType = vt,
		valueStr = valueStr
	}

	return valueInfo
end

local function debugger_getvalue(f)
	local i = 1
	local locals = {}

	while true do
		local name, value = debug.getlocal(f, i)

		if not name then
			break
		end

		if name ~= "(*temporary)" then
			locals[name] = value
		end

		i = i + 1
	end

	local func = getinfo(f, "f").func

	i = 1

	local ups = {}

	while func do
		local name, value = debug.getupvalue(func, i)

		if not name then
			break
		end

		ups[name] = value
		i = i + 1
	end

	return {
		locals = locals,
		ups = ups
	}
end

function debugger_stackInfo(ignoreCount, event)
	local datas = {}
	local stack = {}
	local varInfos = {}
	local funcs = {}
	local index = 0

	for i = ignoreCount, 100 do
		local source = getinfo(i)
		local isadd = true

		if i == ignoreCount then
			local file = source.source

			if file:find(LuaDebugger.DebugLuaFie) then
				return
			end

			if file == "=[C]" then
				isadd = false
			end
		end

		if not source then
			break
		end

		if isadd then
			local file = source.source

			if file:find("@") == 1 then
				file = file:sub(2)

				if not file:find("/") then
					file = file:gsub("%.", "/")
				end
			end

			local info = {
				src = file,
				scoreName = source.name,
				currentline = source.currentline,
				linedefined = source.linedefined,
				what = source.what,
				nameWhat = source.namewhat
			}

			index = i

			local vars = debugger_getvalue(i + 1)

			table.insert(stack, info)
			table.insert(varInfos, vars)
			table.insert(funcs, source.func)
		end

		if source.what == "main" then
			break
		end
	end

	local stackInfo = {
		stack = stack,
		vars = varInfos,
		funcs = funcs
	}
	local data

	if not jit then
		data = {
			stack = stackInfo.stack,
			vars = stackInfo.vars,
			funcs = stackInfo.funcs,
			event = event,
			funcsLength = #stackInfo.funcs
		}
		LuaDebugger.currentTempFunc = data.funcs[1]
	else
		data = {
			stack = stackInfo.stack,
			vars = stackInfo.vars,
			funcs = stackInfo.funcs,
			event = event
		}
	end

	return data
end

local debugger_setBreak

local function CloseDebug()
	print("clear debug", debug.traceback())
	debug.sethook()
	coroutine.yield()

	LuaDebugger.fileMaps = {}
	LuaDebugger.Run = true
	LuaDebugger.StepIn = false
	LuaDebugger.StepInLevel = 0
	LuaDebugger.StepNext = false
	LuaDebugger.StepNextLevel = 0
	LuaDebugger.StepOut = false
	LuaDebugger.breakInfos = {}
	LuaDebugger.runTimeType = nil
	LuaDebugger.isHook = true
	LuaDebugger.pathCachePaths = {}
	LuaDebugger.isProntToConsole = 1
	LuaDebugger.printType = 1
	LuaDebugger.isDebugPrint = true
	LuaDebugger.currentFileName = ""
	LuaDebugger.currentTempFunc = nil
	LuaDebugger.currentDebuggerData = nil
	LuaDebugger.splitFilePaths = {}
	LuaDebugger.DebugLuaFie = ""
	LuaDebugger.stepNextFun = nil
	LuaDebugger.runLineCount = 0

	removetimer(debugger_receiveDebugBreakInfo)
end

local function debugger_receiveDebugBreakInfo()
	if breakInfoSocket then
		local msg, status = breakInfoSocket:receive()

		if status == "closed" then
			CloseDebug()
		end

		if msg then
			local netData = json.decode(msg)

			if netData.event == LuaDebugger.event.S2C_SetBreakPoints then
				debugger_setBreak(netData.data)
			elseif netData.event == LuaDebugger.event.S2C_LoadLuaScript then
				debugger_exeLuaString(netData.data, false)
			elseif netData.event == LuaDebugger.event.S2C_DebugClose then
				CloseDebug()
			end
		end
	end
end

local function splitFilePath(path)
	if not jit and LuaDebugger.splitFilePaths[path] then
		return LuaDebugger.splitFilePaths[path]
	end

	local pos, arr = 0, {}

	for st, sp in function()
		return string.find(path, "/", pos, true)
	end do
		table.insert(arr, string.sub(path, pos, st - 1))

		pos = sp + 1
	end

	table.insert(arr, string.sub(path, pos))

	if not jit then
		LuaDebugger.splitFilePaths[path] = arr
	end

	return arr
end

function debugger_setBreak(datas)
	local breakInfos = LuaDebugger.breakInfos

	for i, data in ipairs(datas) do
		local breakInfo = breakInfos[data.fileName]

		if not breakInfo then
			breakInfos[data.fileName] = {}
			breakInfo = breakInfos[data.fileName]
		end

		if not data.lines or #data.lines == 0 then
			breakInfo[data.serverPath] = nil
		else
			local lineInfos = {}

			for li, line in ipairs(data.lines) do
				lineInfos[line] = true
			end

			breakInfo[data.serverPath] = {
				pathNames = splitFilePath(data.serverPath),
				lines = lineInfos,
				hitConditions = data.hitConditions,
				countConditions = data.countConditions
			}
		end

		local count = 0

		for i, linesInfo in pairs(breakInfo) do
			count = count + 1
		end

		if count == 0 then
			breakInfos[data.fileName] = nil
		end
	end

	local isHook = false

	for k, v in pairs(breakInfos) do
		isHook = true

		break
	end

	if isHook then
		if not LuaDebugger.isHook then
			debug.sethook(debug_hook, "lrc")
		end

		LuaDebugger.isHook = true
	else
		if LuaDebugger.isHook then
			debug.sethook()
		end

		LuaDebugger.isHook = false
	end
end

local function debugger_checkFileIsBreak(fileName)
	return LuaDebugger.breakInfos[fileName]
end

local function debugger_checkIsBreak(fileName, line)
	local breakInfo = LuaDebugger.breakInfos[fileName]

	if breakInfo then
		local ischeck = false

		for k, lineInfo in pairs(breakInfo) do
			local lines = lineInfo.lines

			if lines and lines[line] then
				ischeck = true

				break
			end
		end

		if not ischeck then
			return
		end

		local info = getinfo(3)
		local source = info.source

		source = source:gsub("\\", "/")

		if source:find("@") == 1 then
			source = source:sub(2)

			if not source:find("/") then
				source = source:gsub("%.", "/")
			end
		end

		local index = source:find("%.lua")

		if not index then
			source = source .. ".lua"
		end

		local hitPathNames = splitFilePath(source)
		local hitCounts = {}
		local flineInfo
		local hitCondition = false
		local hasCondition = false
		local hasCountCondition = false
		local hitCountCondition = false

		for k, lineInfo in pairs(breakInfo) do
			local lines = lineInfo.lines
			local pathNames = lineInfo.pathNames

			if lines and lines[line] then
				flineInfo = lineInfo

				if lineInfo.hitConditions and lineInfo.hitConditions[tostring(line)] then
					hasCondition = true

					local condition = lineInfo.hitConditions[tostring(line)]
					local stackInfo = debugger_stackInfo(4, nil)

					local function doCondition()
						local envs = {
							_G = _G
						}
						local vars = stackInfo.vars[1]
						local locals = vars.locals
						local ups = vars.ups

						for k, v in pairs(ups) do
							envs[k] = v
						end

						for k, v in pairs(locals) do
							envs[k] = v
						end

						setmetatable(envs, {
							__index = _G
						})

						local funStr = "return " .. condition
						local fun = loadstring(funStr)

						setfenv(fun, envs)

						return fun()
					end

					local status, msg = xpcall(doCondition, function(error)
						return
					end)

					hitCondition = status and msg
				end

				if hitCondition or not hasCondition then
					hitCounts[k] = 0

					local hitPathNamesCount = #hitPathNames
					local pathNamesCount = #pathNames

					repeat
						if pathNames[pathNamesCount] ~= hitPathNames[hitPathNamesCount] then
							break
						else
							hitCounts[k] = hitCounts[k] + 1
						end

						pathNamesCount = pathNamesCount - 1
						hitPathNamesCount = hitPathNamesCount - 1
					until pathNamesCount <= 0 or hitPathNamesCount <= 0
				end

				break
			end
		end

		local hitFieName = ""
		local maxCount = 0

		for k, v in pairs(hitCounts) do
			if maxCount < v then
				maxCount = v
				hitFieName = k
			end
		end

		if (#hitPathNames == 1 or #hitPathNames > 1 and maxCount > 1) and hitFieName ~= "" and flineInfo then
			if flineInfo.hitCount == nil then
				flineInfo.hitCount = {}
			end

			if flineInfo.hitCount[line] == nil then
				flineInfo.hitCount[line] = 0
			end

			local currentCount = flineInfo.hitCount[line]

			if flineInfo.countConditions and flineInfo.countConditions[tostring(line)] then
				hasCountCondition = true

				local targetCount = tonumber(flineInfo.countConditions[tostring(line)])

				hitCountCondition = currentCount == targetCount - 1
			end

			flineInfo.hitCount[line] = currentCount + 1

			if hitCondition or hitCountCondition or not hasCountCondition then
				return hitFieName
			end
		end
	end

	return false
end

local controller_host = "192.168.1.102"
local controller_port = 7003

local function debugger_sendMsg(serverSocket, eventName, data)
	local sendMsg = {
		event = eventName,
		data = data
	}
	local sendStr = json.encode(sendMsg)

	serverSocket:send(sendStr .. "__debugger_k0204__")
end

function debugger_exeLuaString(data, isBreakPoint)
	local function loadScript()
		local luastr = data.luastr

		if isBreakPoint then
			local currentTabble = {
				_G = _G
			}
			local frameId = data.frameId

			frameId = frameId + 1

			local func = LuaDebugger.currentDebuggerData.funcs[frameId]
			local vars = LuaDebugger.currentDebuggerData.vars[frameId]
			local locals = vars.locals
			local ups = vars.ups

			for k, v in pairs(ups) do
				currentTabble[k] = v
			end

			for k, v in pairs(locals) do
				currentTabble[k] = v
			end

			setmetatable(currentTabble, {
				__index = _G
			})

			local fun = loadstring(luastr)

			setfenv(fun, currentTabble)
			fun()
		else
			local fun = loadstring(luastr)

			fun()
		end
	end

	local status, msg = xpcall(loadScript, function(error)
		print(error)
	end)

	if status then
		debugger_sendMsg(debug_server, LuaDebugger.event.C2S_LoadLuaScript, {
			msg = "执行代码成功"
		})

		if isBreakPoint then
			debugger_sendMsg(debug_server, LuaDebugger.event.C2S_HITBreakPoint, LuaDebugger.currentDebuggerData)
		end
	else
		debugger_sendMsg(debug_server, LuaDebugger.event.C2S_LoadLuaScript, {
			msg = "加载代码失败"
		})
	end
end

local function getLuaFileName(str)
	local pos = 0
	local fileName = ""

	for st, sp in function()
		return string.find(str, "/", pos, true)
	end do
		pos = sp + 1
	end

	fileName = string.sub(str, pos)

	return fileName
end

local function getSource(source)
	if LuaDebugger.pathCachePaths[source] then
		return LuaDebugger.pathCachePaths[source]
	end

	local file = source

	file = file:gsub("\\", "/")

	if file:find("@") == 1 then
		file = file:sub(2)

		if not file:find("/") then
			file = file:gsub("%.", "/")
		end
	end

	local index = file:find("%.lua")

	if not index then
		file = file .. ".lua"
	end

	file = getLuaFileName(file)
	LuaDebugger.pathCachePaths[source] = file

	return file
end

local function debugger_GeVarInfoBytUserData(server, var, variablesReference, debugSpeedIndex)
	local fileds = LuaDebugTool.getUserDataInfo(var)
	local varInfos = {}

	if tolua then
		local luavars = tolua.getpeer(var)

		if luavars then
			for k, v in pairs(luavars) do
				local vinfo = debugger_setVarInfo(k, v)

				table.insert(varInfos, vinfo)
			end
		end
	end

	for i = 1, fileds.Count do
		local filed = fileds[i - 1]
		local valueInfo = {
			name = filed.name,
			valueType = filed.valueType,
			valueStr = ZZBase64.encode(filed.valueStr),
			isValue = filed.isValue
		}

		table.insert(varInfos, valueInfo)
	end

	debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
		isComplete = 1,
		variablesReference = variablesReference,
		debugSpeedIndex = debugSpeedIndex,
		vars = varInfos
	})
end

local function debugger_getBreakVar(body, server)
	local variablesReference = body.variablesReference
	local debugSpeedIndex = body.debugSpeedIndex
	local vinfos = {}

	local function exe()
		local frameId = body.frameId
		local type_ = body.type
		local keys = body.keys
		local vars

		if type_ == 1 then
			vars = LuaDebugger.currentDebuggerData.vars[frameId + 1]
			vars = vars.locals
		elseif type_ == 2 then
			vars = LuaDebugger.currentDebuggerData.vars[frameId + 1]
			vars = vars.ups
		elseif type_ == 3 then
			vars = _G
		end

		for i, v in ipairs(keys) do
			local start_m = string.sub(v, 1, 1)

			if start_m == "[" then
				local len = string.len(v)
				local end_m = string.sub(v, len, len)

				if end_m == "]" then
					v = string.sub(v, 2, len - 1)
				end

				vars = vars[v]
			else
				vars = vars[v]
			end

			if type(vars) == "userdata" and tolua ~= nil and LuaDebugTool == nil then
				vars = tolua.getpeer(vars)
			end

			if vars == nil then
				break
			end
		end

		local varType = type(vars)

		if varType == "userdata" then
			if LuaDebugTool then
				debugger_GeVarInfoBytUserData(server, vars, variablesReference, debugSpeedIndex)

				return
			elseif tolua == nil then
				debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
					isComplete = 1,
					variablesReference = variablesReference,
					debugSpeedIndex = debugSpeedIndex,
					vars = vinfos
				})

				return
			end
		end

		local count = 0

		if vars then
			for k, v in pairs(vars) do
				local vinfo = debugger_setVarInfo(k, v)

				table.insert(vinfos, vinfo)

				if #vinfos > 10 then
					debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
						isComplete = 0,
						variablesReference = variablesReference,
						debugSpeedIndex = debugSpeedIndex,
						vars = vinfos
					})

					vinfos = {}
				end
			end
		end

		debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
			isComplete = 1,
			variablesReference = variablesReference,
			debugSpeedIndex = debugSpeedIndex,
			vars = vinfos
		})
	end

	xpcall(exe, function(error)
		print("debugger_getBreakVar error: \n")
		print(error)
		print(debug.traceback("", 2))
		debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
			isComplete = 1,
			variablesReference = variablesReference,
			debugSpeedIndex = debugSpeedIndex,
			vars = {
				{
					isValue = false,
					name = "error",
					valueType = "string",
					valueStr = ZZBase64.encode("Can not get value.")
				}
			}
		})
	end)
end

local function ResetDebugInfo()
	LuaDebugger.Run = false
	LuaDebugger.StepIn = false
	LuaDebugger.StepNext = false
	LuaDebugger.StepOut = false

	if not jit then
		LuaDebugger.StepNextLevel = 0
	end
end

local function debugger_loop(server)
	server = debug_server

	local command
	local eval_env = {}
	local arg

	while true do
		local line, status = server:receive()

		if status == "closed" then
			CloseDebug()
		end

		if line then
			local netData = json.decode(line)
			local event = netData.event
			local body = netData.data

			if event == LuaDebugger.event.S2C_DebugClose then
				CloseDebug()
			elseif event == LuaDebugger.event.S2C_SetBreakPoints then
				local function setB()
					debugger_setBreak(body)
				end

				xpcall(setB, function(error)
					print(error)
				end)
			elseif event == LuaDebugger.event.S2C_RUN then
				LuaDebugger.runTimeType = body.runTimeType
				LuaDebugger.isProntToConsole = body.isProntToConsole
				LuaDebugger.printType = body.printType

				ResetDebugInfo()

				LuaDebugger.Run = true

				local data = coroutine.yield()

				LuaDebugger.currentDebuggerData = data

				debugger_sendMsg(server, data.event, {
					stack = data.stack
				})
			elseif event == LuaDebugger.event.S2C_ReqVar then
				debugger_getBreakVar(body, server)
			elseif event == LuaDebugger.event.S2C_NextRequest then
				ResetDebugInfo()

				LuaDebugger.StepNext = true

				if not jit then
					LuaDebugger.StepNextLevel = 0
				end

				local data = coroutine.yield()

				LuaDebugger.currentDebuggerData = data

				debugger_sendMsg(server, data.event, {
					stack = data.stack
				})
			elseif event == LuaDebugger.event.S2C_StepInRequest then
				ResetDebugInfo()

				LuaDebugger.StepIn = true

				local data = coroutine.yield()

				LuaDebugger.currentDebuggerData = data

				debugger_sendMsg(server, data.event, {
					stack = data.stack,
					eventType = data.eventType
				})
			elseif event == LuaDebugger.event.S2C_StepOutRequest then
				ResetDebugInfo()

				LuaDebugger.StepOut = true

				local data = coroutine.yield()

				LuaDebugger.currentDebuggerData = data

				debugger_sendMsg(server, data.event, {
					stack = data.stack,
					eventType = data.eventType
				})
			elseif event == LuaDebugger.event.S2C_LoadLuaScript then
				debugger_exeLuaString(body, true)
			end
		end
	end
end

coro_debugger = coroutine.create(debugger_loop)

function debug_hook(event, line)
	if not jit then
		if not LuaDebugger.isHook then
			return
		end

		if LuaDebugger.Run then
			if event == "line" then
				local isCheck = false

				for k, breakInfo in pairs(LuaDebugger.breakInfos) do
					for bk, linesInfo in pairs(breakInfo) do
						if linesInfo.lines[line] then
							isCheck = true

							break
						end
					end

					if isCheck then
						break
					end
				end

				if not isCheck then
					return
				end
			else
				LuaDebugger.currentFileName = nil
				LuaDebugger.currentTempFunc = nil

				return
			end
		end

		if LuaDebugger.StepOut then
			if event == "line" or event == "call" then
				return
			end

			local tempFun = getinfo(2, "f").func

			if LuaDebugger.currentDebuggerData.funcsLength == 1 then
				ResetDebugInfo()

				LuaDebugger.Run = true
			elseif LuaDebugger.currentDebuggerData.funcs[2] == tempFun then
				local data = debugger_stackInfo(3, LuaDebugger.event.C2S_StepInResponse)

				coroutine.resume(coro_debugger, data)
			end

			return
		end

		local file

		if event == "call" then
			if not LuaDebugger.Run then
				LuaDebugger.StepNextLevel = LuaDebugger.StepNextLevel + 1
			end

			local stepInfo = getinfo(2, "S")
			local source = stepInfo.source

			if source:find(LuaDebugger.DebugLuaFie) or source == "=[C]" then
				return
			end

			file = getSource(source)
			LuaDebugger.currentFileName = file
		elseif event == "return" or event == "tail return" then
			if not LuaDebugger.Run then
				LuaDebugger.StepNextLevel = LuaDebugger.StepNextLevel - 1
			end

			LuaDebugger.currentFileName = nil
		elseif event == "line" then
			if LuaDebugger.StepIn then
				local data = debugger_stackInfo(3, LuaDebugger.event.C2S_NextResponse)

				if data then
					LuaDebugger.currentTempFunc = data.funcs[1]

					coroutine.resume(coro_debugger, data)

					return
				end
			end

			if LuaDebugger.StepNext and LuaDebugger.StepNextLevel <= 0 then
				local data = debugger_stackInfo(3, LuaDebugger.event.C2S_NextResponse)

				if data then
					LuaDebugger.currentTempFunc = data.funcs[1]

					coroutine.resume(coro_debugger, data)

					return
				end
			end

			local stepInfo

			if not LuaDebugger.currentFileName then
				stepInfo = getinfo(2, "S")

				local source = stepInfo.source

				if source == "=[C]" or source:find(LuaDebugger.DebugLuaFie) then
					return
				end

				file = getSource(source)
				LuaDebugger.currentFileName = file
			end

			file = LuaDebugger.currentFileName

			local breakInfo = LuaDebugger.breakInfos[file]

			if breakInfo then
				local ischeck = false

				for k, lineInfo in pairs(breakInfo) do
					local lines = lineInfo.lines

					if lines and lines[line] then
						ischeck = true

						break
					end
				end

				if not ischeck then
					return
				end

				local info = stepInfo

				info = info or getinfo(2)

				local hitPathNames = splitFilePath(file)
				local hitCounts = {}
				local flineInfo
				local hitCondition = false
				local hasCondition = false
				local hasCountCondition = false
				local hitCountCondition = false

				for k, lineInfo in pairs(breakInfo) do
					local lines = lineInfo.lines
					local pathNames = lineInfo.pathNames

					if lines and lines[line] then
						flineInfo = lineInfo

						if lineInfo.hitConditions and lineInfo.hitConditions[tostring(line)] then
							hasCondition = true

							local condition = lineInfo.hitConditions[tostring(line)]
							local stackInfo = debugger_stackInfo(3, nil)

							local function doCondition()
								local envs = {
									_G = _G
								}
								local vars = stackInfo.vars[1]
								local locals = vars.locals
								local ups = vars.ups

								for k, v in pairs(ups) do
									envs[k] = v
								end

								for k, v in pairs(locals) do
									envs[k] = v
								end

								setmetatable(envs, {
									__index = _G
								})

								local funStr = "return " .. condition
								local fun = loadstring(funStr)

								setfenv(fun, envs)

								return fun()
							end

							local status, msg = xpcall(doCondition, function(error)
								return
							end)

							hitCondition = status and msg
						end

						if hitCondition or not hasCondition then
							hitCounts[k] = 0

							local hitPathNamesCount = #hitPathNames
							local pathNamesCount = #pathNames

							repeat
								if pathNames[pathNamesCount] ~= hitPathNames[hitPathNamesCount] then
									break
								else
									hitCounts[k] = hitCounts[k] + 1
								end

								pathNamesCount = pathNamesCount - 1
								hitPathNamesCount = hitPathNamesCount - 1
							until pathNamesCount <= 0 or hitPathNamesCount <= 0
						end

						break
					end
				end

				local hitFieName = ""
				local maxCount = 0

				for k, v in pairs(hitCounts) do
					if maxCount < v then
						maxCount = v
						hitFieName = k
					end
				end

				local hitPathNamesLength = #hitPathNames

				if (hitPathNamesLength == 1 or hitPathNamesLength > 1 and maxCount > 1) and hitFieName ~= "" and flineInfo then
					if flineInfo.hitCount == nil then
						flineInfo.hitCount = {}
					end

					if flineInfo.hitCount[line] == nil then
						flineInfo.hitCount[line] = 0
					end

					local currentCount = flineInfo.hitCount[line]

					if flineInfo.countConditions and flineInfo.countConditions[tostring(line)] then
						hasCountCondition = true

						local targetCount = tonumber(flineInfo.countConditions[tostring(line)])

						hitCountCondition = currentCount == targetCount - 1
					end

					flineInfo.hitCount[line] = currentCount + 1

					if hitCondition or hitCountCondition or not hasCountCondition then
						local data = debugger_stackInfo(3, LuaDebugger.event.C2S_HITBreakPoint)

						coroutine.resume(coro_debugger, data)
					end
				end
			end
		end
	else
		local file

		if event == "line" then
			local funs
			local funlength = 0

			if LuaDebugger.currentDebuggerData then
				funs = LuaDebugger.currentDebuggerData.funcs
				funlength = #funs
			end

			local stepInfo = getinfo(2)
			local tempFunc = stepInfo.func
			local source = stepInfo.source

			file = getSource(source)

			if source == "=[C]" or source:find(LuaDebugger.DebugLuaFie) then
				return
			end

			if funlength > 0 and funs[1] == tempFunc and LuaDebugger.currentLine ~= line then
				LuaDebugger.runLineCount = LuaDebugger.runLineCount + 1
			end

			if LuaDebugger.StepOut then
				if funlength == 1 then
					ResetDebugInfo()

					LuaDebugger.Run = true

					return
				elseif funs[2] == tempFunc then
					local data = debugger_stackInfo(3, LuaDebugger.event.C2S_StepInResponse)

					coroutine.resume(coro_debugger, data)

					return
				end
			end

			if LuaDebugger.StepIn then
				if funs[1] == tempFunc and LuaDebugger.runLineCount == 0 then
					return
				end

				local data = debugger_stackInfo(3, LuaDebugger.event.C2S_StepInResponse)

				coroutine.resume(coro_debugger, data)

				return
			end

			if LuaDebugger.StepNext then
				if LuaDebugger.currentLine == line then
					return
				end

				if funs and funs[1] ~= tempFunc then
					if funlength > 1 then
						if funs[2] == tempFunc then
							-- block empty
						else
							return
						end
					else
						return
					end
				end

				local data = debugger_stackInfo(3, LuaDebugger.event.C2S_NextResponse)

				LuaDebugger.runLineCount = 0
				LuaDebugger.currentLine = line

				coroutine.resume(coro_debugger, data)

				return
			end

			local isHit = false
			local sevent

			if isHit == false and debugger_checkIsBreak(file, line) then
				if funs and funs[1] == tempFunc and LuaDebugger.runLineCount == 0 then
					LuaDebugger.runLineCount = 0

					return
				end

				LuaDebugger.runLineCount = 0
				LuaDebugger.currentLine = line
				isHit = true
				sevent = LuaDebugger.event.C2S_HITBreakPoint

				local data = debugger_stackInfo(3, sevent)

				coroutine.resume(coro_debugger, data)
			end
		end
	end
end

local function debugger_xpcall()
	local data = debugger_stackInfo(4, LuaDebugger.event.C2S_HITBreakPoint)

	coroutine.resume(coro_debugger, data)
end

local function start()
	local socket = createSocket()
	local server = socket.connect(controller_host, controller_port)

	debug_server = server

	if server then
		socket = createSocket()
		breakInfoSocket = socket.connect(controller_host, controller_port)

		if breakInfoSocket then
			breakInfoSocket:settimeout(0)
			debugger_sendMsg(breakInfoSocket, LuaDebugger.event.C2S_SetSocketName, {
				name = "breakPointSocket"
			})
			debugger_sendMsg(server, LuaDebugger.event.C2S_SetSocketName, {
				name = "mainSocket",
				version = LuaDebugger.version
			})
			xpcall(function()
				debug.sethook(debug_hook, "lrc")
			end, function(error)
				print("error:", error)
			end)
		end

		coroutine.resume(coro_debugger, server)
	end
end

function StartDebug(host, port)
	LuaDebugger.DebugLuaFie = getLuaFileName(getinfo(1).source)

	if jit then
		local index = LuaDebugger.DebugLuaFie:find("%.lua")

		if index then
			local fileNameLength = string.len(LuaDebugger.DebugLuaFie)

			LuaDebugger.DebugLuaFie = LuaDebugger.DebugLuaFie:sub(1, fileNameLength - 4)
		end
	end

	if not port then
		local token = getinfo(1).source

		if token then
			token = token:gsub("@", "")
			token = token:gsub("\\", "")
			token = token:gsub("/", "")
			token = token:gsub(":", "")
			token = token:gsub("LuaDebug.lua", "")
			token = token:lower()
			port = 0

			for i = 1, #token do
				port = port + string.byte(token:sub(i, i))
			end

			port = port % 10000 + 50000
		end
	end

	if not host then
		print("debug host can not be nil")
	end

	if not port then
		print("debug port can not be nil")
	end

	if type(host) ~= "string" then
		print("debug host arg must be string")
	end

	if type(port) ~= "number" then
		print("debug port arg must be number")
	end

	controller_host = host
	controller_port = port

	xpcall(start, function(error)
		print(error)
	end)

	return debugger_receiveDebugBreakInfo, debugger_xpcall
end

function StartDebugWithTimer(host, port)
	LuaDebugger.Run = false
	LuaDebugger.isHook = false
	LuaDebugger.currentDebuggerData = nil

	ResetDebugInfo()

	local updateDebugger = StartDebug(host, port)

	settimer(0, updateDebugger)
end

local string = string

ZZBase64.__code = {
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"+",
	"/"
}
ZZBase64.__decode = {}

for k, v in pairs(ZZBase64.__code) do
	ZZBase64.__decode[string.byte(v, 1)] = k - 1
end

function ZZBase64.encode(text)
	local len = string.len(text)
	local left = len % 3

	len = len - left

	local res = {}
	local index = 1

	for i = 1, len, 3 do
		local a = string.byte(text, i)
		local b = string.byte(text, i + 1)
		local c = string.byte(text, i + 2)
		local num = a * 65536 + b * 256 + c

		for j = 1, 4 do
			local tmp = math.floor(num / 2^((4 - j) * 6))
			local curPos = tmp % 64 + 1

			res[index] = ZZBase64.__code[curPos]
			index = index + 1
		end
	end

	if left == 1 then
		ZZBase64.__left1(res, index, text, len)
	elseif left == 2 then
		ZZBase64.__left2(res, index, text, len)
	end

	return table.concat(res)
end

function ZZBase64.__left2(res, index, text, len)
	local num1 = string.byte(text, len + 1)

	num1 = num1 * 1024

	local num2 = string.byte(text, len + 2)

	num2 = num2 * 4

	local num = num1 + num2
	local tmp1 = math.floor(num / 4096)
	local curPos = tmp1 % 64 + 1

	res[index] = ZZBase64.__code[curPos]

	local tmp2 = math.floor(num / 64)

	curPos = tmp2 % 64 + 1
	res[index + 1] = ZZBase64.__code[curPos]
	curPos = num % 64 + 1
	res[index + 2] = ZZBase64.__code[curPos]
	res[index + 3] = "="
end

function ZZBase64.__left1(res, index, text, len)
	local num = string.byte(text, len + 1)

	num = num * 16

	local tmp = math.floor(num / 64)
	local curPos = tmp % 64 + 1

	res[index] = ZZBase64.__code[curPos]
	curPos = num % 64 + 1
	res[index + 1] = ZZBase64.__code[curPos]
	res[index + 2] = "="
	res[index + 3] = "="
end

function ZZBase64.decode(text)
	local len = string.len(text)
	local left = 0

	if string.sub(text, len - 1) == "==" then
		left = 2
		len = len - 4
	elseif string.sub(text, len) == "=" then
		left = 1
		len = len - 4
	end

	local res = {}
	local index = 1
	local decode = ZZBase64.__decode

	for i = 1, len, 4 do
		local a = decode[string.byte(text, i)]
		local b = decode[string.byte(text, i + 1)]
		local c = decode[string.byte(text, i + 2)]
		local d = decode[string.byte(text, i + 3)]
		local num = a * 262144 + b * 4096 + c * 64 + d
		local e = string.char(num % 256)

		num = math.floor(num / 256)

		local f = string.char(num % 256)

		num = math.floor(num / 256)
		res[index] = string.char(num % 256)
		res[index + 1] = f
		res[index + 2] = e
		index = index + 3
	end

	if left == 1 then
		ZZBase64.__decodeLeft1(res, index, text, len)
	elseif left == 2 then
		ZZBase64.__decodeLeft2(res, index, text, len)
	end

	return table.concat(res)
end

function ZZBase64.__decodeLeft1(res, index, text, len)
	local decode = ZZBase64.__decode
	local a = decode[string.byte(text, len + 1)]
	local b = decode[string.byte(text, len + 2)]
	local c = decode[string.byte(text, len + 3)]
	local num = a * 4096 + b * 64 + c
	local num1 = math.floor(num / 1024) % 256
	local num2 = math.floor(num / 4) % 256

	res[index] = string.char(num1)
	res[index + 1] = string.char(num2)
end

function ZZBase64.__decodeLeft2(res, index, text, len)
	local decode = ZZBase64.__decode
	local a = decode[string.byte(text, len + 1)]
	local b = decode[string.byte(text, len + 2)]
	local num = a * 64 + b

	num = math.floor(num / 16)
	res[index] = string.char(num)
end
