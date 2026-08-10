local var_0_0 = {
	m_bComparedMemoryRefFileAddTime = true,
	m_bSingleMemoryRefFileAddTime = true,
	m_bAllMemoryRefFileAddTime = true
}

local function var_0_1()
	local var_1_0 = os.date("*t")

	return (string.format("%04d%02d%02d-%02d%02d%02d", tostring(var_1_0.year), tostring(var_1_0.month), tostring(var_1_0.day), tostring(var_1_0.hour), tostring(var_1_0.min), tostring(var_1_0.sec)))
end

local function var_0_2(arg_2_0)
	if not arg_2_0 then
		return ""
	end

	local var_2_0 = getmetatable(arg_2_0)

	if not var_2_0 then
		return tostring(arg_2_0)
	end

	local var_2_1 = ""
	local var_2_2 = rawget(var_2_0, "__tostring")

	if var_2_2 then
		rawset(var_2_0, "__tostring", nil)

		var_2_1 = tostring(arg_2_0)

		rawset(var_2_0, "__tostring", var_2_2)
	else
		var_2_1 = tostring(arg_2_0)
	end

	return var_2_1
end

local function var_0_3()
	local var_3_0 = {}
	local var_3_1 = {}

	setmetatable(var_3_1, {
		__mode = "k"
	})

	local var_3_2 = {}

	setmetatable(var_3_2, {
		__mode = "k"
	})

	var_3_0.m_cObjectReferenceCount = var_3_1
	var_3_0.m_cObjectAddressToName = var_3_2
	var_3_0.m_nStackLevel = -1
	var_3_0.m_strShortSrc = "None"
	var_3_0.m_nCurrentLine = -1

	return var_3_0
end

local function var_0_4(arg_4_0)
	local var_4_0 = var_0_3()

	var_4_0.m_strShortSrc = arg_4_0

	local var_4_1 = var_4_0.m_cObjectReferenceCount
	local var_4_2 = var_4_0.m_cObjectAddressToName
	local var_4_3 = assert(io.open(arg_4_0, "rb"))

	for iter_4_0 in var_4_3:lines() do
		if string.sub(iter_4_0, 1, 2) ~= "--" then
			local var_4_4, var_4_5, var_4_6, var_4_7, var_4_8 = string.find(iter_4_0, "(.+)\t(.*)\t(%d+)")

			if var_4_6 then
				var_4_1[var_4_6] = var_4_8
				var_4_2[var_4_6] = var_4_7
			end
		end
	end

	io.close(var_4_3)

	local var_4_9

	return var_4_0
end

local function var_0_5(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = {}

	setmetatable(var_5_1, {
		__mode = "k"
	})

	local var_5_2 = {}
	local var_5_3 = {}

	setmetatable(var_5_3, {
		__mode = "k"
	})

	var_5_0.m_cObjectExistTag = var_5_1
	var_5_0.m_cObjectAliasName = var_5_2
	var_5_0.m_cObjectAccessTag = var_5_3
	var_5_0.m_nStackLevel = -1
	var_5_0.m_strShortSrc = "None"
	var_5_0.m_nCurrentLine = -1
	var_5_0.m_strObjectName = arg_5_0
	var_5_0.m_strAddressName = type(arg_5_1) == "string" and "\"" .. tostring(arg_5_1) .. "\"" or var_0_2(arg_5_1)
	var_5_0.m_cObjectExistTag[arg_5_1] = true

	return var_5_0
end

local function var_0_6(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	arg_6_0 = arg_6_0 or ""
	arg_6_2 = arg_6_2 or var_0_3()

	if arg_6_2.m_nStackLevel > 0 then
		local var_6_0 = debug.getinfo(arg_6_2.m_nStackLevel, "Sl")

		if var_6_0 then
			arg_6_2.m_strShortSrc = var_6_0.short_src
			arg_6_2.m_nCurrentLine = var_6_0.currentline
		end

		arg_6_2.m_nStackLevel = -1
	end

	local var_6_1 = arg_6_2.m_cObjectReferenceCount
	local var_6_2 = arg_6_2.m_cObjectAddressToName
	local var_6_3 = type(arg_6_1)

	if var_6_3 == "table" then
		if rawget(arg_6_1, "__cname") then
			if type(arg_6_1.__cname) == "string" then
				arg_6_0 = arg_6_0 .. "[class:" .. arg_6_1.__cname .. "]"
			end
		elseif rawget(arg_6_1, "class") then
			if type(arg_6_1.class) == "string" then
				arg_6_0 = arg_6_0 .. "[class:" .. arg_6_1.class .. "]"
			end
		elseif rawget(arg_6_1, "_className") and type(arg_6_1._className) == "string" then
			arg_6_0 = arg_6_0 .. "[class:" .. arg_6_1._className .. "]"
		end

		if arg_6_1 == _G then
			arg_6_0 = arg_6_0 .. "[_G]"
		end

		local var_6_4 = false
		local var_6_5 = false
		local var_6_6 = getmetatable(arg_6_1)

		if var_6_6 then
			local var_6_7 = rawget(var_6_6, "__mode")

			if var_6_7 then
				if string.find(var_6_7, "k") then
					var_6_4 = true
				end

				if string.find(var_6_7, "v") then
					var_6_5 = true
				end
			end
		end

		var_6_1[arg_6_1] = var_6_1[arg_6_1] and var_6_1[arg_6_1] + 1 or 1

		if var_6_2[arg_6_1] then
			return
		end

		var_6_2[arg_6_1] = arg_6_0

		for iter_6_0, iter_6_1 in pairs(arg_6_1) do
			local var_6_8 = type(iter_6_0)

			if var_6_8 == "table" then
				if not var_6_4 then
					var_0_6(arg_6_0 .. ".[table:key.table]", iter_6_0, arg_6_2)
				end

				if not var_6_5 then
					var_0_6(arg_6_0 .. ".[table:value]", iter_6_1, arg_6_2)
				end
			elseif var_6_8 == "function" then
				if not var_6_4 then
					var_0_6(arg_6_0 .. ".[table:key.function]", iter_6_0, arg_6_2)
				end

				if not var_6_5 then
					var_0_6(arg_6_0 .. ".[table:value]", iter_6_1, arg_6_2)
				end
			elseif var_6_8 == "thread" then
				if not var_6_4 then
					var_0_6(arg_6_0 .. ".[table:key.thread]", iter_6_0, arg_6_2)
				end

				if not var_6_5 then
					var_0_6(arg_6_0 .. ".[table:value]", iter_6_1, arg_6_2)
				end
			elseif var_6_8 == "userdata" then
				if not var_6_4 then
					var_0_6(arg_6_0 .. ".[table:key.userdata]", iter_6_0, arg_6_2)
				end

				if not var_6_5 then
					var_0_6(arg_6_0 .. ".[table:value]", iter_6_1, arg_6_2)
				end
			else
				var_0_6(arg_6_0 .. "." .. tostring(iter_6_0), iter_6_1, arg_6_2)
			end
		end

		if var_6_6 then
			var_0_6(arg_6_0 .. ".[metatable]", var_6_6, arg_6_2)
		end
	elseif var_6_3 == "function" then
		local var_6_9 = debug.getinfo(arg_6_1, "Su")

		var_6_1[arg_6_1] = var_6_1[arg_6_1] and var_6_1[arg_6_1] + 1 or 1

		if var_6_2[arg_6_1] then
			return
		end

		var_6_2[arg_6_1] = arg_6_0 .. "[line:" .. tostring(var_6_9.linedefined) .. "@file:" .. var_6_9.short_src .. "]"

		local var_6_10 = var_6_9.nups

		for iter_6_2 = 1, var_6_10 do
			local var_6_11, var_6_12 = debug.getupvalue(arg_6_1, iter_6_2)
			local var_6_13 = type(var_6_12)

			if var_6_13 == "table" then
				var_0_6(arg_6_0 .. ".[ups:table:" .. var_6_11 .. "]", var_6_12, arg_6_2)
			elseif var_6_13 == "function" then
				var_0_6(arg_6_0 .. ".[ups:function:" .. var_6_11 .. "]", var_6_12, arg_6_2)
			elseif var_6_13 == "thread" then
				var_0_6(arg_6_0 .. ".[ups:thread:" .. var_6_11 .. "]", var_6_12, arg_6_2)
			elseif var_6_13 == "userdata" then
				var_0_6(arg_6_0 .. ".[ups:userdata:" .. var_6_11 .. "]", var_6_12, arg_6_2)
			end
		end

		local var_6_14 = debug.getfenv

		if var_6_14 then
			local var_6_15 = var_6_14(arg_6_1)

			if var_6_15 then
				var_0_6(arg_6_0 .. ".[function:environment]", var_6_15, arg_6_2)
			end
		end
	elseif var_6_3 == "thread" then
		var_6_1[arg_6_1] = var_6_1[arg_6_1] and var_6_1[arg_6_1] + 1 or 1

		if var_6_2[arg_6_1] then
			return
		end

		var_6_2[arg_6_1] = arg_6_0

		local var_6_16 = debug.getfenv

		if var_6_16 then
			local var_6_17 = var_6_16(arg_6_1)

			if var_6_17 then
				var_0_6(arg_6_0 .. ".[thread:environment]", var_6_17, arg_6_2)
			end
		end

		local var_6_18 = getmetatable(arg_6_1)

		if var_6_18 then
			var_0_6(arg_6_0 .. ".[thread:metatable]", var_6_18, arg_6_2)
		end
	elseif var_6_3 == "userdata" then
		var_6_1[arg_6_1] = var_6_1[arg_6_1] and var_6_1[arg_6_1] + 1 or 1

		if var_6_2[arg_6_1] then
			return
		end

		var_6_2[arg_6_1] = arg_6_0

		local var_6_19 = debug.getfenv

		if var_6_19 then
			local var_6_20 = var_6_19(arg_6_1)

			if var_6_20 then
				var_0_6(arg_6_0 .. ".[userdata:environment]", var_6_20, arg_6_2)
			end
		end

		local var_6_21 = getmetatable(arg_6_1)

		if var_6_21 then
			var_0_6(arg_6_0 .. ".[userdata:metatable]", var_6_21, arg_6_2)
		end
	elseif var_6_3 == "string" then
		var_6_1[arg_6_1] = var_6_1[arg_6_1] and var_6_1[arg_6_1] + 1 or 1

		if var_6_2[arg_6_1] then
			return
		end

		var_6_2[arg_6_1] = arg_6_0 .. "[" .. var_6_3 .. "]"
	end
end

local function var_0_7(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 then
		return
	end

	arg_7_0 = arg_7_0 or ""
	arg_7_2 = arg_7_2 or var_0_3()

	if arg_7_2.m_nStackLevel > 0 then
		local var_7_0 = debug.getinfo(arg_7_2.m_nStackLevel, "Sl")

		if var_7_0 then
			arg_7_2.m_strShortSrc = var_7_0.short_src
			arg_7_2.m_nCurrentLine = var_7_0.currentline
		end

		arg_7_2.m_nStackLevel = -1
	end

	local var_7_1 = arg_7_2.m_cObjectExistTag
	local var_7_2 = arg_7_2.m_cObjectAliasName
	local var_7_3 = arg_7_2.m_cObjectAccessTag
	local var_7_4 = type(arg_7_1)

	if var_7_4 == "table" then
		if rawget(arg_7_1, "__cname") then
			if type(arg_7_1.__cname) == "string" then
				arg_7_0 = arg_7_0 .. "[class:" .. arg_7_1.__cname .. "]"
			end
		elseif rawget(arg_7_1, "class") then
			if type(arg_7_1.class) == "string" then
				arg_7_0 = arg_7_0 .. "[class:" .. arg_7_1.class .. "]"
			end
		elseif rawget(arg_7_1, "_className") and type(arg_7_1._className) == "string" then
			arg_7_0 = arg_7_0 .. "[class:" .. arg_7_1._className .. "]"
		end

		if arg_7_1 == _G then
			arg_7_0 = arg_7_0 .. "[_G]"
		end

		local var_7_5 = false
		local var_7_6 = false
		local var_7_7 = getmetatable(arg_7_1)

		if var_7_7 then
			local var_7_8 = rawget(var_7_7, "__mode")

			if var_7_8 then
				if var_7_8 == "k" then
					var_7_5 = true
				elseif var_7_8 == "v" then
					var_7_6 = true
				elseif var_7_8 == "kv" then
					var_7_5 = true
					var_7_6 = true
				end
			end
		end

		if var_7_1[arg_7_1] and not var_7_2[arg_7_0] then
			var_7_2[arg_7_0] = true
		end

		if var_7_3[arg_7_1] then
			return
		end

		var_7_3[arg_7_1] = true

		for iter_7_0, iter_7_1 in pairs(arg_7_1) do
			local var_7_9 = type(iter_7_0)

			if var_7_9 == "table" then
				if not var_7_5 then
					var_0_7(arg_7_0 .. ".[table:key.table]", iter_7_0, arg_7_2)
				end

				if not var_7_6 then
					var_0_7(arg_7_0 .. ".[table:value]", iter_7_1, arg_7_2)
				end
			elseif var_7_9 == "function" then
				local var_7_10 = debug.getinfo(iter_7_0, "Su")
				local var_7_11 = "{line:" .. tostring(var_7_10.linedefined) .. "@file:" .. var_7_10.short_src .. "}"

				if not var_7_5 then
					var_0_7(arg_7_0 .. ".[table:key.function" .. var_7_11 .. "]", iter_7_0, arg_7_2)
				end

				if not var_7_6 then
					var_0_7(arg_7_0 .. ".[table:value]", iter_7_1, arg_7_2)
				end
			elseif var_7_9 == "thread" then
				if not var_7_5 then
					var_0_7(arg_7_0 .. ".[table:key.thread]", iter_7_0, arg_7_2)
				end

				if not var_7_6 then
					var_0_7(arg_7_0 .. ".[table:value]", iter_7_1, arg_7_2)
				end
			elseif var_7_9 == "userdata" then
				if not var_7_5 then
					var_0_7(arg_7_0 .. ".[table:key.userdata]", iter_7_0, arg_7_2)
				end

				if not var_7_6 then
					var_0_7(arg_7_0 .. ".[table:value]", iter_7_1, arg_7_2)
				end
			else
				var_0_7(arg_7_0 .. "." .. tostring(iter_7_0), iter_7_1, arg_7_2)
			end
		end

		if var_7_7 then
			var_0_7(arg_7_0 .. ".[metatable]", var_7_7, arg_7_2)
		end
	elseif var_7_4 == "function" then
		local var_7_12 = debug.getinfo(arg_7_1, "Su")
		local var_7_13 = arg_7_0 .. "[line:" .. tostring(var_7_12.linedefined) .. "@file:" .. var_7_12.short_src .. "]"

		if var_7_1[arg_7_1] and not var_7_2[var_7_13] then
			var_7_2[var_7_13] = true
		end

		if var_7_3[arg_7_1] then
			return
		end

		var_7_3[arg_7_1] = true

		local var_7_14 = var_7_12.nups

		for iter_7_2 = 1, var_7_14 do
			local var_7_15, var_7_16 = debug.getupvalue(arg_7_1, iter_7_2)
			local var_7_17 = type(var_7_16)

			if var_7_17 == "table" then
				local var_7_18 = var_0_2(var_7_16)

				var_0_7(arg_7_0 .. ".[ups:" .. var_7_18 .. ":" .. var_7_15 .. "]", var_7_16, arg_7_2)
			elseif var_7_17 == "function" then
				local var_7_19 = debug.getinfo(var_7_16, "Su")
				local var_7_20 = "{line:" .. tostring(var_7_19.linedefined) .. "@file:" .. var_7_19.short_src .. "}"

				var_0_7(arg_7_0 .. ".[ups:function:" .. var_7_15 .. var_7_20 .. "]", var_7_16, arg_7_2)
			elseif var_7_17 == "thread" then
				var_0_7(arg_7_0 .. ".[ups:thread:" .. var_7_15 .. "]", var_7_16, arg_7_2)
			elseif var_7_17 == "userdata" then
				var_0_7(arg_7_0 .. ".[ups:userdata:" .. var_7_15 .. "]", var_7_16, arg_7_2)
			end
		end

		local var_7_21 = debug.getfenv

		if var_7_21 then
			local var_7_22 = var_7_21(arg_7_1)

			if var_7_22 then
				var_0_7(arg_7_0 .. ".[function:environment]", var_7_22, arg_7_2)
			end
		end
	elseif var_7_4 == "thread" then
		if var_7_1[arg_7_1] and not var_7_2[arg_7_0] then
			var_7_2[arg_7_0] = true
		end

		if var_7_3[arg_7_1] then
			return
		end

		var_7_3[arg_7_1] = true

		local var_7_23 = debug.getfenv

		if var_7_23 then
			local var_7_24 = var_7_23(arg_7_1)

			if var_7_24 then
				var_0_7(arg_7_0 .. ".[thread:environment]", var_7_24, arg_7_2)
			end
		end

		local var_7_25 = getmetatable(arg_7_1)

		if var_7_25 then
			var_0_7(arg_7_0 .. ".[thread:metatable]", var_7_25, arg_7_2)
		end
	elseif var_7_4 == "userdata" then
		if var_7_1[arg_7_1] and not var_7_2[arg_7_0] then
			var_7_2[arg_7_0] = true
		end

		if var_7_3[arg_7_1] then
			return
		end

		var_7_3[arg_7_1] = true

		local var_7_26 = debug.getfenv

		if var_7_26 then
			local var_7_27 = var_7_26(arg_7_1)

			if var_7_27 then
				var_0_7(arg_7_0 .. ".[userdata:environment]", var_7_27, arg_7_2)
			end
		end

		local var_7_28 = getmetatable(arg_7_1)

		if var_7_28 then
			var_0_7(arg_7_0 .. ".[userdata:metatable]", var_7_28, arg_7_2)
		end
	elseif var_7_4 == "string" then
		if var_7_1[arg_7_1] and not var_7_2[arg_7_0] then
			var_7_2[arg_7_0] = true
		end

		if var_7_3[arg_7_1] then
			return
		end

		var_7_3[arg_7_1] = true
	end
end

local function var_0_8(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	if not arg_8_6 then
		return
	end

	local var_8_0 = var_0_1()
	local var_8_1 = arg_8_5 and arg_8_5.m_cObjectReferenceCount or nil

	if not arg_8_5 or not arg_8_5.m_cObjectAddressToName then
		local var_8_2
	end

	local var_8_3 = arg_8_6.m_cObjectReferenceCount
	local var_8_4 = arg_8_6.m_cObjectAddressToName
	local var_8_5 = {}
	local var_8_6 = 0

	for iter_8_0 in pairs(var_8_3) do
		var_8_6 = var_8_6 + 1
		var_8_5[var_8_6] = iter_8_0
	end

	table.sort(var_8_5, function(arg_9_0, arg_9_1)
		return var_8_3[arg_9_0] > var_8_3[arg_9_1]
	end)

	local var_8_7 = arg_8_0 and string.len(arg_8_0) > 0
	local var_8_8
	local var_8_9 = print

	if var_8_7 then
		local var_8_10 = string.sub(arg_8_0, -1)

		if var_8_10 ~= "/" and var_8_10 ~= "\\" then
			arg_8_0 = arg_8_0 .. "/"
		end

		local var_8_11 = arg_8_0 .. "LuaMemRefInfo-All"

		if not arg_8_1 or string.len(arg_8_1) == 0 then
			if arg_8_5 then
				if var_0_0.m_bComparedMemoryRefFileAddTime then
					var_8_11 = var_8_11 .. "-[" .. var_8_0 .. "].txt"
				else
					var_8_11 = var_8_11 .. ".txt"
				end
			elseif var_0_0.m_bAllMemoryRefFileAddTime then
				var_8_11 = var_8_11 .. "-[" .. var_8_0 .. "].txt"
			else
				var_8_11 = var_8_11 .. ".txt"
			end
		elseif arg_8_5 then
			if var_0_0.m_bComparedMemoryRefFileAddTime then
				var_8_11 = var_8_11 .. "-[" .. var_8_0 .. "]-[" .. arg_8_1 .. "].txt"
			else
				var_8_11 = var_8_11 .. "-[" .. arg_8_1 .. "].txt"
			end
		elseif var_0_0.m_bAllMemoryRefFileAddTime then
			var_8_11 = var_8_11 .. "-[" .. var_8_0 .. "]-[" .. arg_8_1 .. "].txt"
		else
			var_8_11 = var_8_11 .. "-[" .. arg_8_1 .. "].txt"
		end

		local var_8_12 = assert(io.open(var_8_11, "w"))

		var_8_8 = var_8_12
		var_8_9 = var_8_12.write
	end

	local function var_8_13(arg_10_0)
		if var_8_8 then
			var_8_9(var_8_8, arg_10_0)
		else
			var_8_9(arg_10_0)
		end
	end

	if arg_8_5 then
		var_8_13("--------------------------------------------------------\n")
		var_8_13("-- This is compared memory information.\n")
		var_8_13("--------------------------------------------------------\n")
		var_8_13("-- Collect base memory reference at line:" .. tostring(arg_8_5.m_nCurrentLine) .. "@file:" .. arg_8_5.m_strShortSrc .. "\n")
		var_8_13("-- Collect compared memory reference at line:" .. tostring(arg_8_6.m_nCurrentLine) .. "@file:" .. arg_8_6.m_strShortSrc .. "\n")
	else
		var_8_13("--------------------------------------------------------\n")
		var_8_13("-- Collect memory reference at line:" .. tostring(arg_8_6.m_nCurrentLine) .. "@file:" .. arg_8_6.m_strShortSrc .. "\n")
	end

	var_8_13("--------------------------------------------------------\n")
	var_8_13("-- [Table/Function/String Address/Name]\t[Reference Path]\t[Reference Count]\n")
	var_8_13("--------------------------------------------------------\n")

	if arg_8_3 and arg_8_4 then
		if type(arg_8_4) == "string" then
			var_8_13("-- From Root Object: \"" .. tostring(arg_8_4) .. "\" (" .. arg_8_3 .. ")\n")
		else
			var_8_13("-- From Root Object: " .. var_0_2(arg_8_4) .. " (" .. arg_8_3 .. ")\n")
		end
	end

	for iter_8_1, iter_8_2 in ipairs(var_8_5) do
		if not arg_8_5 or not var_8_1[iter_8_2] then
			if arg_8_2 > 0 then
				if iter_8_1 <= arg_8_2 then
					if type(iter_8_2) == "string" then
						local var_8_14 = tostring(iter_8_2)
						local var_8_15, var_8_16 = string.find(var_8_14, "string: \".*\"")

						if not arg_8_5 and (var_8_15 == nil or var_8_16 == nil) then
							local var_8_17 = string.gsub(var_8_14, "([\n\r])", "\\n")

							var_8_13("string: \"" .. var_8_17 .. "\"\t" .. var_8_4[iter_8_2] .. "\t" .. tostring(var_8_3[iter_8_2]) .. "\n")
						else
							var_8_13(tostring(iter_8_2) .. "\t" .. var_8_4[iter_8_2] .. "\t" .. tostring(var_8_3[iter_8_2]) .. "\n")
						end
					else
						var_8_13(var_0_2(iter_8_2) .. "\t" .. var_8_4[iter_8_2] .. "\t" .. tostring(var_8_3[iter_8_2]) .. "\n")
					end
				end
			elseif type(iter_8_2) == "string" then
				local var_8_18 = tostring(iter_8_2)
				local var_8_19, var_8_20 = string.find(var_8_18, "string: \".*\"")

				if not arg_8_5 and (var_8_19 == nil or var_8_20 == nil) then
					local var_8_21 = string.gsub(var_8_18, "([\n\r])", "\\n")

					var_8_13("string: \"" .. var_8_21 .. "\"\t" .. var_8_4[iter_8_2] .. "\t" .. tostring(var_8_3[iter_8_2]) .. "\n")
				else
					var_8_13(tostring(iter_8_2) .. "\t" .. var_8_4[iter_8_2] .. "\t" .. tostring(var_8_3[iter_8_2]) .. "\n")
				end
			else
				var_8_13(var_0_2(iter_8_2) .. "\t" .. var_8_4[iter_8_2] .. "\t" .. tostring(var_8_3[iter_8_2]) .. "\n")
			end
		end
	end

	if var_8_7 then
		io.close(var_8_8)

		var_8_8 = nil
	end
end

local function var_0_9(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_3 then
		return
	end

	local var_11_0 = var_0_1()
	local var_11_1 = arg_11_3.m_cObjectAliasName
	local var_11_2 = arg_11_0 and string.len(arg_11_0) > 0
	local var_11_3
	local var_11_4 = print

	if var_11_2 then
		local var_11_5 = string.sub(arg_11_0, -1)

		if var_11_5 ~= "/" and var_11_5 ~= "\\" then
			arg_11_0 = arg_11_0 .. "/"
		end

		local var_11_6 = arg_11_0 .. "LuaMemRefInfo-Single"

		if not arg_11_1 or string.len(arg_11_1) == 0 then
			if var_0_0.m_bSingleMemoryRefFileAddTime then
				var_11_6 = var_11_6 .. "-[" .. var_11_0 .. "].txt"
			else
				var_11_6 = var_11_6 .. ".txt"
			end
		elseif var_0_0.m_bSingleMemoryRefFileAddTime then
			var_11_6 = var_11_6 .. "-[" .. var_11_0 .. "]-[" .. arg_11_1 .. "].txt"
		else
			var_11_6 = var_11_6 .. "-[" .. arg_11_1 .. "].txt"
		end

		local var_11_7 = assert(io.open(var_11_6, "w"))

		var_11_3 = var_11_7
		var_11_4 = var_11_7.write
	end

	local function var_11_8(arg_12_0)
		if var_11_3 then
			var_11_4(var_11_3, arg_12_0)
		else
			var_11_4(arg_12_0)
		end
	end

	var_11_8("--------------------------------------------------------\n")
	var_11_8("-- Collect single object memory reference at line:" .. tostring(arg_11_3.m_nCurrentLine) .. "@file:" .. arg_11_3.m_strShortSrc .. "\n")
	var_11_8("--------------------------------------------------------\n")

	local var_11_9 = 0

	for iter_11_0 in pairs(var_11_1) do
		var_11_9 = var_11_9 + 1
	end

	var_11_8("-- For Object: " .. arg_11_3.m_strAddressName .. " (" .. arg_11_3.m_strObjectName .. "), have " .. tostring(var_11_9) .. " reference in total.\n")
	var_11_8("--------------------------------------------------------\n")

	for iter_11_1, iter_11_2 in pairs(var_11_1) do
		var_11_8(tostring(iter_11_1) .. "\n")
	end

	if var_11_2 then
		io.close(var_11_3)

		var_11_3 = nil
	end
end

local function var_0_10(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0 or string.len(arg_13_0) == 0 then
		print("You need to specify a file path.")

		return
	end

	if not arg_13_1 or string.len(arg_13_1) == 0 then
		print("You need to specify a filter string.")

		return
	end

	local var_13_0 = {}
	local var_13_1 = assert(io.open(arg_13_0, "rb"))

	for iter_13_0 in var_13_1:lines() do
		local var_13_2, var_13_3 = string.find(iter_13_0, arg_13_1)

		if var_13_2 and var_13_3 then
			if arg_13_2 then
				local var_13_4, var_13_5 = string.find(iter_13_0, "[\r\n]")

				if var_13_4 and var_13_5 and string.len(iter_13_0) == var_13_5 then
					table.insert(var_13_0, string.sub(iter_13_0, 1, var_13_4 - 1))
				else
					table.insert(var_13_0, iter_13_0)
				end
			end
		elseif not arg_13_2 then
			local var_13_6, var_13_7 = string.find(iter_13_0, "[\r\n]")

			if var_13_6 and var_13_7 and string.len(iter_13_0) == var_13_7 then
				table.insert(var_13_0, string.sub(iter_13_0, 1, var_13_6 - 1))
			else
				table.insert(var_13_0, iter_13_0)
			end
		end
	end

	io.close(var_13_1)

	local var_13_8
	local var_13_9
	local var_13_10 = print

	if arg_13_3 then
		local var_13_11, var_13_12, var_13_13 = string.find(arg_13_0, "(.*)%.txt")
		local var_13_14 = var_13_13 .. "-Filter-" .. (arg_13_2 and "I" or "E") .. "-[" .. arg_13_1 .. "].txt"
		local var_13_15 = assert(io.open(var_13_14, "w"))

		var_13_9 = var_13_15
		var_13_10 = var_13_15.write
	end

	local function var_13_16(arg_14_0)
		if var_13_9 then
			var_13_10(var_13_9, arg_14_0)
		else
			var_13_10(arg_14_0)
		end
	end

	for iter_13_1, iter_13_2 in ipairs(var_13_0) do
		var_13_16(iter_13_2 .. "\n")
	end

	if arg_13_3 then
		io.close(var_13_9)

		var_13_9 = nil
	end
end

local function var_0_11(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = var_0_1()

	if arg_15_4 then
		if not arg_15_3 or string.len(arg_15_3) == 0 then
			arg_15_3 = tostring(arg_15_4)
		end
	else
		arg_15_4 = debug.getregistry()
		arg_15_3 = "registry"
	end

	local var_15_1 = var_0_3()
	local var_15_2 = debug.getinfo(2, "Sl")

	if var_15_2 then
		var_15_1.m_strShortSrc = var_15_2.short_src
		var_15_1.m_nCurrentLine = var_15_2.currentline
	end

	var_0_6(arg_15_3, arg_15_4, var_15_1)
	var_0_8(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, nil, var_15_1)
end

local function var_0_12(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	var_0_8(arg_16_0, arg_16_1, arg_16_2, nil, nil, arg_16_3, arg_16_4)
end

local function var_0_13(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = var_0_4(arg_17_3)
	local var_17_1 = var_0_4(arg_17_4)

	var_0_8(arg_17_0, arg_17_1, arg_17_2, nil, nil, var_17_0, var_17_1)
end

local function var_0_14(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if not arg_18_4 then
		return
	end

	if not arg_18_3 or string.len(arg_18_3) == 0 then
		arg_18_3 = var_0_2(arg_18_4)
	end

	local var_18_0 = var_0_1()
	local var_18_1 = var_0_5(arg_18_3, arg_18_4)
	local var_18_2 = debug.getinfo(2, "Sl")

	if var_18_2 then
		var_18_1.m_strShortSrc = var_18_2.short_src
		var_18_1.m_nCurrentLine = var_18_2.currentline
	end

	var_0_7("registry", debug.getregistry(), var_18_1)
	var_0_9(arg_18_0, arg_18_1, arg_18_2, var_18_1)
end

local var_0_15 = {
	m_cMethods = {},
	m_cHelpers = {},
	m_cBases = {},
	m_cConfig = var_0_0
}

var_0_15.m_cMethods.DumpMemorySnapshot = var_0_11
var_0_15.m_cMethods.DumpMemorySnapshotCompared = var_0_12
var_0_15.m_cMethods.DumpMemorySnapshotComparedFile = var_0_13
var_0_15.m_cMethods.DumpMemorySnapshotSingleObject = var_0_14
var_0_15.m_cHelpers.FormatDateTimeNow = var_0_1
var_0_15.m_cHelpers.GetOriginalToStringResult = var_0_2
var_0_15.m_cBases.CreateObjectReferenceInfoContainer = var_0_3
var_0_15.m_cBases.CreateObjectReferenceInfoContainerFromFile = var_0_4
var_0_15.m_cBases.CreateSingleObjectReferenceInfoContainer = var_0_5
var_0_15.m_cBases.CollectObjectReferenceInMemory = var_0_6
var_0_15.m_cBases.CollectSingleObjectReferenceInMemory = var_0_7
var_0_15.m_cBases.OutputMemorySnapshot = var_0_8
var_0_15.m_cBases.OutputMemorySnapshotSingleObject = var_0_9
var_0_15.m_cBases.OutputFilteredResult = var_0_10

return var_0_15
