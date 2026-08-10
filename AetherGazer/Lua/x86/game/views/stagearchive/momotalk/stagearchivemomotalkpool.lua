local var_0_0 = class("StageArchiveMomoTalkPool", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0.poolDic_ = {}
end

function var_0_0.GetFreeItem(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:GetItemPool(arg_2_1)

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

function var_0_0.ReturnItem(arg_3_0, arg_3_1)
	arg_3_1.isFree = true
end

function var_0_0.GetItemPool(arg_4_0, arg_4_1)
	if not arg_4_0.poolDic_[arg_4_1] then
		arg_4_0.poolDic_[arg_4_1] = {}
	end

	return arg_4_0.poolDic_[arg_4_1]
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.poolDic_) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			iter_5_3.itemView:Dispose()
		end
	end

	arg_5_0.poolDic_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
