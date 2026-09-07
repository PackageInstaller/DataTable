local BaseEntityPool = class("BaseEntityPool", import(".BaseEntity"))

BaseEntityPool.Fields = {
	pools = "table"
}

function BaseEntityPool:Build()
	self.pools = {}

	return
end

function BaseEntityPool:Get(arg_2_1)
	self.pools[arg_2_1] = self.pools[arg_2_1] or {}

	if #self.pools[arg_2_1] == 0 then
		return arg_2_1.New()
	else
		self.pools[arg_2_1][#self.pools[arg_2_1]]:Build()

		return table.remove(self.pools[arg_2_1], #self.pools[arg_2_1])
	end

	return
end

function BaseEntityPool:Return(arg_3_1, arg_3_2)
	arg_3_1:Dispose()

	arg_3_2 = arg_3_2 or arg_3_1.class
	self.pools[arg_3_2] = self.pools[arg_3_2] or {}

	table.insert(self.pools[arg_3_2], arg_3_1)

	return
end

function BaseEntityPool:ReturnArray(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		self:Return(iter_4_1, arg_4_2)
	end

	return
end

function BaseEntityPool:ReturnMap(arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		self:Return(iter_5_1, arg_5_2)
	end

	return
end

return BaseEntityPool
