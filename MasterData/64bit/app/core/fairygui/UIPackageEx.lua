local var_0_0 = fgui.UIPackage
local var_0_1 = handler(fgui.UIPackage, fgui.UIPackage.createObjectBase)

local function var_0_2(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if type(arg_1_0) == "string" and string.sub(arg_1_0, 1, 1) == "_" then
		arg_1_2[arg_1_0] = arg_1_1
	else
		arg_1_2[arg_1_0] = arg_1_1
		arg_1_3[arg_1_0] = arg_1_1
	end
end

local function var_0_3(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0 then
		return
	end

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		var_0_2(iter_2_0, iter_2_1, arg_2_1, arg_2_2)
	end
end

local function var_0_4(arg_3_0, arg_3_1)
	local var_3_0 = rawget(arg_3_0, "__classPub")
	local var_3_1 = rawget(arg_3_0, "__classPriv")
	local var_3_2 = rawget(arg_3_0, "__baseClass")

	if var_3_0[arg_3_1] then
		if type(var_3_0[arg_3_1]) == "function" then
			return function(arg_4_0)
				local var_4_0 = false
				local var_4_1 = 0
				local var_4_2 = {}

				if arg_4_0 and arg_4_0.__classIndex then
					var_4_1 = arg_4_0.__classIndex
				end

				if var_4_1 == 0 then
					for iter_4_0 = 1, #var_3_1 do
						if var_3_1[iter_4_0][arg_3_1] then
							var_4_0 = true

							if arg_4_0 and arg_4_0.__classIndex then
								arg_4_0.__classIndex = iter_4_0
							end

							if arg_3_1 == "ctor" then
								if var_3_1[iter_4_0].__supers then
									for iter_4_1, iter_4_2 in pairs(var_3_1[iter_4_0].__supers) do
										if iter_4_2.__ctor then
											iter_4_2.__ctor(arg_4_0, arg_4_0.__ctorParams[iter_4_0])
										end
									end
								end

								var_4_2 = {
									var_3_1[iter_4_0][arg_3_1](arg_4_0, arg_4_0.__ctorParams[iter_4_0])
								}
							else
								var_4_2 = {
									var_3_1[iter_4_0][arg_3_1](arg_4_0, ...)
								}
							end
						end
					end
				elseif var_3_1[var_4_1][arg_3_1] then
					var_4_0 = true
					var_4_2 = {
						var_3_1[var_4_1][arg_3_1](arg_4_0, ...)
					}
				end

				if arg_4_0 and arg_4_0.__classIndex then
					arg_4_0.__classIndex = var_4_1
				end

				if not var_4_0 then
					var_4_2 = {
						var_3_0[arg_3_1](arg_4_0, ...)
					}
				end

				return unpack((arg_3_1 == "ctor" or nil) and {
					var_3_2[arg_3_1](arg_4_0, ...)
				})
			end
		else
			return var_3_0[arg_3_1]
		end
	end

	local var_3_3 = var_3_1[rawget(arg_3_0, "__classIndex")]

	if var_3_3 and var_3_3[arg_3_1] ~= nil then
		return var_3_3[arg_3_1]
	end

	return var_3_2[arg_3_1]
end

local function var_0_5(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.__classPriv[arg_5_0.__classIndex] then
		var_0_2(arg_5_1, arg_5_2, arg_5_0.__classPriv[arg_5_0.__classIndex], arg_5_0.__classPub)
	else
		arg_5_0.__classPub[arg_5_1] = arg_5_2
	end
end

local function var_0_6(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.__classPub = arg_6_0.__classPub or {}
	arg_6_0.__classPriv = arg_6_0.__classPriv or {}
	arg_6_0.__baseClass = require("app.core.module.UIComponent")
	arg_6_0.__classIndex = 0
	arg_6_0.__ctorParams = arg_6_0.__ctorParams or {}

	local var_6_0 = string.split(arg_6_1, ";")

	for iter_6_0 = 1, #var_6_0 do
		if var_6_0[iter_6_0] ~= "" then
			local var_6_1 = string.split(var_6_0[iter_6_0], ":")

			arg_6_0.__ctorParams[#arg_6_0.__ctorParams + 1] = string.split(var_6_1[2], ",")
			arg_6_0.__classPriv[#arg_6_0.__classPriv + 1] = {}

			local var_6_2 = require(var_6_1[1])

			var_0_3(var_6_2, arg_6_0.__classPriv[#arg_6_0.__classPriv], arg_6_0.__classPub)
			var_0_3(var_6_2.__index, arg_6_0.__classPriv[#arg_6_0.__classPriv], arg_6_0.__classPub)
		end
	end

	setmetatable(tolua.getpeer(arg_6_0), {
		__index = var_0_4,
		__newindex = var_0_5
	})
	arg_6_0:ctor()

	if arg_6_2 then
		arg_6_0:addEventListener(fgui.UIEventType.EnterFinish, handler(arg_6_2, arg_6_2.onUICompEnter))
		arg_6_0:addEventListener(fgui.UIEventType.ExitFinish, handler(arg_6_2, arg_6_2.onUICompExit))
	end
end

local function var_0_7(arg_7_0, arg_7_1)
	if not arg_7_0.numChildren then
		return
	end

	for iter_7_0 = 1, arg_7_0:numChildren() do
		local var_7_0 = arg_7_0:getChildAt(iter_7_0 - 1)

		if var_7_0.numChildren then
			if var_7_0:numChildren() > 0 then
				var_0_7(var_7_0, arg_7_0)
			end

			local var_7_1 = var_7_0:getCustomData()

			if var_7_1 then
				var_0_6(var_7_0, var_7_1, arg_7_1)
			else
				local var_7_2 = var_7_0:getRemark()

				if var_7_2 then
					var_0_6(var_7_0, var_7_2, arg_7_1)
				elseif var_7_0[".classname"] == "fgui.GComponent" then
					var_0_6(var_7_0, "app.core.fairygui.GComponentBaseBindClass", arg_7_1)
				end
			end
		end
	end
end

fgui.UIPackage.iterObject = var_0_7
fgui.UIPackage.bindUIComponent = var_0_6

function fgui.UIPackage.createObjectWithSize(arg_8_0)
	local var_8_0 = var_0_0:createObject(...)

	var_8_0:setSize(display.width, display.height)

	return var_8_0
end

function fgui.UIPackage.createObject(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = var_0_1(arg_9_1, arg_9_2)

	assert(var_9_0, string.format("Could not create object with pkgName: %s and resName: %s", tostring(arg_9_1), tostring(arg_9_2)))
	var_0_7(var_9_0, arg_9_3)
	var_9_0:setName(arg_9_2)

	local var_9_1 = var_9_0:getRemark()

	if config.DEBUG_VERSION and false then
		g.core.log:info("UI CreateObject ==> Path " .. string.format("ui/%s/%s", arg_9_1, arg_9_2))

		if var_9_1 then
			g.core.log:info("Lua Script = >" .. tostring(var_9_1))
		end
	end

	if var_9_1 then
		var_0_6(var_9_0, var_9_1, arg_9_3)
	end

	return var_9_0
end

function fgui.UIPackage.bindLoaderUIComponent(arg_10_0, arg_10_1, arg_10_2)
	var_0_7(arg_10_1, arg_10_2)

	local var_10_0 = arg_10_1:getRemark()

	if var_10_0 then
		var_0_6(arg_10_1, var_10_0, arg_10_2)
	end
end
