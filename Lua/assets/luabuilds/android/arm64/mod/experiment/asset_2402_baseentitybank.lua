local BaseEntityBank = class("BaseEntityBank", import(".BaseEntityPool"))

BaseEntityBank.Fields = {
	marks = "table"
}

function BaseEntityBank:Build()
	BaseEntityBank.super.Build(self)

	self.marks = {}

	return
end

function BaseEntityBank:Fetch(arg_2_1)
	local var_2_0 = self:Get(arg_2_1)

	self.marks[arg_2_1] = self.marks[arg_2_1] or {}

	table.insert(self.marks[arg_2_1], var_2_0)

	return var_2_0
end

function BaseEntityBank:Recycle(arg_3_1)
	if self.marks[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(self.marks[arg_3_1]) do
			self:Return(iter_3_1, arg_3_1)
		end

		self.marks[arg_3_1] = nil
	end

	return
end

function BaseEntityBank:RecycleAll()
	for iter_4_0, iter_4_1 in pairs(self.marks) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			self:Return(iter_4_3, iter_4_0)
		end
	end

	self.marks = {}

	return
end

return BaseEntityBank
