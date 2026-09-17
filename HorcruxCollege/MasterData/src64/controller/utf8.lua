local var_0_0 = "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*"

local function var_0_1(arg_1_0, arg_1_1)
	if arg_1_0 < 0 then
		arg_1_0 = arg_1_1 + arg_1_0 + 1
	end

	return arg_1_0
end

local var_0_2 = {
	map = function(self, arg_2_1, arg_2_2)
		local var_2_0 = 0

		if arg_2_2 then
			for iter_2_0, iter_2_1 in self:gmatch("()" .. var_0_0 .. "()") do
				var_2_0 = var_2_0 + 1

				arg_2_1(var_2_0, iter_2_1 - iter_2_0, iter_2_0)
			end
		else
			for iter_2_2, iter_2_3 in self:gmatch("()(" .. var_0_0 .. ")") do
				var_2_0 = var_2_0 + 1

				arg_2_1(var_2_0, iter_2_3, iter_2_2)
			end
		end
	end
}

function var_0_2.chars(arg_3_0, arg_3_1)
	return coroutine.wrap(function()
		return var_0_2.map(arg_3_0, coroutine.yield, arg_3_1)
	end)
end

function var_0_2:len()
	return select(2, self:gsub("[^\x80-\xC1]", ""))
end

function var_0_2:replace(arg_6_1)
	return self:gsub(var_0_0, arg_6_1)
end

function var_0_2:reverse()
	self = self:gsub(var_0_0, function(arg_8_0)
		return #arg_8_0 > 1 and arg_8_0:reverse()
	end)

	return self:reverse()
end

function var_0_2:strip()
	return self:gsub(var_0_0, function(arg_10_0)
		return #arg_10_0 > 1 and ""
	end)
end

function var_0_2.sub(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_2.len(arg_11_0)

	arg_11_1 = var_0_1(arg_11_1, var_11_0)
	arg_11_2 = arg_11_2 and var_0_1(arg_11_2, var_11_0) or var_11_0

	if arg_11_1 < 1 then
		arg_11_1 = 1
	end

	if var_11_0 < arg_11_2 then
		arg_11_2 = var_11_0
	end

	if arg_11_2 < arg_11_1 then
		return ""
	end

	local var_11_1 = arg_11_2 - arg_11_1
	local var_11_2 = var_0_2.chars(arg_11_0, true)

	for iter_11_0 = 1, arg_11_1 - 1 do
		var_11_2()
	end

	local var_11_3, var_11_4 = select(2, var_11_2())

	if var_11_1 == 0 then
		return string.sub(arg_11_0, var_11_4, var_11_4 + var_11_3 - 1)
	end

	arg_11_1 = var_11_4

	for iter_11_1 = 1, var_11_1 - 1 do
		var_11_2()
	end

	local var_11_5, var_11_6 = select(2, var_11_2())

	return string.sub(arg_11_0, arg_11_1, var_11_6 + var_11_5 - 1)
end

return var_0_2
