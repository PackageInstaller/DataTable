local StageArchiveMomoTalkPool = class("StageArchiveMomoTalkPool", ReduxView)

function StageArchiveMomoTalkPool:Init()
	self.poolDic_ = {}
end

function StageArchiveMomoTalkPool:GetFreeItem(arg_2_1, arg_2_2)
	local var_2_0 = self:GetItemPool(arg_2_1)

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		if iter_2_1.isFree == true then
			iter_2_1.isFree = false

			return iter_2_1
		end
	end

	local var_2_1 = {
		isFree = false,
		itemView = arg_2_2()
	}

	table.insert(var_2_0, var_2_1)

	return var_2_1
end

function StageArchiveMomoTalkPool:ReturnItem(arg_3_1)
	arg_3_1.isFree = true
end

function StageArchiveMomoTalkPool:GetItemPool(arg_4_1)
	self.poolDic_[arg_4_1] = self.poolDic_[arg_4_1] or {}

	return self.poolDic_[arg_4_1]
end

function StageArchiveMomoTalkPool:Dispose()
	for iter_5_0, iter_5_1 in pairs(self.poolDic_) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			iter_5_3.itemView:Dispose()
		end
	end

	self.poolDic_ = nil

	StageArchiveMomoTalkPool.super.Dispose(self)
end

return StageArchiveMomoTalkPool
