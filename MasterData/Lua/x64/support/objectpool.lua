local ObjectPool = class("ObjectPool")

function ObjectPool:Ctor()
	self.uselessParent_ = GameObject.Find("/Pool").transform
	self.freeDic_ = {}

	self:Preload()
end

function ObjectPool:Preload()
	return
end

function ObjectPool:Create(arg_3_1, arg_3_2)
	local var_3_0 = Asset.Load(arg_3_1)

	self:CheckToInitList(arg_3_1)

	for iter_3_0 = 1, arg_3_2 do
		table.insert(self.freeDic_[arg_3_1], (Object.Instantiate(var_3_0, self.uselessParent_)))
	end
end

function ObjectPool:Get(arg_4_1)
	self:CheckToInitList(arg_4_1)

	if #self.freeDic_[arg_4_1] == 0 then
		self:Create(arg_4_1, 1)
	end

	table.remove(self.freeDic_[arg_4_1], #self.freeDic_[arg_4_1])

	return self.freeDic_[arg_4_1][#self.freeDic_[arg_4_1]]
end

function ObjectPool:Return(arg_5_1, arg_5_2)
	self:CheckToInitList(arg_5_1)
	arg_5_2.transform:SetParent(self.uselessParent_, false)
	table.insert(self.freeDic_[arg_5_1], arg_5_2)
end

function ObjectPool:CheckToInitList(arg_6_1)
	self.freeDic_[arg_6_1] = self.freeDic_[arg_6_1] or {}
end

function ObjectPool:IsRecycleAssetPath(arg_7_1)
	if arg_7_1 == "UI/Common/CommonItem" then
		return true
	end

	return false
end

function ObjectPool:Dispose()
	for iter_8_0, iter_8_1 in pairs(self.freeDic_) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1) do
			Object.Destroy(iter_8_3)
		end
	end

	self.freeDic_ = {}
end

return ObjectPool
