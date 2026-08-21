local var_0_0 = singletonClass("IdolDanceCollectionData")

function var_0_0.Init(arg_1_0)
	arg_1_0.records = {}
end

function var_0_0.InitFromServer(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0.records[iter_2_1] = true
	end
end

function var_0_0.IsCollectionRecordViewed(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function var_0_0.MarkCollectionRecordAsViewed(arg_4_0, arg_4_1)
	arg_4_0.records[arg_4_1] = true
end

return var_0_0
