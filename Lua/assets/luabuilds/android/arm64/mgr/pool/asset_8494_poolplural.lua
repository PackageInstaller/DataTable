local PoolUtil = require("Mgr/Pool/PoolUtil")
local PoolPlural = class("PoolPlural")
local var_0_2 = "UnityEngine.GameObject"

function PoolPlural:Ctor(arg_1_1, arg_1_2)
	local var_1_0 = getmetatable(arg_1_1)

	if not var_1_0 or var_1_0[".name"] ~= var_0_2 then
		warning("Poolplural should use gameobject as prefab not transform " .. ((arg_1_1 or nil) and (arg_1_1.name or "NIL")))
	end

	self.prefab = arg_1_1
	self.capacity = arg_1_2
	self.index = 0
	self.items = {}
	self.balance = 0

	return
end

function PoolPlural:Enqueue(arg_2_1, arg_2_2)
	self.balance = self.balance - 1

	if #self.items < self.capacity and (self.keep or not arg_2_2) then
		table.insert(self.items, arg_2_1)

		return false
	else
		PoolUtil.Destroy(arg_2_1)

		return true
	end

	return
end

function PoolPlural:Dequeue()
	self.balance = self.balance + 1

	local var_3_0

	while IsNil(var_3_0) and #self.items > 0 do
		var_3_0 = table.remove(self.items)
	end

	if IsNil(var_3_0) then
		var_3_0 = self:NewItem()
	end

	return var_3_0
end

function PoolPlural:NewItem()
	return Object.Instantiate(self.prefab)
end

function PoolPlural:AllReturned()
	return self.balance == 0 and not self.keep
end

function PoolPlural:ClearPrefab()
	PoolUtil.Destroy(self.prefab)

	self.prefab = nil

	return
end

function PoolPlural:ClearItems()
	while #self.items > 0 do
		PoolUtil.Destroy(table.remove(self.items))
	end

	self.balance = 0

	return
end

function PoolPlural:SetKeep(arg_8_1)
	self.keep = arg_8_1

	return
end

function PoolPlural:Clear()
	self:ClearPrefab()
	self:ClearItems()

	return
end

return PoolPlural
