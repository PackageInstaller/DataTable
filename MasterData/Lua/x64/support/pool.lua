local Pool = class("Pool")

function Pool:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._parent = arg_1_2
	self._template = arg_1_1
	self._count = arg_1_3
	self._pool = {}
	self._isUsing = {}
	self._queue = {}

	self:OnCtor()
end

function Pool:OnCtor()
	for iter_2_0 = 1, self._count do
		local var_2_0 = Object.Instantiate(self._template, self._parent.transform)

		var_2_0.transform.localScale = Vector3(1, 1, 1)
		self._pool[iter_2_0] = var_2_0
		self._isUsing[iter_2_0] = true
	end
end

function Pool:AddPool()
	self._count = self._count + 1

	local var_3_0 = Object.Instantiate(self._template, self._parent.transform)

	var_3_0.transform.localScale = Vector3(1, 1, 1)
	self._pool[self._count] = var_3_0
	self._isUsing[self._count] = true
end

function Pool:GetCanUsingObj()
	for iter_4_0 = 1, self._count do
		if self._isUsing[iter_4_0] == true then
			self._isUsing[iter_4_0] = false

			table.insert(self._queue, iter_4_0)

			return self._pool[iter_4_0], iter_4_0
		end
	end

	self:AddPool()

	self._isUsing[self._count] = false

	table.insert(self._queue, self._count)

	return self._pool[self._count], self._count
end

function Pool:GetUseingIndexObj(arg_5_1)
	return self._pool[arg_5_1]
end

function Pool:FinishIndex(arg_6_1)
	table.removebyvalue(self._queue, arg_6_1)

	self._isUsing[arg_6_1] = true
end

function Pool:GetQueueHead()
	return self._queue[1]
end

function Pool:AllUsed()
	for iter_8_0, iter_8_1 in ipairs(self._isUsing) do
		if iter_8_1 then
			return false
		end
	end

	return true
end

function Pool:GetPool()
	return self._pool
end

function Pool:Dispose()
	if self._pool then
		for iter_10_0, iter_10_1 in ipairs(self._pool) do
			Object.Destroy(iter_10_1)
		end

		self._pool = nil
	end

	self._isUsing = nil
	self._queue = nil
	self._template = nil
end

return Pool
