local LianLianKanItemGen = class("LianLianKanItemGen")

function LianLianKanItemGen:Ctor(arg_1_1, arg_1_2)
	self.weights = {}
	self.total = arg_1_1
	self.offset = 0

	local var_1_0 = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		var_1_0 = var_1_0 + iter_1_1[2]
		self.weights[iter_1_1[1]] = arg_1_1 * iter_1_1[2]
	end

	for iter_1_2, iter_1_3 in pairs(self.weights) do
		self.weights[iter_1_2] = iter_1_3 / var_1_0
	end
end

local function var_0_1(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = math.random() * (arg_2_1 + arg_2_2)

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		if iter_2_1 > 0 then
			var_2_0 = var_2_0 - iter_2_1

			if var_2_0 < 0 then
				return iter_2_0
			end
		end
	end

	local var_2_1 = {}

	for iter_2_2, iter_2_3 in pairs(arg_2_0) do
		table.insert(var_2_1, iter_2_2)
	end

	return var_2_1[math.random(#var_2_1)]
end

function LianLianKanItemGen:Take(arg_3_1)
	local var_3_0 = var_0_1(self.weights, self.total, self.offset)

	self:Pop(var_3_0, arg_3_1)

	return var_3_0
end

function LianLianKanItemGen:Peek(arg_4_1, arg_4_2)
	local var_4_0 = clone(self.weights)
	local var_4_1 = {}

	for iter_4_0 = 1, arg_4_1 do
		local var_4_2 = var_0_1(var_4_0, self.total, self.offset)

		var_4_0[var_4_2] = var_4_0[var_4_2] - arg_4_2

		if var_4_0[var_4_2] < 0 then
			-- block empty
		end

		table.insert(var_4_1, var_4_2)
	end

	return var_4_1
end

function LianLianKanItemGen:Pop(arg_5_1, arg_5_2)
	self.total = self.total - arg_5_2

	local var_5_0 = (self.weights[arg_5_1] or 0) - arg_5_2

	self.weights[arg_5_1] = (self.weights[arg_5_1] or 0) - arg_5_2

	if var_5_0 < 0 then
		self.offset = self.offset + math.min(-var_5_0, arg_5_2)
	end
end

function LianLianKanItemGen:Return(arg_6_1, arg_6_2)
	local var_6_0 = self.weights[arg_6_1] or 0

	self.weights[arg_6_1] = var_6_0 + arg_6_2
	self.total = self.total + arg_6_2

	if var_6_0 < 0 then
		self.offset = self.offset - math.min(-var_6_0, arg_6_2)
	end
end

return LianLianKanItemGen
