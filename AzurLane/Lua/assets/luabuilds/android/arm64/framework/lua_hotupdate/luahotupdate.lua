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
	FileTool = var_1_10000

	return var_1_10000.GetCurrentDirectiory() .. "\\"
end

local function var_0_2(arg_4_0)
	local var_4_0 = arg_4_0:gsub("/", "\\")

	if arg_4_0.find(var_4_0, ":") == nil then
		arg_4_0 = var_0_1() .. arg_4_0
	end

	local var_4_1 = #arg_4_0

	if arg_4_0:sub(var_4_1, var_4_1) == "\\" then
		arg_4_0 = arg_4_0:sub(1, var_4_1 - 1)
	end

	local var_4_2 = {}

	for iter_4_0 in arg_4_0:gmatch("[^\\]+") do
		if iter_4_0 == ".." and #var_4_2 ~= 0 then
			table = var_1_10007

			var_1_10007.remove(var_4_2)
		elseif iter_4_0 ~= "." then
			table = var_1_10007

			var_1_10007.insert(var_4_2, iter_4_0)
		end
	end

	table = var_3

	return var_3.concat(var_4_2, "\\")
end

function var_0_0.InitFileMap(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0) do
		iter_5_1 = var_0_2(iter_5_1)

		var_0_0.NotifyFunc("root path: " .. iter_5_1)

		FileTool = var_6

		local var_5_0 = var_6.GetAllFiles(iter_5_1)

		print = var_1_10007

		var_1_10007("count " .. var_5_0.Count)

		for iter_5_2 = 0, var_5_0.Count - 1 do
			local var_5_1 = var_5_0:get_Item(iter_5_2)

			string = var_1_10012

			if var_1_10012.match(var_5_1, ".*\\(.[_a-zA-Z][_a-zA-Z0-9]*)%.lua") ~= nil then
				local var_5_2

				if var_0_0.FileMap[var_1_10012] == nil then
					var_5_2 = var_0_0.FileMap
					var_5_2[var_1_10012] = {}
				end

				string = var_5_2

				local var_5_3 = var_5_2.sub(var_5_1, #iter_5_1 + 2, #var_5_1 - 4)

				string = var_14

				local var_5_4 = var_14.gsub(var_5_3, "\\", ".")
				local var_5_5 = var_0_0.LuaPathToSysPath

				SysPath = var_15
				var_5_5[var_5_4] = var_15
				table = var_5_5

				var_5_5.insert(var_0_0.FileMap[var_1_10012], {
					SysPath = var_5_1,
					LuaPath = var_5_4
				})
			end
		end

		var_1_10007 = var_0_0.NotifyFunc

		local var_5_6 = "load module count: "

		table = iter_5_2

		var_1_10007(var_5_6 .. iter_5_2.getn(var_0_0.FileMap))
	end

	return
end

function var_0_0.InitFakeTable()
	local var_6_0 = {}

	var_0_0.Meta = var_6_0

	local function var_6_1()
		setmetatable = var_2_10000

		return var_2_10000({}, var_6_0)
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
		if not var_0_0.RequireMap[arg_11_0] then
			local var_11_0 = var_6_1()

			var_0_0.RequireMap[arg_11_0] = var_11_0
		end

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

			rawset = var_2_10003

			var_2_10003(arg_12_0, arg_12_1, var_12_0)

			return var_12_0
		end

		return
	end

	function var_6_0.__newindex(arg_13_0, arg_13_1, arg_13_2)
		rawset = var_2_10003

		var_2_10003(arg_13_0, arg_13_1, arg_13_2)

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

	local var_27_0 = var_0_0.Protection

	setmetatable = var_1
	var_27_0[var_1] = true

	local var_27_1 = var_0_0.Protection

	pairs = var_1
	var_27_1[var_1] = true

	local var_27_2 = var_0_0.Protection

	ipairs = var_1
	var_27_2[var_1] = true

	local var_27_3 = var_0_0.Protection

	next = var_1
	var_27_3[var_1] = true

	local var_27_4 = var_0_0.Protection

	require = var_1
	var_27_4[var_1] = true
	var_0_0.Protection[var_0_0] = true
	var_0_0.Protection[var_0_0.Meta] = true

	local var_27_5 = var_0_0.Protection

	math = var_1
	var_27_5[var_1] = true

	local var_27_6 = var_0_0.Protection

	string = var_1
	var_27_6[var_1] = true

	local var_27_7 = var_0_0.Protection

	table = var_1
	var_27_7[var_1] = true

	return
end

function var_0_0.AddFileFromHUList()
	package = var_1_10000

	local var_28_0 = var_1_10000.loaded

	var_28_0[var_0_0.UpdateListFile] = nil
	require = var_28_0

	local var_28_1 = var_28_0(var_0_0.UpdateListFile)

	var_0_0.ALL = false

	local var_28_2 = var_0_0

	var_28_2.HUMap = {}
	pairs = var_28_2

	for iter_28_0, iter_28_1 in var_28_2(var_28_1) do
		if iter_28_1 == "_ALL_" then
			local var_28_3 = var_0_0

			var_28_3.ALL = true
			pairs = var_28_3

			for iter_28_2, iter_28_3 in var_28_3(var_0_0.FileMap) do
				pairs = var_1_10011

				for iter_28_4, iter_28_5 in var_1_10011(iter_28_3) do
					var_0_0.HUMap[iter_28_5.LuaPath] = iter_28_5.SysPath
				end
			end

			return
		end

		if var_0_0.FileMap[iter_28_1] then
			pairs = var_6

			for iter_28_6, iter_28_7 in var_6(var_0_0.FileMap[iter_28_1]) do
				var_1_10011 = var_0_0.HUMap
				var_1_10011[iter_28_7.LuaPath] = iter_28_7.SysPath
			end
		else
			var_0_0.FailNotify("HotUpdate can't not find " .. iter_28_1)
		end
	end

	return
end

function var_0_0.ErrorHandle(arg_29_0)
	local var_29_0 = var_0_0.FailNotify
	local var_29_1 = "HotUpdate Error\n"

	tostring = var_1_10004

	var_29_0(var_29_1 .. var_1_10004(arg_29_0))

	var_0_0.ErrorHappen = true

	return
end

function var_0_0.BuildNewCode(arg_30_0, arg_30_1)
	io = var_1_10002

	var_1_10002.input(arg_30_0)

	io = var_2

	local var_30_0 = var_2.read("*all")

	if var_0_0.ALL and var_0_0.OldCode[arg_30_0] == nil then
		local var_30_1 = var_0_0.OldCode

		var_30_1[arg_30_0] = var_30_0
		io = var_30_1

		local var_30_2 = var_30_1.input()

		var_3.close(var_30_2)

		return
	end

	if var_0_0.OldCode[arg_30_0] == var_30_0 then
		io = var_3

		local var_30_3 = var_3.input()

		var_3.close(var_30_3)

		return false
	end

	io = var_3

	local var_30_4 = var_3.input()

	var_3.close(var_30_4)

	io = var_3

	var_3.input(arg_30_0)

	local var_30_5 = ("--[[" .. arg_30_1 .. "]] ") .. var_30_0

	io = var_4

	local var_30_6 = var_4.input()

	var_4.close(var_30_6)

	loadstring = var_4

	if not var_4(var_30_5) then
		var_0_0.FailNotify(arg_30_0 .. " has syntax error.")

		collectgarbage = var_5

		var_5("collect")

		return false
	else
		var_0_0.FakeENV = var_0_0.FakeT()
		var_0_0.MetaMap = {}

		local var_30_7 = var_0_0

		var_30_7.RequireMap = {}
		setfenv = var_30_7

		var_30_7(var_4, var_0_0.FakeENV)

		local var_30_8
		local var_30_9 = var_0_0

		var_30_9.ErrorHappen = false
		xpcall = var_30_9

		var_30_9(function()
			var_30_8 = var_0()

			return
		end, var_0_0.ErrorHandle)

		local var_30_10

		if not var_0_0.ErrorHappen then
			var_30_10 = var_0_0.OldCode
			var_30_10[arg_30_0] = var_30_0

			return true, var_30_8
		else
			collectgarbage = var_30_10

			var_30_10("collect")

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
		type = var_2_10001

		if var_2_10001(arg_33_0) ~= "function" then
			type = var_1

			if var_1(arg_33_0) == "table" then
				if var_32_0[arg_33_0] or var_0_0.Protection[arg_33_0] then
					return
				end

				local var_33_0 = var_32_0

				var_33_0[arg_33_0] = true
				type = var_33_0

				local var_33_1

				if var_33_0(arg_33_0) == "function" then
					var_33_1 = 1
					math = var_2

					for iter_33_0 = var_33_1, var_2.huge do
						debug = var_2_10005

						local var_33_2

						var_2_10005, var_33_2 = var_2_10005.getupvalue(arg_33_0, iter_33_0)

						if not var_2_10005 then
							break
						end

						type = var_7

						if var_7(var_33_2) == "function" then
							ipairs = var_7

							for iter_33_1, iter_33_2 in var_7(var_0_0.ChangedFuncList) do
								if var_33_2 == iter_33_2[1] then
									debug = var_12

									var_12.setupvalue(arg_33_0, iter_33_0, iter_33_2[2])
								end
							end
						end

						var_0(var_33_2)
					end
				else
					type = var_33_1

					if var_33_1(arg_33_0) == "table" then
						local var_33_3 = var_0

						debug = var_3

						var_33_3(var_3.getmetatable(arg_33_0))

						local var_33_4 = {}

						pairs = var_2

						for iter_33_3, iter_33_4 in var_2(arg_33_0) do
							var_0(iter_33_3)
							var_0(iter_33_4)

							type = var_7

							if var_7(iter_33_4) == "function" then
								ipairs = var_7

								for iter_33_5, iter_33_6 in var_7(var_0_0.ChangedFuncList) do
									if iter_33_4 == iter_33_6[1] then
										arg_33_0[iter_33_3] = iter_33_6[2]
									end
								end
							end

							type = var_7

							if var_7(iter_33_3) == "function" then
								ipairs = var_7

								for iter_33_7, iter_33_8 in var_7(var_0_0.ChangedFuncList) do
									if iter_33_3 == iter_33_8[1] then
										var_33_4[#var_33_4 + 1] = iter_33_7
									end
								end
							end
						end

						ipairs = var_2

						for iter_33_9, iter_33_10 in var_2(var_33_4) do
							arg_33_0[var_0_0.ChangedFuncList[iter_33_10][2]] = arg_33_0[var_7[1]]
							arg_33_0[var_7[1]] = nil
						end
					end
				end

				return
			end
		end
	end

	_G = var_1_10004

	var_32_1(var_1_10004)

	debug = var_32_1

	local var_32_2 = var_32_1.getregistry()

	ipairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(var_0_0.ChangedFuncList) do
		pairs = var_1_10008

		for iter_32_2, iter_32_3 in var_1_10008(var_32_2) do
			if iter_32_3 == iter_32_1[1] then
				var_32_2[iter_32_2] = iter_32_1[2]
			end
		end
	end

	ipairs = var_3

	for iter_32_4, iter_32_5 in var_3(var_0_0.ChangedFuncList) do
		if iter_32_5[3] == "HUDebug" then
			local var_32_3 = iter_32_5[4]

			var_8.HUDebug(var_32_3)
		end
	end

	return
end

function var_0_0.ReplaceOld(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	type = var_1_10005

	local var_34_0 = var_1_10005(arg_34_0)

	type = var_1_10006

	if var_34_0 == var_1_10006(arg_34_1) then
		type = var_34_0

		if var_34_0(arg_34_1) == "table" then
			var_0_0.UpdateAllFunction(arg_34_0, arg_34_1, arg_34_2, arg_34_3, "")
		else
			type = var_5

			if var_5(arg_34_1) == "function" then
				var_0_0.UpdateOneFunction(arg_34_0, arg_34_1, arg_34_2, nil, arg_34_3, "")
			end
		end
	end

	return
end

function var_0_0.HotUpdateCode(arg_35_0, arg_35_1)
	package = var_1_10002

	if var_1_10002.loaded[arg_35_0] ~= nil then
		var_0_0.VisitedSig = {}
		var_0_0.ChangedFuncList = {}

		local var_35_0

		var_35_0, var_1_10004 = var_0_0.BuildNewCode(arg_35_1, arg_35_0)

		if var_35_0 then
			var_0_0.NotifyFunc("update module " .. arg_35_0)
			var_0_0.ReplaceOld(var_2, var_1_10004, arg_35_0, "Main", "")

			pairs = var_5

			for iter_35_0, iter_35_1 in var_5(var_0_0.RequireMap) do
				package = var_35_1

				local var_35_1 = var_35_1.loaded[iter_35_0]

				var_0_0.ReplaceOld(var_35_1, iter_35_1, iter_35_0, "Main_require", "")
			end

			setmetatable = var_5

			var_5(var_0_0.FakeENV, nil)
			var_0_0.UpdateAllFunction(var_0_0.ENV, var_0_0.FakeENV, " ENV ", "Main", "")

			if #var_0_0.ChangedFuncList > 0 then
				var_0_0.Travel_G()
			end

			collectgarbage = var_5

			var_5("collect")
		end
	elseif var_0_0.OldCode[arg_35_1] == nil then
		io = var_3

		var_3.input(arg_35_1)

		local var_35_2 = var_0_0.OldCode

		io = var_1_10004
		var_35_2[arg_35_1] = var_1_10004.read("*all")
		io = var_35_2

		local var_35_3 = var_35_2.input()

		var_3.close(var_35_3)
	end

	return
end

function var_0_0.ResetENV(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = {}

	;(function(arg_37_0, arg_37_1)
		if not arg_37_0 or var_36_0[arg_37_0] then
			return
		end

		local var_37_0 = var_36_0

		var_37_0[arg_37_0] = true
		type = var_37_0

		if var_37_0(arg_37_0) == "function" then
			var_0_0.DebugNofity(arg_36_3 .. "HU.ResetENV", arg_37_1, "  from:" .. arg_36_2)

			xpcall = var_2

			var_2(function()
				setfenv = var_3_10000

				var_3_10000(arg_37_0, var_0_0.ENV)

				return
			end, var_0_0.FailNotify)
		else
			type = var_2

			if var_2(arg_37_0) == "table" then
				var_0_0.DebugNofity(arg_36_3 .. "HU.ResetENV", arg_37_1, "  from:" .. arg_36_2)

				pairs = var_2

				for iter_37_0, iter_37_1 in var_2(arg_37_0) do
					local var_37_1 = var_0
					local var_37_2 = iter_37_0

					tostring = var_2_10010

					var_37_1(var_37_2, var_2_10010(iter_37_0) .. "__key", " HU.ResetENV ", arg_36_3 .. "    ")

					local var_37_3 = var_0
					local var_37_4 = iter_37_1

					tostring = var_2_10010

					var_37_3(var_37_4, var_2_10010(iter_37_0), " HU.ResetENV ", arg_36_3 .. "    ")
				end
			end
		end

		return
	end)(arg_36_0, arg_36_1)

	return
end

function var_0_0.UpdateUpvalue(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	var_0_0.DebugNofity(arg_39_4 .. "HU.UpdateUpvalue", arg_39_2, "  from:" .. arg_39_3)

	local var_39_0 = {}
	local var_39_1 = {}
	local var_39_2 = 1

	math = var_8

	for iter_39_0 = var_39_2, var_8.huge do
		debug = var_1_10011

		local var_39_3

		var_1_10011, var_39_3 = var_1_10011.getupvalue(arg_39_0, iter_39_0)

		if not var_1_10011 then
			break
		end

		var_39_0[var_1_10011] = var_39_3
		var_39_1[var_1_10011] = true
	end

	local var_39_4 = 1

	math = var_8

	for iter_39_1 = var_39_4, var_8.huge do
		debug = var_1_10011

		local var_39_5

		var_1_10011, var_39_5 = var_1_10011.getupvalue(arg_39_1, iter_39_1)

		if not var_1_10011 then
			break
		end

		if var_39_1[var_1_10011] then
			local var_39_6 = var_39_0[var_1_10011]

			type = var_14

			local var_39_7 = var_14(var_39_6)

			type = var_1_10015

			if var_39_7 ~= var_1_10015(var_39_5) then
				debug = var_39_7

				var_39_7.setupvalue(arg_39_1, iter_39_1, var_39_6)
			else
				type = var_39_7

				if var_39_7(var_39_6) == "function" then
					var_0_0.UpdateOneFunction(var_39_6, var_39_5, var_1_10011, nil, "HU.UpdateUpvalue", arg_39_4 .. "    ")
				else
					type = var_14

					if var_14(var_39_6) == "table" then
						var_0_0.UpdateAllFunction(var_39_6, var_39_5, var_1_10011, "HU.UpdateUpvalue", arg_39_4 .. "    ")

						debug = var_14

						var_14.setupvalue(arg_39_1, iter_39_1, var_39_6)
					else
						debug = var_14

						var_14.setupvalue(arg_39_1, iter_39_1, var_39_6)
					end
				end
			end
		else
			var_0_0.ResetENV(var_39_5, var_1_10011, "HU.UpdateUpvalue", arg_39_4 .. "    ")
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

	tostring = var_6

	local var_40_0 = var_6(arg_40_0)

	tostring = var_1_10007

	local var_40_1 = var_40_0 .. var_1_10007(arg_40_1)

	if var_0_0.VisitedSig[var_40_1] then
		return
	end

	var_0_0.VisitedSig[var_40_1] = true

	var_0_0.DebugNofity(arg_40_5 .. "HU.UpdateOneFunction " .. arg_40_2 .. "  from:" .. arg_40_4)

	pcall = var_7
	debug = var_9

	local var_40_2 = var_9.setfenv
	local var_40_3 = arg_40_1

	getfenv = var_11

	if var_7(var_40_2, var_40_3, var_11(arg_40_0)) then
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

function var_0_0.UpdateAllFunction(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	if var_0_0.Protection[arg_41_0] or var_0_0.Protection[arg_41_1] then
		return
	end

	if arg_41_0 == arg_41_1 then
		return
	end

	tostring = var_5

	local var_41_0 = var_5(arg_41_0)

	tostring = var_1_10006

	local var_41_1 = var_41_0 .. var_1_10006(arg_41_1)

	if var_0_0.VisitedSig[var_41_1] then
		return
	end

	var_0_0.VisitedSig[var_41_1] = true

	var_0_0.DebugNofity(arg_41_4 .. "HU.UpdateAllFunction " .. arg_41_2 .. "  from:" .. arg_41_3)

	pairs = var_6

	for iter_41_0, iter_41_1 in var_6(arg_41_1) do
		local var_41_2 = arg_41_0[iter_41_0]

		type = var_41_3

		local var_41_3 = var_41_3(iter_41_1)

		type = var_1_10013

		if var_41_3 == var_1_10013(var_41_2) then
			type = var_41_3

			if var_41_3(iter_41_1) == "function" then
				var_0_0.UpdateOneFunction(var_41_2, iter_41_1, iter_41_0, arg_41_0, "HU.UpdateAllFunction", arg_41_4 .. "    ")
			else
				type = var_41_3

				if var_41_3(iter_41_1) == "table" then
					var_0_0.UpdateAllFunction(var_41_2, iter_41_1, iter_41_0, "HU.UpdateAllFunction", arg_41_4 .. "    ")
				end
			end
		elseif var_41_2 == nil then
			type = var_41_3

			if var_41_3(iter_41_1) == "function" then
				pcall = var_41_3
				setfenv = var_14

				if var_41_3(var_14, iter_41_1, var_0_0.ENV) then
					arg_41_0[iter_41_0] = iter_41_1
				end
			end
		end
	end

	debug = var_6

	local var_41_4 = var_6.getmetatable(arg_41_0)
	local var_41_5 = var_0_0.MetaMap[arg_41_1]

	type = var_8

	if var_8(var_41_4) == "table" then
		type = var_8

		if var_8(var_41_5) == "table" then
			var_0_0.UpdateAllFunction(var_41_4, var_41_5, arg_41_2 .. "'s Meta", "HU.UpdateAllFunction", arg_41_4 .. "    ")
		end
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

	local var_42_0 = var_0_0

	if not arg_42_3 then
		::label_42_0::

		_G = var_5
	end

	var_42_0.ENV = var_5
	var_0_0.LuaPathToSysPath = {}

	var_0_0.InitFileMap(arg_42_1)

	var_0_0.FakeT = var_0_0.InitFakeTable()

	var_0_0.InitProtection()

	var_0_0.ALL = false

	return
end

function var_0_0.Update()
	var_0_0.AddFileFromHUList()

	pairs = var_0

	for iter_43_0, iter_43_1 in var_0(var_0_0.HUMap) do
		var_0_0.HotUpdateCode(iter_43_0, iter_43_1)
	end

	return
end

return var_0_0
