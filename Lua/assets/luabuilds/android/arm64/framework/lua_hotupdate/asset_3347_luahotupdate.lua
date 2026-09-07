local var_0_0 = {}

function var_0_0.FailNotify(...)
	if var_0_0.NotifyFunc then
		var_0_0.NotifyFunc(...)
	end

	return
end

function var_0_0.DebugNofity(...)
	if var_0_0.DebugNofityFunc then
		var_0_0.DebugNofityFunc(...)
	end

	return
end

local function var_0_1()
	return FileTool.GetCurrentDirectiory() .. "\\"
end

local function var_0_2(arg_4_0)
	arg_4_0 = arg_4_0:gsub("/", "\\")

	if arg_4_0:find(":") == nil then
		arg_4_0 = var_0_1() .. arg_4_0
	end

	if arg_4_0:sub(#arg_4_0, #arg_4_0) == "\\" then
		arg_4_0 = arg_4_0:sub(1, #arg_4_0 - 1)
	end

	local var_4_0 = {}

	for iter_4_0 in arg_4_0:gmatch("[^\\]+") do
		if iter_4_0 == ".." and #var_4_0 ~= 0 then
			table.remove(var_4_0)
		elseif iter_4_0 ~= "." then
			table.insert(var_4_0, iter_4_0)
		end
	end

	return table.concat(var_4_0, "\\")
end

function var_0_0.InitFileMap(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0) do
		iter_5_1 = var_0_2(iter_5_1)

		var_0_0.NotifyFunc("root path: " .. iter_5_1)

		local var_5_0 = FileTool.GetAllFiles(iter_5_1)

		print("count " .. var_5_0.Count)

		for iter_5_2 = 0, var_5_0.Count - 1 do
			local var_5_1 = var_5_0:get_Item(iter_5_2)
			local var_5_2 = string.match(var_5_1, ".*\\(.[_a-zA-Z][_a-zA-Z0-9]*)%.lua")

			if var_5_2 ~= nil then
				if var_0_0.FileMap[var_5_2] == nil then
					var_0_0.FileMap[var_5_2] = {}
				end

				local var_5_3 = string.gsub(string.sub(var_5_1, #iter_5_1 + 2, #var_5_1 - 4), "\\", ".")

				var_0_0.LuaPathToSysPath[var_5_3] = SysPath

				table.insert(var_0_0.FileMap[var_5_2], {
					SysPath = var_5_1,
					LuaPath = var_5_3
				})
			end
		end

		var_0_0.NotifyFunc("load module count: " .. table.getn(var_0_0.FileMap))
	end

	return
end

function var_0_0.InitFakeTable()
	local var_6_0 = {}

	var_0_0.Meta = var_6_0

	local function var_6_1()
		return setmetatable({}, var_6_0)
	end

	local function var_6_2()
		return
	end

	local function var_6_3()
		return var_6_2
	end

	local function var_6_4(arg_10_0, arg_10_1)
		var_0_0.MetaMap[arg_10_0] = arg_10_1

		return arg_10_0
	end

	local function var_6_5(arg_11_0)
		var_0_0.RequireMap[arg_11_0] = var_0_0.RequireMap[arg_11_0] or var_6_1()

		return var_0_0.RequireMap[arg_11_0]
	end

	function var_6_0.__index(arg_12_0, arg_12_1)
		if arg_12_1 == "setmetatable" then
			return var_6_4
		elseif arg_12_1 == "pairs" or arg_12_1 == "ipairs" then
			return var_6_3
		elseif arg_12_1 == "next" then
			return var_6_2
		elseif arg_12_1 == "require" then
			return var_6_5
		else
			local var_12_0 = var_6_1()

			rawset(arg_12_0, arg_12_1, var_12_0)

			return var_12_0
		end

		return
	end

	function var_6_0.__newindex(arg_13_0, arg_13_1, arg_13_2)
		rawset(arg_13_0, arg_13_1, arg_13_2)

		return
	end

	function var_6_0.__call()
		local var_14_0 = var_6_1()
		local var_14_1 = var_6_1()
		local var_14_2 = var_6_1()
	end

	function var_6_0.__add()
		return var_6_0.__call()
	end

	function var_6_0.__sub()
		return var_6_0.__call()
	end

	function var_6_0.__mul()
		return var_6_0.__call()
	end

	function var_6_0.__div()
		return var_6_0.__call()
	end

	function var_6_0.__mod()
		return var_6_0.__call()
	end

	function var_6_0.__pow()
		return var_6_0.__call()
	end

	function var_6_0.__unm()
		return var_6_0.__call()
	end

	function var_6_0.__concat()
		return var_6_0.__call()
	end

	function var_6_0.__eq()
		return var_6_0.__call()
	end

	function var_6_0.__lt()
		return var_6_0.__call()
	end

	function var_6_0.__le()
		return var_6_0.__call()
	end

	function var_6_0.__len()
		return var_6_0.__call()
	end

	return var_6_1
end

function var_0_0.InitProtection()
	var_0_0.Protection = {}
	var_0_0.Protection[setmetatable] = true
	var_0_0.Protection[pairs] = true
	var_0_0.Protection[ipairs] = true
	var_0_0.Protection[next] = true
	var_0_0.Protection[require] = true
	var_0_0.Protection[var_0_0] = true
	var_0_0.Protection[var_0_0.Meta] = true
	var_0_0.Protection[math] = true
	var_0_0.Protection[string] = true
	var_0_0.Protection[table] = true

	return
end

function var_0_0.AddFileFromHUList()
	package.loaded[var_0_0.UpdateListFile] = nil
	var_0_0.ALL = false
	var_0_0.HUMap = {}

	for iter_28_0, iter_28_1 in pairs((require(var_0_0.UpdateListFile))) do
		if iter_28_1 == "_ALL_" then
			var_0_0.ALL = true

			for iter_28_2, iter_28_3 in pairs(var_0_0.FileMap) do
				for iter_28_4, iter_28_5 in pairs(iter_28_3) do
					var_0_0.HUMap[iter_28_5.LuaPath] = iter_28_5.SysPath
				end
			end

			return
		end

		if var_0_0.FileMap[iter_28_1] then
			for iter_28_6, iter_28_7 in pairs(var_0_0.FileMap[iter_28_1]) do
				var_0_0.HUMap[iter_28_7.LuaPath] = iter_28_7.SysPath
			end
		else
			var_0_0.FailNotify("HotUpdate can't not find " .. iter_28_1)
		end
	end

	return
end

function var_0_0.ErrorHandle(arg_29_0)
	var_0_0.FailNotify("HotUpdate Error\n" .. tostring(arg_29_0))

	var_0_0.ErrorHappen = true

	return
end

function var_0_0.BuildNewCode(arg_30_0, arg_30_1)
	io.input(arg_30_0)

	local var_30_0 = io.read("*all")

	if var_0_0.ALL and var_0_0.OldCode[arg_30_0] == nil then
		var_0_0.OldCode[arg_30_0] = var_30_0

		io.input():close()

		return
	end

	if var_0_0.OldCode[arg_30_0] == var_30_0 then
		io.input():close()

		return false
	end

	io.input():close()
	io.input(arg_30_0)
	io.input():close()

	local var_30_1 = loadstring(("--[[" .. arg_30_1 .. "]] ") .. var_30_0)

	if not var_30_1 then
		var_0_0.FailNotify(arg_30_0 .. " has syntax error.")
		collectgarbage("collect")

		return false
	else
		var_0_0.FakeENV = var_0_0.FakeT()
		var_0_0.MetaMap = {}
		var_0_0.RequireMap = {}

		setfenv(var_30_1, var_0_0.FakeENV)

		local var_30_2

		var_0_0.ErrorHappen = false

		xpcall(function()
			var_30_2 = var_30_1()

			return
		end, var_0_0.ErrorHandle)

		if not var_0_0.ErrorHappen then
			var_0_0.OldCode[arg_30_0] = var_30_0

			return true, nil
		else
			collectgarbage("collect")

			return false
		end
	end

	return
end

function var_0_0.Travel_G()
	local var_32_0 = {
		[var_0_0] = true
	}

	local function var_32_1(arg_33_0)
		if type(arg_33_0) ~= "function" and type(arg_33_0) ~= "table" or var_32_0[arg_33_0] or var_0_0.Protection[arg_33_0] then
			return
		end

		var_32_0[arg_33_0] = true

		if type(arg_33_0) == "function" then
			for iter_33_0 = 1, math.huge do
				local var_33_0, var_33_1 = debug.getupvalue(arg_33_0, iter_33_0)

				if not var_33_0 then
					break
				end

				if type(var_33_1) == "function" then
					for iter_33_1, iter_33_2 in ipairs(var_0_0.ChangedFuncList) do
						if var_33_1 == iter_33_2[1] then
							debug.setupvalue(arg_33_0, iter_33_0, iter_33_2[2])
						end
					end
				end

				var_32_1(var_33_1)
			end
		elseif type(arg_33_0) == "table" then
			var_32_1(debug.getmetatable(arg_33_0))

			local var_33_2 = {}

			for iter_33_3, iter_33_4 in pairs(arg_33_0) do
				var_32_1(iter_33_3)
				var_32_1(iter_33_4)

				if type(iter_33_4) == "function" then
					for iter_33_5, iter_33_6 in ipairs(var_0_0.ChangedFuncList) do
						if iter_33_4 == iter_33_6[1] then
							arg_33_0[iter_33_3] = iter_33_6[2]
						end
					end
				end

				if type(iter_33_3) == "function" then
					for iter_33_7, iter_33_8 in ipairs(var_0_0.ChangedFuncList) do
						if iter_33_3 == iter_33_8[1] then
							var_33_2[#var_33_2 + 1] = iter_33_7
						end
					end
				end
			end

			for iter_33_9, iter_33_10 in ipairs(var_33_2) do
				arg_33_0[var_0_0.ChangedFuncList[iter_33_10][2]] = arg_33_0[var_0_0.ChangedFuncList[iter_33_10][1]]
				arg_33_0[var_0_0.ChangedFuncList[iter_33_10][1]] = nil
			end
		end

		return
	end

	var_32_1(_G)

	local var_32_2 = debug.getregistry()

	for iter_32_0, iter_32_1 in ipairs(var_0_0.ChangedFuncList) do
		for iter_32_2, iter_32_3 in pairs(var_32_2) do
			if iter_32_3 == iter_32_1[1] then
				var_32_2[iter_32_2] = iter_32_1[2]
			end
		end
	end

	for iter_32_4, iter_32_5 in ipairs(var_0_0.ChangedFuncList) do
		if iter_32_5[3] == "HUDebug" then
			iter_32_5[4]:HUDebug()
		end
	end

	return
end

function var_0_0.ReplaceOld(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	if type(arg_34_0) == type(arg_34_1) then
		if type(arg_34_1) == "table" then
			var_0_0.UpdateAllFunction(arg_34_0, arg_34_1, arg_34_2, arg_34_3, "")
		elseif type(arg_34_1) == "function" then
			var_0_0.UpdateOneFunction(arg_34_0, arg_34_1, arg_34_2, nil, arg_34_3, "")
		end
	end

	return
end

function var_0_0.HotUpdateCode(arg_35_0, arg_35_1)
	if package.loaded[arg_35_0] ~= nil then
		var_0_0.VisitedSig = {}
		var_0_0.ChangedFuncList = {}

		local var_35_0, var_35_1 = var_0_0.BuildNewCode(arg_35_1, arg_35_0)

		if var_35_0 then
			var_0_0.NotifyFunc("update module " .. arg_35_0)
			var_0_0.ReplaceOld(package.loaded[arg_35_0], var_35_1, arg_35_0, "Main", "")

			for iter_35_0, iter_35_1 in pairs(var_0_0.RequireMap) do
				var_0_0.ReplaceOld(package.loaded[iter_35_0], iter_35_1, iter_35_0, "Main_require", "")
			end

			setmetatable(var_0_0.FakeENV, nil)
			var_0_0.UpdateAllFunction(var_0_0.ENV, var_0_0.FakeENV, " ENV ", "Main", "")

			if #var_0_0.ChangedFuncList > 0 then
				var_0_0.Travel_G()
			end

			collectgarbage("collect")
		end
	elseif var_0_0.OldCode[arg_35_1] == nil then
		io.input(arg_35_1)

		var_0_0.OldCode[arg_35_1] = io.read("*all")

		io.input():close()
	end

	return
end

function var_0_0.ResetENV(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = {}

	local function var_36_1(arg_37_0, arg_37_1)
		if not arg_37_0 or var_36_0[arg_37_0] then
			return
		end

		var_36_0[arg_37_0] = true

		if type(arg_37_0) == "function" then
			var_0_0.DebugNofity(arg_36_3 .. "HU.ResetENV", arg_37_1, "  from:" .. arg_36_2)
			xpcall(function()
				setfenv(arg_37_0, var_0_0.ENV)

				return
			end, var_0_0.FailNotify)
		elseif type(arg_37_0) == "table" then
			var_0_0.DebugNofity(arg_36_3 .. "HU.ResetENV", arg_37_1, "  from:" .. arg_36_2)

			for iter_37_0, iter_37_1 in pairs(arg_37_0) do
				var_36_1(iter_37_0, tostring(iter_37_0) .. "__key", " HU.ResetENV ", arg_36_3 .. "    ")
				var_36_1(iter_37_1, tostring(iter_37_0), " HU.ResetENV ", arg_36_3 .. "    ")
			end
		end

		return
	end

	var_36_1(arg_36_0, arg_36_1)

	return
end

function var_0_0.UpdateUpvalue(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	var_0_0.DebugNofity(arg_39_4 .. "HU.UpdateUpvalue", arg_39_2, "  from:" .. arg_39_3)

	local var_39_0 = {}
	local var_39_1 = {}

	for iter_39_0 = 1, math.huge do
		local var_39_2, var_39_3 = debug.getupvalue(arg_39_0, iter_39_0)

		if not var_39_2 then
			break
		end

		var_39_0[var_39_2] = var_39_3
		var_39_1[var_39_2] = true
	end

	for iter_39_1 = 1, math.huge do
		local var_39_4, var_39_5 = debug.getupvalue(arg_39_1, iter_39_1)

		if not var_39_4 then
			break
		end

		if var_39_1[var_39_4] then
			if type(var_39_0[var_39_4]) ~= type(var_39_5) then
				debug.setupvalue(arg_39_1, iter_39_1, var_39_0[var_39_4])
			elseif type(var_39_0[var_39_4]) == "function" then
				var_0_0.UpdateOneFunction(var_39_0[var_39_4], var_39_5, var_39_4, nil, "HU.UpdateUpvalue", arg_39_4 .. "    ")
			elseif type(var_39_0[var_39_4]) == "table" then
				var_0_0.UpdateAllFunction(var_39_0[var_39_4], var_39_5, var_39_4, "HU.UpdateUpvalue", arg_39_4 .. "    ")
				debug.setupvalue(arg_39_1, iter_39_1, var_39_0[var_39_4])
			else
				debug.setupvalue(arg_39_1, iter_39_1, var_39_0[var_39_4])
			end
		else
			var_0_0.ResetENV(var_39_5, var_39_4, "HU.UpdateUpvalue", arg_39_4 .. "    ")
		end
	end

	return
end

function var_0_0.UpdateOneFunction(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
	if var_0_0.Protection[arg_40_0] or var_0_0.Protection[arg_40_1] then
		return
	end

	if arg_40_0 == arg_40_1 then
		return
	end

	local var_40_0 = tostring(arg_40_0) .. tostring(arg_40_1)

	if var_0_0.VisitedSig[var_40_0] then
		return
	end

	var_0_0.VisitedSig[var_40_0] = true

	var_0_0.DebugNofity(arg_40_5 .. "HU.UpdateOneFunction " .. arg_40_2 .. "  from:" .. arg_40_4)

	if pcall(debug.setfenv, arg_40_1, getfenv(arg_40_0)) then
		var_0_0.UpdateUpvalue(arg_40_0, arg_40_1, arg_40_2, "HU.UpdateOneFunction", arg_40_5 .. "    ")

		var_0_0.ChangedFuncList[#var_0_0.ChangedFuncList + 1] = {
			arg_40_0,
			arg_40_1,
			arg_40_2,
			arg_40_3
		}
	end

	return
end

function var_0_0:UpdateAllFunction(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	if var_0_0.Protection[self] or var_0_0.Protection[arg_41_1] then
		return
	end

	if self == arg_41_1 then
		return
	end

	local var_41_0 = tostring(self) .. tostring(arg_41_1)

	if var_0_0.VisitedSig[var_41_0] then
		return
	end

	var_0_0.VisitedSig[var_41_0] = true

	var_0_0.DebugNofity(arg_41_4 .. "HU.UpdateAllFunction " .. arg_41_2 .. "  from:" .. arg_41_3)

	for iter_41_0, iter_41_1 in pairs(arg_41_1) do
		if type(iter_41_1) == type(self[iter_41_0]) then
			if type(iter_41_1) == "function" then
				var_0_0.UpdateOneFunction(self[iter_41_0], iter_41_1, iter_41_0, self, "HU.UpdateAllFunction", arg_41_4 .. "    ")
			elseif type(iter_41_1) == "table" then
				var_0_0.UpdateAllFunction(self[iter_41_0], iter_41_1, iter_41_0, "HU.UpdateAllFunction", arg_41_4 .. "    ")
			end
		elseif self[iter_41_0] == nil and type(iter_41_1) == "function" and pcall(setfenv, iter_41_1, var_0_0.ENV) then
			self[iter_41_0] = iter_41_1
		end
	end

	local var_41_1 = debug.getmetatable(self)

	if type(var_41_1) == "table" and type(var_0_0.MetaMap[arg_41_1]) == "table" then
		var_0_0.UpdateAllFunction(var_41_1, var_0_0.MetaMap[arg_41_1], arg_41_2 .. "'s Meta", "HU.UpdateAllFunction", arg_41_4 .. "    ")
	end

	return
end

function var_0_0.Init(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	var_0_0.UpdateListFile = arg_42_0
	var_0_0.HUMap = {}
	var_0_0.FileMap = {}
	var_0_0.NotifyFunc = arg_42_2
	var_0_0.OldCode = {}
	var_0_0.ChangedFuncList = {}
	var_0_0.VisitedSig = {}
	var_0_0.FakeENV = nil
	var_0_0.ENV = arg_42_3 or _G
	var_0_0.LuaPathToSysPath = {}

	var_0_0.InitFileMap(arg_42_1)

	var_0_0.FakeT = var_0_0.InitFakeTable()

	var_0_0.InitProtection()

	var_0_0.ALL = false

	return
end

function var_0_0.Update()
	var_0_0.AddFileFromHUList()

	for iter_43_0, iter_43_1 in pairs(var_0_0.HUMap) do
		var_0_0.HotUpdateCode(iter_43_0, iter_43_1)
	end

	return
end

return var_0_0
