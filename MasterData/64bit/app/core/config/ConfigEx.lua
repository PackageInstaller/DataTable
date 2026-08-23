local function var_0_0(arg_1_0, arg_1_1)
	return function()
		return arg_1_1(arg_1_0, ...)
	end
end

local ConfigInfoEx = import(".ConfigInfoEx")
local var_0_2 = {}

function var_0_2:get()
	local var_3_0 = self.get(...)

	var_0_2._checkCfg(self, var_3_0, ...)

	return var_0_2._extendInfo(self, var_3_0)
end

function var_0_2:set(arg_4_1, arg_4_2, arg_4_3)
	self.set(arg_4_1, arg_4_2, arg_4_3)
end

function var_0_2:get_index_data()
	return self.get_index_data()
end

function var_0_2:fetch()
	local var_6_0 = self.get(...)

	var_6_0 = var_6_0 and var_0_2._extendInfo(self, var_6_0)

	return var_6_0
end

function var_0_2:indexOf(arg_7_1)
	local var_7_0 = self.indexOf(arg_7_1)

	var_0_2._checkCfgIndex(self, var_7_0, arg_7_1)

	return var_0_2._extendInfo(self, var_7_0)
end

function var_0_2:getLength()
	return self.getLength()
end

function var_0_2:hasKey(arg_9_1)
	return self.hasKey(arg_9_1)
end

function var_0_2:match(arg_10_1, arg_10_2)
	local var_10_0 = type(arg_10_1) == "function" and arg_10_1 or nil
	local var_10_1 = type(arg_10_1) == "string" and arg_10_1 or nil

	assert(not var_10_1 or arg_10_2, "Invalid condition value: " .. tostring(arg_10_2))

	local var_10_2 = self.__condCache

	if var_10_1 then
		if not self.__condCache then
			self.__condCache = {}
			var_10_2 = self.__condCache
		end

		local var_10_3 = var_10_2[string.format("%s=%s", var_10_1, tostring(arg_10_2))]

		if var_10_3 then
			return var_10_3
		end
	end

	local var_10_4 = {}

	for iter_10_0, iter_10_1 in var_0_2.ipairs(self) do
		if var_10_0 and var_10_0(iter_10_1) then
			table.insert(var_10_4, iter_10_1)
		elseif var_10_1 and iter_10_1[var_10_1] == arg_10_2 then
			table.insert(var_10_4, iter_10_1)
		end
	end

	if var_10_1 then
		var_10_2[string.format("%s=%s", var_10_1, tostring(arg_10_2))] = var_10_4
	end

	return var_10_4
end

function var_0_2.ipairs(arg_11_0)
	return function(arg_12_0, arg_12_1)
		arg_12_1 = arg_12_1 + 1

		local var_12_0 = arg_11_0.indexOf(arg_12_1)

		if var_12_0 then
			return arg_12_1, var_0_2._extendInfo(arg_11_0, var_12_0)
		end

		return nil
	end, arg_11_0, 0
end

function var_0_2:hasData()
	return not not self.get(...)
end

function var_0_2:_extendInfo(arg_14_1)
	arg_14_1.__keyMap = self.__keyMap

	return setmetatable({}, {
		__index = function(arg_15_0, arg_15_1)
			if ConfigInfoEx[arg_15_1] then
				return var_0_0(arg_14_1, ConfigInfoEx[arg_15_1])
			end

			return arg_14_1[arg_15_1]
		end
	})
end

function var_0_2:_checkCfg(arg_16_1)
	if not arg_16_1 then
		local var_16_0 = ""

		for iter_16_0, iter_16_1 in ipairs({
			...
		}) do
			var_16_0 = table.concat({
				var_16_0,
				" ",
				tostring(iter_16_1)
			})
		end

		g.core.platform.BuglyProxy:error("config not found----->" .. self.__name .. " " .. var_16_0 .. " version:" .. g.core.utils.Tools.getVersionInfos())
		assert(false, string.format("Could not find the %s data with params: %s", self.__name, var_16_0))
	end
end

function var_0_2:_checkCfgIndex(arg_17_1, arg_17_2)
	assert(arg_17_1, string.format("Could not find the %s data with index: %s", self.__name, tostring(arg_17_2)))
end

return var_0_2
