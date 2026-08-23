return {
	randomByWeight = function(self)
		local var_1_0 = 0

		for iter_1_0 = 1, #self do
			var_1_0 = var_1_0 + self[iter_1_0]
		end

		local var_1_1 = math.random(1, var_1_0)
		local var_1_2 = 0

		for iter_1_1 = 1, #self do
			var_1_2 = var_1_2 + self[iter_1_1]

			if var_1_1 <= var_1_2 then
				return iter_1_1
			end
		end
	end,
	randomMultiple = function(self, arg_2_1)
		local var_2_0 = {}

		if arg_2_1 > #self then
			return self
		end

		for iter_2_0 = 1, arg_2_1 do
			local var_2_1 = math.random(iter_2_0, #self)

			self[var_2_1], self[iter_2_0] = self[iter_2_0], self[var_2_1]

			table.insert(var_2_0, self[iter_2_0])
		end

		return var_2_0
	end,
	convertListToMap = function(arg_3_0)
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0 or {}) do
			var_3_0[iter_3_1.key] = iter_3_1.value
		end

		return var_3_0
	end,
	isEmpty = function(arg_4_0)
		return _G.next(arg_4_0) == nil
	end,
	isContains = function(arg_5_0, arg_5_1)
		if not arg_5_0 or not arg_5_1 then
			return false
		end

		local var_5_0 = false

		for iter_5_0, iter_5_1 in pairs(arg_5_0) do
			if iter_5_1 == arg_5_1 then
				var_5_0 = true

				break
			end
		end

		return var_5_0
	end,
	packString = function(self, arg_6_1)
		self = self or {}

		if #self == 0 then
			return ""
		end

		arg_6_1 = arg_6_1 or "|"

		local var_6_0 = self[1]

		for iter_6_0 = 2, #self do
			var_6_0 = var_6_0 .. arg_6_1 .. self[iter_6_0]
		end

		return var_6_0
	end,
	delRepeatItem = function(arg_7_0)
		local var_7_0 = {}
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(arg_7_0) do
			if not var_7_1[iter_7_1] then
				var_7_0[#var_7_0 + 1] = iter_7_1
				var_7_1[iter_7_1] = true
			end
		end

		return var_7_0
	end,
	tableToString = function(arg_8_0)
		local var_8_0 = {}

		function var_8_0.ToStringEx(arg_9_0)
			if type(arg_9_0) == "table" then
				return var_8_0._tableToString(arg_9_0)
			elseif type(arg_9_0) == "string" then
				return "'" .. arg_9_0 .. "'"
			else
				return tostring(arg_9_0)
			end
		end

		function var_8_0._tableToString(arg_10_0)
			if arg_10_0 == nil then
				return ""
			end

			local var_10_0 = "{"
			local var_10_1 = 1

			for iter_10_0, iter_10_1 in pairs(arg_10_0) do
				local var_10_2 = ","

				if var_10_1 == 1 then
					var_10_2 = ""
				end

				var_10_0 = iter_10_0 == var_10_1 and var_10_0 .. var_10_2 .. var_8_0.ToStringEx(iter_10_1) or (type(iter_10_0) == "number" or type(iter_10_0) == "string") and var_10_0 .. var_10_2 .. "[" .. var_8_0.ToStringEx(iter_10_0) .. "]=" .. var_8_0.ToStringEx(iter_10_1) or type(iter_10_0) == "userdata" and var_10_0 .. var_10_2 .. "*s" .. var_8_0._talbeToString(getmetatable(iter_10_0)) .. "*e" .. "=" .. var_8_0.ToStringEx(iter_10_1) or var_10_0 .. var_10_2 .. iter_10_0 .. "=" .. var_8_0.ToStringEx(iter_10_1)
				var_10_1 = var_10_1 + 1
			end

			return var_10_0 .. "}"
		end

		return var_8_0._tableToString(arg_8_0)
	end
}
