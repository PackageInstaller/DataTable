local Heap = class("Heap")

function Heap:Ctor(arg_1_1, arg_1_2)
	self.array = arg_1_1
	self.func = arg_1_2

	self:Init()

	return
end

function Heap:Init()
	self.values = underscore.map(self.array, function(arg_3_0)
		return self.func(arg_3_0)
	end)
	self.length = #self.array

	for iter_2_0 = math.floor(self.length / 2), 1, -1 do
		self:Dive(iter_2_0)
	end

	return
end

function Heap:Float(arg_4_1)
	local var_4_0 = math.floor(arg_4_1 / 2)

	while var_4_0 > 0 and self.values[arg_4_1] < self.values[var_4_0] do
		self.array[var_4_0], self.array[arg_4_1] = self.array[arg_4_1], self.array[var_4_0]
		self.values[var_4_0], self.values[arg_4_1] = self.values[arg_4_1], self.values[var_4_0]
		var_4_0 = math.floor(var_4_0 / 2)
		arg_4_1 = var_4_0
	end

	return arg_4_1
end

function Heap:Dive(arg_5_1)
	local var_5_0 = arg_5_1 + arg_5_1 + (arg_5_1 + arg_5_1 < self.length and self.values[arg_5_1 + arg_5_1 + 1] < self.values[arg_5_1 + arg_5_1] and 1 or 0)

	while var_5_0 <= self.length and self.values[var_5_0] < self.values[arg_5_1] do
		self.array[var_5_0], self.array[arg_5_1] = self.array[arg_5_1], self.array[var_5_0]
		self.values[var_5_0], self.values[arg_5_1] = self.values[arg_5_1], self.values[var_5_0]
		var_5_0 = var_5_0 + var_5_0
		arg_5_1 = var_5_0
		var_5_0 = var_5_0 + (var_5_0 < self.length and self.values[var_5_0 + 1] < self.values[var_5_0] and 1 or 0)
	end

	return arg_5_1
end

function Heap:UpdateValue(arg_6_1)
	local var_6_0 = self:GetInedex(arg_6_1)

	if not var_6_0 then
		return
	end

	self.values[var_6_0] = self.func(self.array[var_6_0])

	local var_6_1 = self:Dive((self:Float(var_6_0)))

	return
end

function Heap:POP(arg_7_1)
	local var_7_0 = arg_7_1 and self:GetInedex(arg_7_1) or 1

	assert(self.length == #self.values)

	if var_7_0 == self.length then
		self.length = self.length - 1
	else
		self.array[self.length] = self.array[var_7_0]
		self.array[var_7_0] = self.array[self.length]
		self.values[self.length] = self.values[var_7_0]
		self.values[var_7_0] = self.values[self.length]
		self.length = self.length - 1

		self:Dive(var_7_0)
	end

	local var_7_1 = table.remove(self.array)
	local var_7_2 = table.remove(self.values)
end

function Heap:PUSH(arg_8_1)
	table.insert(self.array, arg_8_1)
	table.insert(self.values, self.func(arg_8_1))

	self.length = self.length + 1

	self:Float(self.length)

	return
end

function Heap:GetLength()
	return self.length
end

function Heap:GetInedex(arg_10_1)
	return table.indexof(self.array, arg_10_1)
end

function Heap:GetTop()
	return {
		element = self.array[1],
		value = self.values[1]
	}
end

return Heap
