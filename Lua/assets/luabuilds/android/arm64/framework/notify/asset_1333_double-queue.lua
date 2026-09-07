local var_0_0 = setmetatable
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {
	__index = var_0_2
}

function var_0_1.New()
	return var_0_0({
		first = 1,
		last = 0,
		data = {},
		data_position = {}
	}, var_0_3)
end

local function var_0_4(arg_2_0)
	while arg_2_0.first <= arg_2_0.last do
		if arg_2_0.data[arg_2_0.first] then
			return true
		end

		arg_2_0.first = arg_2_0.first + 1
	end

	return
end

function var_0_2:is_empty()
	return self.first > self.last
end

function var_0_2:push_front(arg_4_1)
	if self.data_position[arg_4_1] then
		return
	end

	self.first = self.first - 1
	self.data[self.first] = arg_4_1
	self.data_position[arg_4_1] = self.first

	return
end

function var_0_2:push_back(arg_5_1)
	if self.data_position[arg_5_1] then
		return
	end

	self.last = self.last + 1
	self.data[self.last] = arg_5_1
	self.data_position[arg_5_1] = self.last

	return
end

function var_0_2:get_iterator()
	local var_6_0 = self.first

	return function()
		while var_6_0 <= self.last do
			var_6_0 = var_6_0 + 1

			if self.data[var_6_0] then
				return self.data[var_6_0]
			end
		end

		return
	end
end

function var_0_2:remove(arg_8_1)
	if not self.data_position[arg_8_1] then
		return
	end

	self.data[self.data_position[arg_8_1]] = nil
	self.data_position[arg_8_1] = nil

	var_0_4(self)

	return
end

return var_0_1
