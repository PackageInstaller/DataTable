local var_0_0 = singletonClass("DormStorage")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0:Reset()
	if self.storage == nil or next(self.storage) ~= nil then
		self.storage = {}
	end
end

function var_0_0:ClearData(arg_3_1)
	self.storage[arg_3_1] = nil
end

function var_0_0:RecordData(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = self.storage[arg_4_1] or {}

	var_4_0[arg_4_2] = arg_4_3
	self.storage[arg_4_1] = var_4_0
end

function var_0_0:PickData(arg_5_1)
	if self.storage[arg_5_1] then
		local var_5_0, var_5_1 = next(self.storage[arg_5_1])

		return var_5_1
	end
end

local function var_0_1(arg_6_0)
	return arg_6_0[math.random(1, #arg_6_0)]
end

function var_0_0:RndPickData(arg_7_1, arg_7_2)
	if self.storage[arg_7_1] then
		if arg_7_2 then
			return var_0_1(self.storage[arg_7_1])
		else
			local var_7_1 = {}

			for iter_7_0, iter_7_1 in pairs(self.storage[arg_7_1]) do
				table.insert(var_7_1, iter_7_0)
			end

			return self.storage[arg_7_1][var_0_1(var_7_1)]
		end
	end
end

function var_0_0:PushBackData(arg_8_1, arg_8_2)
	local var_8_0 = self.storage[arg_8_1] or {}

	table.insert(var_8_0, arg_8_2)

	self.storage[arg_8_1] = var_8_0
end

function var_0_0:PopFrontData(arg_9_1)
	if self.storage[arg_9_1] then
		table.remove(self.storage[arg_9_1], 1)

		self.storage[arg_9_1] = self.storage[arg_9_1]

		return self.storage[arg_9_1][1]
	end
end

function var_0_0:ForeachData(arg_10_1, arg_10_2)
	if self.storage[arg_10_1] then
		return arg_10_2(self.storage[arg_10_1])
	else
		return function()
			return
		end, nil, nil
	end
end

function var_0_0:MapToData(arg_12_1, arg_12_2)
	self.storage[arg_12_1] = self.storage[arg_12_1]

	return self.storage[arg_12_1]
end

function var_0_0:GetData(arg_13_1, arg_13_2)
	if arg_13_2 == "#" then
		if self.storage[arg_13_1] then
			return #self.storage[arg_13_1], next(self.storage[arg_13_1])
		else
			return nil, nil
		end
	end

	return nullable(self.storage, arg_13_1, arg_13_2)
end

return var_0_0
