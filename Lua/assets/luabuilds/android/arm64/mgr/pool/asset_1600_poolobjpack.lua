local PoolObjPack = class("PoolObjPack")

function PoolObjPack:Ctor(arg_1_1, arg_1_2)
	self.key = arg_1_1
	self.ab = arg_1_2
	self.items = {}
	self.typeDic = {}

	return
end

function PoolObjPack:Get(arg_2_1, arg_2_2)
	if not self.items[arg_2_1] then
		self.items[arg_2_1] = self.ab:LoadAssetSync(arg_2_1, arg_2_2, false, false)
		self.typeDic[arg_2_1] = arg_2_2
	end

	return self.items[arg_2_1]
end

function PoolObjPack:Remove(arg_3_1)
	return table.removebykey(self.items, arg_3_1)
end

function PoolObjPack:GetAmount()
	return table.getCount(self.items)
end

function PoolObjPack:Clear()
	self.items = nil
	self.typeDic = nil

	self.ab:Dispose()

	self.ab = nil

	return
end

return PoolObjPack
