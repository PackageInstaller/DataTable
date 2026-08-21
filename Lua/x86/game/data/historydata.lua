local var_0_0 = singletonClass("HistoryData")

function var_0_0.Init(arg_1_0)
	arg_1_0.historyData_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.data_list) do
		arg_2_0.historyData_[iter_2_1.id] = tonumber(iter_2_1.data)
	end
end

function var_0_0.GetHistoryData(arg_3_0, arg_3_1)
	return arg_3_0.historyData_[arg_3_1]
end

return var_0_0
