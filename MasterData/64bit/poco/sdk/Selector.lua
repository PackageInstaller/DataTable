local var_0_0 = (function(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1 = arg_1_0

	while true do
		if string.byte(arg_1_0, 1) ~= 46 then
			var_1_1 = string.sub(arg_1_0, 1)

			if var_1_0 and #var_1_0 > 0 then
				var_1_1 = table.concat(var_1_0, ".") .. "." .. var_1_1
			end

			break
		end

		if not var_1_0 then
			if not arg_1_1 then
				local var_1_3, var_1_4 = debug.getlocal(3, 1)

				arg_1_1 = var_1_4
			end

			var_1_0 = string.split(arg_1_1, ".")
		end

		table.remove(var_1_0, #var_1_0)
	end

	return require(var_1_1)
end)(".DefaultMatcher")

local function var_0_1(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		if iter_2_1 == arg_2_1 then
			return true
		end
	end

	return false
end

local var_0_2 = {}

var_0_2.__index = var_0_2

function var_0_2.new(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}

	setmetatable(var_3_0, var_0_2)

	var_3_0.dumper = arg_3_1
	var_3_0.matcher = arg_3_2 or var_0_0

	return var_3_0
end

function var_0_2:getRoot()
	return self.dumper:getRoot()
end

function var_0_2:select(arg_5_1, arg_5_2)
	if arg_5_2 == nil then
		arg_5_2 = false
	end

	return self:selectImpl(arg_5_1, arg_5_2, self:getRoot(), 9999, true, true)
end

function var_0_2:selectImpl(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	local var_6_0 = {}

	if arg_6_3 == nil then
		return var_6_0
	end

	local var_6_1, var_6_2 = unpack(arg_6_1)

	if var_6_1 == ">" or var_6_1 == "/" then
		local var_6_3 = {
			arg_6_3
		}

		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			local var_6_4 = {}

			for iter_6_2, iter_6_3 in ipairs(var_6_3) do
				_res = self:selectImpl(iter_6_1, true, iter_6_3, (var_6_1 == "/" and iter_6_0 ~= 1 or nil) and 1, arg_6_5, false)

				for iter_6_4, iter_6_5 in ipairs(_res) do
					if not var_0_1(var_6_4, iter_6_5) then
						table.insert(var_6_4, iter_6_5)
					end
				end
			end

			var_6_3 = var_6_4
		end

		var_6_0 = var_6_3
	elseif var_6_1 == "-" then
		local var_6_6, var_6_7 = unpack(var_6_2)

		for iter_6_6, iter_6_7 in ipairs((self:selectImpl(var_6_6, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6))) do
			sibling_result = self:selectImpl(var_6_7, arg_6_2, iter_6_7:getParent(), 1, arg_6_5, arg_6_6)

			for iter_6_8, iter_6_9 in ipairs(sibling_result) do
				if not var_0_1(var_6_0, iter_6_9) then
					table.insert(var_6_0, iter_6_9)
				end
			end
		end
	elseif var_6_1 == "index" then
		local var_6_8, var_6_9 = unpack(var_6_2)

		var_6_0 = {
			self:selectImpl(var_6_8, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)[var_6_9 + 1]
		}
	elseif var_6_1 == "^" then
		local var_6_10, var_6_11 = unpack(var_6_2)
		local var_6_12 = self:selectImpl(var_6_10, false, arg_6_3, arg_6_4, arg_6_5, arg_6_6)

		if #var_6_12 > 0 then
			local var_6_13 = var_6_12[1]:getParent()

			if var_6_13 ~= nil then
				var_6_0 = {
					var_6_13
				}
			end
		end
	else
		self:_selectTraverse(arg_6_1, arg_6_3, var_6_0, arg_6_2, arg_6_4, arg_6_5, arg_6_6)
	end

	return var_6_0
end

function var_0_2:_selectTraverse(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	if arg_7_6 and not arg_7_2:getAttr("visible") then
		return false
	end

	if self.matcher:match(arg_7_1, arg_7_2) and arg_7_7 then
		if not var_0_1(arg_7_3, arg_7_2) then
			table.insert(arg_7_3, arg_7_2)
		end

		if not arg_7_4 then
			return true
		end
	end

	if arg_7_5 == 0 then
		return false
	end

	arg_7_5 = arg_7_5 - 1

	for iter_7_0, iter_7_1 in ipairs(arg_7_2:getChildren()) do
		if self:_selectTraverse(arg_7_1, iter_7_1, arg_7_3, arg_7_4, arg_7_5, arg_7_6, true) then
			return true
		end
	end

	return false
end

return var_0_2
